---
title: "위치 기반 주차장 공간 검색 서비스"
date: 2026-02-06
description: "공공데이터와 실시간 API를 활용한 위치 기반 모빌리티 서비스"
tags: ["Python", "Streamlit", "MySQL", "Open API", "Folium", "NumPy"]
categories: ["Project"]
---

![Mobility System ERD](/images/mobility_erd.png)

## 📝 프로젝트 개요 (Overview)
- **위치 기반 인프라 탐색**: 사용자가 입력한 목적지 주변의 공공 주차장 데이터를 신속하게 탐색하고 시각화하는 **공간 검색(Spatial Search) 웹 애플리케이션**입니다.
- **신속한 의사 결정**: 목적지 좌표 변환 및 반경 1km 이내 주차장을 실시간 계산하여 **대화형 지도와 요금 정보 카드를 페이징 형태로 한눈에 비교**할 수 있게 돕습니다.

## 🛠️ 기술 스택 & 아키텍처 (Tech Stack & Architecture)
- **주요 기술**: Python, Streamlit, Folium, Streamlit-Folium, Pandas, NumPy, Geocoding API (Kakao/Tmap API 연동 등)
- **아키텍처 패턴**: **Single-Page Application (SPA) with Geoprocessing**
  - **Presentation Layer**: `Streamlit` 데코레이터와 2컬럼 레이아웃(좌측 검색 리스트, 우측 Folium 대화형 지도) 구현
  - **Service & Utility Layer**: NumPy 벡터 연산을 이용한 하버사인(Haversine) 구면 거리 계산 필터링 엔진
  - **Data Layer**: 데이터 프레임 전처리 및 메모리 적재 최적화

## 🎯 핵심 기능 (Key Features)
- **Geocoding 주소-좌표 변환** (`maptest.py`):
  - 사용자가 입력한 목적지 명칭(예: 역이름, 랜드마크)을 위도/경도 좌표쌍으로 실시간 변환
- **NumPy Vectorized Distance Filtering** (`prototype.py`):
  - 목적지 좌표 기준 반경 1km 내 주차장을 빠르게 필터링하여 정렬하는 하버사인 거리 계산 로직
- **대화형 Folium 지도 렌더링** (`prototype.py`):
  - 지도 마커 클릭 시 Streamlit 세션 상태(`st.session_state`)와 연동되어 리스트의 상세 카드 정보를 리런(Rerun)하여 동기화
- **메모리 절약형 Paging Navigation** (`prototype.py`):
  - 필터링된 주차장 리스트를 4개씩 끊어서 페이징 컨트롤러로 렌더링하여 UI 과부하 방지

## 💡 성장 포인트 및 회고 (Takeaways)
- 공공 데이터의 결측치를 정제하여 최적의 타입(Numeric)으로 변환하는 **데이터 전처리 프로세스**와 대용량 좌표 데이터 연산을 속도 저하 없이 해결하는 **벡터 연산 최적화 역량**을 확보함.

---

### 🔍 관련 문서
- [**Troubleshooting 상세 보기**](troubleshooting/) : 대용량 거리 계산 병목 및 상태 전이 최적화
