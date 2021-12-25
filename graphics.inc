INCLUDE Irvine32.inc

StrRemove PROTO, pStart: PTR BYTE
InitHandle PROTO
RandomPineRow PROTO
GetPinePosition PROTO
PrintStartMsg PROTO
PrintEndMsg PROTO

Println PROTO, strptr: PTR BYTE
PrintWhitePine PROTO
PrintPineRows PROTO
PrintPineRow PROTO, col: BYTE, isWhite: BYTE, printPosition: COORD
PrintSpace PROTO, startposition: COORD
PrintPine PROTO, isWhite: BYTE, startPosition: COORD

PrintArrow PROTO
Print0 PROTO, numPosition: COORD
Print1 PROTO, numPosition: COORD
Print2 PROTO, numPosition: COORD
Print3 PROTO, numPosition: COORD
Print4 PROTO, numPosition: COORD
Print5 PROTO, numPosition: COORD
Print6 PROTO, numPosition: COORD
Print7 PROTO, numPosition: COORD
Print8 PROTO, numPosition: COORD
Print9 PROTO, numPosition: COORD
PrintNum PROTO, num: WORD, numPosition: COORD