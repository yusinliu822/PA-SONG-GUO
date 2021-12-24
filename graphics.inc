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