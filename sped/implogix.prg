#include <hmg.ch>
#include "adordd.ch"
#include "try.ch"

function ImportarLogix()

cCAMINHO   := PROFILESTRING( "sped.ini","SINTCERT.DBF","CAMINHO",HB_CWD())+"SINTCERT"
IF ! NETUSE(cCAMINHO)
   RETURN
ENDIF
cCAMINHO   := PROFILESTRING( "sped.ini","CIDCONV.DBF","CAMINHO",HB_CWD())+"CIDCONV"
IF ! NETUSE(cCAMINHO)
   DBCLOSEALL()
   RETURN
ENDIF
cCAMINHO   := PROFILESTRING( "sped.ini","MD10.DBF","CAMINHO",HB_CWD())+"MD10"
IF ! NETUSE(cCAMINHO)
   DBCLOSEALL()
   RETURN
ENDIF
cCAMINHO   := PROFILESTRING( "sped.ini","CNPJXML.DBF","CAMINHO",HB_CWD())+"CNPJXML"
IF ! NETUSE(cCAMINHO)
   DBCLOSEALL()
   RETURN
ENDIF
cCAMINHO   := PROFILESTRING( "sped.ini","DANFE2.DBF","CAMINHO",HB_CWD())+"DANFE2"
IF ! NETUSE(cCAMINHO)
   DBCLOSEALL()
   RETURN
ENDIF

cCAMINHO   := PROFILESTRING( "sped.ini","REGH010LXVAL.DBF","CAMINHO",HB_CWD())+"REGH010LXVAL"
IF ! NETUSE(cCAMINHO)
   DBCLOSEALL()
   RETURN
ENDIF



lMANA5:=MDG("Gravar Mana5")
IF lMANA5
   cCAMINHO   := PROFILESTRING( "sped.ini","MA01.DBF","CAMINHO",HB_CWD())+"MA01"
   IF ! NETUSE(cCAMINHO)
       DBCLOSEALL()
       RETURN
    ENDIF  
    cCAMINHO   := PROFILESTRING( "sped.ini","MB01.DBF","CAMINHO",HB_CWD())+"MB01"
    IF ! NETUSE(cCAMINHO)
       DBCLOSEALL()
       RETURN
    ENDIF
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
   ShowAdoError(oERR,oConn,cCOMANDO) 
end


oRegistro:= CreateObject('ADODB.RecordSet')
oRegistro:CursorLocation := 3

oRegistr2:= CreateObject('ADODB.RecordSet')
oRegistr2:CursorLocation := 3

