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

; �L�U�������Q�G
    INVOKE PrintPine, 0, pineconePosition
    INVOKE PrintPine, 0, pineconePosition2

    ; ���ť���|�M���e���]�i�H���}�l�C���^
    ret
PrintEndPage ENDP

PrintStartPage PROC
; �LPA�Q�G
    INVOKE PrintPA
; print start box
    INVOKE PrintStartBox
; print rule
    INVOKE PrintRule
; �L�U�������Q�G
    INVOKE PrintPine, 0, pineconePosition
    INVOKE PrintPine, 0, pineconePosition2
    mov dl,13
    mov dh,28
    call Gotoxy
    call WaitMsg

    ret
PrintStartPage ENDP
END
