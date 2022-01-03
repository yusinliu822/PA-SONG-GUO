INCLUDE Irvine32.inc
INCLUDE graphics.inc

.data
    PA0 BYTE "******    **       *      * *      ***********",0
    PA1 BYTE "*    *   *  *      *     ** **     *    *    *",0
    PA2 BYTE "*    *  *    *   *****  **   **    ***********",0
    PA3 BYTE "*    * *      *    *      **       *    *    *",0
    PA4 BYTE "****** * **** *   ***    **        ***********",0
    PA5 BYTE "*      *      *   ***    **             *     ",0
    PA6 BYTE "*      *      *  * * *  **   **    ***********",0
    PA7 BYTE "*      *      *  * * *  **    **      * * *   ",0
    PA8 BYTE "*      *      *  * * *  **    **      * * *   ",0
    PA9 BYTE "*      *      *    *   **********  ***  *  ***",0
    start1 BYTE " _____________________ ",0
    start2 BYTE "| ___ ___  _   __ ___ |",0
    start3 BYTE "| |__  |  /_\ |__| |  |",0
    start4 BYTE "| ___| | /   \|  \ |  |",0
    start5 BYTE "|_____________________|",0
    rule0 BYTE " __________________________________ ",0
    rule1 BYTE "|                                  |",0
    rule2 BYTE "|               RULE               |",0
    rule3 BYTE "|                                  |",0
    rule4 BYTE "| 1. Press Space to Start          |",0
    rule5 BYTE "| 2. Use Arrow Key to Play         |",0
    rule6 BYTE "| 3. Hit Pine cones and Get Points |",0
    rule7 BYTE "| 4. 30 seconds only               |",0
    rule8 BYTE "| 5. Do Your Best!!!               |",0
    rule9 BYTE "|__________________________________|",0

    PineCone0 BYTE "           ", 0
    PineCone1 BYTE "     *     ", 0
    PineCone2 BYTE "  *******  ", 0
    PineCone3 BYTE " ********* ", 0
    PineCone4 BYTE "  *     *  ", 0
    PineCone5 BYTE "  *     *  ", 0
    PineCone6 BYTE "   ** **   ", 0
    PineCone7 BYTE "     *     ", 0
    PineCone8 BYTE "  *******  ", 0
    PineCone9 BYTE "  *******  ", 0
    PineCone10 BYTE "   *****   ", 0
    arrow1 BYTE "      *               ***              *      ", 0
    arrow2 BYTE "     **               ***              **     ", 0
    arrow3 BYTE "    ********          ***         ********    ", 0
    arrow4 BYTE "   *********       *********      *********   ", 0
    arrow5 BYTE "    ********        *******       ********    ", 0
    arrow6 BYTE "     **               ***              **     ", 0
    arrow7 BYTE "      *                *               *      ", 0
    score1 BYTE " ________________ ", 0
    score2 BYTE "|  _  _  _  _  _ |", 0
    score3 BYTE "| |_ |  | ||_||_ |", 0
    score4 BYTE "|  _||_ |_|| \|_ |", 0
    score5 BYTE "|________________|", 0
    num01 BYTE "*****",0
    num02 BYTE "*   *",0
    num03 BYTE "*   *",0
    num04 BYTE "*   *",0
    num05 BYTE "*****",0
    num11 BYTE "  *  ",0
    num12 BYTE " **  ",0
    num13 BYTE "* *  ",0
    num14 BYTE "  *  ",0
    num15 BYTE "*****",0
    num21 BYTE "*****",0
    num22 BYTE "    *",0
    num23 BYTE "*****",0
    num24 BYTE "*    ",0
    num25 BYTE "*****",0
    num31 BYTE "*****",0
    num32 BYTE "    *",0
    num33 BYTE "*****",0
    num34 BYTE "    *",0
    num35 BYTE "*****",0
    num41 BYTE "   * ",0
    num42 BYTE "  ** ",0
    num43 BYTE " * * ",0
    num44 BYTE "*****",0
    num45 BYTE "   * ",0
    num51 BYTE "*****",0
    num52 BYTE "*    ",0
    num53 BYTE "*****",0
    num54 BYTE "    *",0
    num55 BYTE "*****",0
    num61 BYTE "*****",0
    num62 BYTE "*    ",0
    num63 BYTE "*****",0
    num64 BYTE "*   *",0
    num65 BYTE "*****",0
    num71 BYTE "*****",0
    num72 BYTE "*   *",0
    num73 BYTE "    *",0
    num74 BYTE "    *",0
    num75 BYTE "    *",0
    num81 BYTE "*****",0
    num82 BYTE "*   *",0
    num83 BYTE "*****",0
    num84 BYTE "*   *",0
    num85 BYTE "*****",0
    num91 BYTE "*****",0
    num92 BYTE "*   *",0
    num93 BYTE "*****",0
    num94 BYTE "    *",0
    num95 BYTE "*****",0
    startGameMsg BYTE "GAME START!",0
    endGameMsg BYTE "TIME'S UP!",0
    checkMsg BYTE "CHECK!",0
    againStr BYTE "1. Press space to restart",0
    exitStr BYTE "2. Press esc to exit",0

    paPosition COORD <2,3>
    paWidth DWORD 46
    startBoxPosition COORD <13, 18>
    startBoxWidth DWORD 23
    rulePosition COORD <8, 24>
    ruleWidth DWORD 36
    pineconePosition COORD <5, 35>
    pineconePosition2 COORD <33, 35>
    picWidth DWORD 11
    picHeight DWORD 7
    pinePosition BYTE "99999",0
    xyPosition COORD<4,0>
    arrowPosition COORD<2,43>
    arrowWidth DWORD 47
    scorePosition COORD <15,5>
    scoreWidth DWORD 18
    numWidth DWORD 5
    againStrPos COORD <13,25>
    againStrWidth DWORD 25
    exitStrPos COORD <13,28>
    exitStrWidth DWORD 20

    divisor WORD 10
    quotient WORD 1 DUP(?)
    remainder WORD 1 DUP(?)
    scorePos COORD <42,15>
    nums DWORD 0


    outputHandle DWORD 0
    count DWORD 0

