#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ RFATR03  º Autor ³ Montes - Oficina1         ³  03/09/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rel.de Vendas x Producao ARL                               º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ P10-Ellfas                                                 º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function RFATR03()

Local oReport

AjustaSX1()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Interface de impressao                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport	:= ReportDef()
oReport:PrintDialog()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Paulo Augusto          ³ Data ³28/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()
Local oReport,oSection1,oSection2
Local cReport := "RFATR03"
Local cTitulo := OemToAnsi("Relatorio de Acompanhamento Pedido x Ordem de Producao.")
Local cDescri := OemToAnsi("Relatorio de Acompanhamento de Pedido x Ordem de Producao.")
Local cPerg   := PADR("FATR03",LEN(SX1->X1_GRUPO))

AjustaSX1()
Pergunte( cPerg , .F. )

oReport  := TReport():New( cReport, cTitulo, cPerg , { |oReport| ReportPrint( oReport, "QRYTMP" ) }, cDescri )
oReport:SetLandScape()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio                      ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport,"Pedidos" , {"QRYTMP"},{"Pedidos"},/*Campos do SX3*/,/*Campos do SIX*/)                      

TRCell():New( oSection1, "C6_NUM" 	 ,"QRYTMP" ,/*X3Titulo*/  ,/*Picture*/                           ,TamSx3("C6_NUM")[1]    ,/*lPixel*/,{||QRYTMP->C6_NUM})
TRCell():New( oSection1, "C5_EMISSAO","QRYTMP" ,/*X3Titulo*/  ,/*Picture*/                           ,TamSx3("C5_EMISSAO")[1],/*lPixel*/,{||QRYTMP->C5_EMISSAO})
TRCell():New( oSection1, "C6_PRODUTO","QRYTMP" ,/*X3Titulo*/  ,/*Picture*/                           ,TamSx3("C6_PRODUTO")[1],/*lPixel*/,{||QRYTMP->C6_PRODUTO})
TRCell():New( oSection1, "C6_DESCRI" ,"QRYTMP" ,/*X3Titulo*/  ,/*Picture*/                           ,TamSx3("C6_DESCRI")[1] ,/*lPixel*/,{||QRYTMP->C6_DESCRI})
TRCell():New( oSection1, "C6_QTDVEN" ,"QRYTMP" ,/*X3Titulo*/  ,PesqPict("SC6","C6_QTDVEN")/*Picture*/,TamSx3("C6_QTDVEN")[1] ,/*lPixel*/,{||QRYTMP->C6_QTDVEN})
TRCell():New( oSection1, "C6_VALOR"  ,"QRYTMP" ,/*X3Titulo*/  ,PesqPict("SC6","C6_VALOR")/*Picture*/ ,TamSx3("C6_VALOR")[1]  ,/*lPixel*/,{||QRYTMP->C6_VALOR})
TRCell():New( oSection1, "C2_NUM"    ,"QRYTMP" ,/*X3Titulo*/  ,/*Picture*/                           ,TamSx3("C2_NUM")[1]    ,/*lPixel*/,{||QRYTMP->C2_NUM})
TRCell():New( oSection1, "C2_EMISSAO","QRYTMP" ,/*X3Titulo*/  ,/*Picture*/                           ,TamSx3("C2_EMISSAO")[1],/*lPixel*/,{||QRYTMP->C2_EMISSAO})
TRCell():New( oSection1, "C2_QUANT"  ,"QRYTMP" ,/*X3Titulo*/  ,PesqPict("SC2","C2_QUANT")/*Picture*/ ,TamSx3("C2_QUANT")[1]  ,/*lPixel*/,{||QRYTMP->C2_QUANT})
TRCell():New( oSection1, "C2_QUJE"   ,"QRYTMP" ,/*X3Titulo*/  ,PesqPict("SC2","C2_QUJE")/*Picture*/  ,TamSx3("C2_QUJE")[1]   ,/*lPixel*/,{||QRYTMP->C2_QUJE})
TRCell():New( oSection1, "D3_DOC"    ,"QRYTMP" ,"Docto.Prod."/*X3Titulo*/  ,/*Picture*/              ,TamSx3("D3_DOC")[1]    ,/*lPixel*/,{||QRYTMP->D3_DOC})
TRCell():New( oSection1, "D3_EMISSAO","QRYTMP" ,"Data Prod."/*X3Titulo*/  ,/*Picture*/               ,TamSx3("D3_EMISSAO")[1],/*lPixel*/,{||QRYTMP->D3_EMISSAO})
TRCell():New( oSection1, "D3_QUANT"  ,"QRYTMP" ,/*X3Titulo*/  ,PesqPict("SD3","D3_QUANT")/*Picture*/ ,TamSx3("D3_QUANT")[1]  ,/*lPixel*/,{||QRYTMP->D3_QUANT})
TRCell():New( oSection1, "D2_DOC"    ,"QRYTMP" ,/*X3Titulo*/  ,/*Picture*/                           ,TamSx3("D2_DOC")[1]    ,/*lPixel*/,{||QRYTMP->D2_DOC})
TRCell():New( oSection1, "D2_SERIE"  ,"QRYTMP" ,/*X3Titulo*/  ,/*Picture*/                           ,TamSx3("D2_SERIE")[1]  ,/*lPixel*/,{||QRYTMP->D2_SERIE})
TRCell():New( oSection1, "D2_EMISSAO","QRYTMP" ,/*X3Titulo*/  ,/*Picture*/                           ,TamSx3("D2_EMISSAO")[1],/*lPixel*/,{||QRYTMP->D2_EMISSAO})
TRCell():New( oSection1, "D2_QUANT"  ,"QRYTMP" ,/*X3Titulo*/  ,PesqPict("SD2","D2_QUANT")/*Picture*/ ,TamSx3("D2_QUANT")[1]  ,/*lPixel*/,{||QRYTMP->D2_QUANT})
  
