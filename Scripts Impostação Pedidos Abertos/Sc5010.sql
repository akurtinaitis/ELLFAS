--SCRIPT DE IMPORTAÇÃO SC5

USE [PROTHEUS_TST]
GO

INSERT INTO [dbo].[SC5010]
           ([C5_FILIAL]
           ,[C5_NUM]
           ,[C5_TIPO]
           ,[C5_CLIENTE]
           ,[C5_LOJACLI]
           ,[C5_CLIENT]
           ,[C5_LOJAENT]
           ,[C5_TRANSP]
           ,[C5_TIPOCLI]
           ,[C5_CONDPAG]
           ,[C5_TABELA]
           ,[C5_VEND1]
           ,[C5_COMIS1]
           ,[C5_VEND2]
           ,[C5_COMIS2]
           ,[C5_VEND3]
           ,[C5_COMIS3]
           ,[C5_VEND4]
           ,[C5_COMIS4]
           ,[C5_VEND5]
           ,[C5_COMIS5]
           ,[C5_DESC1]
           ,[C5_DESC2]
           ,[C5_DESC3]
           ,[C5_DESC4]
           ,[C5_BANCO]
           ,[C5_DESCFI]
           ,[C5_EMISSAO]
           ,[C5_COTACAO]
           ,[C5_PARC1]
           ,[C5_DATA1]
           ,[C5_PARC2]
           ,[C5_DATA2]
           ,[C5_PARC3]
           ,[C5_DATA3]
           ,[C5_PARC4]
           ,[C5_DATA4]
           ,[C5_TPFRETE]
           ,[C5_FRETE]
           ,[C5_SEGURO]
           ,[C5_DESPESA]
           ,[C5_FRETAUT]
           ,[C5_FRTCFOP]
           ,[C5_REAJUST]
           ,[C5_MOEDA]
           ,[C5_PESOL]
           ,[C5_PBRUTO]
           ,[C5_REIMP]
           ,[C5_REDESP]
           ,[C5_VOLUME1]
           ,[C5_VOLUME2]
           ,[C5_VOLUME3]
           ,[C5_VOLUME4]
           ,[C5_ESPECI1]
           ,[C5_ESPECI2]
           ,[C5_ESPECI3]
           ,[C5_ESPECI4]
           ,[C5_ACRSFIN]
           ,[C5_MENNOTA]
           ,[C5_MENPAD]
           ,[C5_INCISS]
           ,[C5_LIBEROK]
           ,[C5_OK]
           ,[C5_NOTA]
           ,[C5_SERIE]
           ,[C5_KITREP]
           ,[C5_OS]
           ,[C5_TIPLIB]
           ,[C5_DESCONT]
           ,[C5_PEDEXP]
           ,[C5_TXMOEDA]
           ,[C5_TPCARGA]
           ,[C5_DTLANC]
           ,[C5_PDESCAB]
           ,[C5_BLQ]
           ,[C5_FORNISS]
           ,[C5_CONTRA]
           ,[C5_VLR_FRT]
           ,[C5_MDCONTR]
           ,[C5_MDNUMED]
           ,[C5_GERAWMS]
           ,[C5_MDPLANI]
           ,[C5_SOLFRE]
           ,[C5_FECENT]
           ,[C5_SOLOPC]
           ,[C5_SUGENT]
           ,[C5_CODED]
           ,[C5_NUMPR]
           ,[C5_ORCRES]
           ,[C5_RECFAUT]
           ,[C5_RECISS]
           ,[C5_ESTPRES]
           ,[C5_OBRA]
           ,[C5_MUNPRES]
           ,[C5_NATUREZ]
           ,[C5_ORIGEM]
           ,[C5_NUMENT]
           ,[C5_CODEMB]
           ,[C5_TABTRF]
           ,[C5_REMCTR]
           ,[C5_REMREV]
           ,[C5_TPCOMPL]
           ,[C5_VEICULO]
           ,[C5_DESCMUN]
           ,[C5_CGCINT]
           ,[C5_CODMOT]
           ,[C5_CODSAF]
           ,[C5_CODVGLP]
           ,[C5_ARTOBRA]
           ,[C5_CLIINT]
           ,[C5_CLIRET]
           ,[C5_CMUNDE]
           ,[C5_CMUNOR]
           ,[C5_CNO]
           ,[C5_NTEMPEN]
           ,[C5_NFSUBST]
           ,[C5_MOEDTIT]
           ,[C5_MSBLQL]
           ,[C5_PLACA1]
           ,[C5_PLACA2]
           ,[C5_PREPEMB]
           ,[C5_RASTR]
           ,[C5_PEDECOM]
           ,[C5_DTTXREF]
           ,[C5_ECPRESN]
           ,[C5_ECSEDEX]
           ,[C5_ECVINCU]
           ,[C5_FILGCT]
           ,[C5_LOJARET]
           ,[C5_MODANP]
           ,[C5_IMINT]
           ,[C5_INDPRES]
           ,[C5_TXREF]
           ,[C5_UFDEST]
           ,[C5_UFORIG]
           ,[C5_TRCNUM]
           ,[C5_TIPOBRA]
           ,[C5_VOLTAPS]
           ,[C5_RET20G]
           ,[C5_SDOC]
           ,[C5_SDOCSUB]
           ,[C5_SERSUBS]
           ,[C5_SLENVT]
           ,[C5_STATUS]
           ,[R_E_C_N_O_]
           ,[C5_XPEDCOM]
           ,[C5_MENNOT1]
           ,[C5_XSERIE]
           ,[C5_PARC5]
           ,[C5_DATA5])
     SELECT C5Full.C5_FILIAL
           ,C5Full.C5_NUM 
           ,C5Full.C5_TIPO 
           ,C5Full.C5_CLIENTE 
           ,C5Full.C5_LOJACLI 
           ,C5Full.C5_CLIENT 
           ,C5Full.C5_LOJAENT 
           ,C5Full.C5_TRANSP 
           ,C5Full.C5_TIPOCLI 
           ,C5Full.C5_CONDPAG 
           ,C5Full.C5_TABELA 
           ,C5Full.C5_VEND1 
           ,C5Full.C5_COMIS1 
           ,C5Full.C5_VEND2 
           ,C5Full.C5_COMIS2 
           ,C5Full.C5_VEND3 
           ,C5Full.C5_COMIS3 
           ,C5Full.C5_VEND4 
           ,C5Full.C5_COMIS4 
           ,C5Full.C5_VEND5 
           ,C5Full.C5_COMIS5 
           ,C5Full.C5_DESC1 
           ,C5Full.C5_DESC2 
           ,C5Full.C5_DESC3 
           ,C5Full.C5_DESC4 
           ,C5Full.C5_BANCO 
           ,C5Full.C5_DESCFI 
           ,C5Full.C5_EMISSAO 
           ,C5Full.C5_COTACAO 
           ,C5Full.C5_PARC1 
           ,C5Full.C5_DATA1 
           ,C5Full.C5_PARC2 
           ,C5Full.C5_DATA2 
           ,C5Full.C5_PARC3 
           ,C5Full.C5_DATA3 
           ,C5Full.C5_PARC4 
           ,C5Full.C5_DATA4 
           ,C5Full.C5_TPFRETE 
           ,C5Full.C5_FRETE 
           ,C5Full.C5_SEGURO 
           ,C5Full.C5_DESPESA 
           ,C5Full.C5_FRETAUT 
           ,C5Full.C5_FRTCFOP 
           ,C5Full.C5_REAJUST 
           ,C5Full.C5_MOEDA 
           ,C5Full.C5_PESOL 
           ,C5Full.C5_PBRUTO 
           ,C5Full.C5_REIMP 
           ,C5Full.C5_REDESP 
           ,C5Full.C5_VOLUME1 
           ,C5Full.C5_VOLUME2 
           ,C5Full.C5_VOLUME3 
           ,C5Full.C5_VOLUME4 
           ,C5Full.C5_ESPECI1 
           ,C5Full.C5_ESPECI2 
           ,C5Full.C5_ESPECI3 
           ,C5Full.C5_ESPECI4 
           ,C5Full.C5_ACRSFIN 
           ,C5Full.C5_MENNOTA 
           ,C5Full.C5_MENPAD 
           ,C5Full.C5_INCISS 
           ,C5Full.C5_LIBEROK 
           ,C5Full.C5_OK 
           ,C5Full.C5_NOTA 
           ,C5Full.C5_SERIE 
           ,C5Full.C5_KITREP 
           ,C5Full.C5_OS 
           ,C5Full.C5_TIPLIB 
           ,C5Full.C5_DESCONT 
           ,C5Full.C5_PEDEXP 
           ,C5Full.C5_TXMOEDA 
           ,C5Full.C5_TPCARGA 
           ,C5Full.C5_DTLANC 
           ,C5Full.C5_PDESCAB 
           ,C5Full.C5_BLQ 
           ,C5Full.C5_FORNISS 
           ,C5Full.C5_CONTRA 
           ,C5Full.C5_VLR_FRT 
           ,C5Full.C5_MDCONTR 
           ,C5Full.C5_MDNUMED 
           ,C5Full.C5_GERAWMS 
           ,C5Full.C5_MDPLANI 
           ,C5Full.C5_SOLFRE 
           ,C5Full.C5_FECENT 
           ,C5Full.C5_SOLOPC 
           ,C5Full.C5_SUGENT 
           ,C5Full.C5_CODED 
           ,C5Full.C5_NUMPR 
           ,C5Full.C5_ORCRES 
           ,C5Full.C5_RECFAUT 
           ,C5Full.C5_RECISS 
           ,C5Full.C5_ESTPRES 
           ,C5Full.C5_OBRA 
           ,C5Full.C5_MUNPRES 
           ,C5Full.C5_NATUREZ 
           ,C5Full.C5_ORIGEM 
           ,C5Full.C5_NUMENT 
           ,C5Full.C5_CODEMB 
           ,C5Full.C5_TABTRF 
           ,C5Full.C5_REMCTR 
           ,C5Full.C5_REMREV 
           ,C5Full.C5_TPCOMPL 
           ,C5Full.C5_VEICULO 
           ,C5Full.C5_DESCMUN 
           ,C5Full.C5_CGCINT 
           ,C5Full.C5_CODMOT 
           ,C5Full.C5_CODSAF 
           ,C5Full.C5_CODVGLP 
           ,C5Full.C5_ARTOBRA 
           ,C5Full.C5_CLIINT 
           ,C5Full.C5_CLIRET 
           ,C5Full.C5_CMUNDE 
           ,C5Full.C5_CMUNOR 
           ,C5Full.C5_CNO 
           ,C5Full.C5_NTEMPEN 
           ,C5Full.C5_NFSUBST 
           ,C5Full.C5_MOEDTIT 
           ,C5Full.C5_MSBLQL 
           ,C5Full.C5_PLACA1 
           ,C5Full.C5_PLACA2 
           ,C5Full.C5_PREPEMB 
           ,C5Full.C5_RASTR 
           ,C5Full.C5_PEDECOM 
           ,C5Full.C5_DTTXREF 
           ,C5Full.C5_ECPRESN 
           ,C5Full.C5_ECSEDEX 
           ,C5Full.C5_ECVINCU 
           ,C5Full.C5_FILGCT 
           ,C5Full.C5_LOJARET 
           ,C5Full.C5_MODANP 
           ,C5Full.C5_IMINT 
           ,C5Full.C5_INDPRES 
           ,C5Full.C5_TXREF 
           ,C5Full.C5_UFDEST 
           ,C5Full.C5_UFORIG 
           ,C5Full.C5_TRCNUM 
           ,C5Full.C5_TIPOBRA 
           ,C5Full.C5_VOLTAPS 
           ,C5Full.C5_RET20G 
           ,C5Full.C5_SDOC 
           ,C5Full.C5_SDOCSUB 
           ,C5Full.C5_SERSUBS 
           ,C5Full.C5_SLENVT 
           ,C5Full.C5_STATUS 
           ,ROW_NUMBER() OVER (ORDER BY C5Full.R_E_C_N_O_) + (Select max(R_E_C_N_O_) from DADOSP12117.dbo.SC5010)  
           ,C5Full.C5_XPEDCOM 
           ,C5Full.C5_MENNOT1 
           ,C5Full.C5_XSERIE 
           ,C5Full.C5_PARC5 
           ,C5Full.C5_DATA5
	   FROM 
	   DADOSP12117.dbo.SC5010 C5Full
	   --LEFT JOIN DADOSP12117.dbo.SA4010 A4 ON C5_TRANSP = A4_COD  AND A4.D_E_L_E_T_ = ''    AND A4.A4_MSBLQL = '2' 
	   --LEFT JOIN DADOSP12117.dbo.SA3010 A3 ON C5_VEND1  = A3_COD  AND A3.D_E_L_E_T_ = ''    AND A3.A3_MSBLQL = '2'
	   --LEFT JOIN DADOSP12117.dbo.SA3010 A31 ON C5_VEND2 = A31.A3_COD AND A31.D_E_L_E_T_ = ''   AND A31.A3_MSBLQL = '2' 
	   WHERE 	
			C5_NOTA		= ''
		AND C5_BLQ		= ''
		AND C5Full.D_E_L_E_T_ = ''
		AND C5_CLIENTE IN ( SELECT A1_COD		FROM DADOSP12117.dbo.SA1010 SA1 WHERE SA1.A1_MSBLQL = '2' AND SA1.D_E_L_E_T_ = '')
		AND C5_CLIENT  IN ( SELECT A1_COD		FROM DADOSP12117.dbo.SA1010 SA1 WHERE SA1.A1_MSBLQL = '2' AND SA1.D_E_L_E_T_ = '')
		AND C5_EMISSAO >= '20200701'
		AND C5_NUM  IN (SELECT C6_NUM FROM DADOSP12117.dbo.SC6010 SC6 WHERE SC6.D_E_L_E_T_ = '' 
																			AND C6_PRODUTO IN ( SELECT B1_COD		FROM DADOSP12117.dbo.SB1010 SB1 WHERE SB1.B1_MSBLQL = '2' AND SB1.D_E_L_E_T_ = '')
																			AND C6_CLI	   IN ( SELECT A1_COD		FROM DADOSP12117.dbo.SA1010 SA1  WHERE SA1.A1_MSBLQL = '2' AND SA1.D_E_L_E_T_ = '')
																			AND C6_BLQ <> 'R'
																			)
		--AND C5_CONDPAG IN ( SELECT E4_CODIGO	FROM DADOSP12117.dbo.SE4010 SE4 WHERE SE4.E4_MSBLQL = '2' AND SE4.D_E_L_E_T_ = '')
		--AND C5_LIBEROK	= '' 
			
GO


--UPDATE SC5010 SET C5_XNUMANT = C5_NUM 

--UPDATE SC5010 SET C5_NUM= C5_XSEQ


--select * from SC5010 // pendente update correlatos 
--SELECT * FROM SC5020 // PENDENTE SEQUENCIA E CORRELATOS
--SELECT * FROM SC5030


--SELECT C5_CLIENT, A1_COD, A1_XCODP17 FROM SC5020 LEFT JOIN SA1020 ON ( C5_CLIENT = A1_COD) ORDER BY A1_XCODP17
--SELECT C5_TRANSP, A4_COD, A4_XCODP17 FROM SC5020 LEFT JOIN SA4010 ON ( C5_TRANSP = A4_COD) ORDER BY A4_XCODP17
--SELECT C5_CONDPAG, E4_CODIGO, E4_XCODP17 FROM SC5020 LEFT JOIN SE4010 ON ( C5_CONDPAG = E4_CODIGO) ORDER BY E4_XCODP17
--SELECT C5_VEND1, A3_COD, A3_XCODP17 FROM SC5010 LEFT JOIN SA3010 ON ( C5_VEND1 = A3_COD )							GROUP BY C5_VEND1, A3_COD, A3_XCODP17 	ORDER BY A3_XCODP17




