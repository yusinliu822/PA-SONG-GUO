
INCLUDE graphics.inc

main	EQU start@0


.data

finalScore WORD 2531, 0
outputHandle DWORD 0
bytesWritten DWORD 0
finalScorePos COORD <20,15>
finalScoreWidth DWORD 0
scorePosition COORD <15,5>
scoreWidth DWORD 20
exitPosition COORD <4,18>
exitWidth DWORD 19
exitStrPos COORD <12,28>
exitStrWidth DWORD 20
againPosition COORD <28, 18>
againWidth DWORD 20
againStrPos COORD <12,25>
againStrWidth DWORD 25
pineconePosition COORD <5,35>
pineconeWidth DWORD 9
pineconePosition2 COORD <33,35>

score1 BYTE " __________________ ", 0
score2 BYTE "|  _  _  _   _   _ |", 0
score3 BYTE "| |_ |  | | |_| |_ |", 0
score4 BYTE "|  _||_ |_| | \ |_ |", 0
score5 BYTE "|__________________|", 0

exitStr BYTE "2. Press esc to exit", 0

againStr BYTE "1. Press space to restart"

PineCone1 BYTE "    *    ", 0
PineCone2 BYTE " ******* ", 0
PineCone3 BYTE "*********", 0
PineCone4 BYTE " *     * ", 0
PineCone5 BYTE " *     * ", 0
PineCone6 BYTE "  ** **  ", 0
PineCone7 BYTE "    *    ", 0

divisor WORD 10
quotient WORD 1 DUP(?)
remainder WORD 1 DUP(?)
scorePos COORD <28,15>
nums DWORD 0
.code

divide PROC USES edx eax,
    dend: WORD,
    sor: WORD,
    quot: WORD,
    rem: WORD

    mov dx, 0
    mov ax, dend
    div sor
    mov quotient, ax
    mov remainder, dx
    ret
divide ENDP

PrintEndPage PROC

    INVOKE GetStdHandle, STD_OUTPUT_HANDLE ; Get the console ouput handle
        mov outputHandle, eax ; save console handle
        call Clrscr

; PrintScore
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR score1,scoreWidth,scorePosition,ADDR bytesWritten
            inc scorePosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR score2,scoreWidth,scorePosition,ADDR bytesWritten
            inc scorePosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR score3,scoreWidth,scorePosition,ADDR bytesWritten
            inc scorePosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR score4,scoreWidth,scorePosition,ADDR bytesWritten
            inc scorePosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR score5,scoreWidth,scorePosition,ADDR bytesWritten
            inc scorePosition.Y

;    mov finalScoreWidth, lengthof finalScore
;    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR finalScore,finalScoreWidth, finalScorePos,ADDR bytesWritten

; Print score num

    mov ecx, 5
PrintScore:
    INVOKE divide, finalScore, divisor, quotient, remainder
    mov eax, nums
    add scorePos.X, ax
    INVOKE PrintNum, remainder, scorePos
    inc nums
    LOOP PrintScore

;Print exit str
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR exitStr,exitStrWidth,exitStrPos,ADDR bytesWritten

;Print again str
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR againStr,againStrWidth,againStrPos,ADDR bytesWritten

;印下面兩顆松果
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PineCone1, pineconeWidth, pineconePosition, ADDR bytesWritten
    add pineconePosition.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PineCone2, pineconeWidth, pineconePosition, ADDR bytesWritten
    add pineconePosition.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PineCone3, pineconeWidth, pineconePosition, ADDR bytesWritten
    add pineconePosition.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PineCone4, pineconeWidth, pineconePosition, ADDR bytesWritten
    add pineconePosition.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PineCone5, pineconeWidth, pineconePosition, ADDR bytesWritten
    add pineconePosition.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PineCone6, pineconeWidth, pineconePosition, ADDR bytesWritten
    add pineconePosition.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PineCone7, pineconeWidth, pineconePosition, ADDR bytesWritten

    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PineCone1, pineconeWidth, pineconePosition2, ADDR bytesWritten
    add pineconePosition2.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PineCone2, pineconeWidth, pineconePosition2, ADDR bytesWritten
    add pineconePosition2.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PineCone3, pineconeWidth, pineconePosition2, ADDR bytesWritten
    add pineconePosition2.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PineCone4, pineconeWidth, pineconePosition2, ADDR bytesWritten
    add pineconePosition2.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PineCone5, pineconeWidth, pineconePosition2, ADDR bytesWritten
    add pineconePosition2.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PineCone6, pineconeWidth, pineconePosition2, ADDR bytesWritten
    add pineconePosition2.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PineCone7, pineconeWidth, pineconePosition2, ADDR bytesWritten

    ;按空白鍵會清除畫面（可以接開始遊戲）
    call ReadChar
    .IF ax == 3920h ;SPACE
        Call Clrscr
    .ENDIF
    .IF ax == 011Bh ;ESC
        Call Clrscr
    .ENDIF
    Call WaitMsg

ret
PrintEndPage ENDP
END
