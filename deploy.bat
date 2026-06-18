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

echo [1/3] 上传 HTML 文件...
%OBSUTIL% cp index.html obs://gewislab-blog/index.html -meta=content-type:text/html -f -u

echo.
echo [2/3] 上传 CSS 文件...
%OBSUTIL% cp css/style.css obs://gewislab-blog/css/style.css -meta=content-type:text/css -f -u

echo.
echo [3/3] 清理多余文件...
%OBSUTIL% rm obs://gewislab-blog/.git/ -r -f >nul 2>&1
%OBSUTIL% rm obs://gewislab-blog/.atomcode/ -r -f >nul 2>&1
%OBSUTIL% rm obs://gewislab-blog/.obsutil/ -r -f >nul 2>&1

echo.
echo ═══════════════════════════
echo  ✓ 部署完成！
echo  访问地址：
echo  https://gewislab-blog.obs-website.cn-north-4.myhuaweicloud.com/
echo ═══════════════════════════
pause
