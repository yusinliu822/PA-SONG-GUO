INCLUDE Irvine32.inc
INCLUDE graphics.inc
INCLUDE mechanism.inc

.data
    score WORD 0

.code
CalScore PROC USES eax edx
    movzx eax, score
    add eax, 50
    mov score, ax
    ret
CalScore ENDP

UpdateScore PROC USES eax edx
    movzx eax, score
    mov  dl, 40                      ; column
    mov  dh, 0                      ; row
    call Gotoxy
    call WriteDec
    ret
UpdateScore ENDP

GetScoreValueInAx PROC
    mov ax, score
    ret
GetScoreValueInAx ENDP

END
