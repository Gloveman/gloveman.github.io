---
title: "OTT 사용자 이탈(Churn) 예측 머신러닝 파이프라인 : Troubleshooting"
date: 2026-02-28
description: "모델 직렬화 불일치 및 불균형 데이터 임계값 최적화 해결"
---

## 🚀 기술적 도전 및 문제 해결 (Technical Challenges & Troubleshooting)

### 1. 모델 직렬화 명칭 불일치에 따른 로딩 실패
- **문제 상황 (Symptom)**: 학습이 끝난 가중치를 파일로 저장하고, 대시보드(App/Inference Stage)에서 이 모델 패키지를 불러와 실시간 추론을 돌리려 할 때, 파일 저장 경로 또는 클래스 인스턴스 미매칭 오류(`FileNotFoundError` / `KeyError`)로 서빙 파이프라인 단절 발생.
- **원인 분석 (Root Causes)**: `model_config.json` 설정에 사용된 이름 키값(`XGBoost`)과 학습을 위해 동적으로 호출되는 Scikit-Learn wrapper의 실제 클래스명(`XGBClassifier`)을 `ModelManager`가 혼용하여 저장 폴더 및 파일 명명 시 괴리 발생.
- **해결 방안 (Solution)**: `ModelManager` 클래스에 모델 클래스명과 설정 파일의 명칭을 명시적으로 이어주는 매핑 딕셔너리(`model_name` 매퍼)를 구현하여 저장 규칙 단일화. 직렬화되는 바이너리 파일 내에 메타데이터(훈련 시점의 피처 리스트, 하이퍼파라미터 로그, 전처리 스케일러 정보)를 함께 패키징하도록 설계하여 추론 환경에서의 입력 호환성을 보장함.

### 2. 불균형 데이터 세트에서의 이탈 예측 왜곡
- **문제 상황 (Symptom)**: 전체 고객 데이터셋 중 이탈(Churn)을 선언한 마이너리티 클래스의 비중이 너무 적어, 일반적인 분류 임계값(0.5)을 사용했을 때 모델이 대다수의 잠재 이탈자를 정상 유지 유저로 잘못 분류(높은 Precision 대비 심각하게 낮은 Recall 발생).
- **원인 분석 (Root Causes)**: 머신러닝 알고리즘이 샘플 수가 훨씬 많은 다수 클래스(정상 유저)의 분류를 정확히 맞추는 방향으로 손실 함수를 최적화하여 판정 선(Decision Boundary)이 한쪽으로 편향됨.
- **해결 방안 (Solution)**: 
  - XGBoost 모델 선언 시 **`scale_pos_weight`**를 불균형 비율에 역비례하도록 계산하여 강제 주입.
  - 검증 셋을 통해 예측 확률 임계값을 0.1부터 0.9까지 그리드 스캐닝하여 Macro F1-score와 Recall의 조화평균이 최대화되는 **Optimal Threshold(최적 임계값)**를 산출하여 배포 모델 객체의 속성값에 고정으로 빌드함.
