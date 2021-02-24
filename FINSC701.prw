#Include "protheus.ch"

//------------------------------------------------------------------------\\
/*/{Protheus.doc} FINSC701()
Processar comissoes e gerar o pedido de compras SA1,SA2,SE3,SC7
@type function
@author Jose Maria
@since 30/09/2020
@version 1.0
/*/
//------------------------------------------------------------------------\\

User Function FINSC701()
Local aArea			:= GetArea()
Local aParamBox		:= {}

Private aRet		:= {}

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Filtro do relatorio.		                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
aAdd(aParamBox,{1,"Vendedor De"			, Space(TamSX3("A3_COD")[1])	,"@!"					,""						,"SA3"	,"",40	,.T.})
aAdd(aParamBox,{1,"Vendedor Até"		, Space(TamSX3("A3_COD")[1])	,"@!"					,"MV_PAR02>=MV_PAR01"	,"SA3"	,"",40	,.T.})
aAdd(aParamBox,{1,"Data de"				, CToD("")						,						,""						,""		,"",50	,.T.})
aAdd(aParamBox,{1,"Data Até"			, CToD("")						,"@!"					,"MV_PAR04>=MV_PAR03"	,""		,"",50	,.T.})

If !ParamBox(aParamBox,"Parametros",@aRet,,,.T.,1,200,,"Profile",.T.,.T.)
	Return Nil
EndIf

If STRZERO(Month(aRet[3]),2)+STRZERO(Year(aRet[3]),4) <> STRZERO(Month(aRet[4]),2)+STRZERO(Year(aRet[4]),4)
	MsgInfo("Verifique o intervalo de dadas, <MES+ANO> diferentes ")
	Return Nil
Endif

Processa( { || ProcComis( aRet, aParamBox ) } , 'Comissão Vendeores Externos, incluindo Pedidos de Compras'    )

RestArea(aArea)

Return Nil

///////////////////////////////////////////////////
Static Function ProcComis( aRet, aParambox)
Local aAreaAtu		:= GetArea()
Local cAlias		:= ""
Local cVendedor		:= ""
Local aDadosSE3 	:= {}
Local nValComis 	:= 0
Local cPeriodo      := STRZERO(Month(aRet[3]),2)+STRZERO(Year(aRet[3]),4)
Local aArqLog       := {}

Default aRet		:= {}

If Len(aRet) > 0
	
	cAlias := GeraDados( aRet )
	
	(cAlias)->( DbGoTop() )
	
	While (cAlias)->(!EOF())
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Efetua quebra de vendedor finalizando arquivo por vendedor   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If cVendedor <> (cAlias)->E3_VEND
			cVendedor := (cAlias)->E3_VEND
			aDadosSE3 := {}
			nValComis := 0
		EndIf
		
		If cVendedor == (cAlias)->E3_VEND
			nValComis += (cAlias)->E3_COMIS
			aadd( aDadosSE3, { cVendedor, (cAlias)->A3_FORNECE, (cAlias)->A3_LOJA, (cAlias)->E3_VEND, (cAlias)->E3_COMIS, (cAlias)->R_E_C_N_O_ } )
		Endif
		
		(cAlias)->( DbSkip() )
		
		If cVendedor <> (cAlias)->E3_VEND .Or. Eof()
			aArqLog := GeraPedCom( cVendedor , nValComis, aDadosSE3, cPeriodo, aArqLog  )
		Endif
		
	EndDo
	
EndIf

If Select(cAlias) > 0
	(cAlias)->( DbCloseArea() )
EndIf

RestArea(aAreaAtu)

If Len( aArqLog ) > 0
	ImpLog( "ELLFAS_Comissao_x_PC" , aArqLog )
Endif

Return Nil


///////////////////////////////////////////////////
Static Function GeraDados( aRet )
Local cAlias		:= GetNextAlias()	//Alias do arquivo temporario
Local cQryRpt		:= ""				//Instrucao da query do relatorio
Local aAreas		:= {SA3->(GetArea()), SE3->(GetArea()), GetArea()}

