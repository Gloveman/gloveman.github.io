# Hugo Portfolio 풀 리팩토링 계획 (확정)

## 현황 분석

현재 `gloveman.github.io`는 Hugo + PaperMod 테마 기반의 포트폴리오 사이트로, 아래의 구조를 가지고 있습니다.

### 현재 구조
```
content/
  _index.md          ← 홈 (profileMode 활용)
  resume.md          ← 이력서 (HTML 직접 삽입)
  search.md          ← 검색 페이지
  projects/
    _index.md        ← 프로젝트 목록 (내용 미작성)
    job-pocket/      ← 프로젝트 상세
    mobility-system/
    olfit/
    ott-churn/
assets/css/extended/
  resume.css         ← 이력서 전용 CSS
  custom.css         ← 홈 미세 스타일 (16줄)
layouts/partials/
  extend_head.html   ← Font Awesome CDN 로드
data/
  geeknews.json      ← GeekNews 스크랩 데이터
scripts/scraper/     ← 비어있음 (스크래퍼 코드 없음)
```

---

## 발견된 문제점 및 개선 기회

### 🔴 Critical (구조적 문제)

1. **`resume.md`에 HTML 직접 인라인**: 이력서 전체가 `content/resume.md` 안에 raw HTML로 작성되어 있어 Hugo의 콘텐츠-레이아웃 분리 원칙에 위배됩니다. 유지보수가 어렵고, 마크다운 에디터에서 가독성이 떨어집니다.
2. **`scripts/scraper/` 비어있음**: GeekNews 스크래퍼 코드 없이 데이터(`geeknews.json`)만 존재. 자동화 워크플로와 연동이 없어 데이터가 수동으로 관리됩니다.
3. **GeekNews 데이터가 홈/어느 페이지에도 렌더링되지 않음**: `data/geeknews.json`이 존재하지만 이를 실제로 표시하는 레이아웃/템플릿이 없습니다.
4. **`projects/_index.md`**: "여기에 프로젝트 목록이 들어갈 예정입니다." 라는 플레이스홀더 텍스트가 남아있음.

### 🟡 Medium (디자인/UX 문제)

5. **홈페이지가 PaperMod 기본 profileMode에 의존**: `_index.md`가 단 7줄로, 커스텀 홈 레이아웃이 없어 개성이 부족합니다.
6. **GeekNews 섹션에 레이아웃/스타일 없음**: 단순 JSON 데이터로만 관리되고 있어 사용자에게 노출되지 않습니다.
7. **`custom.css`가 16줄에 불과**: 사이트 전반적인 디자인 커스터마이징이 거의 없습니다.
8. **프로젝트 페이지**: 각 프로젝트 상세 페이지는 있지만, Projects 목록 페이지(`_index.md`)가 카드형 레이아웃이 아닌 PaperMod 기본 리스트 뷰로 표시됩니다.

### 🟢 Minor (최적화)

9. **`resume.md`의 `layout: "single"`**: 이력서 전용 레이아웃이 없어 PaperMod 기본 single 레이아웃을 그대로 사용합니다.
10. **GitHub Actions에 `Debug Output: ls -R ./public`** 스텝이 남아있음 (디버그 스텝 정리 필요).

---

## 개선 계획 (옵션 선택 필요)

아래 중 어떤 범위로 진행할지 선택해주세요.

### Option A: 핵심 리팩토링 (구조 개선 위주)
구조적 문제를 해결하고 GeekNews 기능을 완성합니다.

1. **`resume.md` 리팩토링**: HTML 인라인을 제거하고 Hugo 데이터 파일(`data/resume.yaml`) + 전용 레이아웃(`layouts/resume/single.html`)으로 분리
2. **GeekNews 렌더링 완성**: `data/geeknews.json`을 활용하는 전용 섹션 페이지 또는 홈 위젯 구현
3. **Projects 목록 페이지**: 카드형 레이아웃(`layouts/projects/list.html`) 추가
4. **GitHub Actions 정리**: 디버그 스텝 제거, GeekNews 자동 스크래핑 워크플로 추가

### Option B: 디자인 전면 개선 (외관 개선 위주)
현재 구조를 유지하면서 시각적으로 훨씬 멋지게 만듭니다.

