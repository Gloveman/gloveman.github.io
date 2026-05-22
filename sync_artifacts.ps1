# sync_artifacts.ps1
# 이 스크립트는 로컬 Gemini Antigravity 브레인 폴더에서 최신 설계 및 진행상황 아티팩트(*.md)를
# 레포지토리의 .antigravity 폴더로 자동으로 동기화합니다.

$brainDir = Join-Path $env:USERPROFILE ".gemini\antigravity\brain"

if (Test-Path $brainDir) {
    # 가장 최근에 수정된 세션 폴더(현재 활성 세션) 찾기
    $latestFolder = Get-ChildItem -Path $brainDir -Directory | 
                    Sort-Object LastWriteTime -Descending | 
                    Select-Object -First 1

    if ($latestFolder) {
        $sourcePath = $latestFolder.FullName
        $destPath = Join-Path $PSScriptRoot ".antigravity"
        
        if (-not (Test-Path $destPath)) {
            New-Item -ItemType Directory -Path $destPath -Force | Out-Null
        }

        # 마크다운 아티팩트 파일들을 복사
        Get-ChildItem -Path $sourcePath -Filter "*.md" | ForEach-Object {
            Copy-Item -Path $_.FullName -Destination $destPath -Force
        }
        Write-Output "Successfully synced artifacts from $sourcePath to $destPath"
    } else {
        Write-Warning "No session folders found in $brainDir"
    }
} else {
    Write-Warning "Gemini brain directory not found at $brainDir"
}
