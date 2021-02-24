#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

#DEFINE cCRLF CHR(13)+CHR(10)

User Function trepate()
    Local oReport
    Private cPerg := "TREPAT"

    ValidPerg(cPerg)
    oReport	:= ReportDef()
    oReport:PrintDialog()

Return

Static Function ReportDef()
    Local oReport,oSection1,oSection2
    Local cReport := "trepate"
    Local cTitulo := OemToAnsi("PERFORMANCE ASSISTÊNCIA TÉCNICA ELLFAS")
    Local cDescri := OemToAnsi("PERFORMANCE ASSISTÊNCIA TÉCNICA ELLFAS")
    local cTipo := ""
    
    Pergunte( cPerg , .F. )
    cTipo := cValToChar(MV_PAR03)
    oReport  := TReport():New( cReport, cTitulo, cPerg , { |oReport| PrintReport( oReport, oSection1 ) }, cDescri )
    oReport:SetLandScape()
   
    oSection1:=TRSection():New(oReport)

    oSection1 := TRSection():New( oReport,"Pedidos" , ,{"Pedidos Pendentes"},/*Campos do SX3*/,/*Campos do SIX*/)

    TRCell():New( oSection1, "CHAMADOS"          , ,"CHAMADOS" /*X3Titulo*/      ,/*Picture*/                           ,20                       ,/*lPixel*/,,"CENTER",)
    TRCell():New( oSection1, "DATA1"             , ,"DATA" /*X3Titulo*/          ,/*Picture*/                           ,08                       ,/*lPixel*/,,"CENTER",)
    TRCell():New( oSection1, "TEMPO1"            , ,"TEMPO" /*X3Titulo*/         ,/*Picture*/                           ,05                       ,/*lPixel*/,,"CENTER",)

    TRCell():New( oSection1, "ORÇAMENTOS"        , ,"ORCAMENTO" /*X3Titulo*/     ,/*Picture*/                           ,20                       ,/*lPixel*/,,"CENTER",)
    TRCell():New( oSection1, "DATA2"             , ,"DATA" /*X3Titulo*/          ,/*Picture*/                           ,08                       ,/*lPixel*/,,"CENTER",)
    TRCell():New( oSection1, "TEMPO2"            , ,"TEMPO" /*X3Titulo*/         ,/*Picture*/                           ,05                       ,/*lPixel*/,,"CENTER",)

    TRCell():New( oSection1, "ORDEMDESERVIÇO"    , ,"ORDEM DE SERVICO"           ,/*Picture*/                           ,20                       ,/*lPixel*/,,"CENTER",)
    TRCell():New( oSection1, "DATA3"             , ,"DATA" /*X3Titulo*/          ,/*Picture*/                           ,08                       ,/*lPixel*/,,"CENTER",)
    	
   
  	TRCell():New( oSection1, "TEMPO3"            , ,"TEMPO" /*X3Titulo*/         ,/*Picture*/                           ,08                       ,/*lPixel*/,,"CENTER",)
    TRCell():New( oSection1, "PEDIDODEVENDA"     , ,"PEDIDO DE VENDA"            ,/*Picture*/                           ,20                       ,/*lPixel*/,,"CENTER",)
    TRCell():New( oSection1, "DATA4"             , ,"DATA" /*X3Titulo*/          ,/*Picture*/                           ,08                       ,/*lPixel*/,,"CENTER",)

Return oReport

