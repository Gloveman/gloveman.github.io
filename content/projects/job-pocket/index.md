---
title: "Job Pocket: RAG 기반 자소서 피드백 서비스"
date: 2026-04-24
description: "실제 합격 자소서 데이터를 참조하는 6단계 RAG 파이프라인 및 정밀도 평가 시스템"
tags: ["NLP", "RAG", "FastAPI", "MySQL 9", "EXAONE 3.5"]
categories: ["Project"]
---

![RAG Pipeline](/images/rag_pipeline.png)

## 🚀 프로젝트 개요
**"합격자의 서술 방식을 학습한 RAG 기반 자기소개서 초안 생성 및 첨삭 서비스"**

Job-Pocket은 실제 합격 자소서 샘플을 벡터 검색으로 추출하여 이를 참조 컨텍스트로 활용하며, 문항 유형별 최적화된 피드백을 제공하는 서비스입니다.

## 👨‍💻 My Contributions
- **리트리벌 정밀도 평가 모듈 개발**: 검색 시스템의 성능을 정량화하기 위한 **Keyword Match Rate** 지표를 직접 설계하고 평가 엔진 구현.
- **Hybrid Search 아키텍처 구현**: FAISS(고속 벡터 검색)와 MySQL(정합성 본문 조회)을 결합한 2단계 검색 파이프라인을 구축하여 검색 속도와 정확도 균형 확보.
- **평가 데이터셋 자동화 파이프라인**: HuggingFace 데이터셋 로드부터 전처리, 인덱스 빌드, 성능 리포트(`REPORT.md`) 생성까지의 전 과정을 자동화.
- **임베딩 모델 벤치마킹**: Qwen3-Embedding 등 다양한 모델을 활용하여 직군별 최적의 임베딩 성능을 도출하기 위한 실험 주도.

## 💻 Tech Stack
- **Backend**: Python 3.12, FastAPI, LangChain, MySQL 9
- **Frontend**: Streamlit
- **Models**: EXAONE 3.5 (Generation), GPT-4o-mini (Refine), Qwen3-Embedding

---

### 🔍 관련 문서
- [**Troubleshooting 상세 보기**](troubleshooting/) : 자소서 초안 재생성 로직 최적화 및 비용 절감
