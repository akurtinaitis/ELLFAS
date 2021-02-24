#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
 
/*
=====================================================================================
|Programa: RCRPICK2    |Autor: Fontanelli                          |Data: 13/07/2020|
=====================================================================================
|Descrição: Impressão de pick list do orçamento                                     |
|                                                                                   |
=====================================================================================
*/
User Function RCRPICK2()

Local aArea	     := GetArea()
Local cFilePrint := ""
Local cPerg	     := ""

Private nLin	 := 0
Private nCol
Private oPrint	   := Nil
Private cLocalTemp := GetTempPath()
Private cDir	   :=  "\SPOOL\"
Private cDirLocal  := cLocalTemp
Private aImp	   := {}

cFilePrint	:= "ORCAMENTO_"+AB3->AB3_NUMORC+"_"+Replace(Time(),":","")+dTos(dDataBase)

oPrint	:=	FwMSPrinter():New(cFilePrint,6,.F.,cDir,.T.,,,,,,,.T.)
oPrint:SetPortrait()  // Formato do Papel - Retrato = SetPortrait() || Paisagem = SetLandscape()
oPrint:cPathPDF := cDirLocal
oPrint:StartPage()

fImprime()

// Mostra tela de visualização de impressão
oPrint:Preview()  //oPrint:Print()

//FClose(oPrint:nHandle)
FreeObj(oPrint)

//CpyS2T(cDir+cFilePrint+".pdf", cDirLocal)

RestArea(aArea)

Return( Nil )

/*
=====================================================================================
|Programa: fImprime    |Autor: Fontanelli                          |Data: 13/07/2020|
=====================================================================================
|Descrição: Impressão de pick list do pedido de venda                               |
|                                                                                   |
=====================================================================================
*/
Static Function fImprime()

Local aArea	        := GetArea()

Local oFonte04		:= tFont():New("ARIAL",04,04,,.F.,,,,.T.,.F.)
Local oFonte05		:= tFont():New("ARIAL",05,04,,.F.,,,,.T.,.F.)
Local oFonte06		:= tFont():New("ARIAL",06,06,,.F.,,,,.T.,.F.)
Local oFonte06N		:= tFont():New("ARIAL",06,06,,.T.,,,,.T.,.F.)
Local oFonte08		:= tFont():New("ARIAL",08,08,,.F.,,,,.T.,.F.)
Local oFonte08N		:= tFont():New("ARIAL",08,08,,.T.,,,,.T.,.F.)
Local oFonte07N		:= tFont():New("ARIAL",07,07,,.T.,,,,.T.,.F.)
Local oFonte07		:= tFont():New("ARIAL",07,07,,.F.,,,,.T.,.F.)
Local oFonte09N		:= tFont():New("ARIAL",09,09,,.T.,,,,.T.,.F.)
Local oFonte09		:= tFont():New("ARIAL",09,09,,.F.,,,,.T.,.F.)
Local oFonte10		:= tFont():New("ARIAL",10,10,,.F.,,,,.T.,.F.)
Local oFonte10N		:= tFont():New("ARIAL",10,10,,.T.,,,,.T.,.F.)
Local oFonte11		:= tFont():New("ARIAL",11,11,,.F.,,,,.T.,.F.)
Local oFonte11N		:= tFont():New("ARIAL",11,11,,.T.,,,,.T.,.F.)
Local oFonte12		:= tFont():New("ARIAL",12,12,,.F.,,,,.T.,.F.)
Local oFonte12N		:= tFont():New("ARIAL",12,12,,.T.,,,,.T.,.F.)
Local oFonte14		:= tFont():New("ARIAL",14,14,,.F.,,,,.T.,.F.)
Local oFonte14N		:= tFont():New("ARIAL",14,14,,.T.,,,,.T.,.F.)
Local oFonte15N		:= tFont():New("ARIAL",15,15,,.T.,,,,.T.,.F.)
Local oFonte16		:= tFont():New("ARIAL",16,16,,.F.,,,,.T.,.F.)
Local oFonte16N		:= tFont():New("ARIAL",16,16,,.T.,,,,.T.,.F.)
Local oFonte18		:= tFont():New("ARIAL",18,18,,.F.,,,,.T.,.F.)
Local oFonte18N		:= tFont():New("ARIAL",18,18,,.T.,,,,.T.,.F.)
Local oFonte20		:= tFont():New("ARIAL",20,20,,.F.,,,,.T.,.F.)
Local oFonte20N		:= tFont():New("ARIAL",20,20,,.T.,,,,.T.,.F.)
Local oFonte22		:= tFont():New("ARIAL",22,22,,.F.,,,,.T.,.F.)
Local oFonte22N		:= tFont():New("ARIAL",22,22,,.T.,,,,.T.,.F.)
Local oFonte24		:= tFont():New("ARIAL",24,24,,.F.,,,,.T.,.F.)
Local oFonte24N		:= tFont():New("ARIAL",24,24,,.T.,,,,.T.,.F.)
Local cLogo			:= ""

dEmissao:= AB3->AB3_EMISSA
	
