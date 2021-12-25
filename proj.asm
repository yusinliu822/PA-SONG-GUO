INCLUDE Irvine32.inc
INCLUDE graphics.inc
INCLUDE page.inc
INCLUDE mechanism.inc

main EQU start@0

.data
    prevTime DWORD 0
    timeLeft DWORD 30
    timeDisplayMsg BYTE "TIME: ",0
    scoreDisplayMsg BYTE "SCORE: ",0

.code
main PROC    
    call InitHandle
StartPage:
    call Clrscr
    INVOKE PrintStartPage
GamePage:
    call Clrscr
    call InitArguments
    INVOKE PrintArrow
    mov ecx, 5
GeneratePinesPos:  
    call RandomPineRow
    loop GeneratePinesPos

    call PrintPineRows

    call GetMseconds
    mov prevTime, eax
    INVOKE Println, OFFSET timeDisplayMsg
    mov  dl, 33                      ; column
    mov  dh, 0                      ; row
    call Gotoxy
    INVOKE Println, OFFSET scoreDisplayMsg

    call UpdateScore

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
    
    call GetScoreValueInAx
    INVOKE PrintEndPage, ax
    ; INVOKE Sleep, 3000
    call ReadChar
    .IF ax == 3920h ; SPACE
        jmp GamePage
    .ENDIF
    .IF ax == 011Bh ; ESC
        jmp StartPage
    .ENDIF
    call WaitMsg
    exit

main ENDP

InitArguments PROC USES eax
    mov eax, 30
    mov timeLeft, eax
    call ClearScoreValue
    ret
InitArguments ENDP

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
            call UpdateScore
        .ELSE
            INVOKE PrintWhitePine
        .ENDIF

	.ELSEIF bl == "1"
        .IF ax == 5000h ; DOWN
            call RandomPineRow     ; create new line pinecone
            call PrintPineRows
            call CalScore
            call UpdateScore
        .ELSE
            INVOKE PrintWhitePine
        .ENDIF

	.ELSEIF bl == "2"
        .IF ax == 4D00h ; RIGHT
            call RandomPineRow     ; create new line pinecone
            call PrintPineRows
            call CalScore
            call UpdateScore
        .ELSE
            INVOKE PrintWhitePine
        .ENDIF
	.ENDIF

	;.IF ax == 011Bh ;ESC
	;	jmp END_FUNC
	;.ENDIF

    ret
HandleKeyboard ENDP



END main