1. **커스텀 홈 레이아웃**: PaperMod profileMode를 오버라이드하여 animated hero 섹션, 스킬 뱃지, GeekNews 위젯을 한 페이지에 배치
2. **Resume 페이지 시각 고도화**: 현재 CSS를 확장하여 glassmorphism 카드, 애니메이션 타임라인, 스킬 프로그레스 바 추가
3. **Projects 카드 디자인**: 프로젝트 카드에 태그 뱃지, hover 효과, 기술 스택 아이콘 추가
4. **GeekNews 위젯**: 홈 페이지에 실시간 기술 뉴스 피드 위젯으로 표시

### Option C: 풀 리팩토링 (A + B 통합)
구조 개선 + 디자인 개선을 모두 진행합니다.

---

## Open Questions

> [!IMPORTANT]
> **Q1. 개선 범위**: Option A (구조), Option B (디자인), Option C (전체) 중 어느 방향으로 진행할까요?

> [!IMPORTANT]
> **Q2. GeekNews 기능 방향**: 현재 `data/geeknews.json`이 홈에서 보이지 않습니다. 이 기능을 어떻게 표시하고 싶으신가요?
> - (a) 홈 페이지 하단에 위젯/섹션으로 표시
> - (b) 별도 `/geeknews/` 페이지 생성
> - (c) 기능 자체를 제거하고 포트폴리오에만 집중

> [!IMPORTANT]
> **Q3. 이력서 데이터 분리**: `resume.md`의 HTML을 Hugo 데이터 파일로 분리하는 리팩토링을 원하시나요? (장점: 구조적으로 깔끔, 단점: 작업량 증가)

> [!IMPORTANT]
> **Q4. GeekNews 자동화**: GitHub Actions에서 주기적으로 GeekNews를 스크래핑하여 `data/geeknews.json`을 자동 업데이트하는 워크플로를 추가할까요?

---

## Proposed Changes (Option C 기준)

### 1. 데이터 레이어 리팩토링

#### [NEW] `data/resume.yaml`
이력서 데이터를 구조화된 YAML 파일로 추출 (이름, 연락처, 스킬, 프로젝트, 자격증, 학력)

---

### 2. 레이아웃 개선

#### [MODIFY] `layouts/partials/extend_head.html`
Font Awesome 외 Google Fonts (Pretendard 대체 또는 보완) 추가

#### [NEW] `layouts/resume/single.html`
`data/resume.yaml`을 읽어 렌더링하는 전용 이력서 레이아웃

#### [NEW] `layouts/projects/list.html`
카드 그리드 형태의 프로젝트 목록 레이아웃

#### [NEW] `layouts/partials/geeknews.html`
GeekNews 뉴스 피드 위젯 partial

#### [NEW] `layouts/index.html` (optional)
홈 페이지 커스텀 레이아웃 (profileMode 오버라이드)

---

### 3. CSS 개선

#### [MODIFY] `assets/css/extended/custom.css`
전역 커스텀 스타일 확장 (변수 정의, 애니메이션, 공통 컴포넌트)

#### [MODIFY] `assets/css/extended/resume.css`
이력서 디자인 고도화 (glassmorphism, 애니메이션 타임라인)

#### [NEW] `assets/css/extended/projects.css`
프로젝트 카드 전용 스타일

#### [NEW] `assets/css/extended/geeknews.css`
GeekNews 위젯 스타일

---

### 4. 콘텐츠 정리

#### [MODIFY] `content/projects/_index.md`
플레이스홀더 텍스트 제거

#### [MODIFY] `content/resume.md`
HTML 인라인 제거, 레이아웃 변경 (`layout: "resume"`)

---

### 5. CI/CD 개선

#### [MODIFY] `.github/workflows/hugo.yaml`
`Debug Output` 스텝 제거

#### [NEW] `.github/workflows/scrape-geeknews.yaml` (선택)
주기적 GeekNews 스크래핑 자동화

#### [NEW] `scripts/scraper/scrape_geeknews.py`
GeekNews 스크래퍼 Python 스크립트

---

## Verification Plan

### Manual Verification
- `hugo server -D` 로컬 실행 후 각 페이지 확인
- 모바일 반응형 레이아웃 확인
- 다크모드/라이트모드 전환 시 CSS 변수 정상 작동 확인
- GitHub Actions 워크플로 실행 확인
