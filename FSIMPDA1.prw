#Include "PROTHEUS.CH"
#Include "TOPCONN.CH"
#include "rwmake.ch"
#INCLUDE "TBICONN.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "totvs.ch"

#INCLUDE "FILEIO.CH"

#DEFINE ENTER chr(13)+chr(10)

Static cTab := 'C:\TABELA_ETHOSX\'
Static cArquivo := "Log_nao_incluso.csv"

/*/{Protheus.doc} chamlogs
//TODO Caixa de dialogo com usuario.
@author Fabio
@since 20/10/2019
@version 1.0
@return ${return}, ${return_description} .T. 
@param 
@type function]
/*/
user function FSIMPDA1()
Private lMaisAlt := .F.
Private oDlg
Private dData   := CTOD("")
Private _dDataN  := CTOD("")
Private dDataI  := CTOD("")
Private nResult := 0       
Private DDATAF  := CTOD("")

	If MSGYESNO("O Processo � inclus�o?")
		nResult := 1 // inclus�o
	Else 
		nResult := 2 // altera��o	
	EndIf	
														
			If nResult == 1
				DEFINE MSDIALOG oDlg FROM 0,0 TO 250,250 PIXEL TITLE "Inclus�o de dados"
				@ 017,17 Say "Data de vigencia : "     of oDlg Pixel
				@ 016,72 MsGet dData Picture "@!" of oDlg Pixel 
			Else
				DEFINE MSDIALOG oDlg FROM 0,0 TO 250,250 PIXEL TITLE "Altera��o de dados"
				@ 017,17 Say "Data antiga : "     of oDlg Pixel
				@ 016,72 MsGet dDataI Picture "@!" of oDlg Pixel 

				@ 047,17 Say "Data nova : "     of oDlg Pixel
				@ 046,72 MsGet _dDataN Picture "@!" of oDlg Pixel 
			EndIf

			@ 090,028 BUTTON "Processar"   SIZE 28,13 PIXEL OF oDlg ACTION FSIMP002(oDlg)
			@ 090,073 BUTTON "Sair"   SIZE 28,13 PIXEL OF oDlg ACTION oDlg:End()
			

		ACTIVATE MSDIALOG oDlg CENTERED
Return

/*/{Protheus.doc} FSIMPDA1
//TODO Na inclus�o se a data est� preenchida e processa o programa.
@author Fabio
@since 07/02/2020
@version 1.0
@return ${return}, ${return_description}

@type function
/*/
Static Function FSIMP002()


		If nResult == 1 .AND. Empty(dData)
			If MSGYESNO("A T E N � � O" + CRLF + CRLF + "O campo Data de vigencia est� em branco deseja realmente continuar?", "DATA")//n�o deve existir
				Processa({|| FSIMP003()}, "Aguarde...", "Atualizando dados...")  // Vira MSGINFO
				oDlg:end()
				Return
			EndIf
		Else
			Processa({|| FSIMP003()}, "Aguarde...", "Atualizando dados...")		
		EndIf

		If !lMaisAlt
			oDlg:end()
		EndIf
	
Return


