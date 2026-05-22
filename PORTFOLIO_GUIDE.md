# 🚀 포트폴리오 사이트 관리 및 컨텐츠 수정 가이드 (PORTFOLIO_GUIDE.md)

이 문서는 `gloveman.github.io` 포트폴리오 사이트의 구조를 설명하고, 향후 프로젝트 추가/수정, 이력서(Resume) 업데이트 및 배포를 진행할 때 참고할 수 있도록 작성된 가이드라인입니다.

---

## 📂 1. 핵심 디렉토리 및 파일 구조

```text
gloveman.github.io/
├── assets/css/extended/
│   ├── custom.css          # 전역 공통 커스텀 스타일 (폰트, 루트 변수 등)
│   └── resume.css          # 이력서 전용 스타일 (타임라인, 카드 디자인 등)
├── content/
│   ├── resume.md           # 이력서 페이지 메타데이터 (layout: resume 지정)
│   └── projects/
│       ├── _index.md       # 프로젝트 목록 페이지 정의 (layout: list 지정)
│       ├── <slug>/         # 개별 프로젝트 폴더 (Leaf Bundle)
│       │   └── index.md    # 프로젝트 상세 소개글 (categories: ["Project"] 필수)
│       └── <slug>-troubleshooting.md  # 개별 프로젝트 트러블슈팅 글 (url 오버라이드 필수)
├── data/
│   └── resume.yaml         # 이력서 구조화 데이터 (인적사항, 스크랩, 스킬, 프로젝트 목록)
├── layouts/
│   ├── index.html          # 메인 홈 화면 커스텀 템플릿
│   ├── projects/
│   │   └── list.html       # 프로젝트 목록 카드 레이아웃
│   └── resume/
│       └── single.html     # data/resume.yaml 데이터를 읽어 렌더링하는 이력서 레이아웃
└── static/images/          # 프로젝트 상세 내에 삽입할 이미지 자원
```

---

## ✍️ 2. 컨텐츠 수정 및 추가 방법

### 2.1. 프로젝트 상세 글 수정 및 신규 추가
프로젝트는 **소개 글(index.md)**과 **트러블슈팅 글(<slug>-troubleshooting.md)**이 1대1 쌍을 이룹니다.

#### 1) 프로젝트 소개글 작성 (`content/projects/<slug>/index.md`)
새 프로젝트 디렉토리(예: `my-new-project`)를 생성하고 `index.md` 파일을 작성합니다.
```yaml
---
title: "프로젝트명: 핵심 부제"
date: 2026-05-22                        # 빌드 시간보다 이전 또는 당일이어야 노출됨 (UTC 기준 미래날짜 지양)
description: "Recruiter의 이목을 끄는 1줄 요약 설명"
tags: ["Python", "FastAPI", "React"]   # 기술 스택 태그
categories: ["Project"]                # 프로젝트 목록 카드로 렌더링되기 위해 필수 지정
---

![대표 이미지](/images/my-project-image.png)

## 📝 프로젝트 개요 (Overview)
- **핵심 가치**: ...
- **해결한 문제**: ...

## 🛠️ 기술 스택 & 아키텍처 (Tech Stack & Architecture)
- **주요 기술**: ...
- **아키텍처 패턴**: ...

## 🎯 핵심 기능 (Key Features)
- **기능 1**: ...
- **기능 2**: ...

---

### 🔍 관련 문서
- [**Troubleshooting 상세 보기**](troubleshooting/) : 특정 기술적 한계 돌파 내용 링크
- [**프로젝트 Wiki 상세 보기 (더 보기)**](https://github.com/.../wiki) : 외부 위키 링크 (더보기 링크)
```

#### 2) 트러블슈팅 글 작성 (`content/projects/<slug>-troubleshooting.md`)
**중요**: 트러블슈팅 글은 프로젝트 폴더 내부가 아닌 `content/projects/` **루트 위치**에 생성해야 합니다. URL이 매칭되도록 프론트매터의 `url` 설정을 명시해야 합니다.
```yaml
---
title: "프로젝트명 : Troubleshooting"
date: 2026-05-22
description: "핵심 트러블슈팅 요약 (예: 메모리 누수 및 캐싱 최적화 해결)"
url: "/projects/<slug>/troubleshooting/"   # 이 설정으로 위의 소개글 링크(/projects/<slug>/troubleshooting/)와 자동 연동됩니다.
---

## 🚀 기술적 도전 및 문제 해결 (Technical Challenges & Troubleshooting)

### 1. 문제 상황 1
- **문제 상황 (Symptom)**: ...
- **원인 분석 (Root Causes)**: ...
- **해결 방안 (Solution)**: ...
```

