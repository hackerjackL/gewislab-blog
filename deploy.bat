@echo off
chcp 65001 >nul
echo ═══════════════════════════
echo  GewisLab 博客 — 一键部署
echo ═══════════════════════════
echo.

set OBSUTIL=.obsutil\obsutil_windows_amd64_5.8.3\obsutil.exe

if not exist %OBSUTIL% (
    echo [!] obsutil 未找到，正在下载...
    powershell -Command "Invoke-WebRequest -Uri 'https://obs-community.obs.cn-north-1.myhuaweicloud.com/obsutil/current/obsutil_windows_amd64.zip' -OutFile '.obsutil.zip' -UseBasicParsing"
    powershell -Command "Expand-Archive -Path '.obsutil.zip' -DestinationPath '.obsutil' -Force"
    del .obsutil.zip
    echo [✓] obsutil 下载完成
    echo.
)

echo [1/2] 上传 HTML 文件...
%OBSUTIL% cp index.html obs://gewislab-blog/index.html -f

echo.
echo  ⚠️ 华为云 OBS 默认域名强制下载，无法在线预览
echo  建议用 GitHub Pages: https://hackerjackL.github.io/gewislab-blog/
echo.
echo ═══════════════════════════
echo  ✓ 部署完成！
echo ═══════════════════════════
pause