/*/{Protheus.doc} FSIMPDA1
//TODO Descri��o leitura do arquivo CSV.
@author Fabio
@since 07/02/2020
@version 1.0
@return ${return}, ${return_description}

@type function
/*/
Static function FSIMP003()
	Local cLinha        := "" 
	Local aDados        := {}
	Local cGrava        := ""
	local  cMascara  	:= '*.csv'
	Local nMascpad      := 0
	local  cDirini   	:= "\"
	Local  lSalvar   	:= .T. //.T. = Salva || .F. = Abre
	Local  nOpcoes   	:= GETF_LOCALHARD
	Local  lArvore   	:= .T. //.T. = apresenta o �rvore do servidor || .F. = n�o apresenta
	
	Private cLeARQ      := ''

	cLocalFile	        := cGetFile( cMascara, "Escolha o arquivo", nMascpad, cDirIni, lSalvar, nOpcoes, lArvore)
	//cLocalFile			:= SubStr(cLocalFile,1,len(cLocalFile)-1)
	ADIR(cLocalFile+ "*.csv",aDados)
	
	MV_PAR01 := cLocalFile//"C:\TABELA_ETHOSX\faethr11_20190630.csv"
	
	cLeARQ	 := SubStr(MV_PAR01,1,RAT("\",MV_PAR01))// CAMINHO DE ONDE PEGOU O ARQUIVO

	FT_FUSE(MV_PAR01)
	FT_FGOTOP()

	If cLocalFile == "" // caso colocar em cancelar na escolha do arquivo ele sai do programa
		Return
	EndIf

	ProcRegua(10000)
	While !FT_FEOF() 
	IncProc("Preparando arquivo...")

		cLinha := Upper(FT_FREADLN())

		aAdd(aDados,Separa(cLinha,";",.T.))

		FT_FSKIP()

	EndDo

	FT_FUSE()
	If !Len(aDados) > 1
		Alert("A T E N � � O" + CRLF + CRLF + "N�o h� dados a ser importado")
		Return
	EndIf

	If nResult == 1
		FSIMP004(aDados)
	Else
		If ValDat(aDados) 
			FSIMP006(aDados)
		Endif
	EndIf
Return

Static Function ValDat(aDados)
	Local lExDaAn := .F.
	Local lExDaNo := .F.
	Local cTabela := aDados[2][1]
	Local aArea := GetArea()

	DBSelectArea("DA1")
	DA1->(DBSetOrder(1))
	DA1->(DBGoTop())

	If DA1->(DBSeek(xFilial("DA1")+cTabela))
		Do While DA1->DA1_CODTAB == cTabela
			If DA1->DA1_DATVIG == dDataI
				lExDaAn := .T.
			EndIf
			DA1->(DbSkip())
		EndDo

		If !lExDaAn
			lMaisAlt := MsgYesNo("A Data antiga informada: "+dToc(dDataI)+" n�o existe na Tabela. Deseja inseir uma nova data?","Data Antiga Inexistente!")
			Return .F.
		EndIf

	EndIf

	DA1->(DBGoTop())

	If DA1->(DBSeek(xFilial("DA1")+cTabela))
		Do While DA1->DA1_CODTAB == cTabela
			If DA1->DA1_DATVIG == _dDataN
				lExDaNo := .F.
				lMaisAlt := MsgYesNo("A tabela informada j� tem data de vig�ncia "+dToc(_dDataN)+". Deseja inseir uma nova data?","Tabela com data de vig�ncia j� existente!")
				Return .F.
			EndIf
			DA1->(DbSkip())
		EndDo
	EndIf

	RestArea(aArea)
return .T.


/*/{Protheus.doc} MaiorItem
//TODO Verifica o ultimo registro do item.
@author Fabio
@since 24/10/2019
@version 1.0
@return ${return}, ${return_description}
@param 
@type function
/*/
Static Function MaiorItem(cCodTab)
	Local cItem 	:= ''
	Local cQuery 	:=	''
	Local cAlias	:= GetNextAlias()

	cQuery += " SELECT MAX(DA1_ITEM) MAIOR FROM "+ retsqlname("DA1")
	cQuery += " WHERE DA1_CODTAB = '"+cCodTab+"'"
	cQuery += "AND D_E_L_E_T_ = ''"

	dbUseArea(.T.,"TOPCONN", TCGenQry(,,cQuery), cAlias, .F., .T.)

	(cAlias)->(dbGoTop())

	if (cAlias)->(!eof())
		cItem := (cAlias)->MAIOR 
	Else	
		cItem := '0000'
	EndIf
	(cAlias)->(DBCloseArea())
Return cItem


/*/{Protheus.doc} chamlogs
//TODO Gera��o de arquivos do log com CSV.
@author Fabio
@since 20/10/2019
@version 1.0
@return ${return}, ${return_description} .T. 
@param 
@type function
/*/
Static function FSIMP005(cMsgErro)

	Local nHandle 
	Local nBloco := 999999
	Local nI := 0
	Local cBuffer := '' 
	Local nRet := MakeDir(cLeARQ)
   
  if nRet != 0
    conout( "N�o foi poss�vel criar o diret�rio. Erro: " + cValToChar(FError()))
  endif

	MakeDir(cLeARQ)

	if !File(cLeARQ+cArquivo)
		nHandle := FCreate(cLeARQ+cArquivo)
	
	else
		nHandle := FOpen(cLeARQ+cArquivo,FO_READWRITE + FO_SHARED )
		FSeek(nHandle, 0, 2)
	endIf

	cBuffer := cMsgErro + CRLF
	FWrite(nHandle, cBuffer,nBloco )
	FClose(nHandle)

	
	If Len(cMsgErro) >0
		MsgInfo("A T E N � � O" + CRLF + CRLF + "Foi gerado um Log do(s) resgistro(s) que n�o foram inclusos no mesmo diret�rio do arquivo .CSV","LOG ARQUIVO")
	EndIf
	cMsgErro := ""
Return .T.


/*/{Protheus.doc} FSIMPDA1
//TODO inclui item
@author Fabio
@since 07/02/2020
@version 1.0
@return ${return}, ${return_description}

@type function
/*/
Static Function FSIMP004(aDados)
Local _loop      := 0
	Local aDadosNao  := {}
	Local nValor     := 0
    Local cItem      := ''
	Local nItem      := 0
	Local cMsgErro   := ''
	Local cDeclaracao 	:= ''
	LOCAL CDATA := ''

	DBSELECTAREA("DA1")

	// Exclui os itens deletados
	cDeclaracao := "DELETE " + RetSqlName("DA1") + " WHERE D_E_L_E_T_ = '*'"
	TCSqlExec(cDeclaracao)



	ADel(aDados,1)// tratamento para excluir primeira linha do array
	ASize( aDados,LEN(aDados)-1)// tratamento para excluir a linha em branco do array
	
	aSort(aDados, , , {|x, y| x[1] < y[1]}) 
	
	cCodTab := aDados[2,1]

	cItem := alltrim(MaiorItem(cCodTab))

	ProcRegua(Len(aDados))
	For _loop := 1 To Len(aDados)
	IncProc("Processando...")
		If !cCodTab == aDados[_loop,1]
			cCodTab := aDados[_loop,1]				
			cItem := alltrim(MaiorItem(cCodTab))
		EndIf

		If !SELECT("SB1") > 0
			DBSELECTAREA("SB1")
		EndIf
		SB1->(DBSETORDER(1))
		SB1->(DBGOTOP())

		If SB1->(dbseek(xFilial("SB1")+ aDados[_loop,2]))
			If !SELECT("DA1") > 0
				DBSELECTAREA("DA1")
			EndIf
			
			
			
			If Empty(dDataI)
				cDataI := DTOS(dData)//VERIFICAR SE A VARIAVEL CONTUNUA DATA
			Else
				cDataI := DTOS(ddataI)
			EndIf
			
			DA1->(DbSetOrder(1))
			DA1->(DBGOTOP())
			if DA1->(dbseek(xFilial("DA1") + aDados[_loop,1] + aDados[_loop,2]))

				If !DA1->(dbseek(xFilial("DA1") + aDados[_loop,1] + aDados[_loop,2] + SPACE(TAMSX3("DA1_CODPRO")[1]-LEN(aDados[_loop,2])) + cDataI))				
					
					DA1->(DbOrderNickName("IMPTAB"))
					DA1->(DBGOTOP())
					
					RecLock("DA1", .T.)	
						If !Empty(cItem)
							cItem := Soma1(cItem)
						Else
							cItem := '001'	
						EndIf
						DA1->DA1_ITEM 	:= cItem
						DA1->DA1_CODTAB := ALLTRIM(aDados[_loop,1])
						DA1->DA1_CODPRO := ALLTRIM(aDados[_loop,2])
						If Valtype(aDados[_loop,3]) <> "N"
							DA1->DA1_PRCVEN := VAL(aDados[_loop,3])
						Else
							DA1->DA1_PRCVEN := aDados[_loop,3]
						EndIf	
						DA1->DA1_ATIVO  := "1"
						DA1->DA1_TPOPER := '4'
						DA1->DA1_QTDLOT := 999999.99
						DA1->DA1_INDLOT := '000000000999999.99'
						DA1->DA1_MOEDA  := 1

						CDATA := DTOS(DDATA)
						DA1->DA1_DATVIG :=STOD (cData)
						DA1->(MsUnLock())	
						SB1->(DBCLOSEAREA())
						DA1->(DBCLOSEAREA())
				Else
					If !ALLTRIM(aDados[_loop,1]) == 'COD. TABELA'//Tratamento para n�o imprimir cabe�alho
						cMsgErro += "---------------------------------------" + CRLF
						cMsgErro += "Item  e codigo j� existe na DA1" + CRLF
						cMsgErro += ALLTRIM(aDados[_loop,1]) + ";" + ALLTRIM(aDados[_loop,2]) + ";" + ALLTRIM(aDados[_loop,3]) + CRLF
					EndIf
				EndIf
			
			Else
				if !ALLTRIM(aDados[_loop,1]) == 'COD. TABELA'//Tratamento para n�o imprimir cabe�alh
					cMsgErro += "---------------------------------------" + CRLF
					cMsgErro += "Item, C�digo ou Tabela n�o cadastrados" + CRLF
					cMsgErro += "Tabela: " + ALLTRIM(aDados[_loop,1]) + ";" + "Cod.Produto: " +ALLTRIM(aDados[_loop,2]) + ";"  + CRLF
				EndIf
			endIf// bloco de interven��o
		Else
			If !ALLTRIM(aDados[_loop,1]) == 'COD. TABELA'//Tratamento para n�o imprimir cabe�alho
					cMsgErro += "---------------------------------------" + CRLF
					cMsgErro += "Produto n�o cadastrado na SB1" + CRLF
					cMsgErro += ALLTRIM(aDados[_loop,1]) + ";" + ALLTRIM(aDados[_loop,2]) + ";" + ALLTRIM(aDados[_loop,3]) + CRLF
			EndIf
		EndIf
	Next

	FSIMP005(cMsgErro)//Fun��o de gera��o de log	

Return

/*/{Protheus.doc} FSIMPDA1
//TODO Altera o item
@author Fabio
@since 07/02/2020
@version 1.0
@return ${return}, ${return_description}

@type function
/*/
Static function FSIMP006(aDados)//FSIMP004(aDados)

	Local _loop      := 0
	Local aDadosNao  := {}
	Local nValor     := 0
    Local cItem      := ''
	Local nItem      := 0
	Local cMsgErro   := ''
	Local cDeclaracao 	:= ''
	LOCAL CDATA := ''
//data nova e data antiga n�o podem ficar em branco
	DBSELECTAREA("DA1")

	// Exclui os itens deletados
	cDeclaracao := "DELETE " + RetSqlName("DA1") + " WHERE D_E_L_E_T_ = '*'"
	TCSqlExec(cDeclaracao)

	ADel(aDados,1)// tratamento para excluir primeira linha do array
	ASize( aDados,LEN(aDados)-1)// tratamento para excluir a linha em branco do array
	
	aSort(aDados, , , {|x, y| x[1] < y[1]}) 
	
	cCodTab := aDados[2,1]

	cItem := alltrim(MaiorItem(cCodTab))

	ProcRegua(Len(aDados))
	For _loop := 1 To Len(aDados)
	IncProc("Processando...")
		If !cCodTab == aDados[_loop,1]
			cCodTab := aDados[_loop,1]				
			cItem := alltrim(MaiorItem(cCodTab))
		EndIf

		If !SELECT("SB1") > 0
			DBSELECTAREA("SB1")
		EndIf
		SB1->(DBSETORDER(1))
		SB1->(DBGOTOP())

		If SB1->(dbseek(xFilial("SB1")+ aDados[_loop,2]))
			If !SELECT("DA1") > 0
				DBSELECTAREA("DA1")
			EndIf
			
			DA1->(DbOrderNickName("IMPTAB"))
			DA1->(DBGOTOP())
			
			If Empty(_dDataN)
				Alert("A T E N � � O" + CRLF + CRLF + "O campo data nova encontra-se em branco" + CRLF + "Favor preencher o campo")
				Return
			EndIf

			If Empty(dDataI)
				Alert("A T E N � � O" + CRLF + CRLF + "O campo data antiga encontra-se em branco" + CRLF + "Favor preencher o campo")
				Return
			Else
				cDataI := DTOS(ddataI)
			EndIf


			If DA1->(dbseek(xFilial("DA1") + aDados[_loop,1] + aDados[_loop,2] + SPACE(TAMSX3("DA1_CODPRO")[1]-LEN(aDados[_loop,2])) + cDataI))
				RecLock("DA1", .F.)
				DA1->DA1_DATVIG := _dDataN//"20200201"//_dDataN
				DA1->(MsUnLock())	

			//inclui uma nova linha por�m item diferente
				RecLock("DA1", .T.)	// DEVE SER INCLUSO POR�M TROCAR A DATA E VALOR DA NOVA TABELA
				If !Empty(cItem)
					cItem := Soma1(cItem)
				Else
					cItem := '001'	
				EndIf
				DA1->DA1_ITEM 	:= cItem
				DA1->DA1_CODTAB := ALLTRIM(aDados[_loop,1])
				DA1->DA1_CODPRO := ALLTRIM(aDados[_loop,2])
				If Valtype(aDados[_loop,3]) <> "N"
					DA1->DA1_PRCVEN := VAL(aDados[_loop,3])
				Else
					DA1->DA1_PRCVEN := aDados[_loop,3]
				EndIf	
				DA1->DA1_ATIVO  := "1"
				DA1->DA1_TPOPER := '4'
				DA1->DA1_QTDLOT := 999999.99
				DA1->DA1_INDLOT := '000000000999999.99'
				DA1->DA1_MOEDA  := 1
				DA1->DA1_DATVIG := dDataI
				
				DA1->(MsUnLock())	
				SB1->(DBCLOSEAREA())
				DA1->(DBCLOSEAREA())	
			Else
				If !ALLTRIM(aDados[_loop,1]) == 'COD. TABELA'//Tratamento para n�o imprimir cabe�alho
					cMsgErro += "---------------------------------------" + CRLF
					cMsgErro += "Produto n�o cadastrado na tabela de pre�o (DA1)" + CRLF
					cMsgErro += ALLTRIM(aDados[_loop,1]) + ";" + ALLTRIM(aDados[_loop,2]) + ";" + ALLTRIM(aDados[_loop,3]) + CRLF
				EndIf
			EndIf
		Else
			If !ALLTRIM(aDados[_loop,1]) == 'COD. TABELA'//Tratamento para n�o imprimir cabe�alho
				cMsgErro += "---------------------------------------" + CRLF
				cMsgErro += "Produto n�o cadastrado" + CRLF
				cMsgErro += ALLTRIM(aDados[_loop,1]) + ";" + ALLTRIM(aDados[_loop,2]) + ";" + ALLTRIM(aDados[_loop,3]) + CRLF
			EndIf
		EndIf
	Next
	FSIMP005(cMsgErro)//Fun��o de gera��o de log	
Return