.code
InitHandle PROC USES eax
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE
    mov outputHandle, eax
    ret
InitHandle ENDP

PrintPA PROC
    mov paPosition.X,2
    mov paPosition.Y,3
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PA0, paWidth, paPosition, ADDR count
    add paPosition.Y, 1;
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PA1, paWidth, paPosition, ADDR count
    add paPosition.Y, 1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PA2, paWidth, paPosition, ADDR count
    add paPosition.Y, 1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PA3, paWidth, paPosition, ADDR count
    add paPosition.Y, 1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PA4, paWidth, paPosition, ADDR count
    add paPosition.Y, 1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PA5, paWidth, paPosition, ADDR count
    add paPosition.Y, 1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PA6, paWidth, paPosition, ADDR count
    add paPosition.Y, 1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PA7, paWidth, paPosition, ADDR count
    add paPosition.Y, 1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PA8, paWidth, paPosition, ADDR count
    add paPosition.Y, 1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR PA9, paWidth, paPosition, ADDR count
ret
PrintPA ENDP

PrintStartBox PROC
    mov startBoxPosition.X,15
    mov startBoxPosition.Y,18
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR start1, startBoxWidth, startBoxPosition, ADDR count
    add startBoxPosition.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR start2, startBoxWidth, startBoxPosition, ADDR count
    add startBoxPosition.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR start3, startBoxWidth, startBoxPosition, ADDR count
    add startBoxPosition.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR start4, startBoxWidth, startBoxPosition, ADDR count
    add startBoxPosition.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR start5, startBoxWidth, startBoxPosition, ADDR count

ret
PrintStartBox ENDP

PrintRule PROC
    mov rulePosition.X,8
    mov rulePosition.Y,24
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR rule0, ruleWidth, rulePosition, ADDR count
    add rulePosition.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR rule1, ruleWidth, rulePosition, ADDR count
    add rulePosition.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR rule2, ruleWidth, rulePosition, ADDR count
    add rulePosition.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR rule3, ruleWidth, rulePosition, ADDR count
    add rulePosition.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR rule4, ruleWidth, rulePosition, ADDR count
    add rulePosition.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR rule5, ruleWidth, rulePosition, ADDR count
    add rulePosition.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR rule6, ruleWidth, rulePosition, ADDR count
    add rulePosition.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR rule7, ruleWidth, rulePosition, ADDR count
    add rulePosition.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR rule8, ruleWidth, rulePosition, ADDR count
    add rulePosition.Y,1
    INVOKE WriteConsoleOutputCharacter, outputHandle, ADDR rule9, ruleWidth, rulePosition, ADDR count

ret
PrintRule ENDP

PrintPineRow PROC USES edx,
    col: BYTE,
    isWhite: BYTE,
    printPosition: COORD

    .IF col == "0"
        INVOKE PrintPine, isWhite, printPosition
        add printPosition.X, 16
        INVOKE PrintSpace, printPosition
        add printPosition.X, 16
        INVOKE PrintSpace, printPosition
        sub printPosition.X, 32
    .ENDIF

    .IF col == "1"
        INVOKE PrintSpace, printPosition
        add printPosition.X, 16
        INVOKE PrintPine, isWhite, printPosition
        add printPosition.X, 16
        INVOKE PrintSpace, printPosition
        sub printPosition.X, 32
    .ENDIF

    .IF col == "2"
        INVOKE PrintSpace, printPosition
        add printPosition.X, 16
        INVOKE PrintSpace, printPosition
        add printPosition.X, 16
        INVOKE PrintPine, isWhite, printPosition
        sub printPosition.X, 32
    .ENDIF
    ret
