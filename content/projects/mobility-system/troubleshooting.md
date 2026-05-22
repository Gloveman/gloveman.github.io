---
title: "Mobility System: Troubleshooting"
date: 2026-02-06
description: "공간 쿼리 성능 개선 및 대량 데이터 처리 최적화"
---

## 🛠 문제 상황 (Challenges)
1. **쿼리 성능 저하**: 수만 건의 데이터셋에서 모든 행과 목적지 사이의 거리를 계산할 경우 검색 속도가 급격히 느려지는 현상 발생.
2. **DB 연결 불안정**: Streamlit의 비연속적인 실행 특성상 세션 유지 시간이 짧아 DB 연결 끊김 오류가 빈번함.

## 🔍 원인 분석 (Root Causes)
1. **전수 조사 방식**: `ST_Distance_Sphere`를 전체 테이블에 적용하면 인덱스를 타지 못해 성능이 저하됨.
2. **Stateless 환경**: Streamlit 앱이 재실행될 때마다 새로운 연결을 시도하거나 기존 연결을 유실하는 구조적 문제.

## 💡 해결 방법 (Solution)
1. **MBR(Minimum Bounding Box) 필터링**: 목적지 반경에 가상의 사각형 영역을 설정하고, `MBRContains`를 사용하여 1차적으로 후보군을 필터링(인덱스 활용)한 뒤 정밀 거리를 계산함.
2. **Connection Pooling & Cache**: `@st.cache_resource`를 활용하여 DB 커넥션을 캐싱하고, 연결 유실 시 자동 재연결(`reconnect=True`) 옵션을 적용.

## ✅ 결과 및 교훈
- **속도 개선**: 수만 건 데이터 기준 검색 속도를 1초 미만으로 단축.
- **교훈**: 위치 기반 서비스에서는 초기 필터링 범위를 설정하여 연산 대상을 줄이는 **공간 데이터 최적화 기법**이 필수적임을 깨달았습니다.