Default aRet		:= {}
cQryRpt := "SELECT SE3.E3_FILIAL,SE3.E3_VEND,SA3.A3_COD,SA3.A3_NREDUZ,SA3.A3_TIPO,SA3.A3_FORNECE,SA3.A3_LOJA," + CRLF
cQryRpt += "       SE3.E3_COMIS,SE3.E3_XPERIOD,SE3.R_E_C_N_O_ "  + CRLF
cQryRpt += " FROM " + RetSqlName("SE3")+ " SE3 " + CRLF
cQryRpt += " INNER JOIN " + RetSqlName("SA3")+ " SA3 ON SA3.A3_COD=SE3.E3_VEND AND SA3.A3_TIPO='E' " + CRLF
cQryRpt += " WHERE SE3.E3_FILIAL = '01' " + CRLF
cQryRpt += "    AND SE3.E3_EMISSAO BETWEEN '" + DToS(aRet[3]) + "' AND '" + DToS(aRet[4]) + "' " + CRLF
cQryRpt += "    AND SE3.E3_VEND BETWEEN '" + aRet[1] + "' AND '" + aRet[2] + "' " + CRLF
cQryRpt += "    AND SE3.D_E_L_E_T_ = ' ' " + CRLF
cQryRpt += " ORDER BY E3_FILIAL, E3_VEND "

If Select(cAlias) > 0
	(cAlias)->( DbCloseArea() )
EndIf

DbUseArea(.T., "TOPCONN", TcGenQry(,,cQryRpt),cAlias, .T., .T.)

aEval(aAreas, {|x| RestArea(x) })

Return cAlias


/////////////////////////////////////////////////////////////////
Static Function GeraPedCom( cVendedor, nValComis, aDadosSE3, cPeriodo, aArqLog )
Local aArea         := GetArea()
Local aAreaSE3
Local xy
Local cFornece      := GetAdvFVal( "SA3", "A3_FORNECE", xFilial("SA3")+cVendedor, 1 )
Local cLojaFor      := GetAdvFVal( "SA3", "A3_LOJA"   , xFilial("SA3")+cVendedor, 1 )
Local aCabec        := {}
Local aLinha        := {}
Local aItens        := {}
Local cErro
Local nPOS
Local aAutoErro
Local cPedCom       := ProxNumPC()
Local aGerarPc      := ValidarPC(cVendedor,cFornece,cLojaFor,cPeriodo)

Private lMsHelpAuto := .T.
Private lMsErroAuto := .F.

