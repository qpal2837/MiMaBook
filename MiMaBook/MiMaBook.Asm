.586
.model flat,stdcall
option casemap :none

include MiMaBook.inc

.code 
SaveMiMaBook proc
	enter 020h,0
	push edi
	push ebx
	push ecx
	push esi
	
	push offset szInputNameTip
	call printf
	add esp,4
	
	lea esi,[g_MiMaBookArray]
	mov eax,sizeof(MiMaBookInfo)
	lea edi,[offset g_Count]
	mov ecx,dword ptr es:[edi]
	imul eax,ecx
	
	
	
	push ecx
	push eax
	lea ebx, [eax+esi+MiMaBookInfo.szName]
	push ebx
	push offset szFormat
	call crt_scanf
	add esp,8
	
	push offset szInputPhoneTip
	call printf;
	add esp,4

	pop eax
	lea ebx, [eax+esi+MiMaBookInfo.szPhone]
	push ebx
	push offset szFormat
	call crt_scanf
	add esp,8
	pop ecx
	
	inc ecx
	mov dword ptr es:[edi],ecx
	pop edi
	pop ecx
	pop ebx
	pop edi
	leave
	ret

SaveMiMaBook endp
GetMiMaBookByName proc
	enter 020h,0
	push ecx
	push ebx
	push edx
	push edi
	push esi
	 
	push offset szInputNameTip
	call crt_printf	
	add esp,4
	
	push offset szUserInput
	push offset szFormat
	call  crt_scanf
	lea ecx,offset g_Count
	mov ecx,dword ptr ds:[ecx]
	mov ebx,sizeof(MiMaBookInfo)
	lea esi,[g_MiMaBookArray]
 ArrayWhile:
 	push ebx
 	push ecx
 	sub ecx,1
 	imul ebx,ecx
 	lea edi,dword ptr ds:[ebx+esi]
 	pop ecx
	pop ebx
	push esi
	lea esi,[offset szUserInput]
	
	push ecx
	push esi
	push edi
	call crt_strcmp
	add esp,8
	pop ecx
	
	test eax,eax	
	pop esi
	jz SetEax
	push ecx
	sub ecx,1
	test ecx,ecx
	pop ecx
	mov eax,0ffffffffh
	jz Over
 loop ArrayWhile
 SetEax:
 	sub ecx,1
 	mov eax,ecx
 Over:
 	pop esi
 	pop edi
 	pop edx
 	pop ebx
 	pop ecx	
	leave
	ret

GetMiMaBookByName endp

DeleteMiMaBook proc
	enter 020h,0
	push ebx
	push esi
	push edi
	push edx	
	call GetMiMaBookByName
	test eax,eax
	jns StartDelete
	push offset  szNull
	call printf;
	add esp,4 
	jmp Over	
 StartDelete:
 	mov ebx,sizeof(MiMaBookInfo)
	lea esi,[g_MiMaBookArray]
	lea edi,offset g_Count
	mov ecx,dword ptr es:[edi]
	dec ecx
	mov dword ptr es:[edi],ecx
	inc ecx
	mov edx,ecx
	mov ecx,100
 ReplaceWhile:
	push ebx
	imul ebx,eax
	lea edi,dword ptr es:[ebx+esi]
	pop ebx	
	push ebx
	inc eax
	push esi
	imul ebx,eax
	lea esi,dword ptr ds:[ebx+esi]
	movsd
	pop esi
	pop ebx
	
	dec eax
	push ebx
	imul ebx,eax
	lea edi,dword ptr es:[ebx+esi+MiMaBookInfo.szPhone]
	pop ebx	
	push ebx
	inc eax
	push esi
	imul ebx,eax
	lea esi,dword ptr ds:[ebx+esi+MiMaBookInfo.szPhone]
	movsd
	pop esi
	pop ebx

	
	cmp eax,edx
	jz Over
 loop ReplaceWhile
 Over:
 	pop edx
	pop edi
	pop esi
	pop ebx
	leave
	ret

DeleteMiMaBook endp

GetMiMaBook proc
	enter 020h,0
	push ecx
	push esi
	push ebx
	push edi
	

	
	mov ebx,sizeof(MiMaBookInfo)
	lea esi,[g_MiMaBookArray]
	lea edi,offset g_Count
	mov ecx,dword ptr es:[edi]
	lea edi,dword ptr [esi]
	mov eax,0
 GetWhile:
 	push eax
 	push ecx
 	lea edi,dword ptr es:[edi+MiMaBookInfo.szPhone]
 	push edi
 	lea edi,dword ptr es:[edi-MiMaBookInfo.szPhone]
 	push edi
 	push offset szInputFormat
 	call printf
 	add esp,0ch
 	pop ecx
 	
 	pop eax
 	
 	inc eax
 	lea edi,dword ptr es:[edi+ebx]
 	
 loop GetWhile	
 	pop edi
	pop esi
	pop ebx
	pop ecx
	leave
	ret
 GetMiMaBook endp
