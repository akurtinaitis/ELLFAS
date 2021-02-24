#Include "PROTHEUS.CH"
#Include "TOPCONN.CH"
#INCLUDE "TBICONN.CH"
// rodar 02 e 03 
User Function xseqc5()
local nseq := 0
local cseq := ""

 PREPARE ENVIRONMENT EMPRESA '01' FILIAL '01'
    If !SELECT("SC5") > 0
        DBSELECTAREA("SC5")
    EndIf    
    SC5->(DBSETORDER(1))
    SC5->(DBGOTOP())

    While !SC5->(Eof())
        nseq++ 
        if Len(alltrim(str(nseq))) = 1
            cSeq := "00000"+Alltrim(STR(nseq))
        endIf
        if Len(alltrim(str(nseq))) = 2
            cSeq := "0000"+Alltrim(STR(nseq))
        endIf
        if Len(alltrim(str(nseq))) = 3
            cSeq := "000"+Alltrim(STR(nseq))
        endIf
        if Len(alltrim(str(nseq))) = 4
            cSeq := "00"+Alltrim(STR(nseq))
        endIf
        if Len(alltrim(str(nseq))) = 5
            cSeq := "0"+Alltrim(STR(nseq))
        endIf
        if Len(alltrim(str(nseq))) = 6
            cSeq := Alltrim(STR(nseq))
        endIf
        RecLock("SC5",.F.)
            SC5->C5_XSEQ := cSeq
        MsUnLock()  

        SC5->(DBSkip())                  
    Enddo
    alert("caboou")
 RESET ENVIRONMENT
return