if mdg("importar clientes")
	nNUMERO:=1
	cSQL = " SELECT clientes.*,cnpjcpf(clientes.num_cgc_cpf) AS cnpj,pessoa(clientes.num_cgc_cpf) as PESSOA,cidades.den_cidade,vdp_cliente_compl.email  AS email_compl,vdp_cli_parametro.texto_parametro "
	cSQL += "       , cliente_grupo_970.cognome_grupo,duns_empresa.num_duns  "
	cSQL += "	,vdp_cli_fornec_cpl.cliente_fornecedor, vdp_cli_fornec_cpl.tip_cadastro, vdp_cli_fornec_cpl.bairro,  "
	cSQL += "    vdp_cli_fornec_cpl.compl_endereco, vdp_cli_fornec_cpl.tip_logradouro, vdp_cli_fornec_cpl.logradouro, vdp_cli_fornec_cpl.num_iden_lograd    "
	cSQL += " ,vdp_cli_grp_email.email "
	cSQL += " FROM clientes  LEFT JOIN cidades ON clientes.cod_cidade = cidades.cod_cidade"
	cSQL += "                LEFT JOIN vdp_cliente_compl ON clientes.cod_cliente = vdp_cliente_compl.cliente"
	cSQL += "                LEFT JOIN vdp_cli_parametro ON clientes.cod_cliente = vdp_cli_parametro.cliente  and vdp_cli_parametro.parametro = 'ins_municipal'"
	cSQL += "                LEFT JOIN CLIENTE_GRUPO_970 ON CLIENTES.cod_cliente = cliente_grupo_970.cod_cliente"
	cSQL += "                LEFT JOIN duns_empresa ON clientes.cod_cliente=duns_empresa.cod_cliente AND duns_empresa.cod_empresa='01' "	
	cSQL += "	 		     LEFT JOIN vdp_cli_grp_email ON clientes.cod_cliente=vdp_cli_grp_email.cliente AND grupo_email=1 AND seq_email=1  "
	cSQL += "                LEFT JOIN vdp_cli_fornec_cpl ON clientes.cod_cliente=vdp_cli_fornec_cpl.cliente_fornecedor AND vdp_cli_fornec_cpl.tip_cadastro='C' "
	cSQL += " where clientes.ies_situacao='A' "

	nHANDLE:=FCREATE("dados_clientes.sql")
	TRY
	   oRegistro:Open(cSQL, oConN, adOpenForwardOnly,adLockReadOnly) //1, 3)
	catch oErr
		ShowAdoError(oERR,oConn,cCOMANDO)
	END
	nCONTA:=0
	WHILE .NOT. oregistro:eof      
	   cESTADO = Left(Trim(FixStr(oregistro:fields("cod_cidade"):value)), 2)
	   cINSCR = ALLTrim(FixStr(oregistro:fields("ins_estadual"):value))
	   cCGC = ALLTrim(FixStr(oregistro:fields("CNPJ"):value))
	   cNUMERO = ALLTRIM(FIXSTR(oregistro:fields("COD_CLIENTE"):value))
	   cCIDADE = ALLTrim(FixStr(oregistro:fields("den_cidade"):value))
	   cNOME = ALLTrim(FixStr(oregistro:fields("nom_cliente"):value))
	   cPESSOA = ALLTrim(FixStr(oregistro:fields("pessoa"):value))
	   cCEP = ALLTrim(FixStr(oregistro:fields("cod_cep"):value))
	   cDDD = PEGDDD(ALLTrim(FixStr(oregistro:fields("num_telefone"):value)))
	   cTELEFONE = PEGTEL(ALLTrim(FixStr(oregistro:fields("num_telefone"):value)))
	   cEMAIL = lower(ALLTrim(Fix02(oregistro:fields("email"):value)))
	   cCCM = ALLTrim(FixStr(oregistro:fields("texto_parametro"):value))
	   cSUFRAMA = ALLTrim(FixStr(oregistro:fields("num_suframa"):value))   
	   cCNAE = ""
 	   cBAIRRO:=ALLTrim(Fix02(oregistro:fields("bairro"):value))   
	   cENDERECO:=ALLTrim(Fix02(oregistro:fields("logradouro"):value))   
	   cNUMEND:=ALLTrim(FixStr(oregistro:fields("num_iden_lograd"):value))   
	   cCOMPLEM:=ALLTrim(FixStr(oregistro:fields("compl_endereco"):value))   
	   cENDTIP:=ALLTrim(FixStr(oregistro:fields("tip_logradouro"):value))   

	   
	   MDS("Cliente: "+cCGC)
	   
	   /* agora pega na query principal compo padrao o compl agora e email_compl
	   IF EMPTY(cEMAIL)
		  cSQL = "SELECT EMAIL FROM vdp_cli_grp_email Where seq_email = 1 And grupo_email = 1 AND cliente='" +cNUMERO + "'"
		  TRY
			 oRegistr2:Open(cSQL, oConN, adOpenForwardOnly,adLockReadOnly) 
		  catch oErr
			 ShowAdoError(oERR,oConn,cCOMANDO)
		  END
		  IF .NOT. oregistr2:eof         
			  cEMAIL = lower(Trim(Fix02(oregistr2:fields("email"):value)))    
			  FWRITE(nHANDLE,"INSERT INTO vdp_cliente_compl (cliente, email, email_secund, endereco_web) VALUES ('"+cNUMERO+"', '', NULL, NULL);"+HB_OSNEWLINE())          
			  FWRITE(nHANDLE,"UPDATE vdp_cliente_compl SET email='" + cEMAIL + "' WHERE cliente='" + cNUMERO + "' ;"+HB_OSNEWLINE())
		  endif
		  oregistr2:close()   
	   ENDIF
	   */

	   IF EMPTY(cEMAIL)
		  dbselectar("cnpjxml")
		  dbgotop()
		  if dbseek(tiraout(ccgc))
			 if EMPTY(cEMAIL) .AND. ! EMPTY(CNPJXML->EMAIL) 
				cEMAIL:=fix02(lower(alltrim(CNPJXML->EMAIL)))
				FWRITE(nHANDLE,"INSERT INTO vdp_cliente_compl (cliente, email, email_secund, endereco_web) VALUES ('"+cNUMERO+"', '', NULL, NULL);"+HB_OSNEWLINE())          
				FWRITE(nHANDLE,"UPDATE vdp_cliente_compl SET email='" + cEMAIL + "' WHERE cliente='" + cNUMERO + "' ;"+HB_OSNEWLINE())
			 endif
		  endif
	   else
	   	  dbselectar("cnpjxml")
		  dbgotop()
		  if dbseek(tiraout(ccgc))
			 if EMPTY(CNPJXML->EMAIL) 
			    netreclock()
				CNPJXML->EMAIL:=cEMAIL
				dbunlock()
			 endif
	      endif
	   ENDIF
		
	   IF TIRAOUT(cINSCR)=TIRAOUT(cCCM).AND.! EMPTY(cCCM) //apaga a ins_municipal pois foi preenchida com a inscricao estadual
		  FWRITE(nHANDLE,"UPDATE vdp_cli_parametro SET texto_parametro='' WHERE cliente='" + cNUMERO + "' and vdp_cli_parametro.parametro = 'ins_municipal';"+HB_OSNEWLINE())
	   ENDIF   
	   
	   
		aRETU:=corrigecid(cESTADO,cCIDADE,cDDD)
		IF aRETU[1]
		   cCIDADE:=aRETU[2]
		ENDIF
		IF EMPTY(cDDD)
		   cDDD:=aRETU[3]
		ENDIF
		

	   
	   aDADOS:={cCGC,cINSCR,cCCM,cESTADO,cCIDADE,cNOME,"LXCLI",TIRAOUT(cCEP),cDDD,cSUFRAMA,cCNAE,lower(cEMAIL),cTELEFONE,cPESSOA,cBAIRRO,cENDERECO,cNUMEND,cCOMPLEM,cENDTIP}
	   IF cPESSOA="J"                 
		  gravacert(aDADOS,.T.)            	  
   	     dbunlock()
	   ENDIF	  
	   
	   nCONTA++
	   IF lMANA5      
		  gravamana5("MA01",aDADOS,"LOGIX")             
	   ENDIF 


	   
	   oRegistro:MoveNext()
	enddo
	oRegistro:CLOSE()
	fclose(nHANDLE)
	alert("Importado Clientes"+STR(nCONTA))
endif	