Static Function PrintReport(oReport,oSection1)
Local   cAlias  := GetNextAlias()
local cTipo := cValToChar(MV_PAR03)
local cDtini := dtos(MV_PAR01)
local cDtFim := dtos(MV_PAR02)
local nMdias1 := 0
local nMdias2 := 0
local nMdias3 := 0
local ntot := 1
local cQuery

    If cTipo = "2"
            cQuery := "SELECT AB2_NRCHAM CHAMADO "  
                cQuery += ",AB2_EMISSA DATA_CHAM "  
                cQuery += ",DATEDIFF(day,AB2_EMISSA, AB2_BXDATA ) TEMPO1 "  
                cQuery += ",AB4_NUMORC "  
                cQuery += ",AB2_BXDATA  "  
                cQuery += ",DATEDIFF(day,AB2_BXDATA, AB7_EMISSA ) TEMPO2 "  
                cQuery += ",AB7_NUMOS "  
                cQuery += ",AB7_EMISSA ORDEM_SERV "  
                cQuery += ",DATEDIFF(day, AB7_EMISSA, C5_EMISSAO ) TEMPO3 "  
                cQuery += ",C5_NUM "  
                cQuery += ",C5_EMISSAO "  
            cQuery += "FROM AB2010 AB2  "  
            cQuery += "INNER JOIN AB4010 AB4 ON AB4_FILIAL = AB2_FILIAL AND AB4_NRCHAM = AB2_NRCHAM+AB2_ITEM AND AB4_NUMORC+AB4_ITEM= AB2_NUMORC  AND AB4.D_E_L_E_T_ = '' "  
            cQuery += "INNER JOIN AB7010 AB7 ON AB7_FILIAL = AB2_FILIAL AND AB7_NUMORC = AB2_NUMORC AND AB7.D_E_L_E_T_ = '' "  
            cQuery += "INNER JOIN AB8010 AB8 ON AB8_FILIAL = AB2_FILIAL AND AB8_NUMOS	= AB7_NUMOS AND AB8_ITEM = AB7_ITEM AND AB8.D_E_L_E_T_ =  '' AND AB8_NUMPV <> '' "  
            cQuery += "INNER JOIN SC6010 SC6 ON C6_FILIAL = AB2_FILIAL AND C6_NUM+C6_ITEM = AB8_NUMPV AND SC6.D_E_L_E_T_ =  '' "  
            cQuery += "INNER JOIN SC5010 SC5 ON C5_FILIAL = C6_FILIAL AND C5_NUM = C6_NUM AND SC5.D_E_L_E_T_ =  '' "  
            cQuery += "WHERE AB2_STATUS <> 'A' "  
            cQuery += " AND AB2_EMISSA BETWEEN '"+cDtini + "'" +" AND '" +  cDtFim + "'"  
            
            cQuery += "AND AB2.D_E_L_E_T_ = '' "  
            cQuery += "GROUP BY  AB2_NRCHAM  "  
            cQuery += ",AB2_EMISSA  "  
            cQuery += ",AB2_BXDATA  "  
            cQuery += ",AB2_EMISSA  "  
            cQuery += ",AB4_NUMORC "  
            cQuery += ",AB7_NUMOS "  
            cQuery += ",C5_NUM "  
            cQuery += ",AB2_BXDATA  "  
            cQuery += ",AB7_EMISSA   "  
            cQuery += ",C5_EMISSAO   "  
            cQuery += "ORDER BY AB2_NRCHAM,AB4_NUMORC, AB7_NUMOS,C5_NUM "  

            cQuery := ChangeQuery( cQuery ) 
            MemoWrite("C:\temp\sql.txt",cQuery)
            Conout("Query WSMETHOD GETAFANT" + cQuery)

            If (Select(cAlias) <> 0)
                dbSelectArea(cAlias)
                (cAlias)->(dbCloseArea())
            EndIf
                
            DbUseArea(.T., "TOPCONN",TCGenQry(,,cQuery),cAlias,.F., .T.)


        oSection1:Init()

        While (cAlias)->(!Eof())
             oSection1:Cell("CHAMADOS"):SetValue((cAlias)->CHAMADO)    
             oSection1:Cell("DATA1"):SetValue(STOD((cAlias)->DATA_CHAM))    
             oSection1:Cell("TEMPO1"):SetValue((cAlias)->TEMPO1)  

             oSection1:Cell("ORÇAMENTOS"):SetValue((cAlias)->AB4_NUMORC)    
             oSection1:Cell("DATA2"):SetValue(STOD((cAlias)->AB2_BXDATA))    
             oSection1:Cell("TEMPO2"):SetValue((cAlias)->TEMPO2)    
            
             oSection1:Cell("ORDEMDESERVIÇO"):SetValue((cAlias)->AB7_NUMOS)    
             oSection1:Cell("DATA3"):SetValue(STOD((cAlias)->ORDEM_SERV))    
             oSection1:Cell("TEMPO3"):SetValue((cAlias)->TEMPO3)    
            
             oSection1:Cell("PEDIDODEVENDA"):SetValue((cAlias)->C5_NUM)    
             oSection1:Cell("DATA4"):SetValue(STOD((cAlias)->C5_EMISSAO))    
                
            IF VALTYPE((cAlias)->TEMPO1) = "N"
                nMdias1 := nMdias1 +  (cAlias)->TEMPO1
                nMdias2 := nMdias2 +  (cAlias)->TEMPO2
                nMdias3 := nMdias3 +  (cAlias)->TEMPO3


            Else

                nMdias1 := nMdias1 + val((cAlias)->TEMPO1)
                nMdias2 := nMdias2 + val((cAlias)->TEMPO2)
                nMdias3 := nMdias3 + val((cAlias)->TEMPO3)
            endIf
            ntot++
            (cAlias)->(DBSkip())
            oSection1:PrintLine()
        endDo

        nMdias1 := nMdias1/ntot
        nMdias2 := nMdias2/ntot
        nMdias3 := nMdias3/ntot

         oSection1:Cell("CHAMADOS"):SetValue("MEDIA EM DIAS")    
         oSection1:Cell("DATA1"):SetValue("T1")    
         oSection1:Cell("TEMPO1"):SetValue(nMdias1)  

         oSection1:Cell("ORÇAMENTOS"):SetValue("")    
         oSection1:Cell("DATA2"):SetValue("T2")    
         oSection1:Cell("TEMPO2"):SetValue(nMdias2)    
        
         oSection1:Cell("ORDEMDESERVIÇO"):SetValue("")    
         oSection1:Cell("DATA3"):SetValue("T3")    
         oSection1:Cell("TEMPO3"):SetValue(nMdias3)    
        
         oSection1:Cell("PEDIDODEVENDA"):SetValue("")    
         oSection1:Cell("DATA4"):SetValue("")    
         
         oSection1:PrintLine()
         
         
         oSection1:Init()
         oSection1:Cell("CHAMADOS"):SetValue("META ESTABELECIDA")
 
         oSection1:Cell("DATA1"):SetValue("")    
         oSection1:Cell("TEMPO1"):SetValue("1")  

         oSection1:Cell("ORÇAMENTOS"):SetValue("")    
         oSection1:Cell("DATA2"):SetValue("")    
         oSection1:Cell("TEMPO2"):SetValue("3")    
        
         oSection1:Cell("ORDEMDESERVIÇO"):SetValue("")    
         oSection1:Cell("DATA3"):SetValue("")    
         oSection1:Cell("TEMPO3"):SetValue("4")    
        
         oSection1:Cell("PEDIDODEVENDA"):SetValue("")    
         oSection1:Cell("DATA4"):SetValue("")  
          
         
         oSection1:PrintLine()
         
         
         
         oSection1:Finish()



    EndIf
    if cTipo = "1"    
        cQuery := "    SELECT	AB2_NRCHAM CHAMADO "  
        cQuery += " ,AB2_EMISSA DATACH "  
        cQuery += " ,DATEDIFF(day,AB2_EMISSA, CASE WHEN AB2_BXDATA = '' THEN GETDATE() ELSE AB2_BXDATA END  ) DATA_ORC "  
        cQuery += " ,ISNULL(AB4_NUMORC,'') NUMORC "  
        cQuery += " ,AB2_BXDATA "  
        cQuery += " ,DATEDIFF(day,CASE WHEN AB2_BXDATA = '' THEN GETDATE() ELSE AB2_BXDATA END, CASE WHEN AB7_EMISSA = '' THEN GETDATE() ELSE AB7_EMISSA END  ) DATA_OS	 "  
        cQuery += " ,ISNULL(AB7_NUMOS,'') NUMOS  "  
        cQuery += " ,AB7_EMISSA "  
        cQuery += " FROM AB2010 AB2  "  
        cQuery += " LEFT JOIN AB4010 AB4 ON AB4_FILIAL = AB2_FILIAL AND AB4_NRCHAM = AB2_NRCHAM+AB2_ITEM AND AB4_NUMORC+AB4_ITEM= AB2_NUMORC  AND AB4.D_E_L_E_T_ = '' "  
        cQuery += " LEFT JOIN AB7010 AB7 ON AB7_FILIAL = AB4_FILIAL AND AB7_NUMORC = AB4_NUMORC+AB4_ITEM AND AB7.D_E_L_E_T_ = '' "  
        cQuery += " WHERE  AB2.D_E_L_E_T_ = '' "  
        cQuery += " AND AB2_EMISSA BETWEEN '"+ cDtini +"' AND '" +cDtFim + "'"  
        cQuery += " GROUP BY AB2_NRCHAM,AB4_NUMORC, AB7_NUMOS,AB2_EMISSA ,AB2_BXDATA , AB7_EMISSA"  
        cQuery += " ORDER BY AB2_NRCHAM,AB4_NUMORC, AB7_NUMOS "  

        cQuery := ChangeQuery( cQuery ) 
            MemoWrite("C:\temp\sql.txt",cQuery)
            Conout("Query WSMETHOD GETAFANT" + cQuery)

            If (Select(cAlias) <> 0)
                dbSelectArea(cAlias)
                (cAlias)->(dbCloseArea())
            EndIf
                
            DbUseArea(.T., "TOPCONN",TCGenQry(,,cQuery),cAlias,.F., .T.)


         oSection1:Init()

        While (cAlias)->(!Eof())
            
             oSection1:Cell("CHAMADOS"):SetValue((cAlias)->CHAMADO)    
             oSection1:Cell("DATA1"):SetValue(STOD((cAlias)->DATACH))    
             oSection1:Cell("TEMPO1"):SetValue((cAlias)->DATA_ORC)  

             oSection1:Cell("ORÇAMENTOS"):SetValue((cAlias)->NUMORC)    
             oSection1:Cell("DATA2"):SetValue(STOD((cAlias)->AB2_BXDATA))    
             oSection1:Cell("TEMPO2"):SetValue((cAlias)->DATA_OS)    
            
             oSection1:Cell("ORDEMDESERVIÇO"):SetValue((cAlias)->NUMOS)    
             oSection1:Cell("DATA3"):SetValue(STOD((cAlias)->AB7_EMISSA))    
            
            
             oSection1:PrintLine()  

            
            nMdias1 := nMdias1 +  (cAlias)->DATA_ORC
            nMdias2 := nMdias2 +  (cAlias)->DATA_OS
            ntot++      
            (cAlias)->(DBSkip())
        endDo
        
        nMdias1 := nMdias1/ntot
        nMdias2 := nMdias2/ntot
        nMdias3 := nMdias3/ntot

         oSection1:Cell("CHAMADOS"):SetValue("MEDIA EM DIAS")    
         oSection1:Cell("DATA1"):SetValue("T1")    
         oSection1:Cell("TEMPO1"):SetValue(nMdias1)  

         oSection1:Cell("ORÇAMENTOS"):SetValue("")    
         oSection1:Cell("DATA2"):SetValue("T2")    
         oSection1:Cell("TEMPO2"):SetValue(nMdias2)    
        
         oSection1:Cell("ORDEMDESERVIÇO"):SetValue("")    
         oSection1:Cell("DATA3"):SetValue("")    
 
         
         oSection1:PrintLine()
         
         
         oSection1:Init()
         oSection1:Cell("CHAMADOS"):SetValue("META ESTABELECIDA")
 
         oSection1:Cell("DATA1"):SetValue("")    
         oSection1:Cell("TEMPO1"):SetValue("1")  

         oSection1:Cell("ORÇAMENTOS"):SetValue("")    
         oSection1:Cell("DATA2"):SetValue("")    
         oSection1:Cell("TEMPO2"):SetValue("3")    
        
         oSection1:Cell("ORDEMDESERVIÇO"):SetValue("")    
         oSection1:Cell("DATA3"):SetValue("")    

         oSection1:PrintLine()
         
         
         
         oSection1:Finish()

        oSection1:Finish()

        oSection1:Finish()
    endIf
