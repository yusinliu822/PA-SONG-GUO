INCLUDE graphics.inc

.data
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
    arrow0 BYTE " _____________   _____________   _____________ ", 0
    arrow1 BYTE "|             | |             | |             |", 0
    arrow2 BYTE "|     *       | |      *      | |       *     |", 0
    arrow3 BYTE "|    **       | |     ***     | |       **    |", 0
    arrow4 BYTE "|   ********  | |   *******   | |  ********   |", 0
    arrow5 BYTE "|  *********  | |  *********  | |  *********  |", 0
    arrow6 BYTE "|   ********  | |     ***     | |  ********   |", 0
    arrow7 BYTE "|    **       | |     ***     | |       **    |", 0
    arrow8 BYTE "|     *       | |     ***     | |       *     |", 0
    arrow9 BYTE "|_____________| |_____________| |_____________|", 0
    score1 BYTE " __________________ ", 0
    score2 BYTE "|  _  _  _   _   _ |", 0
    score3 BYTE "| |_ |  | | |_| |_ |", 0
    score4 BYTE "|  _||_ |_| | \ |_ |", 0
    score5 BYTE "|__________________|", 0
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
    picWidth DWORD 11
    picHeight DWORD 7
    pinePosition BYTE "99999",0
    xyPosition COORD<0,0>
    arrowPosition COORD<1,43>
    arrowWidth DWORD 47
    scorePosition COORD <15,5>
    scoreWidth DWORD 20
    numWidth DWORD 5
    outputHandle DWORD 0
    count DWORD 0

.code
InitHandle PROC USES eax
    INVOKE GetStdHandle, STD_OUTPUT_HANDLE
    mov outputHandle, eax
    ret
InitHandle ENDP

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

    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR arrow0,arrowWidth,arrowPosition,ADDR count
    inc arrowPosition.Y
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
    inc arrowPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR arrow8,arrowWidth,arrowPosition,ADDR count
    inc arrowPosition.Y
    INVOKE WriteConsoleOutputCharacter,outputHandle,ADDR arrow9,arrowWidth,arrowPosition,ADDR count

	ret
PrintArrow ENDP

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

PrintNum PROC,
    num: WORD,
    numPosition: COORD
    .IF num==0
        INVOKE Print0, numPosition
    .ENDIF
    .IF num==1
        INVOKE Print1, numPosition
    .ENDIF
    .IF num==2
        INVOKE Print2, numPosition
    .ENDIF
    .IF num==3
        INVOKE Print3, numPosition
    .ENDIF
    .IF num==4
        INVOKE Print4, numPosition
    .ENDIF
    .IF num==5
        INVOKE Print5, numPosition
    .ENDIF
    .IF num==6
        INVOKE Print6, numPosition
    .ENDIF
    .IF num==7
        INVOKE Print7, numPosition
    .ENDIF
    .IF num==8
        INVOKE Print8, numPosition
    .ENDIF
    .IF num==9
        INVOKE Print9, numPosition
    .ENDIF

ret

PrintNum ENDP
END