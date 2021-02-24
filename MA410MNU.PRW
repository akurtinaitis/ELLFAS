#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"


 
/*
=====================================================================================
|Programa: MA410MNU     |Autor: Fontanelli                         |Data: 13/07/2020|
=====================================================================================
|Descrição: PE para inclusão de opcoes no tela de pedido de venda                   |
|                                                                                   |
=====================================================================================
*/
User Function MA410MNU()

Local nPosRot := 0
                                            
// Em 28/08/2017 desabilita opção de copia de pedido por motivo de regras de preço e comissão
// para correto funcionamento da rotina seria necessario refazer todos os gatilhos e validações customizadas.
If !(RetCodUsr() $ GETMV("EL_UCOPPED",,"000000;")) // Usuarios que podem efetuar a copia do pedido de venda  
   nPosRot := ASCAN(aRotina,{|x|UPPER(x[1])="COPIA"})
   If nPosRot > 0
      aRotina[nPosRot][2] := "AVISO('Atenção','Opção não disponivel',{'OK'})"
   EndIf
EndIf

AAdd( aRotina, { "Documentos", "U_MA410Docs()", 0, 25 } )
AAdd( aRotina, { "Impressao", "U_RCRMR04()"   , 0, 25 } )
AAdd( aRotina, { "PickList", "U_RCRPICK1()"   , 0, 25 } )   
//AAdd( aRotina, { "Imp. Pré Nota", "U_RCRMR02()", 0, 25 } 

Return aRotina

/*
=====================================================================================
|Programa: MA410Docs     |Autor: Fontanelli                        |Data: 13/07/2020|
=====================================================================================
|Descrição:                                                                         |
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
   Aviso("AVISO","Não há documento de saida gerado para o pedido !",{"OK"})
EndIf

Return Nil