if mdg("importar fornecedor")
	nHANDLE:=FCREATE("dados_fornec.sql")
	cSQL = " SELECT fornecedor.*,cnpjcpf(fornecedor.num_cgc_cpf) as cgc,cidades.den_cidade,fornec_compl.ins_municipal,fornec_compl.e_mail,sup_par_fornecedor.parametro_texto   "
	cSQL += "	,vdp_cli_fornec_cpl.cliente_fornecedor, vdp_cli_fornec_cpl.tip_cadastro, vdp_cli_fornec_cpl.bairro,  "
	cSQL += "    vdp_cli_fornec_cpl.compl_endereco, vdp_cli_fornec_cpl.tip_logradouro, vdp_cli_fornec_cpl.logradouro, vdp_cli_fornec_cpl.num_iden_lograd    "	
	cSQL +=  " FROM fornecedor LEFT JOIN cidades ON fornecedor.cod_cidade = cidades.cod_cidade "
	cSQL +=  " LEFT JOIN fornec_compl ON fornecedor.cod_fornecedor = fornec_compl.cod_fornecedor "
	cSQL +=  " LEFT JOIN sup_par_fornecedor ON fornecedor.cod_fornecedor = sup_par_fornecedor.fornecedor  and sup_par_fornecedor.parametro = 'cod_cnae' "
	cSQL += " LEFT JOIN vdp_cli_fornec_cpl ON fornecedor.cod_fornecedor=vdp_cli_fornec_cpl.cliente_fornecedor AND vdp_cli_fornec_cpl.tip_cadastro='F' "
	cSQL +=  " where ies_fornec_ativo<>'I'"
	TRY
	   oRegistro:Open(cSQL, oConN, adOpenForwardOnly,adLockReadOnly) //1, 3)
	catch oErr
		ShowAdoError(oERR,oConn,cCOMANDO)
	END
	nCONTA:=0
	nNUMERO:=1
	WHILE .NOT. oregistro:eof         
		cESTADO  = Left(Trim(FixStr(oregistro:fields("cod_cidade"):value)), 2)
		cINSCR   = ALLTrim(FixStr(oregistro:fields("ins_estadual"):value))
		cCGC     = ALLTrim(FixStr(oregistro:fields("cgc"):value))
		cNUMERO  = alltrim(fixstr(oregistro:fields("COD_Fornecedor"):value))
		cCIDADE  = ALLTrim(FixStr(oregistro:fields("den_cidade"):value))
		cNOME    = ALLTrim(FixStr(oregistro:fields("raz_social"):value))
		cPESSOA  = ALLTrim(FixStr(oregistro:fields("ies_fis_juridica"):value))	
		cCGCTRIM = ALLTrim(TiraOut(cCGC))
		cCEP = ALLTrim(FixStr(oregistro:fields("cod_cep"):value))
		cDDD = PEGDDD(ALLTrim(FixStr(oregistro:fields("num_telefone"):value)))
		cTELEFONE = PEGTEL(ALLTrim(FixStr(oregistro:fields("num_telefone"):value)))
		cEMAIL = lower(ALLTrim(Fix02(oregistro:fields("e_mail"):value))	  )
		cCCM = ALLTrim(FixStr(oregistro:fields("ins_municipal"):value))
		cCCMT:=TIRAOUT(cCCM)
		cSUFRAMA = ""
		cCNAE = tiraout(ALLTrim(FixStr(oregistro:fields("parametro_texto"):value)))	
		
       cBAIRRO:=ALLTrim(Fix02(oregistro:fields("bairro"):value))   
	   cENDERECO:=ALLTrim(Fix02(oregistro:fields("logradouro"):value))   
	   cNUMEND:=ALLTrim(FixStr(oregistro:fields("num_iden_lograd"):value))   
	   cCOMPLEM:=ALLTrim(FixStr(oregistro:fields("compl_endereco"):value))   
	   cENDTIP:=ALLTrim(FixStr(oregistro:fields("tip_logradouro"):value))   
		
		MDS("Fornecedor: "+cCGC)
		
		
		aRETU:=corrigecid(cESTADO,cCIDADE,cDDD)
		IF aRETU[1]
		   cCIDADE:=aRETU[2]
		ENDIF
		IF EMPTY(cDDD)
		   cDDD:=aRETU[3]
		ENDIF
		
		IF EMPTY(cEMAIL)
		  cSQL = "SELECT EMAIL FROM vdp_cli_grp_email Where seq_email = 1 And grupo_email = 1 AND cliente='" +cNUMERO + "'"
		  TRY
			 oRegistr2:Open(cSQL, oConN, adOpenForwardOnly,adLockReadOnly) 
		  catch oErr
			 ShowAdoError(oERR,oConn,cCOMANDO)
		  END
		  IF .NOT. oregistr2:eof         
			  cEMAIL = alltrim(strtran(strtran(lower(Trim(Fix02(oregistr2:fields("email"):value))),chr(13),""),chr(10),""))
			  FWRITE(nHANDLE,"UPDATE fornec_compl SET e_mail='" + cEMAIL + "' WHERE cod_fornecedor='" + cNUMERO + "' ;"+HB_OSNEWLINE())          
		  endif
		  oregistr2:close()   
	   ENDIF

	 
	   IF EMPTY(cCNAE) .OR. EMPTY(cEMAIL)
		  dbselectar("cnpjxml")
		  dbgotop()
		  if dbseek(tiraout(ccgc))
			 if EMPTY(cCNAE).AND.! EMPTY(CNPJXML->CNAE) //checa variavel vazia pois a regra checara tambem cEMAIL
				cCNAE:=CNPJXML->CNAE
				cCNAETMP = substr(cCNAE, 1, 4) + "-" + substr(cCNAE, 5, 1) + "/" + substr(cCNAE, 6, 2)            
				FWRITE(nHANDLE,"INSERT INTO sup_par_fornecedor (empresa, fornecedor, parametro, des_parametro, parametro_booleano, parametro_texto, parametro_val, parametro_numerico, parametro_dat) VALUES ('SE', '" + cNUMERO + "', 'cod_cnae', 'Classificacao Nacional de Atividade Economica', NULL, '" + cCNAETMP + "', NULL, NULL, NULL);"+HB_OSNEWLINE())
				FWRITE(nHANDLE,             "UPDATE sup_par_fornecedor SET parametro_texto= '" + cCNAETMP + "'    WHERE fornecedor='" + cNUMERO + "' and sup_par_fornecedor.parametro = 'cod_cnae' ;"+HB_OSNEWLINE())
			 endif
			 if EMPTY(cEMAIL).AND.! EMPTY(CNPJXML->EMAIL) 
				cEMAIL:=lower(alltrim(CNPJXML->EMAIL))
				FWRITE(nHANDLE,"UPDATE fornec_compl SET e_mail='" + cEMAIL + "' WHERE cod_fornecedor='" + cNUMERO + "' ;"+HB_OSNEWLINE())
			 endif
		  endif
	   ENDIF
	   
	   IF EMPTY(cCNAE).OR. EMPTY(cEMAIL) //cnae/email obtido sefaz
		  dbselectar("sintcert")
		  dbgotop()
		  if dbseek(ccgc)
			 if EMPTY(cCNAE).AND.! EMPTY(sintcert->CNAE) //checa variavel vazia pois a regra checara tambem cEMAIL
				cCNAE:=sintcert->CNAE
				cCNAETMP = substr(cCNAE, 1, 4) + "-" + substr(cCNAE, 5, 1) + "/" + substr(cCNAE, 6, 2)            
				FWRITE(nHANDLE,"INSERT INTO sup_par_fornecedor (empresa, fornecedor, parametro, des_parametro, parametro_booleano, parametro_texto, parametro_val, parametro_numerico, parametro_dat) VALUES ('SE', '" + cNUMERO + "', 'cod_cnae', 'Classificacao Nacional de Atividade Economica', NULL, '" + cCNAETMP + "', NULL, NULL, NULL);"+HB_OSNEWLINE())
				FWRITE(nHANDLE,             "UPDATE sup_par_fornecedor SET parametro_texto= '" + cCNAETMP + "'    WHERE fornecedor='" + cNUMERO + "' and sup_par_fornecedor.parametro = 'cod_cnae' ;"+HB_OSNEWLINE())
			 endif
			 if EMPTY(cEMAIL).AND.! EMPTY(sintcert->EMAIL) 
				cEMAIL:=fix02(lower(alltrim(sintcert->EMAIL)))
				FWRITE(nHANDLE,"UPDATE fornec_compl SET e_mail='" + cEMAIL + "' WHERE cod_fornecedor='" + cNUMERO + "' ;"+HB_OSNEWLINE())
			 endif
		  endif
	   ENDIF

	   nTAMCCM:=TamanhoCCM(cCIDADE,cESTADO)
	   if LEFT(cCCMT,5)="ISENT" .OR. EMPTY(cCCMT).OR.(LEN(cCCMT)<>nTAMCCM.AND.nTAMCCM>0)
		  dbselectar("cnpjxml")
		  dbgotop()
		  if dbseek(tiraout(ccgc))
			 cCCMNFE:=ALLTRIM(TIRAOUT(iMUNICIPAL))
			 IF LEFT(cCCMNFE,5)<>"ISENT".AND.! EMPTY(cCCMNFE)
				IF LEFT(cCCM,5)="ISENT".OR. EMPTY(cCCMT)
				   cCCM:=cCCMNFE
				   FWRITE(nHANDLE,"UPDATE fornec_compl SET ins_municipal='" + cCCMNFE + "' WHERE cod_fornecedor='" + cNUMERO + "' ;"+HB_OSNEWLINE())
				ELSE                        
				   IF LEN(cCCMNFE)=nTAMCCM
					 cCCM:=cCCMNFE
					 FWRITE(nHANDLE,"UPDATE fornec_compl SET ins_municipal='" + cCCMNFE + "' WHERE cod_fornecedor='" + cNUMERO + "' ;"+HB_OSNEWLINE())
				   ENDIF               
				ENDIF   
			 ENDIF      
		  endif   
	   endif
	   

	   IF TIRAOUT(cINSCR)=cCCMT.AND.! EMPTY(cCCMT)  //apaga a ins_municipal pois foi preenchida com a inscricao estadual
		  FWRITE(nHANDLE,"UPDATE fornec_compl SET ins_municipal='' WHERE cod_fornecedor='" + cNUMERO + "' ;"+HB_OSNEWLINE())
	   ENDIF
	   IF cCCM=".".AND.LEN(cCCM)=1 //preenchidos errado . , outros
		  FWRITE(nHANDLE,"UPDATE fornec_compl SET ins_municipal='' WHERE cod_fornecedor='" + cNUMERO + "' ;"+HB_OSNEWLINE())
	   ENDIF   
	 
		
		aDADOS:={cCGC,cINSCR,cCCM,cESTADO,cCIDADE,cNOME,"LXFOR",TIRAOUT(cCEP),cDDD,cSUFRAMA,cCNAE,lower(cEMAIL),cTELEFONE,cPESSOA,cBAIRRO,cENDERECO,cNUMEND,cCOMPLEM,cENDTIP}
		IF cPESSOA="J"	                  	
		   gravacert(aDADOS,.T.)
		endif  
		nCONTA++
		IF lMANA5
		  gravamana5("MB01",aDADOS,"LOGIX")             
		ENDIF   
		
	 

		oRegistro:MoveNext()
	enddo
	oRegistro:CLOSE()
	fclose(nHANDLE)
	alert("Importado Fornecedores: "+STR(nCONTA))
