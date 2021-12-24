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
    startGameMsg BYTE "GAME START!",0
    endGameMsg BYTE "TIME'S UP!",0
    checkMsg BYTE "CHECK!",0
    picWidth DWORD 11
    picHeight DWORD 7
    pinePosition BYTE "99999",0
    xyPosition COORD<0,0>
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
END