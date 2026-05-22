---
title: "Olfit: 퍼스널 향수 큐레이션 서비스"
date: 2026-05-18
description: "이미지 분석(Aura Vector)과 RAG를 결합한 실시간 하이브리드 추천 파이프라인"
tags: ["Deep Learning", "NVIDIA NIM", "RAG", "Django", "React"]
categories: ["Project"]
---

![Olfit Main Architecture](/images/data_flow.png)

## 🎨 프로젝트 개요
**"시각적 감성과 기술적 취향의 조화, 실시간 하이브리드 추천 엔진"**

Olfit은 사용자가 업로드한 OOTD(오늘의 패션) 이미지에서 느껴지는 추상적인 '무드'와 텍스트로 표현된 향기 취향을 분석하여, 단순한 성분 매칭을 넘어선 감성적 향수 추천을 제공합니다.

## 👨‍💻 My Contributions
- **하이브리드 추천 엔진 설계 및 구현**: 시각 지표(Aura)와 언어 지표(RAG)를 결합한 가중치 기반 스코어링 수식 설계 및 구현.
- **RAG 파이프라인 최적화**: OpenAI Embedding과 Pinecone을 연동하여 1,000개 이상의 향수 데이터를 벡터화하고, Symmetric RAG 전략을 통해 검색 정밀도 향상.
- **VLM 데이터 엔지니어링**: NVIDIA NIM(Gemma-VLM)을 활용하여 이미지에서 향수 트리거 키워드를 추출하는 프롬프트 엔지니어링 및 데이터 구조화.
- **추천 로직 검증 시스템**: Symmetry Check 로직을 개발하여 추천 결과의 논리적 타당성을 검증하고, 다양한 엣지 케이스 테스트 통과.

## 💻 Tech Stack
- **Backend**: Python 3.12, Django, DRF, MySQL 8.4
- **Frontend**: React 19, TypeScript, Tailwind CSS, Shadcn UI, Zustand
- **AI/ML**: NVIDIA NIM (VLM), OpenAI (Embedding), Pinecone (Vector DB)

---

### 🔍 관련 문서
- [**Troubleshooting 상세 보기**](troubleshooting/) : 이미지 업로드 중복 요청 해결 과정