endif

nANOANT:=year(date())
nMESANT:=month(date())
nMESANT--
IF nMESANT=0
   nMESANT:=12
   nANOANT:=nANOANT-1
ENDIF

if mdg("Importar preco referencia")
	FOR X=1 TO 7
	   nCONTA:=1      
	   DO CASE
		  CASE X=1
			 cSQL = " SELECT cod_item,pre_unit FROM desc_preco_item "
			 cSQL += " WHERE (cod_empresa='01') AND pre_unit>0 AND cod_item <>''"
			 CSQL += " and cod_item[1,4]<>'9.99' and num_list_preco<>9001"
			 cSQL += " GROUP BY 1,2"
			 cTIPOPRECO:="L"
			 //lista 9001 itens transferencia matriz filial
		  CASE X=2
			 cSQL = "   SELECT cod_item,pre_unit_base AS pre_unit FROM cotacao_preco "
			 cSQL += "    WHERE  dat_fim_validade>today  "
			 cSQL += "   AND (cod_empresa='01' ) AND ies_versao_atual='S' "
			 CSQL += " and cod_item[1,4]<>'9.99' "
			 cTIPOPRECO:="C"
		  CASE X=3  
			 cSQL = " SELECT cod_item,valor AS pre_unit FROM ci_item_lista_970 WHERE valor>0 "
			 cTIPOPRECO:="I"      
		  CASE X=4
			 cSQL = " SELECT cod_item,valor_novo AS pre_unit FROM ci_it_atu_lst_970 WHERE valor_novo>0 and tipo<>'O' "
			 cTIPOPRECO:="A" 
		  CASE X=5
			 cSQL = "SELECT COD_ITEM,CUS_UNIT_MEDIO AS PRE_UNIT FROM item_custo WHERE cus_unit_medio>0"
			 cTIPOPRECO:="M" 
		  CASE X=6
			 cSQL = "SELECT iTEM as cod_item,custo AS PRE_UNIT FROM custo_avg_970  WHERE custo>0"
			 cTIPOPRECO:="V"   
		  case x=7         
			 cSQL = "SELECT cod_item,cus_unit_medio AS PRE_UNIT FROM estoque_hist WHERE ano_ref="+str(nanoant)+" AND mes_ref="+str(nmesant)
			 cTIPOPRECO:="E"   
	   ENDcase  
	   //hb_memowrit("uso.slq",cSQL)
	   TRY
		  oRegistro:Open(cSQL, oConN, adOpenForwardOnly,adLockReadOnly)
	   catch oErr
		   ShowAdoError(oERR,oConn,cCOMANDO)
	   END
	   nCONTA:=0
	   WHILE .NOT. oregistro:eof           
		  cCOD_ITEM := ALLTrim(FixStr(oregistro:fields("cod_item"):value))
		  nVl_UNIT :=oregistro:fields("pre_unit"):value      
		  nCONTA++  
		  mds(strZERO(x,2)+"/"+cCOD_ITEM)
		  IF nVl_UNIT>0     
			dbselectar("regh010lxval")      
			dbgotop()
			if ! dbseek(cTIPOPRECO+cCOD_ITEM)
			   netrecapp()
			   regh010lxval->cod_item:=cCOD_ITEM
			   regh010lxval->TIPOPRECO:=cTIPOPRECO
			ELSE
			   netreclock()
			ENDIF
			if nvl_unit>regh010lxval->VL_UNIT
			   regh010lxval->VL_UNIT:=nVL_UNIT         
			ENDIF
			dbunlock()
		  ENDIF  
		  oRegistro:MoveNext()
	   enddo
	   oRegistro:CLOSE()
	NEXT X   
	alert("Importado Lista de Preco/Contrato"+STR(nCONTA))
