---
title: "목적지 주변 주차장 & 주유소 조회 시스템"
date: 2026-02-06
description: "공공데이터와 실시간 API를 활용한 위치 기반 모빌리티 서비스"
tags: ["Python", "Streamlit", "MySQL", "Open API", "Folium"]
categories: ["Project"]
---

![Mobility System ERD](/images/mobility_erd.png)

## 🚗 프로젝트 개요
**"복잡한 검색 과정 없이 직관적으로 탐색하는 주변 시설 조회 시스템"**

공공데이터 기반의 MySQL 공간 쿼리를 활용해 목적지 반경 내 시설을 정밀하게 필터링하며, 지도 시각화와 카드 UI를 통해 사용자에게 최적의 모빌리티 환경을 제공합니다.

## 👨‍💻 My Contributions
- **프로젝트 매니징(PM)**: 팀 전체 일정 관리 및 백엔드-프론트엔드 간의 인터페이스 설계 주도.
- **공간 쿼리(Spatial Query) 구현**: MySQL의 위도/경도 데이터를 활용하여 반경 내 주차장을 추출하는 고정밀 필터링 로직 개발.
- **하이브리드 데이터 파이프라인 설계**: 정적 공공데이터(MySQL)와 동적 가격 데이터(API)를 분리하여 시스템 가용성과 정보의 신뢰성을 동시에 확보하는 구조 설계.
- **DB 스키마 설계 및 데이터 적재**: 수만 건의 주차장 공공데이터를 정제하여 효율적인 조회가 가능한 ERD 설계 및 DB 마이그레이션 수행.

## 💻 Tech Stack
- **Backend**: Python, MySQL
- **Frontend**: Streamlit, Folium (Maps)
- **Data**: Pandas, Open API Ingestion

---

### 🔍 관련 문서
- [**Troubleshooting 상세 보기**](troubleshooting/) : 공간 쿼리 성능 최적화 및 DB 연결 안정화
