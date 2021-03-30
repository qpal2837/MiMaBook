.586
.model flat,stdcall
option casemap:none
include crtdll.inc
include windows.inc
include kernel32.inc
include msvcrt.inc
include Stdlib.Inc


includelib msvcrt.lib
includelib Stdlib.lib
includelib crtdll.lib
includelib kernel32.lib
.data
;电话本信息结构体
MiMaBookInfo struct
	szName 			BYTE 		20 dup(0)
	szPhone 		BYTE 		20 dup(0)
MiMaBookInfo ends
;电话本信息结构体指针别名
PMiMaBookInfo 			typedef ptr MiMaBookInfo

;电话本结构体

g_MiMaBookArray 		MiMaBookInfo 		100 dup (<'0'>)
;电话本结构体指针
PMiMaBook typedef ptr MiMaBook
szFilePath			db "data.txt",0
szFileParam			db "wb+",0
szFileParamB			db "ab+",0
szFileParamC			db "rb+",0
szInputFormat			db "%s-------%s",0dh,0ah,0
szWelcome 			db "欢迎使用电话本",0dh,0ah,"1.添加信息",0dh,0ah,"2.删除信息",0ah,0dh,"3.修改信息",0ah,0dh,"4.查看信息",0ah,0dh,"0.退出",0ah,0dh,"请输入",0ah,0dh,0
szFormat  			db "%s",0
szInputNameTip 			db  "请输入姓名:",0ah,0dh,0
szInputPhoneTip 		db "请输入电话:",0ah,0dh,0
szNull				db "这个姓名不存在",0ah,0dh,0
g_TempMiMaBookInfo 		MiMaBookInfo		<'0','0'>
g_MaxCount 			DWORD 			100
g_Count				BYTE			0


.data?

szUserInput 			db 			?
file	    			DWORD 			?			



.code 
;菜单展示
ShowMenu proto
;通过名字查询信息
GetMiMaBookByName proto
;添加
SaveMiMaBook proto
;删除信息
DeleteMiMaBook proto
;更新信息
UpdateMiMaBook proto
;查找信息
FindMiMaBook proto
;判断字符串是否相同
GetMiMaBook proto
;保存文件
SaveData    proto
;读取文件
ReadData    proto

