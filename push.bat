@echo off
chcp 65001 >nul
title Git 一键推送脚本 - XRJprogram.github.io
cd /d "%~dp0"

echo ========================================================
echo         XRJprogram.github.io - 一键 Git 提交流程
echo ========================================================
echo.

echo [1/3] 正在检查并暂存所有变更文件...
git add -A

echo [2/3] 检查本地提交状态...
git diff-index --quiet HEAD --
if %errorlevel% neq 0 (
    set commit_msg=update: %date% %time%
    git commit -m "%commit_msg%"
    echo 本地变更已自动提交 (Commit: %commit_msg%)。
) else (
    echo 本地工作区整洁，准备同步已暂存或已存在的本地提交...
)

echo.
echo [3/3] 正在推送到 GitHub 远端 (git push origin main)...
git push origin main

if %errorlevel% equ 0 (
    echo.
    echo ========================================================
    echo  [SUCCESS] 远端推送成功！GitHub Pages 正在自动构建部署。
    echo ========================================================
) else (
    echo.
    echo ========================================================
    echo  [ERROR] 推送失败，请检查网络代理配置或 GitHub 凭据权限。
    echo ========================================================
)

echo.
pause