---

### 2.2. 이력서(Resume) 내용 업데이트
현재 이력서 화면은 마크다운 내에 HTML을 직접 적지 않고, **`data/resume.yaml`**의 구조화 데이터를 읽어서 템플릿화합니다. 내용 수정 시에는 `data/resume.yaml` 파일의 키값을 채워 넣으시면 됩니다.

- **스킬셋 수정**: `skills` 섹션 하위의 태그를 가감합니다.
- **인적 정보 수정**: `contact` 아래의 주소들을 변경합니다.
- **이력서 내 프로젝트 리스트**: `projects` 하위에 `bullets`나 프로젝트 요약을 추가/삭제합니다.

---

## 🖥️ 3. 로컬 테스트 및 배포

### 3.1. 로컬 환경에서 테스트
1. VS Code 또는 터미널을 엽니다.
2. 로컬 웹 서버를 실행합니다:
   ```bash
   hugo server -D
   ```
   *(conda 환경을 사용 중이라면 `conda activate base` 이후 `hugo server -D` 실행)*
3. 브라우저에서 `http://localhost:1313`으로 접속하여 레이아웃 및 링크(더보기, 트러블슈팅)가 깨지지 않는지 실시간으로 확인합니다.

### 3.2. 실서버 배포
수정이 완료되면 Git을 통해 원격 저장소(`main` 브랜치)로 커밋 후 푸시하면 GitHub Actions가 자동으로 실행되어 빌드 및 배포가 완료됩니다.

```bash
# 1. 변경된 파일 확인 및 스테이징
git status
git add .

# 2. 커밋 메시지 작성 (Conventional Commits 포맷 권장)
git commit -m "docs: update my-project details and add wiki links"

# 3. GitHub 원격 저장소로 푸시 (자동으로 Actions CI 빌드 트리거)
git push origin main
```
배포 성공 여부는 GitHub 저장소의 **[Actions]** 탭에서 실시간 빌드 로그를 통해 확인할 수 있습니다.

---
💡 **참고 사항**:
- 외부 위키 상세 보기 링크(더 보기)는 프로젝트 설명 글 `index.md` 하단의 `### 🔍 관련 문서` 단락에 추가해 주시면 화면 최하단에 통일된 디자인으로 깔끔하게 매핑됩니다.

---

## 🤖 4. 타 컴퓨터로 이관 및 AI 프롬프트 지시 가이드

### 4.1. 새로운 컴퓨터에서 AI(Antigravity) 세션을 열었을 때 지시법
새로운 컴퓨터에서 `git clone` 후 작업을 이어갈 때, AI가 이전 리팩토링 맥락을 알지 못해 엉뚱한 방향으로 코드를 수정하는 등의 문제를 방지하기 위해 **첫 프롬프트로 다음과 같이 지시**해 주시면 됩니다:
> "`.antigravity/` 폴더 내에 있는 `implementation_plan.md`, `task.md`, `walkthrough.md` 파일을 참조해서 이전 진행 상황과 설계 맥락을 먼저 완전히 분석해줘. 그리고 이어서 [원하는 작업 내용]을 진행해 주면 돼."

### 4.2. 아티팩트 자동 동기화 설정 (Git Hook)
로컬 브레인의 실시간 진행 상황(`walkthrough.md`, `task.md` 등)이 수정될 때마다 자동으로 `.antigravity/` 디렉토리에 복사 및 스테이징되도록 Git Hook을 설정해 두었습니다.
새로운 기기에서 레포지토리를 다운받은 후, **최초 1회 아래 명령어를 터미널에 입력**하면 자동 동기화 기능이 활성화됩니다:
```bash
git config core.hooksPath .githooks
```
이후 `git commit` 명령어를 실행할 때마다 `sync_artifacts.ps1` 스크립트가 백그라운드에서 실행되어 현재 개발 세션 브레인 폴더의 최신 마크다운 파일들을 자동으로 복사하고 커밋 스테이지에 추가합니다.