If !Empty(cVendedor)
	
	//---------------------------------------//
	If aGerarPC[1]
		
		If SA2->( dBSeek(xFilial("SA2")+cFornece+cLojaFor,.F.) )
			aadd(aCabec,{ "C7_FILIAL"   , xFilial("SC7")  } )
			aadd(aCabec,{ "C7_NUM"      , cPedCom         } )
			aadd(aCabec,{ "C7_EMISSAO"  , dDataBase       } )
			aadd(aCabec,{ "C7_FORNECE"  , SA2->A2_COD     } )
			aadd(aCabec,{ "C7_LOJA"     , SA2->A2_LOJA    } )
			aadd(aCabec,{ "C7_COND"     , If( Empty(SA2->A2_COND), "001",SA2->A2_COND ) } )
			aadd(aCabec,{ "C7_CONTATO"  , SA2->A2_CONTATO } )
			aadd(aCabec,{ "C7_FILENT"   , cFilAnt         } )
			
			aadd(aLinha,{ "C7_PRODUTO"  , "000016"     , Nil } )
			aadd(aLinha,{ "C7_QUANT"    , 1            , Nil } )
			aadd(aLinha,{ "C7_PRECO"    , nValComis    , Nil } )
			aadd(aLinha,{ "C7_TOTAL"    , nValComis    , Nil } )
			aadd(aLinha,{ "C7_XPERIOD"  , cPeriodo     , Nil } )
			aadd( aItens , aLinha )
			
			lMsErroAuto := .F.
			lAutoErrNoFile := .T.
			MATA120(1,aCabec,aItens,3,,,)
			If lMsErroAuto
				//MostraErro()
				aAutoErro := GETAUTOGRLOG()
				cErro     := ''
				For xy:=1 to len(aAutoErro)
					nPOS := AT("< -- Invalido",aAutoErro[xy])
					if nPOS	> 0
						cErro := aAutoErro[xy]
						exit
					else
						if !(nPOS > 0)
							nPOS := AT("->", aAutoErro[xy])
							if nPOS	> 0
								cErro := aAutoErro[xy]
								exit
							endif
						endif
					endif
				Next
				cErro := "Erro "+AllTrim(cErro)
				aadd( aArqLog , { cVendedor , cPeriodo, cFornece+"-"+cLojaFor, cPedcom, nValComis, Left(cErro,50) } )
			Else
				If Len( aDadosSE3 ) > 0
					dBSelectArea("SE3")
					aAreaSE3 := GetArea()
					For xy := 1 To Len( aDadosSE3 )
						DbGoTo( aDadosSE3[xy][6] )
						RecLock("SE3",.F.)
						SE3->E3_XPERIOD := cPeriodo
						MsUnlock()
					Next xy
					RestArea( aAreaSE3 )
				Endif
				aadd( aArqLog , { cVendedor , cPeriodo, cFornece+"-"+cLojaFor, cPedcom , nValComis, "Pedido de compras gerado com sucesso" } )
			EndIf
		Else
			aadd( aArqLog , { cVendedor , cPeriodo, cFornece+"-"+cLojaFor, "      ", nValComis,"Fornecdor não cadastrado" } )
		Endif
	Else
		aadd( aArqLog , { cVendedor , cPeriodo, cFornece+"-"+cLojaFor,aGerarPC[2],nValComis,"Já Existe PC do Vendedor neste periodo" } )
	Endif
	
EndIf

RestArea( aArea )

Return( aArqLog )


/////////////////////////////////////////////////////////////////
Static Function ProxNumPC()
Local aArea  := GetArea()
Local cRet   := ""
Local cQuery := ""

cQuery := "SELECT MAX(C7_NUM) AS C7NUM"
cQuery += " FROM "+RetSqlName("SC7")+" SC7 "
cQuery += " WHERE SC7.C7_FILIAL = '"+xFilial("SC7")+"' "
cQuery += "   AND SC7.D_E_L_E_T_= ' ' "

If Select("TMPSC7") > 0
	TMPSC7->( DbCloseArea() )
EndIf
cQuery := ChangeQuery(cQuery)
dbUseArea( .T. , "TOPCONN",TcGenQry(,,cQuery),"TMPSC7",.F.,.F.)
If ( TMPSC7->C7NUM=='NULL' .Or. Empty(TMPSC7->C7NUM) )
	cRet := Strzero(1,TamSX3("C7_NUM")[1])
Else
	cRet := TMPSC7->C7NUM
	cRet := Soma1( cRet )
Endif
TMPSC7->( DbCloseArea() )

RestArea( aArea )

Return( cRet )


/////////////////////////////////////////////////////////////////
Static Function ValidarPC(cVendedor,cFornece,cLojaFor,cPeriodo)
Local aArea  := GetArea()
Local lRet   := .T.
Local cPed   := Space(TamSX3("C7_NUM")[1])
Local cQuery := ""

cQuery := "SELECT C7_NUM,C7_XPERIOD "
cQuery += " FROM "+RetSqlName("SC7")+" SC7 "
cQuery += " WHERE SC7.C7_FILIAL  = '"+xFilial("SC7")+"' "
cQuery += "   AND SC7.C7_FORNECE = '"+cFornece+"' "
cQuery += "   AND SC7.C7_LOJA    = '"+cLojaFor+"' "
cQuery += "   AND SC7.C7_XPERIOD = '"+cPeriodo+"' "
cQuery += "   AND SC7.D_E_L_E_T_ = ' ' "

If Select("TMPSC7") > 0
	TMPSC7->( DbCloseArea() )
