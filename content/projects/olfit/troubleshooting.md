---
title: "Olfit: Troubleshooting"
date: 2026-05-18
description: "프론트엔드 이미지 업로드 중복 요청 및 레이스 컨디션 해결"
---

## 🛠 문제 상황 (Symptom)
이미지 업로드 및 분석 과정에서 다음과 같은 중복 실행 현상이 관측되었습니다.
- 업로드 로직이 2회 중복 실행됨.
- `/api/analyze/` 요청이 두 번 발생하여 서버 자원 낭비 및 리포트 상태 중복 갱신 발생.

## 🔍 원인 분석 (Root Causes)
1. **Event Bubbling**: 부모 `div`의 click handler와 자식 `input`의 click 이벤트가 겹쳐 핸들러가 이중 호출됨.
2. **In-flight Guard 부재**: 비동기로 동작하는 이미지 리사이징 및 업로드 로직 진입 시, 이미 처리 중인지 확인하는 동기적 잠금(Lock) 장치가 없었음.
3. **타이머 관리 미흡**: 분석 대기 중 표시되는 progress timer가 중복 생성되어 UI가 비정상적으로 작동함.

## 💡 해결 방법 (Solution)
1. **이벤트 흐름 개선**: `label-input` 연결 방식을 사용하여 버블링 문제를 원천 차단하거나, 부모 핸들러에서 중복 이벤트를 무시하도록 수정.
2. **Synchronous Lock 도입**: `useRef`를 활용하여 `isProcessingRef.current` 상태로 즉각적인 처리를 제어하는 가드 로직 추가.
3. **Timer Cleanup**: 새로운 분석 시작 전 이전 타이머를 명시적으로 정리(`clearInterval`)하여 UI 일관성 유지.

## ✅ 결과 및 교훈
수정 후 중복 요청이 1회로 정상화되었으며, 비동기 통신이 잦은 서비스에서는 **상태 가드(In-flight guard)**와 **이벤트 전파 제어**가 시스템 안정성에 결정적인 역할을 함을 체득했습니다.