endif	


//Incluir fornecedor com xml e ajustar data de inicio
IF MDG("Importar inicio xml")
	dbselectar("cnpjxml")
	dbsetorder(1)	
    cSQL = " SELECT tiraout(cnpjcpf(fornecedor.num_cgc_cpf)) AS fornecedor,to_char(parametro_dat) AS parametro_dat FROM sup_par_fornecedor "
    cSQL += " LEFT JOIN fornecedor ON sup_par_fornecedor.fornecedor=fornecedor.cod_fornecedor  "
    cSQL += "     WHERE empresa = 'SE' AND (parametro='dat_ini_utiliz_nf-e') AND parametro_dat IS NOT NULL  "
    cSQL += "     and ies_fornec_ativo<>'I' "
	//cSQL = " SELECT fornecedor[2,15],to_char(parametro_dat) AS parametro_dat FROM sup_par_fornecedor "
	//cSQL += " WHERE empresa = 'SE' AND (parametro='dat_ini_utiliz_nf-e') AND parametro_dat IS NOT NULL "  
	TRY
	   oRegistro:Open(cSQL, oConN, adOpenForwardOnly,adLockReadOnly) //1, 3)
	catch oErr
		ShowAdoError(oERR,oConn,cCOMANDO)
	END
	nCONTA:=0
	WHILE .NOT. oregistro:eof     
	   cFORNECEDOR:=oregistro:fields("fornecedor"):value
	   cDATA := oregistro:fields("parametro_dat"):value      
	   nCONTA++   
	   mds(cFORNECEDOR)   
	   dbselectar("cnpjxml")
	   dbgotop()
	   if dbseek(cFORNECEDOR)      
		  if empty(cnpjxml->dinixml) 
			 netreclock()
			 cnpjxml->dinixml:=CTOD(cDATA)
			 dbunlock()
		  endif   
	   else 
		  //IF VALCGC(cFORNECEDOR,,.F.) nao incluir pois estava trazendo fornecedor inativos ou com muito tempo sem compra
		  //	 netrecapp()
		  //	 cnpjxml->CNPJ:=cFORNECEDOR
		  //	 cnpjxml->dinixml:=CTOD(cDATA)
		  //	 dbunlock()
		  //ENDIF   
	   ENDIF   
	   oRegistro:MoveNext()
	enddo
	oRegistro:CLOSE()
endif	


IF MDG("Checar email grupo vdp")
   dbselectar("cnpjxml")
   dbgotop()
   while .not. Eof()
       cCNPJ:=CNPJXML->CNPJ
       mds(cCNPJ)   
	   
      IF at('EMPRESA',UPPER(CNPJXML->EMAIL))>0       //email internos como sendo pessoais     
          netreclock()	  
          CNPJXML->EMAIL:=''
		   dbunlock()  
      ENDIF 
	   

       if empty(cnpjxml->email)	   
	      cEMAIL:=""
	      cSQL = "SELECT EMAIL FROM vdp_cli_grp_email Where seq_email = 1 And grupo_email = 1 AND cliente='" +"0"+ cCNPJ + "'"
		  TRY
			 oRegistr2:Open(cSQL, oConN, adOpenForwardOnly,adLockReadOnly) 
		  catch oErr
			 ShowAdoError(oERR,oConn,cCOMANDO)
		  END
		  IF .NOT. oregistr2:eof         
			  cEMAIL = lower(Trim(Fix02(oregistr2:fields("email"):value)))    
		  endif
		  oregistr2:close()   
		  if ! empty(cEMAIL) .and.  at('EMPRESA',cEMAIL)=0
		     netreclock()
			 CNPJXML->EMAIL:=cEMAIL
			 dbunlock()  
	      ENDIF
       endif
      dbskip()
   enddo
endif


nHANDLE:=FCREATE("dados_inixml.sql")

