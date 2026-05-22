---
title: "튈까말까: OTT 고객 이탈 예측 시스템"
date: 2026-02-28
description: "PPM 이론과 머신러닝을 활용한 Netflix 사용자 이탈 방지 솔루션"
tags: ["Machine Learning", "XGBoost", "Python", "Streamlit", "CRM"]
categories: ["Project"]
---

![Prediction Pipeline](/images/predict_diagram.png)

## 🎬 프로젝트 개요
**"사용자 행동 데이터를 기반으로 이탈 징후를 사전에 포착하는 머신러닝 솔루션"**

Netflix 사용자 행동 로그를 분석하여 이탈 가능성이 높은 고객을 식별하는 모델을 구축하고, Streamlit 대시보드를 통해 CRM 실무에 활용할 수 있도록 구현한 프로젝트입니다.

## 👨‍💻 My Contributions
- **엔드투엔드 ML 파이프라인 구축**: 데이터 수집, 전처리, 모델 학습, 추론의 전 과정을 모듈화하여 유지보수가 용이한 파이프라인 설계.
- **핵심 피처 엔지니어링**: 21만 건의 행동 로그에서 `days_since_last_watch`, `completion_rate` 등 이탈 예측에 결정적인 16개의 피처 도출 및 생성.
- **XGBoost 모델 최적화**: 클래스 불균형 문제를 해결하기 위해 `scale_pos_weight` 튜닝 및 임계값(Threshold) 최적화를 주도하여 PR-AUC 0.945 달성.
- **대규모 데이터 전처리**: 대용량 로그 데이터의 이상치 처리 및 정규화 과정을 자동화하여 모델 학습의 안정성 확보.

## 💻 Tech Stack
- **Language**: Python
- **ML/Analysis**: Scikit-learn, XGBoost, Pandas, NumPy
- **App**: Streamlit, Plotly

---

### 🔍 관련 문서
- [**Troubleshooting 상세 보기**](troubleshooting/) : 모델 식별자 불일치 및 설정 참조 오류 해결