UpdateMiMaBook proc
	enter 020h,0
	push ebx
	push esi
	push edi
	push edx	
	call GetMiMaBookByName
	test eax,eax
	jns StartUpdate
	push offset  szNull
	call printf;
	add esp,4 
	jmp Over
 StartUpdate:
 	push eax
 	push offset szInputNameTip
	call printf
	add esp,4
	
	pop eax
	lea esi,[g_MiMaBookArray]
	mov ecx,sizeof(MiMaBookInfo)
	imul eax,ecx
	lea esi,dword ptr [esi+eax+MiMaBookInfo.szName]
	push eax
	
	push esi
	push offset szFormat
	call crt_scanf
	add esp,8
	
	push offset szInputPhoneTip
	call printf
	add esp,4
	
	pop eax
	lea esi,dword ptr [esi+MiMaBookInfo.szPhone]
	push esi
	push offset szFormat
	call crt_scanf
	add esp,8
	
	
	
	push offset szInputPhoneTip
	call printf;
	add esp,4

	
 Over:
 	pop edx
	pop edi
	pop esi
	pop ebx
	leave
	ret

ret
 UpdateMiMaBook endp
 
SaveData proc
	enter 020h,0
	push esi
	push ebx
	push offset szFileParam
	push offset szFilePath
	call crt_fopen
	add esp,8

	mov esi,eax
	push esi
	
	push esi
	lea esi,dword ptr es:[offset g_Count]
	mov ebx,dword ptr es:[esi]
	push ebx
	mov ebx,sizeof(MiMaBookInfo)
	push ebx
	lea esi,dword ptr es:[offset g_MiMaBookArray]
	push esi
	call crt_fwrite
	
	add esp,010h
	pop esi
	push esi
	call crt_fclose
	add esp,4
	
	pop ebx
	pop esi
	leave 
	ret

SaveData endp

ReadData proc
	enter 020h,0
	push esi
	push ebx
	push edi
	push ecx
	
	push offset szFileParamB
	push offset szFilePath
	call crt_fopen
	add esp,8
	
	mov esi,eax
	push esi
	call crt_fclose
	add esp,8
	;打开文件
	push offset szFileParamC
	push offset szFilePath
	call crt_fopen
	add esp,8
	mov esi,eax
	
	;获取数据数量
	push 2
	push 0
	push esi
	call crt_fseek
	add esp,0ch
	
	push esi
	call crt_ftell
	add esp,4
	mov ebx,eax
	
	mov ecx,sizeof(MiMaBookInfo)
	mov ebx,eax
	div ecx
	lea ecx,dword ptr es:[offset g_Count]
	mov dword ptr ds:[ecx],eax
	
	push esi
	call crt_rewind
	add esp,4
	
	push esi
	lea ecx,dword ptr es:[offset g_Count]
	mov ecx,dword ptr ds:[ecx]
	push ecx
	mov ecx,sizeof(MiMaBookInfo)
	push ecx
	lea edi,dword ptr ss:[offset g_MiMaBookArray]
	push edi
	call crt_fread
	add esp,0ch
	
	push esi
	call crt_fclose
	add esp,4
	
	
	pop ecx
	pop edi
	pop ebx
	pop esi
	leave
	ret

ReadData endp

ShowMenu proc
	enter 020h,0
	push ecx;
	mov cx,0
	call ReadData
 MenuWhile:
	push offset szWelcome
	call crt_printf
	add esp,4
	push offset szUserInput
	push offset szFormat
	call crt_scanf
	push offset szUserInput
	add esp,8
	pop eax
	cmp byte ptr ds:[eax],031h
	je save
	cmp byte ptr ds:[eax],032h
	je delete
	cmp byte ptr ds:[eax],033h
	je update
	cmp byte ptr ds:[eax],034h
	je find
	jmp OverMenu
 save:	
 	call SaveMiMaBook
	jmp MenuWhile
 delete:
 	call DeleteMiMaBook
	jmp MenuWhile
 update: 
 	call UpdateMiMaBook
	jmp MenuWhile
 find:
 	call GetMiMaBook
	jmp MenuWhile
 loop MenuWhile

 OverMenu:
 	call SaveData
 	add esp,8
	pop ecx;
	leave
	ret
 ShowMenu endp


start:
 	call ShowMenu;
 	push 0
 	call ExitProcess
end start