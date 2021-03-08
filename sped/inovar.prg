#include <hmg.ch>
#include "adordd.ch"
#include "try.ch"
#require "hbxlsxml"

function InovarLogix(dINI,dFIM,nTIPO)

IF VALTYPE(nTIPO)<>"N"
   nTIPO:=1
ENDIF

cConn:="Provider=MSDASQL.1;Persist Security Info=False;Data Source=ol_logix"
try

oConn:=CreateObject( "ADODB.Connection" )
with object oConn
  :ConnectionString:=cConn
  :Open()
end

cCOMANDO:="SET ISOLATION TO DIRTY READ"
oComm:=CreateObject( "ADODB.Command" )
with object oComm
  :CommandText:=cCOMANDO
  :CommandType:=adCmdText
  :ActiveConnection:=oConn
  :Execute()
end
catch oErr
   ShowAdoError(oERR,oCon,cCOMANDO) 
end


oRegistro:= CreateObject('ADODB.RecordSet')
oRegistro:CursorLocation := 3

// usa distinct pois o componente por estar em mais de uma estrutura

   cSQL = " SELECT DISTINCT aviso_rec.cod_empresa, "
   cSQL += "        nf_sup.num_nf, "
   cSQL += "        nf_sup.cod_fornecedor,fornecedor.raz_social_reduz,nf_sup.dat_entrada_nf,nf_sup.ies_especie_nf, "
   cSQL += "        aviso_rec.num_aviso_rec,aviso_rec.num_seq, "
   cSQL += "        aviso_rec.cod_ITEM,aviso_rec.den_item, "
   cSQL += "        aviso_rec.cod_unid_med_nf,aviso_rec.qtd_declarad_nf,aviso_rec.pre_unit_nf,aviso_rec.val_liquido_item, "
   cSQL += "        item.cod_familia,       "
   cSQL += "        aviso_rec.gru_ctr_desp_item,fornecedor.cod_cidade[1,2],  "
   cSQL += "        OBF_PAR_GRP_DESP.PARAMETRO_VAL AS origem, "
   cSQL += "        sup_par_ar.parametro_texto,  "
   cSQL += "        aviso_rec.cod_cla_fisc  "
   cSQL += "       ,sup_item_fci.numero_fci"
   cSQL += "       ,sup_item_fci.qtd_item_fci"
   cSQL += "       ,sup_item_fci.pct_contd_import"
   cSQL += "  FROM aviso_rec "
   cSQL += " LEFT JOIN item ON aviso_rec.cod_empresa=item.cod_empresa "
   cSQL += "         AND AVISO_REC.cod_item=ITEM.cod_item "
   IF nTIPO=1      
		cSQL += "         LEFT JOIN estrut_grade ON AVISO_REC.cod_empresa=estrut_grade.cod_empresa  "
		cSQL += "        AND aviso_rec.cod_item=estrut_grade.cod_item_compon  "
		cSQL += "        AND estrut_grade.dat_validade_fim IS null    "
   ENDIF    
   cSQL += " LEFT JOIN nf_SUP ON aviso_rec.cod_empresa=nf_sup.cod_empresa "
   cSQL += "                  AND AVISO_REC.num_aviso_rec=nf_sup.num_aviso_rec "
   cSQL += " LEFT JOIN fornecedor ON nf_sup.cod_fornecedor=fornecedor.cod_fornecedor                  "
   cSQL += " LEFT JOIN OBF_PAR_GRP_DESP  ON aviso_rec.cod_empresa=OBF_PAR_GRP_DESP.empresa "
   cSQL += "                  AND aviso_rec.gru_ctr_desp_item=OBF_PAR_GRP_DESP.grp_ctr_despesa "
   cSQL += "                  AND OBF_PAR_GRP_DESP.UNID_FEDERAL=fornecedor.cod_cidade[1,2]      "
   cSQL += "                  AND OBF_PAR_GRP_DESP.PARAMETRO='origem_mercadoria' "
   cSQL += " LEFT JOIN  SUP_PAR_AR ON aviso_rec.cod_empresa=sup_par_ar.empresa "
   cSQL += "                       AND aviso_rec.num_aviso_rec=sup_par_ar.aviso_recebto "
   cSQL += "                       AND SUP_PAR_AR.PARAMETRO='chav_aces_nf_eletr'          "   
   cSQL += " LEFT JOIN SUP_ITEM_FCI ON aviso_rec.cod_empresa = sup_item_fci.empresa "
   cSQL += "                        and   aviso_rec.num_aviso_rec = sup_item_fci.aviso_recebto "
   cSQL += "                        AND   aviso_rec.num_seq = sup_Item_fci.seq_aviso_recebto "   
   cSQL += " WHERE nf_sup.dat_entrada_nf>='"+dtoc(dini)+"' and nf_sup.dat_entrada_nf<='"+dtoc(dfim)+"'"   
   IF nTIPO=1
      cSQL += " 	AND cod_item_compon IS NOT null  "   
	  cSQL += " AND item.ies_tip_item<>'B' "
      cSQL += " 	AND item.cod_familia<>'220' 	and item.cod_familia<>'850' 	and item.cod_familia<>'970' "
      cSQL += " 	AND item.cod_familia<>'MPT' "
   ENDIF   

