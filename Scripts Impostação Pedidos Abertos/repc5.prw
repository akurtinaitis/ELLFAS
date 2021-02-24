#Include "PROTHEUS.CH"
#Include "TOPCONN.CH"
#INCLUDE "TBICONN.CH"

#INCLUDE "FILEIO.CH"
#INCLUDE "RPTDEF.CH"
//rodar 01 02 2 03

user function repc5()
    PREPARE ENVIRONMENT EMPRESA '02' FILIAL '01'
    trocaCli()
    trocaTra()
   // trocaVend()
   // trocCond()

    RESET ENVIRONMENT
return
//CLIENTE
static function trocaCli()

    local cCli17 := ""
    local cCli25 := ""
    local cQuery := ""
    local cAlias := getNextAlias()
    
    If !SELECT("SC5") > 0
        DBSELECTAREA("SC5")
    EndIf    
    SC5->(DBSETORDER(1))
    SC5->(DBGOTOP())
    
    While !SC5->(Eof())
        cCli17 := SC5->C5_CLIENT   

        cQuery := " SELECT ISNULL(A1_COD,'') client" 
        cQuery += ",A1_XCODP17" 
        cQuery += " FROM " + RetSqlName("SA1")
        cQuery += " where A1_XCODP17 = '" + cCli17 + "'"
        cQuery += " GROUP BY A1_COD , A1_XCODP17"

        cQuery := ChangeQuery( cQuery )

        DbUseArea(.T., "TOPCONN",TCGenQry(,,cQuery),cAlias,.F., .T.)

        (cAlias)->(dbSelectArea((cAlias)))                    
        (cAlias)->(dbGoTop())

        cCli25 := (cAlias)->client
        if !Empty(cCli25)
            RecLock("SC5",.F.)
                SC5->C5_CLIENT := cCli25
                SC5->C5_CLIENTE := cCli25
            MsUnLock()  
        else
            csvL := "02;" +  "Cliente;"  +SC5->C5_NUM + ";" + SC5->C5_CLIENT  
            chamlogs(,csvL) 
        
        EndIf
        (cAlias)->(DBCloseArea())
        SC5->(DBSkip())           
    endDo

return

//TRANSPORTADORA


static function trocaTra()

    local ctrans17 := ""
    local ctrans25 := ""
    local cQuery := ""
    local cAlias := getNextAlias()
    
    If !SELECT("SC5") > 0
        DBSELECTAREA("SC5")
    EndIf    
    SC5->(DBSETORDER(1))
    SC5->(DBGOTOP())
    
    While !SC5->(Eof())
        ctrans17 := SC5->C5_TRANSP  

        cQuery :=  "SELECT ISNULL(A4_COD,'') TRANSP,A4_XCODP17 FROM " + RetSqlName("SA4") + " WHERE SA4010.D_E_L_E_T_ = '' AND A4_XCODP17 = '" +  ctrans17 +"'"   
                
        cQuery := ChangeQuery( cQuery )

        DbUseArea(.T., "TOPCONN",TCGenQry(,,cQuery),cAlias,.F., .T.)

        (cAlias)->(dbSelectArea((cAlias)))                    
        (cAlias)->(dbGoTop())

        ctrans25 := (cAlias)->TRANSP
        if !Empty(ctrans25)
            RecLock("SC5",.F.)
                SC5->C5_TRANSP := ctrans25
                
            MsUnLock()  
        else
            csvL := "02;" +  "Transportadora;" +SC5->C5_NUM + ";" + SC5->C5_TRANSP  
            chamlogs(,csvL) 
        
        EndIf
        (cAlias)->(DBCloseArea())
        SC5->(DBSkip())           
    endDo


return

static function trocaVend()

    local cVend17 := ""
    local cVend25 := ""
    local cQuery := ""
    local cAlias := getNextAlias()
    
    If !SELECT("SC5") > 0
        DBSELECTAREA("SC5")
    EndIf    
    SC5->(DBSETORDER(1))
    SC5->(DBGOTOP())
    
    While !SC5->(Eof())
        cVend17 := SC5->C5_VEND1  
        cQuery := " SELECT ISNULL(A3_COD,'') VENDEDOR FROM SA3010 WHERE A3_XCODP17 = '"+ cVend17+"' AND SA3010.D_E_L_E_T_ = ' ' " 
        
        DbUseArea(.T., "TOPCONN",TCGenQry(,,cQuery),cAlias,.F., .T.)

        (cAlias)->(dbSelectArea((cAlias)))                    
        (cAlias)->(dbGoTop())

        cVend25 := (cAlias)->VENDEDOR
        If !Empty(cVend25)
            RecLock("SC5",.F.)
                SC5->C5_VEND1 := cVend25
                
            MsUnLock()  
        else
            csvL := "02;" + "Vendedor;" +  SC5->C5_NUM + ";" + SC5->C5_VEND1  
            chamlogs(,csvL) 
        
        EndIf
        (cAlias)->(DBCloseArea())
        SC5->(DBSkip())           
    endDo


return

static function trocCond()

    local cCond17 := ""
    local cCond25 := ""
    local cQuery  := ""
    local cAlias  := getNextAlias()
    
    If !SELECT("SC5") > 0
        DBSELECTAREA("SC5")
    EndIf    
    SC5->(DBSETORDER(1))
    SC5->(DBGOTOP())
    
    While !SC5->(Eof())
        cCond17 := SC5->C5_CONDPAG  

        cQuery :=  "SELECT ISNULL(E4_CODIGO,'') CODIGO FROM  " + RetSqlName("SE4") + " SE4  WHERE SE4.D_E_L_E_T_ = '' AND E4_XCODP17 = '" +  cCond17 +"'"   
                
        cQuery := ChangeQuery( cQuery )

        DbUseArea(.T., "TOPCONN",TCGenQry(,,cQuery),cAlias,.F., .T.)

        (cAlias)->(dbSelectArea((cAlias)))                    
        (cAlias)->(dbGoTop())

        cCond25 := (cAlias)->CODIGO
        if !Empty(cCond25)
            RecLock("SC5",.F.)
                SC5->C5_CONDPAG := cCond25
            
            MsUnLock()  
        else
            csvL := "02;" + "Cond. Pgto;" +SC5->C5_NUM + ";" + SC5->C5_CONDPAG  
            chamlogs(,csvL)        
        EndIf
       
        (cAlias)->(DBCloseArea())
        SC5->(DBSkip())           
    endDo


return


static function chamlogs(cFile,csvL)

	Local nHandle 
	Local nBloco    := 99999
	Local nI        := 0
	Local cBuffer   := '' 
	Local cLeARQ    := "c:\lobao\data\arquivos\"
    Default cFile   := "Log_C501_nao_alterado.csv"
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