//incluir data para os fornecedor que recebeu xml
nCONTA:=0
dbselectar("cnpjxml")
dbgotop()
while ! eof()
   cCNPJ:=CNPJXML->CNPJ
   mds(cCNPJ)   
   If valcpF(cCNPJ, .f.) 
      NETRECLOCK()
      cnpjxml->dinixml:=CTOD("01/12/2008")
      DBUNLOCK()
   ENDIF
   if ! empty(cnpjxml->ultimaimp) .and. empty(cnpjxml->dinixml) .AND. LEN(ALLTRIM(cCNPJ))=14  //so gera se ja chegou alguma nota  
      cDATA:=DTOC(cnpjxml->ultimaimp)
      dbselectar("danfe2")
      dbsetorder(2)
      dbgotop()
      dbseek(cCNPJ)
      IF DANFE2->CNPJ==cCNPJ         
         cDATA:=DTOC(STOD(STRTRAN(EMISSAO,"-","")))                      
      ENDIF
      dbselectar("cnpjxml")
      IF ! EMPTY(cDATA) .AND. cDATA<>'  /  /    '
         cTEXTO:=" INSERT INTO sup_par_fornecedor (empresa, fornecedor, parametro, des_parametro, parametro_booleano, parametro_texto, parametro_val, parametro_numerico, parametro_dat)"
         FWRITE(nhandle,cTEXTO+HB_OSNEWLINE())
         cTEXTO:=" VALUES ('SE', '0"+cCNPJ+"', 'ies_utiliza_NFe', 'Indica se utiliza Nota Fiscal Eletrônica', 'S', NULL, NULL, NULL, NULL); "
         FWRITE(nhandle,cTEXTO+HB_OSNEWLINE())         
         cTEXTO:=" INSERT INTO sup_par_fornecedor (empresa, fornecedor, parametro, des_parametro, parametro_booleano, parametro_texto, parametro_val, parametro_numerico, parametro_dat)"
         FWRITE(nhandlE,cTEXTO+HB_OSNEWLINE())      
         cTEXTO:=" VALUES ('SE', '0"+cCNPJ+"', 'dat_ini_utiliz_nf-e', 'Inicio de utilizacao da Nota Fiscal Eletronica', NULL, NULL, NULL, NULL, '"+cDATA+"');"
         FWRITE(nhandlE,cTEXTO+HB_OSNEWLINE())    
         NETRECLOCK()
         cnpjxml->dinixml:=CTOD(cDATA)
         dbunlock()         
         nCONTA++
      ENDIF         
   endif
   dbselectar("cnpjxml")
   cTEXTO:=""
   IF ! EMPTY(cnpjxml->complem)
       cTEXTO:="UPDATE vdp_cli_fornec_cpl SET compl_endereco='"+fix02(cnpjxml->complem)+"'     WHERE  cliente_fornecedor = '0"+cCNPJ+"' AND (compl_endereco=''     OR compl_endereco     IS NULL) ;"
	   cTEXTO+=HB_OSNEWLINE()
   endif		
   IF ! EMPTY(cnpjxml->endereco)	  
		cTEXTO+="UPDATE vdp_cli_fornec_cpl SET logradouro='"+strtran(fix02(cnpjxml->endereco),"'","")+"'         WHERE  cliente_fornecedor = '0"+cCNPJ+"' AND (logradouro=''         OR logradouro         IS NULL) ;"
        cTEXTO+=HB_OSNEWLINE()		
   endif				
   IF ! EMPTY(cnpjxml->numend)
		cTEXTO+="UPDATE vdp_cli_fornec_cpl SET num_iden_lograd='"+alltrim(cnpjxml->numend)+"'    WHERE  cliente_fornecedor = '0"+cCNPJ+"' AND (num_iden_lograd=''    OR num_iden_lograd    IS NULL) ;"
		cTEXTO+=HB_OSNEWLINE()
   endif		
   IF ! EMPTY(cnpjxml->email)		
		cTEXTO+="UPDATE vdp_cli_fornec_cpl SET correio_eletronico='"+alltrim(cnpjxml->email)+"' WHERE  cliente_fornecedor = '0"+cCNPJ+"' AND (correio_eletronico='' OR correio_eletronico IS NULL) ;"
		cTEXTO+=HB_OSNEWLINE()
   endif		
   IF ! EMPTY(cnpjxml->telefone)		
		cTEXTO+="UPDATE vdp_cli_fornec_cpl SET telefone_1='(" + DDD + ")" + alltrim(cnpjxml->telefone)+"' WHERE  cliente_fornecedor = '0"+cCNPJ+"' AND (telefone_1='' OR telefone_1 IS NULL) ;"
		cTEXTO+=HB_OSNEWLINE()
   endif
   IF ! EMPTY(cnpjxml->ENDTIP)
		cTEXTO+="UPDATE vdp_cli_fornec_cpl SET tip_logradouro='"+alltrim(cnpjxml->endtip)+"'     WHERE  cliente_fornecedor = '0"+cCNPJ+"' AND (tip_logradouro=''     OR tip_logradouro     IS NULL) ;"
	    cTEXTO+=HB_OSNEWLINE()
    endif	
    IF ! EMPTY(cnpjxml->bairro)
	    cTEXTO+="UPDATE vdp_cli_fornec_cpl SET bairro='"+strtran(fix02(cnpjxml->bairro),"'","")+"'     WHERE  cliente_fornecedor = '0"+cCNPJ+"'  AND (bairro=''  OR bairro IS NULL) ;"
		 cTEXTO+=HB_OSNEWLINE()	
	endif		
	
	
	  IF ! EMPTY(cnpjxml->complem)
		   cTEXTO:="UPDATE h_fornecedor SET compl_endereco='"+fix02(cnpjxml->complem)+"'     WHERE  cod_fornecedor = '0"+cCNPJ+"' AND (compl_endereco=''     OR compl_endereco     IS NULL) ;"
		   cTEXTO+=HB_OSNEWLINE()
	   endif		
	   IF ! EMPTY(cnpjxml->endereco)	  
			cTEXTO+="UPDATE h_fornecedor SET endereco='"+strtran(fix02(cnpjxml->endereco),"'","")+"'         WHERE  cod_fornecedor = '0"+cCNPJ+"' AND (endereco=''         OR endereco         IS NULL) ;"
			cTEXTO+=HB_OSNEWLINE()		
	   endif				
	   IF ! EMPTY(cnpjxml->numend)
			cTEXTO+="UPDATE h_fornecedor SET numero='"+alltrim(cnpjxml->numend)+"'    WHERE  cod_fornecedor = '0"+cCNPJ+"' AND (numero=''    OR numero    IS NULL) ;"
			cTEXTO+=HB_OSNEWLINE()
	   endif		
		IF ! EMPTY(cnpjxml->bairro)
			cTEXTO+="UPDATE h_fornecedor SET bairro='"+strtran(fix02(cnpjxml->bairro),"'","")+"'     WHERE  cod_fornecedor = '0"+cCNPJ+"'  AND (bairro=''  OR bairro IS NULL) ;"
			 cTEXTO+=HB_OSNEWLINE()	
		endif	
	
   
    cCODPART:=alltrim(cnpjxml->codpart) 
    if ! empty(cCODPART) .and. cCODPART<>'0'+cCNPJ
      IF ! EMPTY(cnpjxml->complem)
		   cTEXTO:="UPDATE vdp_cli_fornec_cpl SET compl_endereco='"+fix02(cnpjxml->complem)+"'     WHERE  cliente_fornecedor = '"+cCODPART+"' AND (compl_endereco=''     OR compl_endereco     IS NULL) ;"
		   cTEXTO+=HB_OSNEWLINE()
	   endif		
	   IF ! EMPTY(cnpjxml->endereco)	  
			cTEXTO+="UPDATE vdp_cli_fornec_cpl SET logradouro='"+strtran(fix02(cnpjxml->endereco),"'","")+"'         WHERE  cliente_fornecedor = '"+cCODPART+"' AND (logradouro=''         OR logradouro         IS NULL) ;"
			cTEXTO+=HB_OSNEWLINE()		
	   endif				
	   IF ! EMPTY(cnpjxml->numend)
			cTEXTO+="UPDATE vdp_cli_fornec_cpl SET num_iden_lograd='"+alltrim(cnpjxml->numend)+"'    WHERE  cliente_fornecedor = '"+cCODPART+"' AND (num_iden_lograd=''    OR num_iden_lograd    IS NULL) ;"
			cTEXTO+=HB_OSNEWLINE()
	   endif		
	   IF ! EMPTY(cnpjxml->email)		
			cTEXTO+="UPDATE vdp_cli_fornec_cpl SET correio_eletronico='"+alltrim(cnpjxml->email)+"' WHERE  cliente_fornecedor = '"+cCODPART+"' AND (correio_eletronico='' OR correio_eletronico IS NULL) ;"
			cTEXTO+=HB_OSNEWLINE()
	   endif		
	   IF ! EMPTY(cnpjxml->telefone)		
			cTEXTO+="UPDATE vdp_cli_fornec_cpl SET telefone_1='(" + DDD + ")" + alltrim(cnpjxml->telefone)+"' WHERE  cliente_fornecedor = '"+cCODPART+"' AND (telefone_1='' OR telefone_1 IS NULL) ;"
			cTEXTO+=HB_OSNEWLINE()
	   endif
	   
	   IF ! EMPTY(cnpjxml->ENDTIP)
			cTEXTO+="UPDATE vdp_cli_fornec_cpl SET tip_logradouro='"+alltrim(cnpjxml->endtip)+"'     WHERE  cliente_fornecedor = '"+cCODPART+"' AND (tip_logradouro=''     OR tip_logradouro     IS NULL) ;"
			cTEXTO+=HB_OSNEWLINE()
		endif		
		
	   IF ! EMPTY(cnpjxml->bairro)
		  cTEXTO+="UPDATE vdp_cli_fornec_cpl SET bairro='"+strtran(fix02(cnpjxml->bairro),"'","")+"'     WHERE  cliente_fornecedor = '"+cCODPART+"' AND (bairro=''  OR bairro IS NULL) ;"
		  cTEXTO+=HB_OSNEWLINE()
	  endif		

		
		   IF ! EMPTY(cnpjxml->complem)
			   cTEXTO:="UPDATE h_fornecedor SET compl_endereco='"+fix02(cnpjxml->complem)+"'     WHERE  cod_fornecedor = '"+cCODPART+"' AND (compl_endereco=''     OR compl_endereco     IS NULL) ;"
			   cTEXTO+=HB_OSNEWLINE()
		   endif		
		   IF ! EMPTY(cnpjxml->endereco)	  
				cTEXTO+="UPDATE h_fornecedor SET endereco='"+strtran(fix02(cnpjxml->endereco),"'","")+"'         WHERE  cod_fornecedor = '"+cCODPART+"' AND (endereco=''         OR endereco         IS NULL) ;"
				cTEXTO+=HB_OSNEWLINE()		
		   endif				
		   IF ! EMPTY(cnpjxml->numend)
				cTEXTO+="UPDATE h_fornecedor SET numero='"+alltrim(cnpjxml->numend)+"'    WHERE  cod_fornecedor = '"+cCODPART+"' AND (numero=''    OR numero    IS NULL) ;"
				cTEXTO+=HB_OSNEWLINE()
		   endif		
			IF ! EMPTY(cnpjxml->bairro)
				cTEXTO+="UPDATE h_fornecedor SET bairro='"+strtran(fix02(cnpjxml->bairro),"'","")+"'     WHERE  cod_fornecedor = '"+cCODPART+"'  AND (bairro=''  OR bairro IS NULL) ;"
				 cTEXTO+=HB_OSNEWLINE()	
			endif
	
		
		
    endif

   
   //SELECT * FROM vdp_cli_fornec_cpl WHERE (num_iden_lograd IS NULL OR num_iden_lograd='')  AND cliente_fornecedor[10,13]<>'0000'  AND cliente_fornecedor[10,13]<>'9999'
   
   
   IF ! EMPTY(cTEXTO)
	 FWRITE(nhandlE,cTEXTO)    
   ENDIF	 
   dbskip()