PrintPineRow ENDP

PrintSpace PROC USES ecx,
    startposition:COORD ;印空白
    add startposition.Y,1
    mov ecx,7
    Space:
        push ecx
        INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR PineCone0,picWidth,startposition,ADDR count
        add startposition.Y,1
        pop ecx
        Loop Space

    ret
PrintSpace ENDP

; 印松果
PrintPine PROC,
    isWhite: BYTE, ; 1 = 白色, 0 = 中空
    startposition: COORD

    add startposition.Y,1
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR PineCone1,picWidth,startposition,ADDR count
    add startposition.Y,1
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR PineCone2,picWidth,startposition,ADDR count
    add startposition.Y,1
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR PineCone3,picWidth,startposition,ADDR count
    add startposition.Y,1
    .IF isWhite == 0h
        INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR PineCone4,picWidth,startposition,ADDR count
        add startposition.Y,1
        INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR PineCone5,picWidth,startposition,ADDR count
        add startposition.Y,1
        INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR PineCone6,picWidth,startposition,ADDR count
        add startposition.Y,1
    .ELSE
        INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR PineCone8,picWidth,startposition,ADDR count
        add startposition.Y,1
        INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR PineCone9,picWidth,startposition,ADDR count
        add startposition.Y,1
        INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR PineCone10,picWidth,startposition,ADDR count
        add startposition.Y,1
    .ENDIF
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR PineCone7,picWidth,startposition,ADDR count
    add startposition.Y,1
    ret
PrintPine ENDP

RandomPineRow PROC
    mov edx, OFFSET pinePosition
    INVOKE StrRemove, edx
    add edx, 4

    call Randomize
    mov eax, 3
    call RandomRange                ;record in eax
    .IF eax == 0
        mov bl, "0"
        mov [edx], bl
    .ENDIF
    .IF eax == 1
        mov bl, "1"
        mov [edx], bl
    .ENDIF
    .IF eax == 2
        mov bl, "2"
        mov [edx], bl
    .ENDIF
    ret
RandomPineRow ENDP

PrintWhitePine PROC
    mov xyPosition.Y, 34
    mov edx, OFFSET pinePosition
    mov bl, [edx]
    INVOKE PrintPineRow, bl, 1, xyPosition
    INVOKE Sleep, 500
PrintWhitePine ENDP

; stores the pointer to pinePosition in edx
GetPinePosition PROC
    mov edx, OFFSET pinePosition
    ret
GetPinePosition ENDP

Println PROC,
    strptr: PTR BYTE,

    mov edx, strptr
    call WriteString
    call Crlf
    ret
Println ENDP

PrintStartMsg PROC USES edx
    mov edx, OFFSET startGameMsg
    call WriteString
    call Crlf
    ret
PrintStartMsg ENDP

PrintEndMsg PROC USES edx
    mov edx, OFFSET endGameMsg
    call WriteString
    call Crlf
    ret
PrintEndMsg ENDP

PrintPineRows PROC USES edx
    mov edx, OFFSET pinePosition

    mov xyPosition.Y, 34 ; 5 rows, starting from the last row
    mov bl, [edx]
    INVOKE PrintPineRow, bl, 0, xyPosition

    sub xyPosition.Y, 8
    mov bl, [edx+1]
    INVOKE PrintPineRow, bl, 0, xyPosition

    sub xyPosition.Y, 8
    mov bl, [edx+2]
    INVOKE PrintPineRow, bl, 0, xyPosition

    sub xyPosition.Y, 8
    mov bl, [edx+3]
    INVOKE PrintPineRow, bl, 0, xyPosition

    sub xyPosition.Y, 8
    mov bl, [edx+4]
    INVOKE PrintPineRow, bl, 0, xyPosition
    ret
PrintPineRows ENDP

StrRemove PROC USES ecx esi edi,
	pStart: PTR BYTE,	; 要移除的字串頭

	INVOKE Str_length, pStart
	mov	ecx,eax			;ecx = 字串長度
    sub ecx, 1
	mov esi, pStart	;esi = 字串起始位置
	add esi, 1;esi += 要移除的字元數
	mov edi, pStart	;edi = 字串起始位置

	cld               ;clear direction flag
	rep movsb	     ;do the move

	mov	BYTE PTR [edi],0	; insert new null byte
Exit_proc:
	ret
StrRemove ENDP

