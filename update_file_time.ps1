<#
.SYNOPSIS
    修改文件的创建时间、修改时间和访问时间

.DESCRIPTION
    此脚本用于批量修改文件的时间属性，包括：
    - 创建时间（CreationTime）
    - 最后修改时间（LastWriteTime）
    - 最后访问时间（LastAccessTime）

.PARAMETER DateTime
    要设置的目标时间，格式为 "yyyy-MM-dd HH:mm:ss"
    例如：2024-03-20 14:30:00

.PARAMETER File
    单个文件的完整路径

.PARAMETER Files
    多个文件的完整路径，用空格分隔

.EXAMPLE
    # 修改单个文件
    .\update_file_time.ps1 -DateTime "2025-02-09 10:05:00" -File "C:\path\to\file.txt"

.EXAMPLE
    # 修改多个文件
    .\update_file_time.ps1 -DateTime "2025-02-09 10:05:00" -Files "file1.txt file2.txt file3.txt"

.EXAMPLE
    # 同时指定单个文件和多个文件
    .\update_file_time.ps1 -DateTime "2025-02-09 10:05:00" -File "single.txt" -Files "file1.txt file2.txt"
#>

param (
    [Parameter(Mandatory=$true)]
    [DateTime]$DateTime,
    
    [Parameter(Mandatory=$false)]
    [string]$File,
    
    [Parameter(Mandatory=$false)]
    [string]$Files
)

# 显示开始处理的信息
Write-Host "开始处理文件时间修改..." -ForegroundColor Green
Write-Host "目标时间: $DateTime" -ForegroundColor Yellow

# 初始化文件列表数组
$FileList = @()

# 处理单个文件参数
if ($File) {
    $FileList += $File
}

# 处理多个文件参数
if ($Files) {
    $FileList += $Files -split " "
}

# 检查是否有文件需要处理
if ($FileList.Count -eq 0) {
    Write-Host "错误：必须指定至少一个文件（使用 -File 或 -Files 参数）" -ForegroundColor Red
    exit
}

foreach ($file in $FileList) {
    try {
        if (Test-Path $file) {
            $item = Get-Item $file
            $item.CreationTime = $DateTime
            $item.LastWriteTime = $DateTime
            $item.LastAccessTime = $DateTime
            
            Write-Host "成功修改文件: $file" -ForegroundColor Green
        } else {
            Write-Host "文件不存在: $file" -ForegroundColor Red
        }
    }
    catch {
        Write-Host "处理文件时出错: $file" -ForegroundColor Red
        Write-Host $_.Exception.Message -ForegroundColor Red
    }
}

Write-Host "处理完成!" -ForegroundColor Green