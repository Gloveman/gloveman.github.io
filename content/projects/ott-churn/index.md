---
title: "OTT 사용자 이탈(Churn) 예측 머신러닝 파이프라인"
date: 2026-02-28
description: "PPM 이론과 머신러닝을 활용한 Netflix 사용자 이탈 방지 솔루션"
tags: ["Machine Learning", "XGBoost", "Python", "Streamlit", "CRM", "RandomForest"]
categories: ["Project"]
---

![Prediction Pipeline](/images/predict_diagram.png)

## 📝 프로젝트 개요 (Overview)
- **선제적 고객 관리**: OTT 플랫폼 구독자의 행동 로그 및 결제 이력을 모델링하여 **이탈 위험도가 높은 고객을 선제적으로 예측 및 감지하는 ML 파이프라인**입니다.
- **예측력 극대화**: 21만 건의 대규모 비정형 행동 로그를 분석해 도출한 16가지 고유 피처와 XGBoost 앙상블 기법으로 **PR-AUC 0.945라는 고성능 모델을 제공**합니다.

## 🛠️ 기술 스택 & 아키텍처 (Tech Stack & Architecture)
- **주요 기술**: Python, XGBoost, Scikit-Learn, Pandas, NumPy, Joblib, Streamlit (Dashboard), JSON/YAML Configs
- **아키텍처 패턴**: **Config-Driven ML Pipeline (구성 정의 기반 머신러닝 아키텍처)**
  - **Data Ingestion & Pipeline**: `data_processor.py`를 활용해 원본 CSV 로드, 전처리, 스케일링, Train-Test Split을 모듈화하여 관리
  - **Model Training & Manager**: `model_config.json` 설정을 읽어 훈련 매개변수를 주입하고 `ModelTrainer`가 학습을 제어하며, 완성된 가중치를 `ModelManager`가 패키징하여 직렬화
  - **Inference & Visualization**: 학습된 모델 패키지를 로드하여 추론하는 `ModelPredictor`와 Streamlit 기반의 대시보드 UI 레이어 탑재

## 🎯 핵심 기능 (Key Features)
- **모듈화된 데이터 프로세싱** (`data_processor.py`):
  - 스케일러(Robust/Standard) 정보와 인코딩 정보를 저장하여 훈련과 추론 시 완벽히 동일한 데이터 변환 파이프라인 보장
- **설정 파일 기반 모델 훈련 컨트롤러** (`train.py`):
  - 하이퍼파라미터 튜닝 정보(`model_config.json`)를 바탕으로 여러 분류기(XGBoost, RandomForest)를 일관되게 학습 및 교차 검증
- **예측 임계값(Threshold) 최적화 알고리즘**:
  - Macro F1-score 및 이탈 타겟 클래스의 리콜(Recall)을 반영한 임계값 최적점을 스캐닝하여 비즈니스 효율 극대화
- **이탈 리스크 분석 대시보드** (`app.py`):
  - 특정 유저의 이탈 확률 시각화 및 피처 중요도(Feature Importance) 분석 화면 제공

## 💡 성장 포인트 및 회고 (Takeaways)
- 프로덕션 환경의 예측 모델 시스템을 위해 Jupyter Notebook의 실험적 코드를 **재사용 가능하고 엄격하게 분리된 파이프라인(OOP 기반 모듈)**으로 프로덕션 레벨 리팩토링을 수행하는 능력을 입증함.

---

### 🔍 관련 문서
- [**Troubleshooting 상세 보기**](troubleshooting/) : 모델 직렬화 불일치 및 불균형 데이터 임계값 튜닝
