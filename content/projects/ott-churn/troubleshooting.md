---
title: "튈까말까: Troubleshooting"
date: 2026-02-28
description: "모델 저장/로드 시 식별자 불일치 및 설정값 참조 로직 수정"
---

## 🛠 문제 상황 (Critical Issues)
모델 학습 파이프라인 통합 과정에서 다음과 같은 오류가 발생했습니다.
1. **식별자 불일치**: 설정 파일의 키값(`XGBoost`)과 실제 저장된 폴더명(`XGBClassifier`)이 달라 모델 로드 시 경로를 찾지 못함.
2. **설정 참조 오류**: `DataProcessor`가 중첩된 JSON 설정 구조(nested dict)를 잘못 참조하여 기본값으로만 작동하는 현상 발견.

## 🔍 원인 분석 (Root Causes)
1. **객체 기반 명명 규칙**: 모델 객체의 클래스명을 그대로 저장 폴더명으로 사용하면서, 추상화된 설정 파일의 명칭과 괴리가 발생함.
2. **Config Path 오설정**: `test_size` 등의 파라미터가 `train_config` 내부에 있음에도 최상위 depth에서 찾으려 시도함.

## 💡 해결 방법 (Solution)
1. **명시적 매핑 도입**: `ModelManager.save_model_package`가 명시적인 `model_name`을 인자로 받도록 수정하여 설정값과 폴더명을 통일.
2. **설정 참조 로직 수정**: `self.model_cfg.get('train_config', {}).get('test_size')` 형태로 중첩 구조를 정확히 탐색하도록 변경.

## ✅ 결과 및 교훈
- **시스템 안정성**: 모델 학습 후 즉시 추론 서비스로 연결되는 파이프라인의 견고함 확보.
- **교훈**: 규모가 큰 프로젝트일수록 **명칭 규칙(Naming Convention)**과 **설정값 구조**를 문서화하고 엄격하게 관리하는 것이 통합 비용을 줄이는 길임을 배웠습니다.
