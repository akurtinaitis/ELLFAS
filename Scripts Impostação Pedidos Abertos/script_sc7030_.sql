-- IMPORTAÇÃO PARCIAIS DE COMPRAS
USE [PROTHEUS_TST]
GO

INSERT INTO [dbo].[SC7030]
           ([C7_FILIAL]
           ,[C7_TIPO]
           ,[C7_ITEM]
           ,[C7_PRODUTO]
           ,[C7_UM]
           ,[C7_SEGUM]
           ,[C7_QUANT]
           ,[C7_CODTAB]
           ,[C7_PRECO]
           ,[C7_TOTAL]
           ,[C7_QTSEGUM]
           ,[C7_IPI]
           ,[C7_ITEMSC]
           ,[C7_NUMSC]
           ,[C7_DINICOM]
           ,[C7_DINICQ]
           ,[C7_DINITRA]
           ,[C7_DATPRF]
           ,[C7_LOCAL]
           ,[C7_OBS]
           ,[C7_OBSM]
           ,[C7_FORNECE]
           ,[C7_CC]
           ,[C7_CONTA]
           ,[C7_ITEMCTA]
           ,[C7_LOJA]
           ,[C7_COND]
           ,[C7_CONTATO]
           ,[C7_FILENT]
           ,[C7_DESC1]
           ,[C7_DESC2]
           ,[C7_DESC3]
           ,[C7_EMISSAO]
           ,[C7_NUM]
           ,[C7_QUJE]
           ,[C7_REAJUST]
           ,[C7_FRETE]
           ,[C7_EMITIDO]
           ,[C7_DESCRI]
           ,[C7_TPFRETE]
           ,[C7_QTDREEM]
           ,[C7_CODLIB]
           ,[C7_RESIDUO]
           ,[C7_NUMCOT]
           ,[C7_MSG]
           ,[C7_TX]
           ,[C7_CONTROL]
           ,[C7_IPIBRUT]
           ,[C7_ENCER]
           ,[C7_OP]
           ,[C7_VLDESC]
           ,[C7_SEQUEN]
           ,[C7_NUMIMP]
           ,[C7_ORIGEM]
           ,[C7_QTDACLA]
           ,[C7_VALEMB]
           ,[C7_FLUXO]
           ,[C7_TPOP]
           ,[C7_APROV]
           ,[C7_CONAPRO]
           ,[C7_GRUPCOM]
           ,[C7_USER]
           ,[C7_STATME]
           ,[C7_RESREM]
           ,[C7_OK]
           ,[C7_QTDSOL]
           ,[C7_VALIPI]
           ,[C7_VALICM]
           ,[C7_TES]
           ,[C7_DESC]
           ,[C7_PICM]
           ,[C7_BASEICM]
           ,[C7_BASEIPI]
           ,[C7_SEGURO]
           ,[C7_DESPESA]
           ,[C7_VALFRE]
           ,[C7_MOEDA]
           ,[C7_TXMOEDA]
           ,[C7_PENDEN]
           ,[C7_CLVL]
           ,[C7_BASEIR]
           ,[C7_ALIQIR]
           ,[C7_VALIR]
           ,[C7_ICMCOMP]
           ,[C7_ICMSRET]
           ,[C7_BASIMP5]
           ,[C7_BASIMP6]
           ,[C7_ESTOQUE]
           ,[C7_VALSOL]
           ,[C7_SOLICIT]
           ,[C7_VALIMP5]
           ,[C7_VALIMP6]
           ,[C7_SEQMRP]
           ,[C7_CODORCA]
           ,[C7_DTLANC]
           ,[C7_CODCRED]
           ,[C7_TIPOEMP]
           ,[C7_ESPEMP]
           ,[C7_CONTRA]
           ,[C7_CONTREV]
           ,[C7_PLANILH]
           ,[C7_MEDICAO]
           ,[C7_ITEMED]
           ,[C7_FREPPCC]
           ,[C7_POLREPR]
           ,[C7_PERREPR]
           ,[C7_DT_IMP]
           ,[C7_GRADE]
           ,[C7_AGENTE]
           ,[C7_ITEMGRD]
           ,[C7_FORWARD]
           ,[C7_TIPO_EM]
           ,[C7_ORIGIMP]
           ,[C7_DEST]
           ,[C7_COMPRA]
           ,[C7_PESO_B]
           ,[C7_INCOTER]
           ,[C7_IMPORT]
           ,[C7_CONSIG]
           ,[C7_CONF_PE]
           ,[C7_DESP]
           ,[C7_EXPORTA]
           ,[C7_LOJAEXP]
           ,[C7_CONTAIN]
           ,[C7_MT3]
           ,[C7_CONTA20]
           ,[C7_CONTA40]
           ,[C7_CON40HC]
           ,[C7_ARMAZEM]
           ,[C7_FABRICA]
           ,[C7_LOJFABR]
           ,[C7_DT_EMB]
           ,[C7_TEC]
           ,[C7_EX_NCM]
           ,[C7_EX_NBM]
           ,[C7_BASESOL]
           ,[C7_DIACTB]
           ,[C7_NODIA]
           ,[C7_PO_EIC]
           ,[C7_CODED]
           ,[C7_NUMPR]
           ,[C7_FILEDT]
           ,[C7_FATDIRE]
           ,[C7_FILCEN]
           ,[C7_DEDUCAO]
           ,[C7_ITEMNE]
           ,[C7_IDTSS]
           ,[C7_GCPIT]
           ,[C7_GCPLT]
           ,[C7_NUMSA]
           ,[C7_RETENCA]
           ,[C7_REVISAO]
           ,[C7_QUJEDED]
           ,[C7_QUJEFAT]
           ,[C7_QUJERET]
           ,[C7_RATEIO]
           ,[C7_TIPCOM]
           ,[C7_VALINS]
           ,[C7_VALISS]
           ,[C7_TPCOLAB]
           ,[C7_BASECSL]
           ,[C7_ALIQISS]
           ,[C7_ALQCSL]
           ,[C7_CODNE]
           ,[C7_ALIQINS]
           ,[C7_ACCITEM]
           ,[C7_ACCNUM]
           ,[C7_ACCPROC]
           ,[C7_CODRDA]
           ,[C7_BASEISS]
           ,[C7_BASEINS]
           ,[C7_VALCSL]
           ,[C7_OBRIGA]
           ,[C7_PLOPELT]
           ,[C7_FISCORI]
           ,[C7_LOTPLS]
           ,[C7_DIREITO]
           ,[D_E_L_E_T_]
           ,[R_E_C_N_O_]
           ,[R_E_C_D_E_L_])
    SELECT
			C7FULL.C7_FILIAL 
           ,C7FULL.C7_TIPO 
           ,C7FULL.C7_ITEM 
           ,C7FULL.C7_PRODUTO 
           ,C7FULL.C7_UM 
           ,C7FULL.C7_SEGUM 
           ,C7FULL.C7_QUANT 
           ,C7FULL.C7_CODTAB 
           ,C7FULL.C7_PRECO 
           ,C7FULL.C7_TOTAL 
           ,C7FULL.C7_QTSEGUM 
           ,C7FULL.C7_IPI 
           ,C7FULL.C7_ITEMSC 
           ,C7FULL.C7_NUMSC 
           ,C7FULL.C7_DINICOM 
           ,C7FULL.C7_DINICQ 
           ,C7FULL.C7_DINITRA 
           ,C7FULL.C7_DATPRF 
           ,C7FULL.C7_LOCAL 
           ,C7FULL.C7_OBS 
           ,C7FULL.C7_OBSM 
           ,C7FULL.C7_FORNECE 
           ,C7FULL.C7_CC 
           ,C7FULL.C7_CONTA 
           ,C7FULL.C7_ITEMCTA 
           ,C7FULL.C7_LOJA 
           ,C7FULL.C7_COND 
           ,C7FULL.C7_CONTATO 
           ,C7FULL.C7_FILENT 
           ,C7FULL.C7_DESC1 
           ,C7FULL.C7_DESC2 
           ,C7FULL.C7_DESC3 
           ,C7FULL.C7_EMISSAO 
           ,C7FULL.C7_NUM 
           ,C7FULL.C7_QUJE 
           ,C7FULL.C7_REAJUST 
           ,C7FULL.C7_FRETE 
           ,C7FULL.C7_EMITIDO 
           ,C7FULL.C7_DESCRI 
           ,C7FULL.C7_TPFRETE 
           ,C7FULL.C7_QTDREEM 
           ,C7FULL.C7_CODLIB 
           ,C7FULL.C7_RESIDUO 
           ,C7FULL.C7_NUMCOT 
           ,C7FULL.C7_MSG 
           ,C7FULL.C7_TX 
           ,C7FULL.C7_CONTROL 
           ,C7FULL.C7_IPIBRUT 
           ,C7FULL.C7_ENCER 
           ,C7FULL.C7_OP 
           ,C7FULL.C7_VLDESC 
           ,C7FULL.C7_SEQUEN 
           ,C7FULL.C7_NUMIMP 
           ,C7FULL.C7_ORIGEM 
           ,C7FULL.C7_QTDACLA 
           ,C7FULL.C7_VALEMB 
           ,C7FULL.C7_FLUXO 
           ,C7FULL.C7_TPOP 
           ,C7FULL.C7_APROV 
           ,C7FULL.C7_CONAPRO 
           ,C7FULL.C7_GRUPCOM 
           ,C7FULL.C7_USER 
           ,C7FULL.C7_STATME 
           ,C7FULL.C7_RESREM 
           ,C7FULL.C7_OK 
           ,C7FULL.C7_QTDSOL 
           ,C7FULL.C7_VALIPI 
           ,C7FULL.C7_VALICM 
           ,C7FULL.C7_TES 
           ,C7FULL.C7_DESC 
           ,C7FULL.C7_PICM 
           ,C7FULL.C7_BASEICM 
           ,C7FULL.C7_BASEIPI 
           ,C7FULL.C7_SEGURO 
           ,C7FULL.C7_DESPESA 
           ,C7FULL.C7_VALFRE 
           ,C7FULL.C7_MOEDA 
           ,C7FULL.C7_TXMOEDA 
           ,C7FULL.C7_PENDEN 
           ,C7FULL.C7_CLVL 
           ,C7FULL.C7_BASEIR 
           ,C7FULL.C7_ALIQIR 
           ,C7FULL.C7_VALIR 
           ,C7FULL.C7_ICMCOMP 
           ,C7FULL.C7_ICMSRET 
           ,C7FULL.C7_BASIMP5 
           ,C7FULL.C7_BASIMP6 
           ,C7FULL.C7_ESTOQUE 
           ,C7FULL.C7_VALSOL 
           ,C7FULL.C7_SOLICIT 
           ,C7FULL.C7_VALIMP5 
           ,C7FULL.C7_VALIMP6 
           ,C7FULL.C7_SEQMRP 
           ,C7FULL.C7_CODORCA 
           ,C7FULL.C7_DTLANC 
           ,C7FULL.C7_CODCRED 
           ,C7FULL.C7_TIPOEMP 
           ,C7FULL.C7_ESPEMP 
           ,C7FULL.C7_CONTRA 
           ,C7FULL.C7_CONTREV 
           ,C7FULL.C7_PLANILH 
           ,C7FULL.C7_MEDICAO 
           ,C7FULL.C7_ITEMED 
           ,C7FULL.C7_FREPPCC 
           ,C7FULL.C7_POLREPR 
           ,C7FULL.C7_PERREPR 
           ,C7FULL.C7_DT_IMP 
           ,C7FULL.C7_GRADE 
           ,C7FULL.C7_AGENTE 
           ,C7FULL.C7_ITEMGRD 
           ,C7FULL.C7_FORWARD 
           ,C7FULL.C7_TIPO_EM 
           ,C7FULL.C7_ORIGIMP 
           ,C7FULL.C7_DEST 
           ,C7FULL.C7_COMPRA 
           ,C7FULL.C7_PESO_B 
           ,C7FULL.C7_INCOTER 
           ,C7FULL.C7_IMPORT 
           ,C7FULL.C7_CONSIG 
           ,C7FULL.C7_CONF_PE 
           ,C7FULL.C7_DESP 
           ,C7FULL.C7_EXPORTA 
           ,C7FULL.C7_LOJAEXP 
           ,C7FULL.C7_CONTAIN 
           ,C7FULL.C7_MT3 
           ,C7FULL.C7_CONTA20 
           ,C7FULL.C7_CONTA40 
           ,C7FULL.C7_CON40HC 
           ,C7FULL.C7_ARMAZEM 
           ,C7FULL.C7_FABRICA 
           ,C7FULL.C7_LOJFABR 
           ,C7FULL.C7_DT_EMB 
           ,C7FULL.C7_TEC 
           ,C7FULL.C7_EX_NCM 
           ,C7FULL.C7_EX_NBM 
           ,C7FULL.C7_BASESOL 
           ,C7FULL.C7_DIACTB 
           ,C7FULL.C7_NODIA 
           ,C7FULL.C7_PO_EIC 
           ,C7FULL.C7_CODED 
           ,C7FULL.C7_NUMPR 
           ,C7FULL.C7_FILEDT 
           ,C7FULL.C7_FATDIRE 
           ,C7FULL.C7_FILCEN 
           ,C7FULL.C7_DEDUCAO 
           ,C7FULL.C7_ITEMNE 
           ,C7FULL.C7_IDTSS 
           ,C7FULL.C7_GCPIT 
           ,C7FULL.C7_GCPLT 
           ,C7FULL.C7_NUMSA 
           ,C7FULL.C7_RETENCA 
           ,C7FULL.C7_REVISAO 
           ,C7FULL.C7_QUJEDED 
           ,C7FULL.C7_QUJEFAT 
           ,C7FULL.C7_QUJERET 
           ,C7FULL.C7_RATEIO 
           ,C7FULL.C7_TIPCOM 
           ,C7FULL.C7_VALINS 
           ,C7FULL.C7_VALISS 
           ,C7FULL.C7_TPCOLAB 
           ,C7FULL.C7_BASECSL 
           ,C7FULL.C7_ALIQISS 
           ,C7FULL.C7_ALQCSL 
           ,C7FULL.C7_CODNE 
           ,C7FULL.C7_ALIQINS 
           ,C7FULL.C7_ACCITEM 
           ,C7FULL.C7_ACCNUM 
           ,C7FULL.C7_ACCPROC 
           ,C7FULL.C7_CODRDA 
           ,C7FULL.C7_BASEISS 
           ,C7FULL.C7_BASEINS 
           ,C7FULL.C7_VALCSL 
           ,C7FULL.C7_OBRIGA 
           ,C7FULL.C7_PLOPELT 
           ,C7FULL.C7_FISCORI 
           ,C7FULL.C7_LOTPLS 
           ,C7FULL.C7_DIREITO 
           ,C7FULL.D_E_L_E_T_ 
           ,ROW_NUMBER() OVER (ORDER BY C7FULL.R_E_C_N_O_) + (Select max(R_E_C_N_O_) from DADOSP12117.dbo.SC7010) 
           ,C7FULL.R_E_C_D_E_L_ 
            
    
    FROM DADOSP12117.dbo.SC7030 C7FULL
	WHERE 
		C7FULL.C7_QUJE		= '0' 
	And C7FULL.C7_QTDACLA	= '0'
	And C7FULL.C7_RESIDUO	= ''
	AND C7FULL.C7_CONTRA	= ''
	AND C7FULL.C7_CONAPRO	<>'B'
	AND C7FULL.D_E_L_E_T_	= ''
	AND C7FULL.C7_PRODUTO IN ( SELECT B1_COD FROM DADOSP12117.dbo.SB1010 B1 WHERE B1.D_E_L_E_T_ = ''    AND B1.B1_MSBLQL <> '1' )
	AND C7FULL. C7_FORNECE IN ( SELECT A2_COD FROM DADOSP12117.dbo.SA2010 A2 WHERE A2.D_E_L_E_T_ = ''    AND A2.A2_MSBLQL <> '1' )
	AND C7FULL.C7_EMISSAO > '20150101'
	
GO

--select * from SC7030

--UPDATE SC7030 SET C7_XNUMANT = C7_NUM


--UPDATE SC7030 SET C7_NUM= C7_XSEQ