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
|Descrição: Importa informações de endereço no cadastro de produto                  |
|                                                                                   |
=====================================================================================
*/
user function IMPENDER()

	Local aSays 		:= {}
	Local aButtons		:= {}
	Local nOpca 		:= 0
	Local cCadastro		:= "Importação de Endereço do Produto"
	Local cFileOpen 	:= ""

	Private cTitulo := "Planilha"

	AADD(aSays, "Este Programa ira importar uma planilha padrão CSV."	)
	AADD(aSays, "" 	)
	AADD(aSays, ""	)
	AADD(aSays, ""	)
	AADD(aSays, ""	)

	//Insere os botões na tela e adiciona funções a eles.
	AADD(aButtons, { 1,.T.,{|| nOpca:= 1, FechaBatch() 			}} )
	AADD(aButtons, { 2,.T.,{|| nOpca:= 0, FechaBatch() 			}} )
	aAdd(aButtons, { 5,.T.,{|| nOpca:= 2, SelArq(@cFileOpen) }} )

	//Cria a tela com os botões.
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
|Descrição: Importa informações de endereço no cadastro de produto                  |
|                                                                                   |
=====================================================================================
*/
Static Function SelArq(cFileOpen)

	Local cTitulo  	:= "Selecione o Arquivo"
	Local cExtens   := ""

	//cExtens   += "Planilha padrão CSV | *.cst | "
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
|Descrição: Importa informações de endereço no cadastro de produto                  |
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
		MsgAlert("Arquivo: "+cArqLER+" não localizado","Atenção !")
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

			// [02] Endereço
			If At(";",cBuffer) > 0
				Cpo02 := Substr(cBuffer,1,nReg - 1)															
				Cpo02 := Cpo02
			Else
				Cpo02 := Substr(cBuffer,1)
				Cpo02 := Cpo02
			EndIf
			
			Aadd(aVetTr,{	Cpo01,; // [01] Produto
							Cpo02,; // [02] Endereço
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
						MsgAlert("Produto "+aVetTr[nP][1]+" não encontrado.","Atenção !")
					endif
		
			Next nP

			MsgAlert("Arquivo: "+cArqLER+" processado.","Atenção !")
			
		endIf
		
	endif

Return()