enddo
DBCLOSEAREA()

if mdg("gerar ccm-SP")
	cCAMCCM := PROFILESTRING( "sped.ini","PATH","CNPJIEUF",HB_CWD())
	IF  netuse(cCAMCCM+"CCMSP")  
		SET FILTER TO  ! EMPTY(CCM)	
		dbgotop()     
		WHILE ! EOF()      
			mds(CCMSP->CNPJ)
			IF ! EMPTy(CCMSP->CCM)
				cNUMERO:="0"+CCMSP->CNPJ
				cIM    := Transform(CCMSP->CCM,"@R 9.999.999-9") 
				FWRITE(nHANDLE,"UPDATE vdp_cli_parametro SET texto_parametro='"+cIM+"' WHERE cliente='"        + cNUMERO + "' and vdp_cli_parametro.parametro = 'ins_municipal' AND (texto_parametro='' OR texto_parametro IS NULL) ;"+HB_OSNEWLINE())
				FWRITE(nHANDLE,"UPDATE fornec_compl       SET ins_municipal='"+cIM+"'   WHERE cod_fornecedor='" + cNUMERO + "'  AND (ins_municipal=''  OR ins_municipal  IS NULL)  ;"+HB_OSNEWLINE())
			ENDIF
		   dbskip()	  
		enddo   
	endif
	DBCLOSEAREA()
ENDIF

fclose(nHANDLE)
alert("Importado data xml"+STR(nCONTA))

//gravasql("dados_clientes.sql")
//gravasql("dados_fornec.sql")
//gravasql("dados_inixml.sql")
mds("...")
dbcloseall()

