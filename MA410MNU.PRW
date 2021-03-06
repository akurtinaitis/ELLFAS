#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"


 
/*
=====================================================================================
|Programa: MA410MNU     |Autor: Fontanelli                         |Data: 13/07/2020|
=====================================================================================
|Descri��o: PE para inclus�o de opcoes no tela de pedido de venda                   |
|                                                                                   |
=====================================================================================
*/
User Function MA410MNU()

Local nPosRot := 0
                                            
// Em 28/08/2017 desabilita op��o de copia de pedido por motivo de regras de pre�o e comiss�o
// para correto funcionamento da rotina seria necessario refazer todos os gatilhos e valida��es customizadas.
If !(RetCodUsr() $ GETMV("EL_UCOPPED",,"000000;")) // Usuarios que podem efetuar a copia do pedido de venda  
   nPosRot := ASCAN(aRotina,{|x|UPPER(x[1])="COPIA"})
   If nPosRot > 0
      aRotina[nPosRot][2] := "AVISO('Aten��o','Op��o n�o disponivel',{'OK'})"
   EndIf
EndIf

AAdd( aRotina, { "Documentos", "U_MA410Docs()", 0, 25 } )
AAdd( aRotina, { "Impressao", "U_RCRMR04()"   , 0, 25 } )
AAdd( aRotina, { "PickList", "U_RCRPICK1()"   , 0, 25 } )   
//AAdd( aRotina, { "Imp. Pr� Nota", "U_RCRMR02()", 0, 25 } 

Return aRotina

/*
=====================================================================================
|Programa: MA410Docs     |Autor: Fontanelli                        |Data: 13/07/2020|
=====================================================================================
|Descri��o:                                                                         |
|                                                                                   |
=====================================================================================
*/
User Function MA410Docs()

Local cDirDoc	:= AllTrim(GetMV("ES_DIRDOC",, "DIRDOC"))

If !EMPTY(SC5->C5_NOTA)
   SF2->(dbSetOrder(1))
   SF2->(dbSeek(xFilial("SF2")+SC5->C5_NOTA))
   
   U_RECDocum(	"SF2" , SF2->F2_FILIAL	, SF2->F2_DOC+SF2->F2_SERIE	, SF2->F2_FILIAL + SF2->F2_DOC+SF2->F2_SERIE	, 1,;
			.F.		, cDirDoc, .F. /*lRemove*/ )
Else
   Aviso("AVISO","N�o h� documento de saida gerado para o pedido !",{"OK"})
EndIf

Return Nil