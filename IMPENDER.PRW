#include 'protheus.ch'
#include 'parmtype.ch' 
#include "TopConn.ch"
#include "TBICONN.CH"
#include "TbiCode.ch"
#include "rwmake.CH"
 
#define CMD_OPENWORKBOOK			1
#define CMD_CLOSEWORKBOOK			2
#define CMD_ACTIVEWORKSHEET	   		3
#define CMD_READCELL				4

/*
=====================================================================================
|Programa: IMPENDER    |Autor: Fontanelli                          |Data: 13/07/2020|
=====================================================================================
|Descricao: Importa informacoes de endereco para o SB1 (Cadastro de produtos)   |
|                                                                                   |
=====================================================================================
*/
user function IMPENDER()

	Local aSays 		:= {}
	Local aButtons		:= {}
	Local nOpca 		:= 0
	Local cCadastro		:= "Importa��o de Endere�o do Produto"
	Local cFileOpen 	:= ""

	Private cTitulo := "Planilha"

	AADD(aSays, "Este Programa ira importar uma planilha padr�o CSV."	)
	AADD(aSays, "" 	)
	AADD(aSays, ""	)
	AADD(aSays, ""	)
	AADD(aSays, ""	)

	//Insere os bot�es na tela e adiciona fun��es a eles.
	AADD(aButtons, { 1,.T.,{|| nOpca:= 1, FechaBatch() 			}} )
	AADD(aButtons, { 2,.T.,{|| nOpca:= 0, FechaBatch() 			}} )
	aAdd(aButtons, { 5,.T.,{|| nOpca:= 2, SelArq(@cFileOpen) }} )

	//Cria a tela com os bot�es.
	FormBatch( cCadastro, aSays, aButtons )

	If nOpca == 0 .Or. Empty(Alltrim(cFileOpen))
		Return Nil
	ElseIf nOpca == 1 .And. !Empty(Alltrim(cFileOpen))
		Processa( { ||Importar(cFileOpen) } )
	Else
		Return Nil
	EndIf

Return


/*
=====================================================================================
|Programa: SelArq      |Autor: Fontanelli                          |Data: 13/07/2020|
=====================================================================================
|Descri��o: Importa informa��es de endere�o no cadastro de produto                  |
|                                                                                   |
=====================================================================================
*/
Static Function SelArq(cFileOpen)

	Local cTitulo  	:= "Selecione o Arquivo"
	Local cExtens   := ""

	//cExtens   += "Planilha padr�o CSV | *.cst | "
	cExtens   += "Todos os Arquivos  | *.* | "

	//Seleciona o Local do arquivo                 
	cFileOpen := cGetFile(cExtens,cTitulo,0,,.F.,GETF_ONLYSERVER+GETF_LOCALHARD+GETF_NETWORKDRIVE)

	If !File(cFileOpen)
		MsgAlert("Nenhuma Planilha Selecionada!")
	Endif

Return(cFileOpen)


/*
=====================================================================================
|Programa: Importar    |Autor: Fontanelli                          |Data: 13/07/2020|
=====================================================================================
|Descri��o: Importa informa��es de endere�o no cadastro de produto                  |
|                                                                                   |
=====================================================================================
*/
Static Function Importar(cFile)

	Local cBuffer	  	:= ''
	Local nP

	aVetTr := {}

	// Pasta onde vou LER o arquivo
	cArqLER  := cFile
	
	If !File(cArqLER)
		MsgAlert("Arquivo: "+cArqLER+" n�o localizado","Aten��o !")
	Endif

	If File(cArqLER)
	
		FT_FUse(cArqLER)
		FT_FGoTop()
		FT_FSkip()
		
		While !FT_FEOF()
			
			cBuffer  := FT_FREADLN()
			
			nReg := At(";",cBuffer)
			
			Cpo01:= Substr(cBuffer,1,nReg - 1); cBuffer := Substr(cBuffer,nReg+1); nReg := At(";",cBuffer) 	// [01] Produto
			Cpo01:= Cpo01

			// [02] Endere�o
			If At(";",cBuffer) > 0
				Cpo02 := Substr(cBuffer,1,nReg - 1)															
				Cpo02 := Cpo02
			Else
				Cpo02 := Substr(cBuffer,1)
				Cpo02 := Cpo02
			EndIf
			
			Aadd(aVetTr,{	Cpo01,; // [01] Produto
							Cpo02,; // [02] Endere�o
						})
			
			FT_FSkip()
			
		EndDo
		
		FT_FUse()
		
		If Len(aVetTr) > 0
	
			// Todos os Itens sao marcados com o Retorno
			For nP := 1 to Len(aVetTr)

					DbSelectArea("SB1")
					SB1->(DbSetOrder(1))
					SB1->(dbGoTop())   
					If DbSeek(xFilial("SB1")+aVetTr[nP][1])
						RecLock("SB1",.F.)	
						SB1->B1_XENDER := aVetTr[nP][2]	
						MsUnLock()
					else
						MsgAlert("Produto "+aVetTr[nP][1]+" n�o encontrado.","Aten��o !")
					endif
		
			Next nP

			MsgAlert("Arquivo: "+cArqLER+" processado.","Aten��o !")
			
		endIf
		
	endif

Return()

