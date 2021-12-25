INCLUDE page.inc

main EQU start@0

.data
    prevTime DWORD 0
    timeLeft DWORD 30
    count DWORD 0
    ranNum DWORD ?
    score DWORD 0
    timeDisplayMsg BYTE "TIME: ",0
    scoreDisplayMsg BYTE "SCORE: ",0

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
    mov prevTime, eax
    INVOKE Println, OFFSET timeDisplayMsg
    INVOKE Println, OFFSET scoreDisplayMsg
    mov eax, score
    mov  dl, 6                      ; column
    mov  dh, 1                      ; row
    call Gotoxy
    call WriteDec

GameLoop:
    DetectKeyEvent:
        mov eax, 20          ; sleep, to allow OS to time slice
        call Delay           ; (otherwise, some key presses are lost)
        call ReadKey
        jz CheckTime
        call HandleKeyboard
    CheckTime:
        call GetMseconds ; now = eax
        mov ebx, eax
        sub eax, prevTime
    OneSecond:
        .IF eax >= 1000
            call UpdateTimer
        .ENDIF
    CheckGameOver:
        mov eax, timeLeft
        cmp eax, 0                      ; if timeLeft > 0
        jne GameLoop                   ; goto GameLoop
    
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

UpdateTimer PROC USES eax edx
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
    mov prevTime, ebx
    ret
UpdateTimer ENDP

HandleKeyboard PROC USES ebx edx
ReadPosition:
    call GetPinePosition    ; edx = pinePosition
    mov bl, [edx]           ; bl = cur pine position

ReadUserInput:
    .IF bl == "0"
        .IF ax == 4B00h ; LEFT
            call RandomPineRow     ; create new line pinecone
            call PrintPineRows
            call CalScore
            ; jmp ReadPosition
        .ELSE
            INVOKE PrintWhitePine
            ; jmp ReadUserInput
        .ENDIF

	.ELSEIF bl == "1"
        .IF ax == 5000h ; DOWN
            call RandomPineRow     ; create new line pinecone
            call PrintPineRows
            call CalScore
            ; jmp ReadPosition
        .ELSE
            INVOKE PrintWhitePine
            ; jmp ReadUserInput
        .ENDIF

	.ELSEIF bl == "2"
        .IF ax == 4D00h ; RIGHT
            call RandomPineRow     ; create new line pinecone
            call PrintPineRows
            call CalScore
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


CalScore PROC USES eax edx
    mov eax,score
    add eax,50
    mov score,eax
    mov  dl, 6                      ; column
    mov  dh, 1                      ; row
    call Gotoxy
    call WriteDec
    ret
CalScore ENDP

END main