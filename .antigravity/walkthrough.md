# Portfolio Improvements & Project Analysis Walkthrough

This document summarizes the changes made to resolve issues with the Hugo portfolio site and the comprehensive analysis conducted on the user's projects (`NLPproject`, `1st_project`, `2nd_project`, `3rd_project\job-pocket`, `4th_project\olfit`) to create a developer portfolio.

## Accomplishments

### 1. Hugo Portfolio Site Fixes & Enhancement
- **GitHub Pages 404 Resolved**: Discovered that changing the source from "Deploy from branch" to "GitHub Actions" required a fresh commit to trigger a deployment. Staged, committed, and pushed a `.gitignore` to ignore build files (`/public/`, `/resources/`, `/.hugo_build.lock`), which triggered the GitHub Actions run and successfully deployed the site.
- **Local Build Verification**: Configured the Windows Path environment variables locally and verified the local Hugo build (`hugo --gc --minify`) runs and succeeds without errors.
- **Resume Data Separation**: Migrated the raw inline HTML from `content/resume.md` into a structured Hugo data file at `data/resume.yaml` and created a custom layout at `layouts/resume/single.html` to keep the layout separated from the content.
- **Projects Card Layout**: Replaced the default PaperMod list layout for projects with a custom grid of project cards via `layouts/projects/list.html` and styled it with hover effects and tag badges.
- **Custom Home Layout**: Created a premium, interactive homepage template `layouts/index.html` featuring a floating Hero section and Quick Stats summary.

### 2. Developer Portfolio Project Document (`portfolio_projects.md`)
- Prepared a professional, recruiter-focused portfolio analysis at [portfolio_projects.md](file:///C:/Users/MSI/.gemini/antigravity/brain/0b234da5-900d-435a-b7db-d02886bc7513/portfolio_projects.md).
- The document analyzes the codebases and structures of the five projects using a 5-section layout:
  1. **프로젝트 개요 (Overview)**: 3-line elevator pitch highlighting the core value proposition.
  2. **기술 스택 & 아키텍처 (Tech Stack & Architecture)**: Modular breakdown and architecture patterns.
  3. **핵심 기능 (Key Features)**: Key components and their mapping to code files.
  4. **기술적 도전 및 문제 해결 (Technical Challenges & Troubleshooting)**: Deep dives into data pre-processing, performance scaling, VLM text parsing, and API race conditions.
  5. **성장 포인트 및 회고 (Takeaways)**: Value and skill demonstration points for hiring managers.

### 3. Clean URL Troubleshooting Pages & External Wiki Links
- **Redirects & Leaf Bundle Fix**: Migrated nested `troubleshooting.md` files out of leaf bundles into the root `content/projects/` as `<project-slug>-troubleshooting.md`, setting `url` redirects in front matter to maintain `/projects/<slug>/troubleshooting/` URLs cleanly.
- **Card List Filtering**: Modified `layouts/projects/list.html` and `layouts/index.html` to only render pages marked with `categories: ["Project"]`. This successfully prevents troubleshooting pages from appearing as cards in the project list and Featured Projects section.
- **Timezone Future-dating Fix**: Adjusted `nlp-project` dates from `2026-05-23` to `2026-05-22` so that Hugo builds in UTC time zones (like GitHub Actions runners) do not exclude the project as future-dated.
- **Wiki Links Integration**: Added external markdown wiki links ("더 보기") to `content/projects/job-pocket/index.md` and `content/projects/olfit/index.md` at the end of the project overview under the `🔍 관련 문서` header.
- **Content Maintenance Guide**: Created a step-by-step Korean instructions manual [PORTFOLIO_GUIDE.md](file:///e:/gloveman.github.io/PORTFOLIO_GUIDE.md) in the workspace root detailing how to edit and add projects, update the resume YAML, and perform builds and deployments.
- **Project README**: Created [README.md](file:///e:/gloveman.github.io/README.md) at the root of the workspace to introduce the repository, outline its features, and link to the maintenance guide.
- **Agent Context Persistence**: Created [`.antigravity/`](file:///e:/gloveman.github.io/.antigravity) folder at the repository root and copied all the planning/design artifacts (`implementation_plan.md`, `task.md`, `walkthrough.md`, `portfolio_projects.md`) to guarantee that future Antigravity sessions on other machines can seamlessly load and understand the history of this workspace.
- **Auto-push Git Hook**: Created `.githooks/post-commit` to automatically push changes to the remote branch after a commit, facilitating seamless GitHub synchronization.
- **Guide Updates**: Updated `PORTFOLIO_GUIDE.md` with instructions on how to set up the hooks and command guidelines for new computers.

## Verification & Status

- **Live URL**: `https://gloveman.github.io/` is live and successfully deployed.
- **Git Commits & Push**:
  - `fix: resolve Mermaid rendering and layout calculations`
  - `fix: resolve Hugo deprecation warnings and update CI version`
  - `docs: restructure troubleshooting pages to fix 404 errors`
  - `refactor: filter out troubleshooting pages from project lists`
  - `docs: adjust nlp-project date to avoid future-dating`
  - `docs: add portfolio maintenance and content modification guide`
  - `docs: add README with introduction and links to maintenance guide`
  - `chore: save agent context and planning artifacts in repository`
  - `chore: add post-commit hook for auto-pushing to remote`
- All local commits have been pushed successfully to the remote `main` branch.

