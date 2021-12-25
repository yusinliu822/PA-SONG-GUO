INCLUDE page.inc

main EQU start@0

.data
    startTime DWORD ?
    curTime DWORD ?
    timeLeft DWORD 30
    count DWORD 0
    ranNum DWORD ?
    score DWORD 0
    timeDisplayMsg BYTE "TIME: ",0
    inputKeyAscii WORD ?

.code
main PROC
    call PrintStartMsg
    call InitHandle

    call Clrscr
    mov ecx, 5
GeneratePinesPos:
    call RandomPineRow
    loop GeneratePinesPos

    call PrintPineRows

    call GetMseconds
    mov startTime, eax
    INVOKE Println, OFFSET timeDisplayMsg
GAMESTART:
    call GetMseconds
    mov curTime, eax
    sub eax, startTime
    cmp eax, 1000                   ; if duration < 1 sec
    jl ENDLABEL                     ; then goto ENDLABEL
ONESECOND:
    mov eax, curTime
    mov startTime, eax              ; update startTime
    dec timeLeft                    ; timeLeft--
    mov  dl, 6                      ; column
    mov  dh, 0                      ; row
    .IF timeLeft == 9
        call Gotoxy
        mov al, '0'
        call WriteChar
    .ENDIF
    .IF timeLeft < 10
        add dl, 1
    .ENDIF
    call Gotoxy
    mov eax, timeLeft
    call WriteDec                   ; print timeLeft
    ; call Crlf
    jmp ENDLABEL
ENDLABEL:
    DetectKeyEvent:
        call ReadKey
        jz EndKeyEvent
        mov inputKeyAscii, ax
        call HandleKeyboard
    EndKeyEvent:

    mov eax, timeLeft
    cmp eax, 0                      ; if timeLeft > 0
    jne GAMESTART                   ; goto GAMESTART
    
EndPage:
    call Clrscr
    mov eax, score
    call WriteDec
    call Crlf
    
    call PrintEndMsg
    INVOKE PrintEndPage
    INVOKE Sleep, 3000
    call WaitMsg
    exit

main ENDP

HandleKeyboard PROC USES ebx edx
ReadPosition:
    call GetPinePosition    ; edx = pinePosition
    mov bl, [edx]           ; bl = cur pine position

ReadUserInput:
    ; call ReadChar
    mov ax, inputKeyAscii
    .IF bl == "0"
        .IF ax == 4B00h ; LEFT
            call RandomPineRow     ; create new line pinecone
            call PrintPineRows
            ; jmp ReadPosition
        .ELSE
            INVOKE PrintWhitePine
            ; jmp ReadUserInput
        .ENDIF
	.ENDIF

	.IF bl == "1"
        .IF ax == 5000h ; DOWN
            call RandomPineRow     ; create new line pinecone
            call PrintPineRows
            ; jmp ReadPosition
        .ELSE
            INVOKE PrintWhitePine
            ; jmp ReadUserInput
        .ENDIF
	.ENDIF

	.IF bl == "2"
        .IF ax == 4D00h ; RIGHT
            call RandomPineRow     ; create new line pinecone
            call PrintPineRows
            ; jmp ReadPosition
        .ELSE
            INVOKE PrintWhitePine
            ; jmp ReadUserInput
        .ENDIF
	.ENDIF

	;.IF ax == 011Bh ;ESC
	;	jmp END_FUNC
	;.ENDIF

    ret
HandleKeyboard ENDP


calscore PROC uses eax
    mov eax, score
    add eax, 50
    mov score, eax
calscore ENDP

END main