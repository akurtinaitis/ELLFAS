#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH" 

/*
=====================================================================================
|Programa: RCRPICK1    |Autor: Fontanelli                          |Data: 13/07/2020|
=====================================================================================
|Descrição: Impressão de pick list do pedido de venda                               |
|                                                                                   |
=====================================================================================
*/
User Function RCRPICK1()

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

cFilePrint	:= "PEDVENDA_"+SC5->C5_NUM+"_"+Replace(Time(),":","")+dTos(dDataBase)

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

dEmissao:= SC5->C5_EMISSAO
	
DbSelectArea("SA1")
SA1->(dbSetOrder(1))
SA1->(dbSeek(xFilial("SA1")+SC5->C5_CLIENTE+SC5->C5_LOJACLI))
cNomeCli := Alltrim(SC5->C5_CLIENTE)+"/"+Alltrim(SC5->C5_LOJACLI)+" - "+Alltrim(SA1->A1_NOME)

aItens := {}
dbSelectArea("SC6")
dbSetOrder(1)
dbSeek(xFilial("SC6")+SC5->C5_NUM)
While SC6->(!EOF()) .And. SC6->C6_FILIAL+SC6->C6_NUM == xFilial("SC6")+SC5->C5_NUM

	DbSelectArea("SB1")
	SB1->(dbSetOrder(1))
	SB1->(dbSeek(xFilial("SB1")+SC6->C6_PRODUTO))
	cEndereco := Alltrim(SB1->B1_XENDER)

	AADD(aItens,{ SC6->C6_ITEM,;
				  SC6->C6_PRODUTO,;
				  SC6->C6_DESCRI,;
				  SC6->C6_UM,;
				  SC6->C6_LOCAL,;
				  TRANSFORM(SC6->C6_QTDVEN,PESQPICT("SC6","C6_QTDVEN")),;
				  cEndereco,;
  				  "__________________________________________________"} )


	SC6->(dbSkip())
EndDo

dbSelectArea("SC5")

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

oPrint:Say(nLin,00200,OemToAnsi("PICKLIST - PEDIDO DE VENDA"),oFonte18N)

nLin += 30
oPrint:Say(nLin,0010,OemToAnsi("Cliente: "),oFonte10)
oPrint:Say(nLin,0060,OemToAnsi(cNomeCli),oFonte10N)

nLin += 20

oPrint:Say(nLin,0010,OemToAnsi("Pedido: "),oFonte10)
oPrint:Say(nLin,0060,OemToAnsi(SC5->C5_NUM),oFonte10N)

nLin += 20
oPrint:Say(nLin,0010,OemToAnsi("Emissão: "),oFonte10)
oPrint:Say(nLin,0060,OemToAnsi(DTOC(dEmissao)),oFonte10N)

nLin += 20
aColumn := { "Item", "Produto", "Descrição", "UN", "Local", "Quantidade", "Endereço", "Observação"}
aCoord  := {10,30,100,235,255,285,330,420,580}

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