EndIf
cQuery := ChangeQuery(cQuery)
dbUseArea( .T. , "TOPCONN",TcGenQry(,,cQuery),"TMPSC7",.F.,.F.)
If !( TMPSC7->C7_NUM=='NULL' .Or. Empty(TMPSC7->C7_NUM) )
	cPed := TMPSC7->C7_NUM
	lRet := .F.
Endif
TMPSC7->( DbCloseArea() )

RestArea( aArea )

Return( {lRet, cPed} )


//------------------------------------------------------------------------\\
/*/{Protheus.doc} ImpLog
Imprime log
@type Function
@author Jose Maria
@since 01/10/2020
@version 1.0
@example ImpLog( "Comissao_PC_" , _aArqLog )
/*/
//------------------------------------------------------------------------\\
Static Function ImpLog(cNomeArq, aLinhas)

Local cDesc1 := 'Este programa tem como objetivo imprimir relatorio '
Local cDesc2 := 'de acordo com os parametros informados pelo usuario.'
Local cDesc3 := ''
Local titulo := 'Relatório Comissão x Pedido Compras '+cNomeArq
Local nLin   := 80
Local aOrd 	 := {}
Local Cabec1 := 'Vendedor                        Periodo         Fornecedor PC      Valor/Comis Ocorrencia'
Local Cabec2 := ''

Private lEnd        := .F.
Private lAbortPrint := .F.
Private limite      := 132
Private tamanho     := 'M'
Private nomeprog    := 'GeraLog'
Private nTipo       := 15
Private aReturn     := { 'Zebrado', 1, 'Administracao', 1, 2, 1, '', 1}
Private nLastKey    := 0
Private cbtxt      	:= Space(10)
Private cbcont     	:= 00
Private CONTFL     	:= 01
Private m_pag      	:= 01
Private cPerg       := ''
Private wnrel      	:= 'GeraLog'
Private cString		:= ''

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin,aLinhas) },Titulo)

Return Nil

//------------------------------------------------------------------------\\
/*/{Protheus.doc} RunReport
Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS, monta a
janela com a regua de processamento.
@type Function
@author José Maria
@since 01/10/2020
@version 1.0
@example RunReport()
/*/
//------------------------------------------------------------------------\\
Static Function RunReport(Cabec1,Cabec2,Titulo,nLin,aLinhas)
Local nI       := 0
Local cNomeVen := Space(TamSX3("A3_NREDUZ")[1])

SetRegua(Len(aLinhas))

If nLin > 60
	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	nLin := 8
Endif

For nI := 1 to Len(aLinhas)
	
	If lAbortPrint
		@nLin,00 PSAY '*** CANCELADO PELO OPERADOR ***'
		Exit
	Endif
	
	If nLin > 60
		Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
		nLin := 8
	Endif
	//         1         2         3         4         5         6        7          8         9        10        11        12        13
	//123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	//Vendedor                        Periodo         Fornecedor PC      Valor/Comis Ocorrencia
	//000000 xxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxx 000000-00  000000 9,999,999.99 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
	
	cNomeVen  := GetAdvFVal("SA3","A3_NREDUZ",xFilial("SA3")+aLinhas[nI,1],1)
	
	@nLin,001 PSAY aLinhas[nI,1]+" "+cNomeVen                   //Vendedor + Nome
	@nLin,033 PSAY aLinhas[nI,2]                                //Periodo
	@nLin,049 PSAY aLinhas[nI,3]                                //Fornecedor + Loja
	@nLin,060 PSAY aLinhas[nI,4]                                //Numero do Pedido Compra
	@nLin,067 PSAY Transform( aLinhas[nI,5],"@E 9,999,999.99")  //Valor do Pedido/Comissao
	@nLin,080 PSAY aLinhas[nI,6]                                //Ocorrencia Gerado com sucesso/Fornecedor não Cadastrado, Cond.Pag Não Cadastrada, Natureza Não Cadastrada
	nLin := nLin + 1
	
Next nI

set device to screen

If aReturn[5]==1
	dbCommitAll()
	set printer to
	OurSpool(wnrel)
Endif

MS_Flush()

Return Nil

Return