DbSelectArea("SA1")
SA1->(dbSetOrder(1))
SA1->(dbSeek(xFilial("SA1")+AB3->AB3_CODCLI+AB3->AB3_LOJA))
cNomeCli := Alltrim(AB3->AB3_CODCLI)+"/"+Alltrim(AB3->AB3_LOJA)+" - "+Alltrim(SA1->A1_NOME)

aItens := {}
dbSelectArea("AB4")
dbSetOrder(1)
dbSeek(xFilial("AB4")+AB3->AB3_NUMORC)
While AB4->(!EOF()) .And. AB4->AB4_FILIAL+AB4->AB4_NUMORC == xFilial("AB3")+AB3->AB3_NUMORC

	DbSelectArea("SB1")
	SB1->(dbSetOrder(1))
	SB1->(dbSeek(xFilial("SB1")+AB4->AB4_CODPRO))
	cEndereco := Alltrim(SB1->B1_XENDER)

	AADD(aItens,{ AB4->AB4_ITEM,;
				  AB4->AB4_CODPRO,;
				  SB1->B1_DESC,;
				  SB1->B1_UM,;
				  SB1->B1_LOCPAD,;
				  TRANSFORM(1,PESQPICT("SC6","C6_QTDVEN")),;
				  cEndereco,;
				  AB4->AB4_NUMSER,;
  				  "_____________________________________"} )


	AB4->(dbSkip())
EndDo

dbSelectArea("AB3")

nLin := 10
If cEmpAnt = '01'
	If File("\system\logo_proposta_ellfas.png")
		cLogo := "\system\logo_proposta_ellfas.png"
	EndIf
ElseIf cEmpAnt = '02'
	If File("\system\logo_proposta_arl.png")
		cLogo := "\system\logo_proposta_arl.png"
	EndIf
ElseIf cEmpAnt = '03'
	If File("\system\logo_proposta_marlin.png")
		cLogo := "\system\logo_proposta_marlin.png"
	EndIf
EndIf

oPrint:SayBitmap( nLin, 010, cLogo , 200, 60 )  //343,273

nLin += 80

oPrint:Say(nLin,00215,OemToAnsi("PICKLIST - ORÇAMENTO"),oFonte18N)

nLin += 30
oPrint:Say(nLin,0010,OemToAnsi("Cliente: "),oFonte10)
oPrint:Say(nLin,0060,OemToAnsi(cNomeCli),oFonte10N)

nLin += 20

oPrint:Say(nLin,0010,OemToAnsi("Orçamento: "),oFonte10)
oPrint:Say(nLin,0060,OemToAnsi(AB3->AB3_NUMORC),oFonte10N)

nLin += 20
oPrint:Say(nLin,0010,OemToAnsi("Emissão: "),oFonte10)
oPrint:Say(nLin,0060,OemToAnsi(DTOC(dEmissao)),oFonte10N)

nLin += 20
aColumn := { "Item", "Produto", "Descrição", "UN", "Local", "Quantidade", "Endereço", "Série", "Observação"}
aCoord  := {10,30,100,235,255,285,330,420,460,580}

For nCol := 1 To Len(aCoord)-1
	oPrint:Box(nLin,aCoord[nCol],nLin+15,aCoord[nCol+1])
	oPrint:Say(nLin+10,aCoord[nCol]+5,OemToAnsi(aColumn[nCol]),oFonte06)
Next

nLin += 15

For nItem := 1 To Len(aItens)
	
	nLin += 15
	For nCol := 1 To Len(aCoord)-1
		oPrint:Say(nLin,aCoord[nCol]+5,OemToAnsi(aItens[nItem,nCol]),oFonte06N)
	Next
	
	If nLin > 750
		//Inicia a próxima página
		oPrint:EndPage()
		
		oPrint:StartPage()
		nLin	:= 10
	EndIf
	
Next

nLin := 750
oPrint:Box(nLin,010,nLin+15,580)
oPrint:Box(nLin+15,010,nLin+70,580)

nLin += 10

oPrint:Say(nLin,0015,OemToAnsi ("Informação Complementar: "),oFonte11)

nLin += 26
oPrint:Say(nLin,0015,OemToAnsi   ("Data Conferência: "),oFonte10N)  
oPrint:Say(nLin,0115-20,OemToAnsi   ("_______/_______/_______"),oFonte11) 
oPrint:Say(nLin,0300,OemToAnsi   ("Data Separação: "),oFonte10N)  
oPrint:Say(nLin,0400-20,OemToAnsi   ("_______/_______/_______"),oFonte11)

nLin += 26
oPrint:Say(nLin,0015,OemToAnsi   ("Separador: "),oFonte10N)
oPrint:Say(nLin,0115-20,OemToAnsi   ("___________________________________"),oFonte11)
oPrint:Say(nLin,0300,OemToAnsi   ("Assinatura: "),oFonte10N)
oPrint:Say(nLin,0400-20,OemToAnsi   ("___________________________________"),oFonte11)

// Termina a página
oPrint:EndPage()

Return

