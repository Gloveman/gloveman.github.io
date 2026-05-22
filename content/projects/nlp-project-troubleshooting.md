---
title: "Multi-Hop RAG 파이프라인 실험실 : Troubleshooting"
date: 2026-05-23
description: "컨텍스트 할루시네이션 및 토큰 임계값 초과 문제 해결"
url: "/projects/nlp-project/troubleshooting/"
---

## 🚀 기술적 도전 및 문제 해결 (Technical Challenges & Troubleshooting)

### 1. 할루시네이션 및 무관한 컨텍스트 유입
- **문제 상황 (Symptom)**: 단순 유사도(Cosine Similarity) 검색 결과에는 질문의 키워드만 겹치고 실제 다중 홉(Multi-Hop) 추론에는 전혀 도움을 주지 않는 노이즈 문서가 다수 유입되어 최종 LLM 답변에 할루시네이션 발생.
- **원인 분석 (Root Causes)**: 쿼리와 문서 간 단어 매칭 기반 또는 단일 임베딩 유사도만으로는 여러 단계를 거쳐야 하는 복잡한 정보 결합 관계를 인지하지 못함.
- **해결 방안 (Solution)**: **Cross-Encoder Reranker** (`ms-marco-MiniLM-L12-v2`)를 도입하여 검색된 Top-20 문서와 쿼리 간의 문맥적 정밀 유사도를 재측정함. 이후 스코어들을 Min-Max 정규화한 가중치를 추출하여 프롬프트 컨텍스트에 명시적으로 바인딩함으로써, LLM이 신뢰도가 높은 정보에 집중(Attention)하도록 설계.

### 2. 컨텍스트 윈도우 초과 및 추론 비용 증가
- **문제 상황 (Symptom)**: 여러 문서를 프롬프트에 그대로 주입할 경우 LLM의 입력 제한 토큰을 초과하거나, 과도한 컨텍스트 크기로 인해 API 요금 급증 및 속도 저하 발생.
- **원인 분석 (Root Causes)**: Multi-Hop 검색 구조 특성상 다수의 관련 후보 문서를 확보해야 하므로 입력 컨텍스트 길이가 지나치게 늘어남.
- **해결 방안 (Solution)**: **Token Thresholding & Conditional Summarization** 구조를 구축함. 전체 텍스트 길이가 사전에 지정된 `TOKEN_THRESHOLD`를 초과할 경우에만, Reranker의 스코어 가중치를 활용하여 `FLAN-T5-Base` 모델이 핵심 정보 위주로 점진적인 문서 요약(Compression)을 수행하게 설계하여 입력 토큰 수를 절반 이하로 최적화함.