Set( _SET_DATEFORMAT, "dd/mm/yyyy" )

   
xarquivo := "c:\temp\"+if(nTIPO=1,"inovar_","todas_")+dtos(dini)+"_"+dtos(dfim)+".xml"


   oXml := ExcelWriterXML():New( xarquivo )
   oXml:setOverwriteFile( .T. )

   oObj := oXml:addStyle( "textLeft" )
   oObj:alignHorizontal( "Left" )
   oObj:alignVertical( "Center" )
   oObj:fontSize( 10 )

   oObj := oXml:addStyle( "textLeftWrap" )
   oObj:alignHorizontal( "Left" )
   oObj:alignVertical( "Center" )
   oObj:alignWraptext()
   oObj:fontSize( 10 )

   oObj := oXml:addStyle( "textLeftBold" )
   oObj:alignHorizontal( "Left" )
   oObj:alignVertical( "Center" )
   oObj:fontSize( 10 )
   oObj:setFontBold()

   oObj := oXml:addStyle( "textLeftBoldCor" )
   oObj:alignHorizontal( "Left" )
   oObj:alignVertical( "Center" )
   oObj:fontSize( 10 )
   oObj:setFontBold()
   oObj:bgColor( "lightblue" )
   oObj:alignWraptext()

   oObj := oXml:addStyle( "textRight" )
   oObj:alignHorizontal( "Right" )
   oObj:alignVertical( "Center" )
   oObj:fontSize( 10 )

   oObj := oXml:addStyle( "textRightBold" )
   oObj:alignHorizontal( "Right" )
   oObj:alignVertical( "Center" )
   oObj:fontSize( 10 )
   oObj:setFontBold()

   oObj := oXml:addStyle( "textRightBoldCor" )
   oObj:alignHorizontal( "Right" )
   oObj:alignVertical( "Center" )
   oObj:fontSize( 10 )
   oObj:setFontBold()
   oObj:bgColor( "lightblue" )
   oObj:alignWraptext()

   oObj := oXml:addStyle( "numberRight" )
   oObj:alignHorizontal( "Right" )
   oObj:alignVertical( "Center" )
   oObj:setNumberFormat( "#,##0.00" )
   oObj:fontSize( 10 )
   
   oObj := oXml:addStyle( "numberRight0" )
   oObj:alignHorizontal( "Right" )
   oObj:alignVertical( "Center" )
   oObj:setNumberFormat( "#####0" )
   oObj:fontSize( 10 )

      oObj := oXml:addStyle( "numberRight3" )
   oObj:alignHorizontal( "Right" )
   oObj:alignVertical( "Center" )
   oObj:setNumberFormat( "######0.000" )
   oObj:fontSize( 10 )


   oObj := oXml:addStyle( "numberRightBold" )
   oObj:alignHorizontal( "Right" )
   oObj:alignVertical( "Center" )
   oObj:setNumberFormat( "#,##0.00" )
   oObj:fontSize( 10 )
   oObj:setFontBold()

   oObj := oXml:addStyle( "numberRightBoldCor" )
   oObj:alignHorizontal( "Right" )
   oObj:alignVertical( "Center" )
   oObj:setNumberFormat( "#,##0.00" )
   oObj:fontSize( 10 )
   oObj:setFontBold()
   oObj:bgColor( "lightblue" )

   oObj := oXml:addStyle( "numberRightZero" )
   oObj:alignHorizontal( "Right" )
   oObj:alignVertical( "Center" )
   oObj:setNumberFormat( "#,##0.00;[Red]-#,##0.00;;@" ) //"#,###.00")
   oObj:fontSize( 10 )
   oObj:setFontBold()

   oObj := oXml:addStyle( "Cabec" )
   oObj:alignHorizontal( "Left" )
   oObj:alignVertical( "Center" )
   oObj:fontSize( 12 )
   oObj:setFontBold()

   oObj := oXml:addStyle( "CabecRight" )
   oObj:alignHorizontal( "Right" )
   oObj:alignVertical( "Center" )
   oObj:fontSize( 12 )
   oObj:setFontBold()

   oSheet := oXml:addSheet( "Plan1" )

   oObj := oSheet
   for colunas=1 to 31
       oObj:columnWidth( colunas,  100 )
   next colunas    
   
