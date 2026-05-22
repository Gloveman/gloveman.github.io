---
title: "위치 기반 주차장 공간 검색 서비스 : Troubleshooting"
date: 2026-02-06
description: "대용량 거리 계산 병목 및 상태 전이 최적화 문제 해결"
---

## 🚀 기술적 도전 및 문제 해결 (Technical Challenges & Troubleshooting)

### 1. 수만 건의 위경도 데이터 실시간 거리 계산 병목
- **문제 상황 (Symptom)**: 사용자가 지도 상에서 위치를 입력하거나 변경했을 때, 주변 주차장을 조회하는 부분에서 응답 지연(3~5초 이상)이 심하게 발생하여 웹앱이 얼어붙는 현상 발생.
- **원인 분석 (Root Causes)**: 전국 단위 주차장 CSV 원본 데이터를 로드하고 단순 반복문(for loop)이나 Python Pandas `.apply` 함수를 사용해 거리를 매번 순차적으로 계산하면서 CPU 연산 병목 발생.
- **해결 방안 (Solution)**: **NumPy의 Vectorized Operation(벡터 연산)**을 활용하여 10만 행 이상의 좌표 연산을 CPU의 SIMD(단일 명령 다중 데이터) 가속 수준으로 행렬화하여 실시간 처리. 거리를 밀리초(ms) 단위로 즉각 구하고, 서울특별시 행만 선 필터링 및 **`@st.cache_data`** 데코레이터를 적용해 중복 로딩 제거.

### 2. 지도 마커 클릭과 목록 UI의 실시간 동기화 지연
- **문제 상황 (Symptom)**: Folium 지도에서 마커를 클릭했을 때, Streamlit의 고유 아키텍처 특성상 컴포넌트가 격리되어 화면 전체가 리프레시되며 선택 상태 정보가 소실되거나 하이라이팅이 엇갈림.
- **원인 분석 (Root Causes)**: Streamlit-Folium 컴포넌트와 Streamlit의 메인 파이썬 실행 쓰레드 간 비동기 상태 변화가 즉시 상호 전달되지 않고 초기화됨.
- **해결 방안 (Solution)**: `st.session_state.selected_parking` 세션 컨텍스트와 `st.rerun()` 함수를 결합함. Folium 컴포넌트 출력 객체에서 클릭한 마커의 툴팁 텍스트를 파싱하여 `st.session_state`에 동적으로 기록하고, 강제 Rerun 루프를 태움으로써 클릭 시 즉시 리스트 카드에서 해당 주차장에 고대비 Highlight 스타일을 매핑시킴.