FUNCTION ShowAdoError(oERR,oCon,cMESSAGE)
LOCAL   nAdoErrors   := 0
LOCAL   oAdoErr
LOCAL   cERRO

      nAdoErrors   :=  oCon:Errors:Count()
      IF nAdoErrors > 0
         oAdoErr      := oCon:Errors(nAdoErrors-1)
         cERRO:= oAdoErr:Description + HB_OsNewLine() + oAdoErr:Source 
         cERRO+= oCon:ConnectionString   + HB_OsNewLine()
         cERRO+= HB_VALTOEXP(oCon:Provider)   + HB_OsNewLine()
         cERRO+= HB_VALTOEXP(oCon:State)   + HB_OsNewLine()
      ELSE
         cERRO:= 'Outros Erros'
      ENDIF
      IF VALTYPE(cMESSAGE)="C"
         cERRO+=HB_OsNewLine()+ cMESSAGE
      ENDIF
      cERRO+=HB_OsNewLine()+oErr:Operation + " " + oErr:Description
      hb_memowrit("showadoerror"+ArqLogDataHora("log"),cERRO)
      msginfO(cERRO)      
RETURN nil


Function gravamana5(cARQ,aDADOS,cORIGEM)
LOCAL cCGC
cCGC:=aDADOS[1] //9999 cnpj genericos logix importacao
IF VALCGC(cCGC,,.F.) .or.  substr(cCGC,11,4)<>'9999'  .or.   Valcpf(CCGC,.F.) 
else
   return
endif  
dbselectar(cARQ)  
IF cARQ="MA01"
   dbsetorder(4)
ENDIF   
IF cARQ="MB01"
   DBSETORDER(3)
ENDIF
DBGOTOP()
IF ! dbSEEK(CCGC)
   dbsetorder(1)
   dbgotop()
   while dbseek(nNUMERO)
      nNUMERO++
   enddo   
   netrecapp()
   &cARQ.->NUMERO:=nNUMERO
   &cARQ.->CGC:=cCGC
   IF cARQ="MA01"
      MA01->cNUMERO:=STRZERO(nNUMERO,8)
   ENDIF
ELSE
   netreclock()
ENDIF

      //  aDADOS:={cCGC,cINSCR,cCCM,cESTADO,cCIDADE,cNOME,"LXCLI",TIRAOUT(cCEP),cDDD,cSUFRAMA,cCNAE,cEMAIL,cTELEFONE,cPESSOA}
//                   1    2      3     4        5      6      7        8          9     10       11    12     13        14

          IF cARQ="MA01"
             aCAMPOS:={"CGC","INSCR","IMUNICIPI","ESTADO","CIDADE","NOME","","CEP","DDD","SUFRAMA","CNAE","EMAIL","TELEFONE","PESSOA"}
          ELSE
             aCAMPOS:={"CGC","IESTADUAL","IMUNICIPI","ESTADO","CIDADE","NOME","","CEP","DDD","SUFRAMA","CNAE","EMAIL","TELEFONE","PESSOA"}
          ENDIF
          
          IF cORIGEM="LOGIX"
              AADD(aCAMPOS,"BAIRRO")
              AADD(aDADOS,ALLTrim(FixStr(oregistro:fields("den_bairro"):value)))
              AADD(aCAMPOS,"CONTATO")
              AADD(aDADOS,ALLTrim(FixStr(oregistro:fields("nom_contato"):value)))
              cCOGNOME:=""
              IF cARQ="MA01"
                  cCOGNOME:=ALLTrim(FixStr(oregistro:fields("nom_reduzido"):value))
              ENDIF
              IF cARQ="MB01"
                  cCOGNOME:=ALLTrim(FixStr(oregistro:fields("raz_social_reduz"):value))
              ENDIF        
              IF Len(AllTrim(cCOGNOME))=0
                 cCOGNOME:=aDADOS[6]
              ENDIF	
              AADD(aCAMPOS,"COGNOME")
              AADD(aDADOS,cCOGNOME)
              IF cARQ="MA01"
                  AADD(aCAMPOS,"ENDERECO")
                  AADD(aDADOS,ALLTrim(FixStr(oregistro:fields("end_cliente"):value)))
                  AADD(aCAMPOS,"GRUPOEMP")
                  AADD(aDADOS,ALLTrim(FixStr(oregistro:fields("cognome_grupo"):value)))
                  AADD(aCAMPOS,"CODIGOINT")
                  AADD(aDADOS,ALLTrim(FixStr(oregistro:fields("cod_cliente"):value)))
                  AADD(aCAMPOS,"CODIGO")
                  AADD(aDADOS,ALLTrim(FixStr(oregistro:fields("num_duns"):value)))
              ENDIF    
              IF cARQ="MB01"
                  AADD(aCAMPOS,"ENDERECO")
                  AADD(aDADOS,ALLTrim(FixStr(oregistro:fields("end_fornec"):value)))
                  AADD(aCAMPOS,"CODIGOINT")
                  AADD(aDADOS,ALLTrim(FixStr(oregistro:fields("cod_fornecedor"):value)))
                  AADD(aCAMPOS,"BANCO")
                  AADD(aDADOS,ALLTrim(FixStr(oregistro:fields("cod_banco"):value)))
                  AADD(aCAMPOS,"AGENCIA")
                  AADD(aDADOS,ALLTrim(FixStr(oregistro:fields("num_agencia"):value)))
                  AADD(aCAMPOS,"CONTA")
                  AADD(aDADOS,ALLTrim(FixStr(oregistro:fields("num_conta_banco"):value)))              
              ENDIF
          ENDIF        
          
          FOR X=2 TO LEN(aCAMPOS)
              IF X<>7
                 cCAMPO:=ACAMPOS[X]
                 IF ! EMPTY(aDADOS[X])
                    &cARQ.->&cCAMPO.:=aDADOS[X]
                 ENDIF
              ENDIF  
          NEXT X   
         
          

return .t.

function corrigecid(cUF,cCidade,cDDD)
aRETU:={.F.,cCIDADE,cDDD}
dbselectar("MD10")
dbgotop()
if ! dbseek(cUF+cCIDADE)
   dbselectar("cidconv")
   dbgotop()
   if dbseek(cUF+cCIDADE)
      aRETU:={.T.,cidconv->CIDDES,cDDD}
   endif
ELSE   
   IF EMPTY(cDDD)
      aRETU[3]:=DDD
   ENDIF
endif
return aRETU
