#Include "PROTHEUS.CH"
#Include "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

#INCLUDE "FILEIO.CH"
#INCLUDE "RPTDEF.CH"


user function repc7()
    PREPARE ENVIRONMENT EMPRESA '03' FILIAL '01'
    
    trocaPro()
    trocaFor()

    RESET ENVIRONMENT
return

static function trocaPro()

    local cPro17 := ""
    local cPro25 := ""
    local cQuery := ""
    local cAlias := getNextAlias()

    If !SELECT("SC7") > 0
        DBSELECTAREA("SC7")
    EndIf    
    SC7->(DBSETORDER(1))
    SC7->(DBGOTOP())
    
    While !SC7->(Eof())
        cPro17 := ALLTRIM(SC7->C7_PRODUTO)   

        cQuery :=  "SELECT ISNULL (B1_COD,'') PROD  ,B1_XCODP17 FROM " + RetSqlName("SB1") + " SB1 WHERE SB1.D_E_L_E_T_ = '' AND B1_XCODP17 = '" +  cPro17 +"'" 

        cQuery := ChangeQuery( cQuery )

        DbUseArea(.T., "TOPCONN",TCGenQry(,,cQuery),cAlias,.F., .T.)

        (cAlias)->(dbSelectArea((cAlias)))                    
        (cAlias)->(dbGoTop())

        cPro25 := (cAlias)->PROD
        If !Empty(cPro25)
            RecLock("SC7",.F.)

                SC7->C7_PRODUTO := cPro25
            
            MsUnLock()
        else
            csvL := "Produto;" + ";" +SC7->C7_NUM + ";" + SC7->C7_PRODUTO  
            chamlogs(,csvL) 
        
        EndIf
         
        (cAlias)->(DBCloseArea())
        SC7->(DBSkip())           
    endDo

return

static function trocaFor()

    local cFor17 := ""
    local cFor25 := ""
    local cQuery := ""
    local cAlias := getNextAlias()

    If !SELECT("SC7") > 0
        DBSELECTAREA("SC7")
    EndIf    
    SC7->(DBSETORDER(1))
    SC7->(DBGOTOP())
    
    While !SC7->(Eof())
        cFor17 := ALLTRIM(SC7->C7_FORNECE)   

        cQuery :=  "SELECT ISNULL (A2_COD,'') FORNECE  FROM " + RetSqlName("SA2") + " SA2 WHERE SA2.D_E_L_E_T_ = '' AND A2_XCODP17 = '" +  cFor17 +"'" 

        cQuery := ChangeQuery( cQuery )

        DbUseArea(.T., "TOPCONN",TCGenQry(,,cQuery),cAlias,.F., .T.)

        (cAlias)->(dbSelectArea((cAlias)))                    
        (cAlias)->(dbGoTop())

        cFor25 := (cAlias)->FORNECE
        If !Empty(cFor25)
            RecLock("SC7",.F.)

                SC7->C7_FORNECE := cFor25
            
            MsUnLock()
        
        else
            csvL := "Fornecedor;" + ";" +SC7->C7_NUM + ";" + SC7->C7_FORNECE  
            chamlogs(,csvL) 
        
        EndIf
         
        (cAlias)->(DBCloseArea())
        SC7->(DBSkip())           
    endDo

return

static function chamlogs(cFile,csvL)

	Local nHandle 
	Local nBloco    := 99999
	Local nI        := 0
	Local cBuffer   := '' 
	Local cLeARQ    := "c:\lobao\data\arquivos\"
   	Default cFile	:= "Log_sc7_nao_alterado.csv"
  	Default cCsvl   := ""


	MakeDir(cLeARQ)
	
	if !File(cLeARQ+cFile)
		nHandle := FCreate(cLeARQ+cFile)
	
	else
		nHandle := FOpen(cLeARQ+cFile,FO_READWRITE + FO_SHARED )
		FSeek(nHandle, 0, 2)
	endIf
	//nHandle := FCreate(cLeARQ+cFile)

	cBuffer += csvL + CRLF
	FSeek(nHandle, 0, 2)
	FWrite(nHandle, cBuffer,nBloco )
	FClose(nHandle)

	


Return .T.