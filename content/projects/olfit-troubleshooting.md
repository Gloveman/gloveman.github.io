---
title: "Olfít: VLM & Vector Search 기반 퍼스널 향수 큐레이션 플랫폼 : Troubleshooting"
date: 2026-05-18
description: "VLM 비정형 텍스트 응답 예외 처리 및 프론트엔드 비동기 레이스 컨디션 해결"
url: "/projects/olfit/troubleshooting/"
---

## 🚀 기술적 도전 및 문제 해결 (Technical Challenges & Troubleshooting)

### 1. VLM 출력 결과의 비정형성으로 인한 백엔드 JSON 파서 크래시
- **문제 상황 (Symptom)**: NVIDIA NIM Gemma-VLM API가 리턴하는 응답 텍스트에 간헐적으로 마크다운 코드 블록 표식(```json ...)이나 꼬리말 자연어 문장 등이 포함되어 들어와, 장고 백엔드의 JSON 파서가 데이터를 파싱하지 못하고 500 에러를 반환하며 크래시 발생.
- **원인 분석 (Root Causes)**: VLM은 자연어 생성 모델이므로 프롬프트에 아무리 JSON 포맷 준수를 지시해도 가끔 부가 텍스트를 함께 출력하는 무작위성(Stochasticity)을 통제하기 어려움.
- **해결 방안 (Solution)**: 
  - **`extract_json_from_text` 정규식 추출기** 개발: 문자열 내에서 JSON 블록(`{...}`) 패턴만을 정규표현식으로 잡아내 추출하는 가드 로직 구현.
  - 범주형 전처리 및 **`normalize_vlm_result`** 유틸리티 구축: VLM이 추출해 낸 무드(Mood) 키워드를 사전에 정의된 규칙 키값들과 매칭 및 정규화하여 일치하지 않는 이상 텍스트 전처리.
  - **`_get_dummy_result` Fallback 구조**: 모델 API 호출 실패 및 파싱 최후 에러 상황 발생 시 사전에 학습된 평균값 기반의 더미 무드 데이터를 동적으로 반환해 서비스가 영속적으로 유지되도록 설계함.

### 2. 이미지 업로드와 선택지 변경 시 발생하는 레이스 컨디션 (Race Condition)
- **문제 상황 (Symptom)**: 사용자가 고해상도 이미지를 업로드하여 VLM 서버가 이미지 분석을 비동기로 돌리고 있는 와중에, 화면 상의 선호 향 노트 옵션을 연속해서 빠르게 클릭했을 때 화면 추천 결과에 이전 호출 데이터가 중복 덮어씌워지거나 오작동하는 심각한 비동기 데이터 일관성 장애 발생.
- **원인 분석 (Root Causes)**: 먼저 보낸 이미지 업로드 API 요청(비용 및 대기시간 김)의 응답이 늦게 완료되어, 사용자가 나중에 빠르게 눌러 먼저 완료된 향 노트 추천 API 요청의 결과를 이전 완료 시점의 이미지 분석 콜백이 무작위로 덮어쓰게 됨.
- **해결 방안 (Solution)**: 
  - 프론트엔드 API 클라이언트 단에 **`AbortController`**를 탑재함. 신규 요청이 시작되면 기존에 송출되어 처리 중이던 이미지/추천 요청 커넥션(In-flight Request)을 즉각 취소(Cancel)시킴으로써 네트워크 결과 순서 꼬임을 예방.
  - 입력 핸들러에 **디바운스(Debounce)** 처리를 적용하여 단시간 다중 입력을 방지함으로써, 클라이언트-서버 간 상태 일관성 및 동기화를 견고히 다짐.

### 3. 외부 API (NVIDIA VLM, OpenAI, Pinecone) 다중 연동 장애에 따른 서비스 가용성 위기
- **문제 상황 (Symptom)**: 실시간 하이브리드 추천 파이프라인 진행 시, NVIDIA NIM API, OpenAI Embedding API, Pinecone Vector DB 중 단 하나의 외부 API라도 장애(API Key 만료, 쿼터 제한, 네트워크 타임아웃)를 일으킬 경우 추천 서비스 전체가 멈추고 에러 페이지가 노출되는 가용성 저하 문제 발생.
- **원인 분석 (Root Causes)**: 추천 로직이 외부 서비스에 지나치게 동기적(Synchronous)이고 밀접하게 결합(Tightly Coupled)되어 있어 단일 장애점(SPOF, Single Point of Failure)이 발생함.
- **해결 방안 (Solution)**: **다단계 폴백(Robust Fallback) 아키텍처**를 설계함.
  - **VLM 장애 시**: VLM API가 실패하거나 타임아웃이 걸리면 사전에 정의된 `DUMMY_RESULT`를 주입하여 이미지 분석 스텝을 모크(Mock) 처리하고, 사용자의 명시적 선호 노트(40%)를 중심으로 추천이 수행되도록 함.
  - **시맨틱 검색 (OpenAI / Pinecone) 장애 시**: 백엔드 DB 자체에 **MySQL 기반 5축 아우라 필터링 엔진**으로 자동 전환(Failover)되도록 구현. 사용자의 5축 중 가장 강한 메인 계열을 DB에서 1차로 필터링하고, DB에 미리 빌드/캐싱된 아우라 점수 테이블을 사용하여 코사인 유사도를 로컬 연산하여 추천 결과를 보장함.
