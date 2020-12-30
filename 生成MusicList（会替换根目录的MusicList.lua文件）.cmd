@echo off
setlocal enabledelayedexpansion
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 你要生成列表的文件夹路径 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: 你的文件夹位置 , 完整位置 , 就从资源管理器(即文件夹窗口)上面的地址栏直接复制就行了
:: 分隔符用 \ , 结尾不要带 \
set filepath=C:\Users\Administrator\Desktop\新建文件夹

:: 相对于 zsound 的文件夹位置
:: 分隔符用 / , 结尾带 /
set subpath=新建文件夹

:: 音量
set volume=1

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 下面是脚本 ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set message=当前选择的文件夹是 : 
set listis=查找到的文件 :
set oggfile=*.ogg
set wavfile=*.wav
set strlen_str=%filepath%
set /a strlen_num=1

:next
if not "%strlen_str%"=="" (
	set /a strlen_num+=1
	set "strlen_str=%strlen_str:~1%"
	goto next
)

chcp 65001
@echo .
@echo %message%%filepath%
@echo .
@echo return>MusicList.lua
@echo {>>MusicList.lua
@echo %listis%
for /r %filepath% %%i in (%oggfile% %wavfile%) do (
	set filename=%%i
	call set "filename=%%filename:~!strlen_num!%%"
	call set "filename=%%filename:\=/%%"
	set fileid=!filename!
	call set "fileid=%%fileid:~0,-4%%"
	@echo !fileid!
	@echo 	{ "!fileid!" , "%subpath%!filename!" , %volume% } ,>>MusicList.lua
)
@echo }>>MusicList.lua
@echo .

pause