Return oReport

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportPrint ³ Autor ³ Montes - Oficina1  ³ Data ³ 03.09.10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relatorio de Vendas x Producao                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ ReportPrint( oReport )                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oReport - Objeto do Relatorio                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport )
Local oSection1 := oReport:Section(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Definicao dos cabecalhos                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Titulo := OemToAnsi("Relatorio de Acompanhamento Pedido x Ordem de Producao.")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa query para retornar os dados solicitados             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

cQuery := "SELECT C6_NUM,C5_EMISSAO,C6_PRODUTO,C6_DESCRI,C6_QTDVEN,C6_VALOR,C2_NUM,C2_EMISSAO,C2_QUANT,C2_QUJE,D3_DOC,D3_EMISSAO,D3_QUANT,D2_DOC,D2_SERIE,D2_EMISSAO,D2_QUANT " 
cQuery += " FROM "+RetSqlName("SC6")+" SC6"
cQuery += " INNER JOIN "+RetSqlName("SC5")+" SC5 ON C5_FILIAL = C6_FILIAL AND C5_NUM = C6_NUM AND SC5.D_E_L_E_T_ = ' '
cQuery += " INNER JOIN "+RetSqlName("SF4")+" SF4 ON F4_FILIAL = ' ' AND F4_CODIGO = C6_TES AND SF4.D_E_L_E_T_ = ' '
cQuery += " LEFT OUTER JOIN "+RetSqlName("SC2")+" SC2 ON C2_FILIAL = C6_FILIAL AND C2_PEDIDO = C6_NUM AND C2_ITEMPV = C6_ITEM AND SC2.D_E_L_E_T_ = ' '
cQuery += " LEFT OUTER JOIN "+RetSqlName("SD3")+" SD3 ON D3_FILIAL = C2_FILIAL AND D3_OP = C2_NUM+C2_ITEM+C2_SEQUEN AND SD3.D_E_L_E_T_ = ' '
cQuery += " LEFT OUTER JOIN "+RetSqlName("SD2")+" SD2 ON D2_FILIAL = C6_FILIAL AND D2_PEDIDO = C6_NUM AND D2_ITEMPV = C6_ITEM AND SD2.D_E_L_E_T_ = ' '
cQuery += " WHERE SC6.D_E_L_E_T_ = ' '"
cQuery += " AND C5_EMISSAO >= '20100825'"
cQuery += " AND C5_EMISSAO BETWEEN '"+DTOS(MV_PAR01)+"' AND '"+DTOS(MV_PAR02)+"'"
cQuery += " AND C6_PRODUTO BETWEEN '"+MV_PAR03+"' AND '"+MV_PAR04+"'"
cQuery += " AND F4_ESTOQUE = 'S'"

cQuery := ChangeQuery(cQuery)

TcQuery cQuery New Alias 'QRYTMP'                      

TCSetField("QRYTMP","C5_EMISSAO","D",8,0)
TCSetField("QRYTMP","C2_EMISSAO","D",8,0)
TCSetField("QRYTMP","D3_EMISSAO","D",8,0)
TCSetField("QRYTMP","D2_EMISSAO","D",8,0)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicia rotina de impressao                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("QRYTMP")
dbGoTop()

oSection1:SetTotalInLine(.T.)
oReport:SetTotalInLine(.F.)

oReport:SetTitle(titulo)

oReport:SetMeter(RecCount())

dbSelectArea("QRYTMP")
dbGoTop()

oSection1:Init()

While !QRYTMP->(EOF())
	oSection1:PrintLine()

   dbSelectArea("QRYTMP")
   dbSkip()
       
    //If cPedido <> cPedido
	//	oReport:ThinLine()
	//	oReport:PrintText(OemToAnsi(STR0043) + Space(01)+ Dtoc(dDataRef) + " : " +Alltrim(Transf(nTotCheque,PesqPict("SE1","E1_VALOR"))))
	//EndIf
EndDo
oSection1:Finish()

dbSelectArea("QRYTMP")
dbCloseArea()

Return .T.

/*/
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ AjustaSx1    ³ Autor ³ Montes - Oficina1   	³ Data ³ 03/09/10 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica/cria SX1 a partir de matriz para verificacao          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Siga                                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function AjustaSX1()

Local _sAlias	:= Alias()
Local aCposSX1	:= {}
Local nX 		:= 0
Local lAltera	:= .F.
Local nCondicao
Local nJ
Local cKey		:= ""
Local aPergs:={}
Local cPerg := PADR("FATR03",LEN(SX1->X1_GRUPO))

Aadd(aPergs,{"De data de emissao ?"  ,"¿De Fecha de emision ?"  ,"From Issue Date ?" ,"mv_ch1","D",08,0,0,"G","","mv_par01", "         "   ,"             ","            ","","","               ","               ","               ","","","","","","","","","","","","","","","","    ","   ","   ","S",""})
Aadd(aPergs,{"Ate data de emissao ?" ,"¿A Fecha de emision ?"   ,"To Issue Date ?"   ,"mv_ch2","D",08,0,0,"G","","mv_par02", "         "   ,"             ","            ","","","               ","               ","               ","","","","","","","","","","","","","","","","    ","   ","   ","S",""})
Aadd(aPergs,{"Produto De ?"           ,"¿De Produto ?"          ,"From Product ?"    ,"mv_ch3","C",15,0,0,"G","","mv_par03", "         "   ,"             ","            ","","","               ","               ","               ","","","","","","","","","","","","","","","","    ","SB1","   ","S",""})
Aadd(aPergs,{"Produto Ate ?"          ,"¿A Produto ?"           ,"To Product ?"      ,"mv_ch4","C",15,0,0,"G","","mv_par04", "         "   ,"             ","            ","","","               ","               ","               ","","","","","","","","","","","","","","","","    ","SB1","   ","S",""})

aCposSX1:={"X1_PERGUNT","X1_PERSPA","X1_PERENG","X1_VARIAVL","X1_TIPO","X1_TAMANHO",;
"X1_DECIMAL","X1_PRESEL","X1_GSC","X1_VALID",;
"X1_VAR01","X1_DEF01","X1_DEFSPA1","X1_DEFENG1","X1_CNT01",;
"X1_VAR02","X1_DEF02","X1_DEFSPA2","X1_DEFENG2","X1_CNT02",;
"X1_VAR03","X1_DEF03","X1_DEFSPA3","X1_DEFENG3","X1_CNT03",;
"X1_VAR04","X1_DEF04","X1_DEFSPA4","X1_DEFENG4","X1_CNT04",;
"X1_VAR05","X1_DEF05","X1_DEFSPA5","X1_DEFENG5","X1_CNT05",;
"X1_F3", "X1_GRPSXG", "X1_PYME","X1_HELP" }

dbSelectArea("SX1")
dbSetOrder(1)
For nX:=1 to Len(aPergs)
	lAltera := .F.
	If MsSeek(Padr(cPerg,Len(SX1->X1_GRUPO))+Right(aPergs[nX][11], 2))
		If Alltrim(aPergs[nX][1]) != Alltrim(SX1->X1_PERGUNT)
			lAltera := .T.
		EndIf
	EndIf
	
	If ! lAltera .And. Found() .And. X1_TIPO <> aPergs[nX][5]
		lAltera := .T.		// Garanto que o tipo da pergunta esteja correto
	EndIf
	
	If ! Found() .Or. lAltera
		RecLock("SX1",If(lAltera, .F., .T.))
		Replace X1_GRUPO with cPerg
		Replace X1_ORDEM with Right(aPergs[nX][11], 2)
		For nj:=1 to Len(aCposSX1)
			If 	Len(aPergs[nX]) >= nJ .And. aPergs[nX][nJ] <> Nil .And.;
				FieldPos(AllTrim(aCposSX1[nJ])) > 0
				Replace &(AllTrim(aCposSX1[nJ])) With aPergs[nx][nj]
			Endif
		Next nj
		MsUnlock()
		cKey := "P."+AllTrim(X1_GRUPO)+AllTrim(X1_ORDEM)+"."
		
		If ValType(aPergs[nx][Len(aPergs[nx])]) = "A"
			aHelpSpa := aPergs[nx][Len(aPergs[nx])]
		Else
			aHelpSpa := {}
		EndIf
		
		If ValType(aPergs[nx][Len(aPergs[nx])-1]) = "A"
			aHelpEng := aPergs[nx][Len(aPergs[nx])-1]
		Else
			aHelpEng := {}
		EndIf
		
		If ValType(aPergs[nx][Len(aPergs[nx])-2]) = "A"
			aHelpPor := aPergs[nx][Len(aPergs[nx])-2]
		Else
			aHelpPor := {}
		EndIf
		
		PutSX1Help(cKey,aHelpPor,aHelpEng,aHelpSpa)
	EndIf
Next

Return()