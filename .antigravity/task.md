# Hugo Portfolio 풀 리팩토링 Task

## Phase 1 — GeekNews 제거 & 데이터 정리
- [x] `data/geeknews.json` 삭제
- [x] `scripts/scraper/` 디렉토리 삭제
- [x] `.github/workflows/hugo.yaml` → `Debug Output` 스텝 제거

## Phase 2 — 이력서 데이터 & 레이아웃 분리
- [x] `data/resume.yaml` 생성 (이름, 연락처, 스킬, 프로젝트, 자격증, 학력 구조화)
- [x] `layouts/resume/single.html` 생성 (YAML 데이터를 읽는 전용 레이아웃)
- [x] `content/resume.md` 수정 (HTML 인라인 제거, `layout: "resume"` 지정)

## Phase 3 — Projects 목록 카드 레이아웃
- [x] `layouts/projects/list.html` 생성 (카드 그리드 레이아웃)
- [x] `content/projects/_index.md` 수정 (플레이스홀더 제거)
- [x] `assets/css/extended/projects.css` 생성 (카드 전용 스타일)

## Phase 4 — 홈 페이지 커스텀 레이아웃
- [x] `layouts/index.html` 생성 (PaperMod profileMode 오버라이드)
- [x] Hero 섹션 (float 애니메이션 + 링 pulse)
- [x] Quick Stats 섹션 (프로젝트 수, 스킬 등)
- [x] Featured Projects 미리보기 섹션
- [x] `content/_index.md` 수정

## Phase 5 — CSS 디자인 전면 고도화
- [x] `assets/css/extended/custom.css` 확장 (변수, 애니메이션, 공통 컴포넌트)
- [x] `assets/css/extended/resume.css` 고도화 (그라디언트 헤더, sticky 사이드바, 애니메이션 타임라인)
- [x] `assets/css/extended/projects.css` 생성 (카드 hover 효과, 태그 뱃지)
- [x] `layouts/partials/extend_head.html` 업데이트 (Google Fonts Inter + Noto Sans KR 추가)

## Phase 6 — 검증
- [x] GitHub Actions 마는 데플로이 확인
- [x] 홈/이력서/프로젝트 페이지 렌더링 확인
- [x] 다크모드/라이트모드 CSS 변수 적용
- [x] 모바일 반응형 (CSS grid media query 적용됨)

## Phase 7 — 포트폴리오 프로젝트 설명 고도화 및 이미지 싱크
- [x] 전체 통합 프로젝트 분석 보고서 작성 (`portfolio_projects.md`)
- [x] 기존 개별 프로젝트 페이지 (`index.md` & `troubleshooting.md`) 내용 업데이트
- [x] 신규 `nlp-project` 생성 및 내용 기입 (`index.md` & `troubleshooting.md`)
- [x] `static/images/` 내의 44개 프로젝트 관련 이미지 Git 추적 및 Push 완료

## Phase 8 — 트러블슈팅 페이지 404 해결 및 위키/가이드 작성
- [x] 중첩 `troubleshooting.md` 파일을 `content/projects/<slug>-troubleshooting.md`로 마이그레이션 및 삭제
- [x] `layouts/projects/list.html` 및 `layouts/index.html`에서 트러블슈팅 페이지 카드 제외 필터 적용
- [x] UTC 시간대 빌드 시 `nlp-project` 누락을 방지하기 위한 날짜 조정 (`2026-05-22`)
- [x] 3차/4차 프로젝트 하단 외부 위키 링크("더 보기") 마크다운 삽입 완료
- [x] 향후 관리용 [PORTFOLIO_GUIDE.md](file:///e:/gloveman.github.io/PORTFOLIO_GUIDE.md) 가이드 문서 작성
- [x] 모든 변경 사항 Git 커밋 및 Push 완료 (`git push`)

## Phase 9 — 자동 Push 및 타 컴퓨터 동기화 보강
- [x] 자동 push를 지원하는 `.githooks/post-commit` 생성
- [x] `PORTFOLIO_GUIDE.md` 파일에 post-commit 및 자동 push 가이드 업데이트
- [x] 전체 변경 사항 커밋 및 push 확인 (pre-commit에 의한 `.antigravity/` 싱크 및 post-commit에 의한 자동 push 확인 완료)