PrintArrow PROC
    mov arrowPosition.X, 2
    mov arrowPosition.Y, 43
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR arrow1,arrowWidth,arrowPosition,ADDR count
    inc arrowPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR arrow2,arrowWidth,arrowPosition,ADDR count
    inc arrowPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR arrow3,arrowWidth,arrowPosition,ADDR count
    inc arrowPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR arrow4,arrowWidth,arrowposition,ADDR count
    inc arrowPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR arrow5,arrowWidth,arrowPosition,ADDR count
    inc arrowPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR arrow6,arrowWidth,arrowPosition,ADDR count
    inc arrowPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR arrow7,arrowWidth,arrowPosition,ADDR count

	ret
PrintArrow ENDP


PrintScoreBox PROC
    mov scorePosition.X, 15
    mov scorePosition.Y, 5
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR score1,scoreWidth,scorePosition,ADDR count
        inc scorePosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR score2,scoreWidth,scorePosition,ADDR count
        inc scorePosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR score3,scoreWidth,scorePosition,ADDR count
        inc scorePosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR score4,scoreWidth,scorePosition,ADDR count
        inc scorePosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR score5,scoreWidth,scorePosition,ADDR count

    ret
PrintScoreBox ENDP

Print0 PROC,
    numPosition: COORD

    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num01,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num02,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num03,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num04,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num05,numWidth,numPosition,ADDR count

    ret
Print0 ENDP

Print1 PROC,
    numPosition: COORD

    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num11,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num12,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num13,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num14,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num15,numWidth,numPosition,ADDR count

    ret
Print1 ENDP

Print2 PROC,
    numPosition: COORD

    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num21,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num22,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num23,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num24,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num25,numWidth,numPosition,ADDR count

    ret
Print2 ENDP

Print3 PROC,
    numPosition: COORD

    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num31,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num32,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num33,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num34,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num35,numWidth,numPosition,ADDR count

    ret
Print3 ENDP

Print4 PROC,
    numPosition: COORD

    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num41,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num42,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num43,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num44,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num45,numWidth,numPosition,ADDR count

    ret
Print4 ENDP

Print5 PROC,
    numPosition: COORD

    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num51,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num52,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num53,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num54,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num55,numWidth,numPosition,ADDR count

    ret
Print5 ENDP

Print6 PROC,
    numPosition: COORD

    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num61,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num62,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num63,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num64,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num65,numWidth,numPosition,ADDR count

    ret
Print6 ENDP

Print7 PROC,
    numPosition: COORD

    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num71,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num72,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num73,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num74,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num75,numWidth,numPosition,ADDR count

    ret
Print7 ENDP

Print8 PROC,
    numPosition: COORD

    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num81,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num82,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num83,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num84,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num85,numWidth,numPosition,ADDR count

    ret
Print8 ENDP

Print9 PROC,
    numPosition: COORD

    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num91,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num92,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num93,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num94,numWidth,numPosition,ADDR count
    inc numPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR num95,numWidth,numPosition,ADDR count

    ret
Print9 ENDP

Divide PROC USES edx eax,
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
Divide ENDP


PrintFinalScore PROC USES ecx ebx eax,
    finalScore: WORD
    mov scorePos.X, 42
    mov scorePos.Y, 15
    mov ecx, 5
    mov bx, finalScore
    mov quotient, bx
    mov eax, 0
PrintScore:
    push ecx
    INVOKE Divide, quotient, divisor, quotient, remainder
    sub scorePos.X, 6
    INVOKE PrintNum, remainder, scorePos
    pop ecx
    LOOP PrintScore
ret
PrintFinalScore ENDP

PrintNum PROC,
    num: WORD,
    numPosition: COORD
    .IF num == 0
        INVOKE Print0, numPosition
    .ELSEIF num == 1
        INVOKE Print1, numPosition
    .ELSEIF num == 2
        INVOKE Print2, numPosition
    .ELSEIF num == 3
        INVOKE Print3, numPosition
    .ELSEIF num == 4
        INVOKE Print4, numPosition
    .ELSEIF num == 5
        INVOKE Print5, numPosition
    .ELSEIF num == 6
        INVOKE Print6, numPosition
    .ELSEIF num == 7
        INVOKE Print7, numPosition
    .ELSEIF num == 8
        INVOKE Print8, numPosition
    .ELSEIF num == 9
        INVOKE Print9, numPosition
    .ENDIF
    ret
PrintNum ENDP

PrintAgainMsg PROC
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR againStr,againStrWidth,againStrPos,ADDR count
    ret
PrintAgainMsg ENDP

PrintExitMsg PROC
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR exitStr,exitStrWidth,exitStrPos,ADDR count
    ret
PrintExitMsg ENDP

END
