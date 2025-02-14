param (
    [Parameter(Mandatory=$true)]
    [string]$WindowTitle,
    
    [Parameter(Mandatory=$true)]
    [int]$Width,
    
    [Parameter(Mandatory=$true)]
    [int]$Height
)

Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class Win32 {
        [DllImport("user32.dll")]
        public static extern bool MoveWindow(IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
        
        [DllImport("user32.dll")]
        public static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);
        
        public struct RECT {
            public int Left;
            public int Top;
            public int Right;
            public int Bottom;
        }
    }
"@

# 获取包含指定标题的窗口
$windows = Get-Process | Where-Object {$_.MainWindowTitle -like "*$WindowTitle*" -and $_.MainWindowHandle -ne 0}

if ($windows.Count -eq 0) {
    Write-Host "未找到包含标题 '$WindowTitle' 的窗口"
    exit
}

foreach ($window in $windows) {
    $handle = $window.MainWindowHandle
    $rect = New-Object Win32+RECT
    
    # 获取当前窗口位置
    [Win32]::GetWindowRect($handle, [ref]$rect)
    $currentX = $rect.Left
    $currentY = $rect.Top
    
    # 保持原来的位置，只改变宽度和高度
    [Win32]::MoveWindow($handle, $currentX, $currentY, $Width, $Height, $true)
    
    Write-Host "已调整窗口大小：'$($window.MainWindowTitle)'"
}