#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"


/* 
=====================================================================================
|Programa: AT400ROT     |Autor: Fontanelli                         |Data: 13/07/2020|
=====================================================================================
|Descrição: PE para inclusão de opcoes no tela de orcamento                         |
|                                                                                   |
=====================================================================================
*/

User Function AT400ROT()
                     
Local aRet := {}

aAdd(aRet,{'PickList','U_RCRPICK2()', 0 , 2})

Return aRet