return


Static Function ValidPerg(cPerg)
	Local aArea := GetArea()

	xPUTSX1(cPerg   ,"01","Data Inicial ?"          ,''           ,''             ,"MV_CH1"     ,"D",8                      ,0,0,"G","" ,""     ,"","","MV_PAR01","","","","","","","","","","","","","","","","")
	xPUTSX1(cPerg   ,"02","Data Final ? "           ,''           ,''             ,"MV_CH2"     ,"D",8                      ,0,0,"G","" ,""     ,"","","MV_PAR02","","","","","","","","","","","","","","","","")
    xPUTSX1(cPerg	,"03","Parcial ou total?"       ,''           ,''             ,"MV_CH3"	    ,"C",8                   	,0, ,"C",""	,""     ,"","","MV_PAR03","PARCIAL","","","","TOTAL","","","","","","","","","","","")

	RestArea( aArea )

Return


Static Function xPutSx1(cGrupo,cOrdem,cPergunt,cPerSpa,cPerEng,cVar,;
	cTipo ,nTamanho,nDecimal,nPresel,cGSC,cValid,;
	cF3, cGrpSxg,cPyme,;
	cVar01,cDef01,cDefSpa1,cDefEng1,cCnt01,;
	cDef02,cDefSpa2,cDefEng2,;
	cDef03,cDefSpa3,cDefEng3,;
	cDef04,cDefSpa4,cDefEng4,;
	cDef05,cDefSpa5,cDefEng5,;
	aHelpPor,aHelpEng,aHelpSpa,cHelp)
	***********************
	Local aArea := GetArea()
	Local cKey
	Local lPort := .f.
	Local lSpa := .f.
	Local lIngl := .f.

	cKey := "P." + AllTrim( cGrupo ) + AllTrim( cOrdem ) + "."

	cPyme    := Iif( cPyme       == Nil, " ", cPyme       )
	cF3      := Iif( cF3         == NIl, " ", cF3         )
	cGrpSxg  := Iif( cGrpSxg     == Nil, " ", cGrpSxg     )
	cCnt01   := Iif( cCnt01      == Nil, "" , cCnt01      )
	cHelp    := Iif( cHelp       == Nil, "" , cHelp       )

	dbSelectArea( "SX1" )
	dbSetOrder( 1 )

	cGrupo := PadR( cGrupo , Len( SX1->X1_GRUPO ) , " " )

	If !( DbSeek( cGrupo + cOrdem ))

		cPergunt:= If(! "?" $ cPergunt .And. ! Empty(cPergunt),Alltrim(cPergunt)+" ?",cPergunt)
		cPerSpa     := If(! "?" $ cPerSpa .And. ! Empty(cPerSpa) ,Alltrim(cPerSpa) +" ?",cPerSpa)
		cPerEng     := If(! "?" $ cPerEng .And. ! Empty(cPerEng) ,Alltrim(cPerEng) +" ?",cPerEng)

		Reclock( "SX1" , .T. )

		Replace X1_GRUPO   With cGrupo
		Replace X1_ORDEM   With cOrdem
		Replace X1_PERGUNT With cPergunt
		Replace X1_PERSPA  With cPerSpa
		Replace X1_PERENG  With cPerEng
		Replace X1_VARIAVL With cVar
		Replace X1_TIPO    With cTipo
		Replace X1_TAMANHO With nTamanho
		Replace X1_DECIMAL With nDecimal
		Replace X1_PRESEL  With nPresel
		Replace X1_GSC     With cGSC
		Replace X1_VALID   With cValid

		Replace X1_VAR01   With cVar01

		Replace X1_F3      With cF3
		Replace X1_GRPSXG  With cGrpSxg

		If Fieldpos("X1_PYME") > 0
			If cPyme != Nil
				Replace X1_PYME With cPyme
			Endif
		Endif

		Replace X1_CNT01   With cCnt01
		If cGSC == "C"               // Mult Escolha
			Replace X1_DEF01   With cDef01
			Replace X1_DEFSPA1 With cDefSpa1
			Replace X1_DEFENG1 With cDefEng1

			Replace X1_DEF02   With cDef02
			Replace X1_DEFSPA2 With cDefSpa2
			Replace X1_DEFENG2 With cDefEng2

			Replace X1_DEF03   With cDef03
			Replace X1_DEFSPA3 With cDefSpa3
			Replace X1_DEFENG3 With cDefEng3

			Replace X1_DEF04   With cDef04
			Replace X1_DEFSPA4 With cDefSpa4
			Replace X1_DEFENG4 With cDefEng4

			Replace X1_DEF05   With cDef05
			Replace X1_DEFSPA5 With cDefSpa5
			Replace X1_DEFENG5 With cDefEng5
		Endif

		Replace X1_HELP With cHelp

		//     PutSX1Help(cKey,aHelpPor,aHelpEng,aHelpSpa)

		MsUnlock()
	Else

		lPort := ! "?" $ X1_PERGUNT .And. ! Empty(SX1->X1_PERGUNT)
		lSpa  := ! "?" $ X1_PERSPA  .And. ! Empty(SX1->X1_PERSPA)
		lIngl := ! "?" $ X1_PERENG  .And. ! Empty(SX1->X1_PERENG)

		If lPort .Or. lSpa .Or. lIngl
			RecLock("SX1",.F.)
			If lPort
				SX1->X1_PERGUNT:= Alltrim(SX1->X1_PERGUNT)+" ?"
			EndIf
			If lSpa
				SX1->X1_PERSPA := Alltrim(SX1->X1_PERSPA) +" ?"
			EndIf
			If lIngl
				SX1->X1_PERENG := Alltrim(SX1->X1_PERENG) +" ?"
			EndIf
			SX1->(MsUnLock())
		EndIf
	Endif

	RestArea( aArea )

Return