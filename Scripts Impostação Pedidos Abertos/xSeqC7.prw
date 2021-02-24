#Include "PROTHEUS.CH"
#Include "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

#INCLUDE "FILEIO.CH"
#INCLUDE "RPTDEF.CH"

User Function xseqc7()
    local nseq := 1
    local cseq := ""
    local cCod := ""

    PREPARE ENVIRONMENT EMPRESA '03' FILIAL '01'

    If !SELECT("SC7") > 0
        DBSELECTAREA("SC7")
    EndIf    
    SC7->(DBSETORDER(1))
    SC7->(DBGOTOP())
    
    cCod := SC7->C7_NUM
    WHILE !SC7->(Eof())
        
        IF cCod = SC7->C7_NUM

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

        RecLock("SC7",.F.)
            SC7->C7_XSEQ := cSeq
        MsUnLock()  

        SC7->(DBSkip()) 
        endIf
        if cCod != SC7->C7_NUM
            
            nseq++ 
            cCod := SC7->C7_NUM
        endIf
        
    endDo
    RESET ENVIRONMENT
return