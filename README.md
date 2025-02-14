# pwsh_tools
适用于 PowerShell 的一些方便学习工作用的脚本，大部分由 AI 生成   
[![Moe Counter!](https://count.getloli.com/get/@pwsh_tools.github?theme=3d-num&padding=7&offset=0&align=top&scale=.5&pixelated=1&darkmode=auto)](https://count.getloli.com/)

### [查找窗口标题并设置窗口尺寸](set_window_size.ps1)

```powershell
# 将标题包含"记事本"的窗口调整为 800x600
set_window_size.ps1 -WindowTitle "记事本" -Width 800 -Height 600
```

### [批量修改文件的创建时间、修改时间和访问时间](update_file_time.ps1)

#### 参数说明
- `-DateTime`: 要设置的目标时间，格式为 "yyyy-MM-dd HH:mm:ss"
  - 例如：2024-03-20 14:30:00
- `-File`: 单个文件的完整路径
- `-Files`: 多个文件的完整路径，用空格分隔

#### 示例
##### 修改单个文件
```powershell
update_file_time.ps1 -DateTime "2025-02-09 10:05:00" -File "C:\path\to\file.txt"
```

##### 修改多个文件
```powershell
update_file_time.ps1 -DateTime "2025-02-09 10:05:00" -Files "file1.txt file2.txt file3.txt"
```

##### 同时指定单个文件和多个文件
```powershell
update_file_time.ps1 -DateTime "2025-02-09 10:05:00" -File "single.txt" -Files "file1.txt file2.txt"
```
