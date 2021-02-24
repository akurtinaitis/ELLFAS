#Include "PROTHEUS.CH"
#Include "TOPCONN.CH"
#INCLUDE "TBICONN.CH"


#INCLUDE "FILEIO.CH"
#INCLUDE "RPTDEF.CH"
// rodar 01 02 e 03

user function repc6()
    PREPARE ENVIRONMENT EMPRESA '02' FILIAL '01'
    trocaPro()
    trocaCli()
    trocaTes()
    trocaArm()

    RESET ENVIRONMENT
return

//
static function trocaPro()

    local cPro17 := ""
    local cPro25 := ""
    local cQuery := ""
    local cAlias := getNextAlias()
    
    If !SELECT("SC6") > 0
        DBSELECTAREA("SC6")
    EndIf    
    SC6->(DBSETORDER(1))
    SC6->(DBGOTOP())
    
    While !SC6->(Eof())
        cPro17 := ALLTRIM(SC6->C6_PRODUTO)   

        cQuery :=  "SELECT ISNULL(B1_COD,'') PROD  ,B1_XCODP17 FROM " + RetSqlName("SB1") + " SB1 WHERE SB1.D_E_L_E_T_ = '' AND B1_XCODP17 = '" +  cPro17 +"'" 

        cQuery := ChangeQuery( cQuery )

        DbUseArea(.T., "TOPCONN",TCGenQry(,,cQuery),cAlias,.F., .T.)

        (cAlias)->(dbSelectArea((cAlias)))                    
        (cAlias)->(dbGoTop())

        cPro25 := (cAlias)->PROD
        If !Empty(cPro25)
            RecLock("SC6",.F.)

                SC6->C6_PRODUTO := cPro25
            
            MsUnLock()
        
        else
            csvL := "01;" + "Produto" + ";" +SC6->C6_NUM + ";" + ALLTRIM(SC6->C6_PRODUTO)
            chamlogs(,csvL) 
        
        
        EndIf
         
        (cAlias)->(DBCloseArea())
        SC6->(DBSkip())           
    endDo

return

static function trocaCli()

    local cCli17 := ""
    local cCli25 := ""
    local cQuery := ""
    local cAlias := getNextAlias()
    
    If !SELECT("SC6") > 0
        DBSELECTAREA("SC6")
    EndIf    
    SC6->(DBSETORDER(1))
    SC6->(DBGOTOP())
    
    While !SC6->(Eof())
        cCli17 := ALLTRIM(SC6->C6_CLI)   
       
        cQuery :=  "SELECT ISNULL(A1_COD,' ') CLI, A1_XCODP17 FROM " + RetSqlName("SA1") + " SA1 WHERE  SA1.D_E_L_E_T_ = ' ' AND A1_XCODP17 = '" +  cCli17 +"'" 

        cQuery := ChangeQuery( cQuery )

        DbUseArea(.T., "TOPCONN",TCGenQry(,,cQuery),cAlias,.F., .T.)

        (cAlias)->(dbSelectArea((cAlias)))                    
        (cAlias)->(dbGoTop())

        cCli25 := (cAlias)->CLI
        if !Empty(cCli25)
            RecLock("SC6",.F.)
                SC6->C6_CLI := cCli25
            
            MsUnLock() 
        
        else
            csvL := "01;" + "Cliente" + ";" +SC6->C6_NUM + ";" + ALLTRIM(SC6->C6_CLI)  
            chamlogs(,csvL) 
        
        endIf

 
        (cAlias)->(DBCloseArea())
        SC6->(DBSkip())           
    endDo

return

static function trocaTes()

    local cTES17 := ""
    local cTES25 := ""
    local cQuery := ""
    local cAlias := getNextAlias()
    
    If !SELECT("SC6") > 0
        DBSELECTAREA("SC6")
    EndIf    
    SC6->(DBSETORDER(1))
    SC6->(DBGOTOP())
    
    While !SC6->(Eof())
        cTES17 := ALLTRIM(SC6->C6_TES)   
       
        cQuery :=  "SELECT ISNULL(F4_CODIGO,'') TES FROM " + RetSqlName("SF4") + " SF4 WHERE SF4.D_E_L_E_T_ = '' AND F4_X_CODAN = '" +  cTES17 +"'" 

        cQuery := ChangeQuery( cQuery )

        DbUseArea(.T., "TOPCONN",TCGenQry(,,cQuery),cAlias,.F., .T.)

        (cAlias)->(dbSelectArea((cAlias)))                    
        (cAlias)->(dbGoTop())

        cTES25 := (cAlias)->TES
        if !Empty(cTES25)
            RecLock("SC6",.F.)
                
                SC6->C6_TES := cTES25
                
            MsUnLock()  
 
        else
            csvL := "01;" + "TES" + ";" +SC6->C6_NUM + ";" + ALLTRIM(SC6->C6_TES)  
            chamlogs(,csvL) 
        
        
        endIf
        (cAlias)->(DBCloseArea())
        SC6->(DBSkip())           
    endDo

return


//ARMAZÉM

static function trocaArm()

    local cTES17 := ""
    local cTES25 := ""
    local cQuery := ""
    local cAlias := getNextAlias()
    
    If !SELECT("SC6") > 0
        DBSELECTAREA("SC6")
    EndIf    
    SC6->(DBSETORDER(1))
    SC6->(DBGOTOP())
    
    While !SC6->(Eof())
        cTES17 := ALLTRIM(SC6->C6_LOCAL)   
       
        cQuery :=  "SELECT ISNULL(NNR_CODIGO,'') NNRCOD FROM " + RetSqlName("NNR") + " NNR WHERE NNR.D_E_L_E_T_ = '' AND NNR_XCDP17 = '" +  cTES17 +"'" 

        cQuery := ChangeQuery( cQuery )

        DbUseArea(.T., "TOPCONN",TCGenQry(,,cQuery),cAlias,.F., .T.)

        (cAlias)->(dbSelectArea((cAlias)))                    
        (cAlias)->(dbGoTop())

        cTES25 := (cAlias)->NNRCOD
        if !Empty(cTES25)
            RecLock("SC6",.F.)
                
                SC6->C6_LOCAL := cTES25
                
            MsUnLock()  
        else
            csvL := "01;" + "Armazem" + ";" +SC6->C6_NUM + ";" + ALLTRIM(SC6->C6_LOCAL) 
            chamlogs(,csvL) 
        
        endIf
        (cAlias)->(DBCloseArea())
        SC6->(DBSkip())           
    endDo

return

static function chamlogs(cFile,csvL)

	Local nHandle 
	Local nBloco    := 99999
	Local nI        := 0
	Local cBuffer   := '' 
	Local cLeARQ    := "c:\lobao\data\arquivos\"
    Default cFile   := "Log_C601_nao_alterado.csv"
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
