@echo off
setlocal enabledelayedexpansion
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: ��Ҫ�����б���ļ���·�� ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: ����ļ���λ�� , ����λ�� , �ʹ���Դ������(���ļ��д���)����ĵ�ַ��ֱ�Ӹ��ƾ�����
:: �ָ����� \ , ��β��Ҫ�� \
set filepath=C:\Users\Administrator\Desktop\�½��ļ���

:: ����� zsound ���ļ���λ��
:: �ָ����� / , ��β�� /
set subpath=�½��ļ���

:: ����
set volume=1

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: �����ǽű� ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set message=��ǰѡ����ļ����� : 
set listis=���ҵ����ļ� :
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