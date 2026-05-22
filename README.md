# 🚀 이창우(gloveman) 개발자 포트폴리오 웹사이트

이 레포지토리는 Hugo(PaperMod 테마)와 GitHub Pages를 기반으로 구축된 개발자 포트폴리오 및 기술 블로그용 웹사이트입니다.

- **실서버 URL**: [https://gloveman.github.io/](https://gloveman.github.io/)

---

## ✨ 주요 기능 및 특징

1. **커스텀 홈 화면**: Floating Hero 섹션과 퀵 스탯 카드로 개인의 주요 성과를 한눈에 전달합니다.
2. **구조화된 이력서 (Resume)**: HTML 코드가 인라인으로 섞여있지 않고, YAML 형식의 정형 데이터(`data/resume.yaml`)와 템플릿(`layouts/resume/single.html`)을 분리하여 유지보수성을 극대화했습니다.
3. **프로젝트 카드 갤러리**: 다양한 프로젝트들을 태그, 일자, 요약 정보가 포함된 그리드 형태의 카드 뷰로 세련되게 보여줍니다.
4. **트러블슈팅(Troubleshooting) 연동**: 프로젝트마다 발생한 고유한 기술적 문제점과 해결 방안(Symptom - Root Cause - Solution)을 정리한 전용 트러블슈팅 페이지를 Clean URL 구조(`/projects/<slug>/troubleshooting/`)로 유기적으로 연동했습니다.
5. **Mermaid 다이어그램 지원**: 시스템 구조 및 아키텍처 흐름도를 Mermaid.js 엔진을 통해 반응형 웹페이지에서 텍스트 코드로 직접 렌더링합니다.

---

## 🛠️ 기술 스택

- **정적 사이트 빌더**: Hugo (`extended` 버전)
- **테마**: PaperMod (커스텀 레이아웃 오버라이드)
- **스타일링**: Vanilla CSS
- **배포 & CI/CD**: GitHub Actions (자동 빌드 및 GitHub Pages 배포)

---

## 📖 컨텐츠 관리 가이드

이 포트폴리오 웹사이트에 신규 프로젝트를 추가하거나 이력서 데이터 등을 수정하려면 프로젝트 루트에 작성된 **[PORTFOLIO_GUIDE.md](PORTFOLIO_GUIDE.md)** 가이드 문서를 참고해 주시기 바랍니다.

- 신규 프로젝트 작성 방법 (소개글 및 트러블슈팅 1:1 연동 구조)
- `data/resume.yaml` 기반 이력서 정보 갱신 방법
- 로컬 개발 환경에서의 빌드 및 라이브 테스트 방법
- GitHub 커밋 및 자동 배포 방법
