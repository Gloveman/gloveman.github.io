---
title: "Multi-Hop RAG 파이프라인 실험실"
date: 2026-05-23
description: "FAISS GPU, Cross-Encoder Reranking 및 T5 요약을 결합한 고성능 Multi-Hop RAG 실험 플랫폼"
tags: ["NLP", "RAG", "FAISS", "Cross-Encoder", "FLAN-T5", "PyTorch"]
categories: ["Project"]
---

![RAG Architecture](/images/retrieval_flow.png)

## 📝 프로젝트 개요 (Overview)
- **정보 추출의 정밀도 향상**: 복잡한 질문에 대해 여러 문서의 단서를 추적해 답변해야 하는 **Multi-Hop 추론(HotpotQA)을 해결하기 위한 RAG 파이프라인**입니다.
- **컨텍스트 최적화**: GPU 가속 벡터 검색, 교차 엔코더(Cross-Encoder) 기반 재정렬, T5 기반 가중치 반영 요약을 결합하여 **LLM의 입력 토큰을 효율화하고 할루시네이션을 억제**합니다.

## 🛠️ 기술 스택 & 아키텍처 (Tech Stack & Architecture)
- **주요 기술**: Python, PyTorch, FAISS GPU, SentenceTransformers (`bge-small-en-v1.5`), CrossEncoder (`ms-marco-MiniLM-L12-v2`), transformers (`FLAN-T5-Base`, `FLAN-T5-Small`), HuggingFace Datasets
- **아키텍처 패턴**: **실험 및 벤치마크 파이프라인(Experimental Pipeline)**
  - **Retrieval Layer**: `datasets` 모듈로 HotpotQA 로드 후 `FAISS GPU Index`를 통해 고속 벡터 유사도 검색 수행
  - **Rerank & Summarize Layer**: 임베딩 기반 검색 결과 중 Top-K 문서들을 `Cross-Encoder`로 재평가 후 가중치가 높은 핵심 정보 위주로 T5 요약 수행
  - **Generation Layer**: Few-shot 예시 프롬프트와 정제된 요약 텍스트를 generator에 전달하여 최종 답변 생성

## 🎯 핵심 기능 (Key Features)
- **GPU 가속 Vector Search** (`buildDB.py`, `rag_baseline.py`):
  - 10만 건 이상의 문서를 `BAAI/bge-small-en-v1.5`로 임베딩하여 FAISS GPU 인덱스로 빌드, 코사인 유사도 기반 고속 Top-20 검색
- **정규화 점수 기반 Reranking** (`rag_baseline.py`):
  - 검색된 Top-20 문서와 쿼리 쌍을 `ms-marco-MiniLM-L12-v2`에 입력해 Relevance Score를 측정하고 Min-Max 정규화로 가중치 도출
- **가중치 반영 점진적 요약 (Weighted Summarization)** (`summarize_generate.py`):
  - 컨텍스트 길이가 임계값(`TOKEN_THRESHOLD`)을 초과할 경우, Reranker 가중치를 프롬프트에 명시하여 `FLAN-T5-Base`를 통해 핵심 문장 위주로 압축

## 💡 성장 포인트 및 회고 (Takeaways)
- 단순 텍스트 처리를 넘어 **Embedding -> Vector DB Indexing -> Reranking -> Selective Compression -> Generation**으로 이어지는 현대적 RAG 아키텍처의 핵심 파이프라인을 커스텀 구현하고, 각 모듈의 병목 지점을 모니터링 및 튜닝하는 역량을 증명함.

---

### 🔍 관련 문서
- [**Troubleshooting 상세 보기**](troubleshooting/) : 컨텍스트 할루시네이션 및 토큰 한계 돌파