cCAMPOS:="EMP|NF|FORNECEDOR|NOME|DATAENTRADA|ESP|AR|SEQ|ITEM|NOME|UNID|QTDE|PRECO|VALOR|FAMILIA|GRPDESP|UF|ORIGEM|CHAVE|NCM|FCI|FCIQTD|FCIPER|NCMXML|ICMSORI|ICMSCST|IPICST|PISCST|COFINSCST|CHECKNCM|CHECKORI"
//         1   2   3          4          5    6   7   8    9    10  11   12  13     14     15     16    17   18    19    20     21      22   23     24       25       26      27      28        29    30    31                              

nLinha := 1
oObj := oSheet
aCAMPOS  :=HB_ATokens(cCAMPOS,"|")
for colunas= 1 to 28
   oObj:writeString( nLinha,colunas, aCAMPOS[COLunas]     , "textLeftBoldCor" )      
next colunas   
nLINHA++

TRY
   oRegistro:Open(cSQL, oConN, adOpenForwardOnly,adLockReadOnly) //1, 3)
catch oErr
    ShowAdoError(oERR,oConn,cCOMANDO)
END
nCONTA:=0
WHILE .NOT. oregistro:eof   
   cGRV:=""
   cCHAVE:=ALLTRIM(STRVAL(oregistro:fields("parametro_texto"):value))
   cARQUIVO:=""
   cORIGEM :=""
   cORILOGIX:=oregistro:fields("origem"):value
   cNCMLOGIX:=oregistro:fields("cod_cla_fisc"):value
   IF VALTYPE(cORILOGIX)<>"N"
      cORILOGIX:="?"
   ELSE
      cORILOGIX:=STRZERO(cORILOGIX,1)
   ENDIF   
   FOR Z=0 TO 22 //matriz 1 a 23 registro 0-22
       cVALOR:=alltrim(STRVAL(oregistro:fields(Z):value))
       cVALOR:=RANGEREPL(chr(0),chr(31),cVALOR," ")
       cVALOR:=RANGEREPL(chr(127),chr(255),cVALOR," ")
       cGRV+=cVALOR+"|"
   NEXT Z
   MDS("verificando: "+cGRV)
   IF nTIPO<>3 .and. ! EMPTY(cCHAVE)
      MDS("buscando xml"+cCHAVE)
      cARQUIVO:=PegCamXml(cCHAVE)  
      IF ! EMPTY(cARQUIVO) 
         MDS("lendo xml"+cARQUIVO)
         LINHA:=HB_MEMOREAD(cARQUIVO)
         nCONTA:=oregistro:fields("num_seq"):value
         IF nCONTA<10
            cCHAVE:="det nItem="+CHR(34)+STRZERO(nCONTA,1)+CHR(34)
         Else
            cCHAVE:="det nItem="+CHR(34)+STRZERO(nCONTA,2)+CHR(34)                      
         endif
         nPOSINI:=AT(cCHAVE,LINHA)
         LINHA2:=SUBSTR(LINHA,nPOSINI-1)                      
         LINHA2:=PegaDados(cCHAVE ,Alltrim(Linha2),,"det")                      
         IF lINHA2="0".and.len(linha2)=1 //ano achou secao
         ELSE
         ENDIF    
         cNCM:=PegaDados("NCM" ,Alltrim(Linha2) )
         cGRV+=cNCM+"|"             
         aIMP:={"ICMS","IPI","PIS","COFINS"}
         for z=1 to 4             
             cIMP:=PegaDados(aIMP[Z] ,Alltrim(Linha2))
             IF Z=1
                cORIGEM:=PegaDados("orig" ,cIMP,'?' )
                cGRV+=cORIGEM+"|"             
             ENDIF
             cCST:=PegaDados("CST" ,cIMP,'?' )
             cGRV+=cCST+"|"             
         NEXT Z 
         IF cNCMLOGIX=cNCM
            cGRV+="=|"
         ELSE
            cGRV+="<>|"
         ENDIF
         IF cORILOGIX=cORIGEM
            cGRV+="="
         ELSE
            cGRV+=cORILOGIX+"<>"+cORIGEM
         ENDIF
      ENDIF   
   ENDIF
   aCAMPOS  :=HB_ATokens(cGRV,"|")   
   for colunas= 1 to len(Acampos) //tem que ser len ao inves 19 pois pode nao ter todos os campos
      oObj:writeString( nLinha,colunas, aCAMPOS[COLunas]     , "textLeft" )      
   next colunas   
   nLINHA++  
   oRegistro:MoveNext()
enddo
oRegistro:CLOSE()
@ 24,00 say "Gravando Planilha"
oXml:writeData( xarquivo )
alert("Planilha Gerada "+xarquivo)


mds("...")
msginfo("concluido")