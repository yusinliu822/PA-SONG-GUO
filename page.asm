INCLUDE Irvine32.inc
INCLUDE graphics.inc

main	EQU start@0

.data

pineconePosition COORD <5, 35>
pineconePosition2 COORD <33, 35>

.code

PrintEndPage PROC,
    finalScore:WORD
; Print Score Box
    INVOKE PrintScoreBox
    INVOKE PrintFinalScore, finalScore

; Print again message
    INVOKE PrintAgainMsg
; Print exit message
    INVOKE PrintExitMsg

; 印下面兩顆松果
    INVOKE PrintPine, 0, pineconePosition
    INVOKE PrintPine, 0, pineconePosition2

    ; 按空白鍵會清除畫面（可以接開始遊戲）
    ret
PrintEndPage ENDP

PrintStartPage PROC
; 印PA松果
    INVOKE PrintPA
; print start box
    INVOKE PrintStartBox
; print rule
    INVOKE PrintRule
; 印下面兩顆松果
    INVOKE PrintPine, 0, pineconePosition
    INVOKE PrintPine, 0, pineconePosition2
    mov dl,13
    mov dh,28
    call Gotoxy
    call WaitMsg

    ret
PrintStartPage ENDP
END
