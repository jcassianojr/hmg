FUNCTION imptxt(cTIPO)


   cARQIMP:=""
   cSUBLINHA:=""
    
   IF cTIPO="XMLSPED"
      impxmlsped()        
      return
   ENDIF
       
   
    IF cTIPO="SINTEGRA" //incluir outros registros 10/11/90    
    
        caRQIMP:= Getfile ( { {'Arquivos Sintegras','*.*'} } , 'Abrir Arquivo' , HB_CWD() , .f. , .t. ) 
        IF EMPTy(cARQIMP)
           RETURN
        ENDIF
        cCAM   := PROFILESTRING( "sped.ini","PATH","SINTEGRA",HB_CWD())              
        aDBFREG:={"sint10","sint11","sint50","sint51","sint53", ;
                  "sint54","sint55","sint56","sint60R","sint60a","sint60d", ;
                  "sint60i","sint60m","sint61","sint70","sint71",;
                  "sint74","sint75","sint76","sint77","sint85","sint86", ;
                  "sint88C","sint88D","sint88E","sint88T","sint88M",;
                  "sint90" }   
        for x=1 to len(aDBFREG)
            if ! netzap(cCAM+aDBFREG[X])
               return
            endif    
        next x
        for x=1 to len(aDBFREG)
            if ! netUSE(cCAM+aDBFREG[X])
               dbcloseall()
               return
            endif            
        next x
        
        
        aDBF50:={ {"TIPO"        ,"C", 2,0},    ;    
                {"CGC"         ,"C",14,0},    ;    
                {"IE"          ,"C",14,0},    ;    
                {"DATA"        ,"SD", 8,0},    ;    
                {"UF"          ,"C", 2,0},    ;    
                {"MODELO"      ,"N", 2,0},    ;    
                {"SERIE"       ,"C", 3,0},    ;    
                {"NUMERO"      ,"N", 6,0},    ;    
                {"CFOP"        ,"C", 4,0},    ;    
                {"EMITENTE"    ,"C", 1,0},    ;    
                {"VALORTOT"    ,"N",13,2},    ;    
                {"BASE"        ,"N",13,2},    ;    
                {"VALOR"       ,"N",13,2},    ;    
                {"ISENTA"      ,"N",13,2},    ;    
                {"OUTRAS"      ,"N",13,2},    ;    
                {"ALIQUOTA"    ,"N", 4,2},    ;    
                {"SITUACAO"    ,"C", 1,0}}   
                
      aDBF51:={ {"TIPO"        ,"C", 2,0},    ;    
                {"CGC"         ,"C",14,0},    ;    
                {"IE"          ,"C",14,0},    ;    
                {"DATA"        ,"SD", 8,0},    ;    
                {"UF"          ,"C", 2,0},    ;    
                {"SERIE"       ,"C", 3,0},    ;    
                {"NUMERO"      ,"N", 6,0},    ;    
                {"CFOP"        ,"C", 4,0},    ;    
                {"VALORTOT"    ,"N",13,2},    ;    
                {"VALOR"       ,"N",13,2},    ;    
                {"ISENTA"      ,"N",13,2},    ;    
                {"OUTRAS"      ,"N",13,2},    ;    
                {"BRANCOS"     ,"C", 20,2},    ;    
                {"SITUACAO"    ,"C", 1,0}}   
                
      aDBF53:={ {"TIPO"        ,"C", 2,0},    ;    
                {"CGC"         ,"C",14,0},    ;    
                {"IE"          ,"C",14,0},    ;    
                {"DATA"        ,"SD", 8,0},    ;    
                {"UF"          ,"C", 2,0},    ;    
                {"MODELO"      ,"N", 2,0},    ;    
                {"SERIE"       ,"C", 3,0},    ;    
                {"NUMERO"      ,"N", 6,0},    ;    
                {"CFOP"        ,"C", 4,0},    ;    
                {"EMITENTE"    ,"C", 1,0},    ;   
                {"BASE"        ,"N",13,2},    ;    
                {"VALOR"       ,"N",13,2},    ;    
                {"DESPESAS"    ,"N",13,2},    ;    
                {"SITUACAO"    ,"C", 1,0},    ;
                {"ANTECIPA"    ,"C", 1,0},    ;    
                {"BRANCOS"     ,"C", 29,2}}
         
      aDBF54:={ {"TIPO"        ,"C", 2,0},    ;    
                {"CGC"         ,"C",14,0},    ;    
                {"MODELO"      ,"N", 2,0},    ;    
                {"SERIE"       ,"C", 3,0},    ;    
                {"NUMERO"      ,"N", 6,0},    ;    
                {"CFOP"        ,"C", 4,0},    ;
                {"SITUACAO"    ,"N", 3,0},    ;    
                {"ITEM"        ,"N", 3,0},    ;
                {"CODIGORED"   ,"C",14,0},    ;              
                {"QTDE"        ,"N",11,3},    ;    
                {"VALORMER"    ,"N",12,2},    ;    
                {"DESCONTO"    ,"N",12,2},    ;    
                {"BASEICM"     ,"N",12,2},    ;    
                {"BASESUB"     ,"N",12,2},    ;
                {"VALORIPI"    ,"N",12,2},    ;    
                {"ICM"         ,"N", 4,2}}    
         

      aDBF70:={ {"TIPO"        ,"C", 2,0},    ;    
                {"CGC"         ,"C",14,0},    ;    
                {"IE"          ,"C",14,0},    ;    
                {"DATA"        ,"SD", 8,0},    ;    
                {"UF"          ,"C", 2,0},    ;    
                {"MODELO"      ,"N", 2,0},    ;    
                {"SERIE"       ,"C", 1,0},    ;  
                {"SUB"         ,"C", 2,0},    ;            
                {"NUMERO"      ,"N", 6,0},    ;    
                {"CFOP"        ,"C", 4,0},    ;    
                {"VALORTOT"    ,"N",13,2},    ;    
                {"BASE"        ,"N",14,2},    ;    
                {"VALOR"       ,"N",14,2},    ;    
                {"ISENTA"      ,"N",14,2},    ;    
                {"OUTRAS"      ,"N",14,2},    ;    
                {"FRETE"       ,"C", 1,2},    ;    
                {"SITUACAO"    ,"C", 1,0}}   


      aDBF75:={ {"TIPO"        ,"C", 2,0}, ;
                {"DATAINI"     ,"SD",8,0}, ;
                {"DATAFIM"     ,"SD",8,0}, ;
                {"CODIGORED"   ,"C",14,0}, ;
                {"CLASSIPI"    ,"C", 8,0}, ;
                {"NOME"   ,"C",53,0}, ;                    
                {"UNID"        ,"C", 6,0}, ;
                {"IPI"         ,"N", 5,2}, ;
                {"ICM"         ,"N", 4,2}, ;                 
                {"REDICM"      ,"N", 4,2}, ;
                {"SUBICM"      ,"N", 4,2}}  

                
            

        
    ENDIF
    
    
    IF cTIPO="TABAUX" 
       cREG:="TABAUX"    
       aUF    := { "AC", "AL", "AM", "AP", "BA", "CE", "DF", "ES", "GO", ;
              "MA", "MG", "MS", "MT", "PA", "PB", "PE", "PI", "PR", ;
              "RJ", "RN", "RO", "RR", "RS", "SC", "SE", "SP", "TO" }

       cFOLDER:=GetFolder ( 'Pasta Arquivos tabelas auxiliares sped' )
       cFOLDER+="\"
	   mListaArq := Directory(cFOLDER+"*.*") //,"D")    include diretorios                       
       //mListaArq := Directory(cFOLDER+"*.txt","D")     //efinance nao tem sped no txt                      
       nLENX:=LEN(mListaArq)
       aCNPJ:={}
       cCAM   := PROFILESTRING( "sped.ini","PATH","SPEDTABELAS",HB_CWD())
       FOR I= 1 TO nLENX       
           cARQUIVO:= UPPER(mListaArq[i,1])
           cNOMEORI:= cARQUIVO  
           cARQIMP:=cFOLDER+cARQUIVO
           cARQUIVO:=STRTRAN(cARQUIVO,"SPEDCONTABIL_GLOBAL$SPEDCONTABIL_UF$","SPEDCONTABIL_GLOBAL$SPEDCONTABIL_UF_SIGLA_NOME$")
           cARQUIVO:=STRTRAN(cARQUIVO,"SPEDPISCOFINS_","")
           cARQUIVO:=STRTRAN(cARQUIVO,"SPEDCONTABIL_","")		
		   cARQUIVO:=STRTRAN(cARQUIVO,"SPEDECF_DINAMICA_","")
		   cARQUIVO:=STRTRAN(cARQUIVO,"SPEDECF_LOCAL","")
		   cARQUIVO:=STRTRAN(cARQUIVO,"SPEDECF_","")
           cARQUIVO:=STRTRAN(cARQUIVO,".TXT","") //sped nao tem extensao porem efinance tem .txt
           FOR H=1 TO 27 //tabelas codigos estaduais
               cARQUIVO:=STRTRAN(cARQUIVO,"SPEDFISCAL_"+aUF[H]+"$","$"+aUF[H]+"_")
           NEXT H           
           nPOS:=AT("$",cARQUIVo)
           IF nPOS>0
              cARQUIVO:=SUBSTR(cARQUIVO,nPOS+1)
              nPOS:=AT("$",cARQUIVo)
              IF nPOS>0              
                 cARQUIVO:=SUBSTR(cARQUIVO,1,nPOS-1)
              ENDIF                 
           ENDIF
           
           DO CASE //diFerencas nomes pis/confins
               CASE cARQUIVO="CL_CONS_AGUA"
                    cARQUIVO:="CONSUMO_AGUA"
               CASE cARQUIVO="CL_CONS_GAS"
                    cARQUIVO:="CONSUMO_GAS"
               CASE cARQUIVO="CL_CONS_ENERGIA"
                    cARQUIVO:="CONSUMO_ENERGIA"                                               
               CASE cARQUIVO="MOD_DOC"
                    cARQUIVO:="SINTDOC"
               CASE cARQUIVO="UF_COD_SIG"
                    cARQUIVO:="UF_CODIGO_SIGLA"
               CASE cARQUIVO="UNIDADES_DA_FEDERACAO"
                    cARQUIVO:="UF_CODIGO_SIGLA"
               CASE cARQUIVO="UF_SIG_NOM"
                    cARQUIVO:="UF_SIGLA_NOME"
               CASE cARQUIVO="TP_CT"
                    cARQUIVO:="TP_CONHEC_TRANS"
               CASE cARQUIVO="TP_CT_E"
                    cARQUIVO:="TIPO_CT_E"        
               CASE cARQUIVO="TIPO_CT"
                    cARQUIVO:="TP_CONHEC_TRANS"                        
               CASE cARQUIVO="CL_CONS_COMUN_TELECOM"
                    cARQUIVO:="CONSUMO_TELECOM"
               CASE cARQUIVO="SIT_TRIB_ICMS"
                    cARQUIVO:="CST_ICMS"
               CASE cARQUIVO="SIT_TRIB_IPI"
                    cARQUIVO:="CST_IPI"
               CASE cARQUIVO="SIT_TRIB_PIS"
                    cARQUIVO:="CST_PIS"
               CASE cARQUIVO="SIT_TRIB_COFINS"
                    cARQUIVO:="CST_COFINS"
               CASE cARQUIVO="PAIS_SISCOMEX"
                    cARQUIVO:="SISCOMEX_PAISES"
                CASE cARQUIVO="CNAE21"
                    cARQUIVO:="FO_CNAE2"
                CASE cARQUIVO="COD_CEST"
                    cARQUIVO:="CEST"
                CASE cARQUIVO="CBC_MOEDA"
                    cARQUIVO:="MOEDA"
               CASE cARQUIVO="MODELOS"
                    cARQUIVO:="SINTDOC"
            END CASE
              
			//esocial sao tbs   
		    lCHECTB:=.T.

            nFile := HB_FUse(cARQIMP)	
            cLINHA:=UPPER(HB_FREADLN())	
            HB_FSkip(1)			   
			cLINH2:=UPPER(HB_FREADLN())	
     	    HB_FUse()
			   
		    IF AT("MUNICIPIOS",cARQUIVO)>0	   
			   IF At("NOME_MUN,",cLINHA)>0 .OR. At("NOM_MUN,",cLINHA)>0
			      cARQUIVO:="MD10"
				  lCHECTB:=.F.
			   endif			   
            ENDIF
               
            IF AT("CNAE",cARQUIVO)>0   
			   IF At("CODCNAE,",cLINHA)>0
			      cARQUIVO:="FO_CNAE2"
				  lCHECTB:=.F.
			   endif
            ENDIF   

            IF AT("CNAECSV",cARQUIVO)>0   
			   cARQUIVO:="FO_CNAE2"
			   lCHECTB:=.F.
            ENDIF   
            IF AT("NATJUCSV",cARQUIVO)>0   
			   cARQUIVO:="NATUREZA_JURIDICA"
			   lCHECTB:=.F.
            ENDIF   
            IF AT("QUALSCSV",cARQUIVO)>0   
			   cARQUIVO:="QUALIF_SOCIO_CNPJ"
			   lCHECTB:=.F.
            ENDIF   
            IF AT("PAISCSV",cARQUIVO)>0   
			   cARQUIVO:="SISCOMEX_PAISES"
			   lCHECTB:=.F.
            ENDIF   


            IF AT("CFOP",cARQUIVO)>0 .AND. LEN(cARQUIVO)=4 //len evita cfop complemntares como cfop_creditos
			   IF At("DESC_CFOP,",cLINHA)>0
			      cARQUIVO:="MD04"
				  lCHECTB:=.F.
			   endif
            ENDIF
            
			   
			   IF At("OFICIAL GENERAL",cLINH2)>0
			      cARQUIVO:="ESOCIAL_CBO"
				  lCHECTB:=.F.
			   endif
	
            IF AT("PAISES",cARQUIVO)>0 .AND. cARQUIVO<>"SISCOMEX_PAISES"
    		   IF At("COD_PAIS,",cLINHA)>0
					    DO CASE
						   CASE At("1|CANADA",cLINH2)>0
						       cARQUIVO:="SISCOMEX_PAISES"   
							CASE At("ABU DHABI",cLINH2)>0
						       cARQUIVO:="SPED_PAISES" 
						   OTHERWISE
						    cARQUIVO:="PAISES" //usa codigo bacen importa
                        ENDCASE					
				  lCHECTB:=.F.
			   endif
		    ENDIF	   


            
		   if LEFT(cARQUIVO,2)="TB"    		       
               DO CASE
					CASE cARQUIVO="TB1205"
						cARQUIVO:="esocial_tab01" //    Categorias de Trabalhadores - eSocial
					CASE cARQUIVO="TB1206"
						cARQUIVO:="esocial_tab02" //    Grau de Exposição a Agentes Nocivos - eSocial
					CASE cARQUIVO="TB1207"
						cARQUIVO:="esocial_tab03" //    Tabela de Natureza das Rubricas da Folha de Pagamento - eSocial
					CASE cARQUIVO="TB1208"
						cARQUIVO:="esocial_tab04" //    Códigos e Alíquotas de Fpas/Terceiros - eSocial
					CASE cARQUIVO="TB1209"
						cARQUIVO:="esocial_tab05" //    Tipos de Inscrição - eSocial
					CASE cARQUIVO="TB1210"
					    DO CASE
						   CASE At("1|CANADA",cLINH2)>0
						       cARQUIVO:="SISCOMEX_PAISES"   
							CASE At("ABU DHABI",cLINH2)>0
						       cARQUIVO:="SPED_PAISES" 
						   OTHERWISE
						    cARQUIVO:="PAISES" //usa codigo bacen importa
                        ENDCASE
					CASE cARQUIVO="TB1211"
						cARQUIVO:="esocial_tab07" //    Resultado da Monitoração Biológica - eSocial 
					CASE cARQUIVO="TB1212"
						cARQUIVO:="esocial_tab08" // - Classificação Tributária - eSocial
					CASE cARQUIVO="TB12038"
						cARQUIVO:="esocial_tab09" // - Tipos de Arquivo - eSCocial
					CASE cARQUIVO="TB1214"
						cARQUIVO:="esocial_tab10" // - Tipos de Lotação - eSocial
					CASE cARQUIVO="TB1215"
						cARQUIVO:="esocial_tab11" // - Compatibilidade entre Categoria de Trabalhadores, Classificação Tributária e Tipos de Lotação - eSocial
					CASE cARQUIVO="TB1216"
						cARQUIVO:="esocial_tab13" //    Parte do corpo atingida - eSocial
					CASE cARQUIVO="TB1217"
						cARQUIVO:="esocial_tab14" //    Agente causador do Acidente de Trabalho - eSocial 
					CASE cARQUIVO="TB1218"
						cARQUIVO:="esocial_tab15" //    Agente Causador / Situação Geradora de Doença Profissional - eSocial 
					CASE cARQUIVO="TB1219"
						cARQUIVO:="esocial_tab16" //    Situação Geradora do Acidente de Trabalho - eSocial
					CASE cARQUIVO="TB1220"
						cARQUIVO:="esocial_tab17" //    Descrição da Natureza da Lesão - eSocial 
					CASE cARQUIVO="TB1863"
						cARQUIVO:="esocial_tab18" //    Motivos de Afastamento - eSocial
					CASE cARQUIVO="TB1820"
						cARQUIVO:="esocial_tab19" //    Motivos de Desligamento - eSocial
					CASE cARQUIVO="TB1254"
						cARQUIVO:="esocial_tab20" //    Tipos de Logradouros - eSocial
					CASE cARQUIVO="TB1224"
						cARQUIVO:="esocial_tab21" //    Fatores de Riscos Ambientais - eSocial 
					CASE cARQUIVO="TB1225"
						cARQUIVO:="esocial_tab22" //    Fator de Risco para Insalubridade/Periculosidade/Penosidade - eSocial
					CASE cARQUIVO="TB1226"
						cARQUIVO:="esocial_tab23" //    Aposentadoria Especial INSS - eSocial
					CASE cARQUIVO="TB1227"
						cARQUIVO:="esocial_tab24" //    Compatibilidade entre FPAS e Classificação Tributária - eSocial
					CASE cARQUIVO="TB1864"
						cARQUIVO:="esocial_tab26" //    Codificação de Acidente de Trabalho - eSocial
					CASE cARQUIVO="TB1228"
						cARQUIVO:="ESOCIAL_CBO" // "esocial_tab50" //    cbo
					CASE cARQUIVO="TB1229"
						cARQUIVO:="esocial_tab51" //    Tabela de Códigos de Terceiro - eSocial
					CASE cARQUIVO="TB1230"
						cARQUIVO:="esocial_tab52" //    Tabela de Horários do eSocial
					CASE cARQUIVO="TB1231"
						cARQUIVO:="esocial_tab53" //    Tabela de Naturezas Jurídicas - eSocial
					CASE cARQUIVO="TB12006"
						cARQUIVO:="esocial_tab54" //    Tabela de Rubricas do eSocial
					CASE cARQUIVO="TB1407"
						cARQUIVO:="esocial_tab55" //    Compatibilidade - Categoria x Classificação Tributária x Motivo do Desligamento - eSocial
					CASE cARQUIVO="TB1234"
						//cARQUIVO:="cod_cnae" //esocial_tab56" //    Tabela de Classificação Nacional de Atividades Econômicas (CNAE) - eSocial
						cARQUIVO:="fo_cnae2"
					CASE cARQUIVO="TB11957"
						cARQUIVO:="esocial_tab57" //    Tabela para Cálculo da Contribuição Previdenciária do Empregado - eSocial
					CASE cARQUIVO="TB1236"
						cARQUIVO:="esocial_tab58" //    Tabela para Cálculo da Retenção do Imposto de Renda - eSocial
					CASE cARQUIVO="TB1237"
						cARQUIVO:="esocial_tab59" //    Tipo de Decisão Judicia Administrativa - eSocial
					CASE cARQUIVO="TB1238"
						cARQUIVO:="esocial_tab60" //    Tabela de CID - eSocial   
					CASE cARQUIVO="TB1258"
						cARQUIVO:="esocial_tab61" //    Tabela de Cargos do eSocial
					CASE cARQUIVO="TB1257"
						cARQUIVO:="esocial_tab62" //    Tabela de Grupos CBO - eSocial
					CASE cARQUIVO="TB1289"
						cARQUIVO:="esocial_tab63" //    Tabela de Relacionamento Rubricas Usuais por Categoria - eSocial
					CASE cARQUIVO="TB1242"
						cARQUIVO:="esocial_tab64" //    Tabela de Lotações Tributárias do eSocial
					CASE cARQUIVO="TB11962"
						cARQUIVO:="esocial_tab65" //    Tabela de Cálculo do Salário Família do eSocial
					CASE cARQUIVO="TB1244"
						cARQUIVO:="esocial_tab66" //    Tabela Referência para Alíquotas e Descontos - eSocial
					CASE cARQUIVO="TB1399"
						cARQUIVO:="esocial_tab67" //    Tabela de Causas do Afastamento MTE - eSocial
					CASE cARQUIVO="TB11999"
						cARQUIVO:="esocial_tab68" //    Tabela de Rubricas Rescisórias do MTE - eSocial
					CASE cARQUIVO="TB1536"
						cARQUIVO:="esocial_tab69" //    Informações Adicionais da Rescisão MTE - eSocial
					CASE cARQUIVO="TB1211"
						cARQUIVO:="esocial_tab70" //    Tabela de Tipos de Admissão do Trabalhador - eSocial
					CASE cARQUIVO="TB1868"
						cARQUIVO:="esocial_tab71" //    Tabela de Tipos de CAT - eSocial
					CASE cARQUIVO="TB1869"
						cARQUIVO:="esocial_tab72" //    Tabela de Tipos de Atestados de Saúde Ocupacional - eSocial
					CASE cARQUIVO="TB1870"
						cARQUIVO:="esocial_tab73" //    Tabela de Tipos de Aviso Prévio - eSocial
					CASE cARQUIVO="TB1871"
						cARQUIVO:="esocial_tab74" //    Tabela de Motivos de Cancelamento de Aviso Prévio" //    eSocial
					CASE cARQUIVO="TB1872"
						cARQUIVO:="esocial_tab75" //    Tabela de Tipos de Reintegração - eSocial
					CASE cARQUIVO="TB737" .OR. cARQUIVO="TB13003"
						cARQUIVO:="municipios"
					CASE cARQUIVO="TB348"   //verificar equivalente e social
						cARQUIVO:="uf_sigla_nome"
			  ENDCASE 
		   Endif	   
               
			   

           cCAM   := PROFILESTRING( "sped.ini","PATH","SPEDTABELAS",HB_CWD())
		   if at("ESOCIAL_TAB",UPPER(cARQUIVO))>0
		      cCAM   := PROFILESTRING( "sped.ini","PATH","FOLHA",HB_CWD())
		   endif
           
           IF SUBSTR(cARQUIVO,3,1)="_" .and. ASCAN(aUF,LEFT(cARQUIVO,2))>0
              cCAM+=LEFT(cARQUIVO,2)+"\"
           endif

           lZAP:=.T.
		   //case para upgrade tabelas padrao LZAP:=.F. virara false para nao apagar os dados existente
		   DO CASE
		      CASE upper(cARQUIVO)="MD10"
			       lZAP:=.F.
				   cCAM   := PROFILESTRING( "sped.ini","PATH","CEP",HB_CWD())
		      CASE upper(cARQUIVO)="SPED_PAISES" .OR. upper(cARQUIVO)="SISCOMEX_PAISES" 
			       lZAP:=.T.
				   cCAM   := PROFILESTRING( "sped.ini","PATH","SPEDTABELAS",HB_CWD())
		      CASE upper(cARQUIVO)="PAISES"
			       lZAP:=.F.
				   cCAM   := PROFILESTRING( "sped.ini","PATH","CEP",HB_CWD())
		      CASE upper(cARQUIVO)="MD04"
			       lZAP:=.F.
				   cCAM   := PROFILESTRING( "sped.ini","PATH","FISCAL",HB_CWD())
		      CASE upper(cARQUIVO)="CST_COFINS"
			       lZAP:=.F.
				   cCAM   := PROFILESTRING( "sped.ini","PATH","FISCAL",HB_CWD())
		      CASE upper(cARQUIVO)="CST_PIS"
			       lZAP:=.F.
				   cCAM   := PROFILESTRING( "sped.ini","PATH","FISCAL",HB_CWD())
		      CASE upper(cARQUIVO)="CST_IPI"
			       lZAP:=.F.
				   cCAM   := PROFILESTRING( "sped.ini","PATH","FISCAL",HB_CWD())
		      CASE upper(cARQUIVO)="CST_ICMS"
			       lZAP:=.F.
				   cCAM   := PROFILESTRING( "sped.ini","PATH","SINTEGRA",HB_CWD())
		      CASE upper(cARQUIVO)="SINTDOC"
			       lZAP:=.F.
				   cCAM   := PROFILESTRING( "sped.ini","PATH","FISCAL",HB_CWD())
		      CASE upper(cARQUIVO)="MD05"
			       lZAP:=.F.
				   cCAM   := PROFILESTRING( "sped.ini","PATH","CEP",HB_CWD())
		      CASE upper(cARQUIVO)="MD05X"
			       lZAP:=.F.
				   cCAM   := PROFILESTRING( "sped.ini","PATH","FISCAL",HB_CWD())
		      CASE upper(cARQUIVO)="CEST"
			       lZAP:=.F.
				   cCAM   := PROFILESTRING( "sped.ini","PATH","FISCAL",HB_CWD())
		      CASE upper(cARQUIVO)="FO_CNAE2"
			       lZAP:=.F.
				   cCAM   := PROFILESTRING( "sped.ini","PATH","FOLHA",HB_CWD())
		      CASE upper(cARQUIVO)="NFECRET"
			       lZAP:=.F.
				   cCAM   := PROFILESTRING( "sped.ini","PATH","NFECNPJ",HB_CWD())
		      CASE upper(cARQUIVO)="MOEDA"  
			       lZAP:=.F.
				   cCAM   := PROFILESTRING( "sped.ini","PATH","SPEDTABELAS",HB_CWD())
		   ENDCASE
			   
           
            IF ! FILE(cCAM+cARQUIVO+".DBF") .AND. mdg("Criar: "+cCAM+cARQUIVO)
               criatabelasped(cARQIMP,cCAM+cARQUIVO)
            ENDIF
               
               
            IF if(lZAP,netzap(cCAM+cARQUIVO),.t.) //if lzap zera o arquivo caso contrario entra na rotina de importacao
               IF NETUSE(cCAM+cARQUIVO)    
                   nGRV:=FCREATE(cARQUIVO+".SQL")
                   cCRIASQL:="CREATE TABLE "+cARQUIVO
                   cCRIASQL+=" ("
                   cCRIASQL+="ID_ESCT   BIGINT,"
                   aUSO:=DBSTRUCT()
                   FOR K=1 TO LEN(aUSO)
                       cCRIASQL+=alltrim(aUSO[K][1])+" "
                       DO CASE
                          CASE aUSO[K][2]="C"
                               IF aUSO[K][3]=254
                                 cCRIASQL+="VARCHAR (512)"
                               ELSE
                                 cCRIASQL+="VARCHAR ("+ALLTRIM(STR(aUSO[K][3]))+")"
                               ENDIF  
                          CASE aUSO[K][2]="D"
                               cCRIASQL+="SMALLDATETIME"
                          CASE aUSO[K][2]="N"                           
                               cCRIASQL+="DECIMAL ("+ALLTRIM(STR(aUSO[K][3]))+","+ALLTRIM(STR(aUSO[K][4]))+")"                                
                       ENDCASE
                       cCRIASQL+=" ," 
                   NEXT 
                   cCRIASQL+="HASH      BIGINT"
                   cCRIASQL+="); "
                   
                   FWRITE(nGRV,cCRIASQL+HB_OSNEWLINE())
                   
                   nFile := HB_FUse(cARQIMP)
                   nLASTREC:=hb_flastrec()
                   zei_fort( nLASTREC,,,0)
                 //  hb_fgotop()
                   HB_FUse()
           
                   cDELIM:=FDELIM (cARQIMP,1024) //acha o delimitador chr(13)+chr(10) dos ou chr(10) linux usado abaixo no freadline
                   nFILE:=FOPEN(cARQIMP) //abre o arquivo
                   nLINHA:=1

                   IF AT("CNAECSV",CNOMEORI)>0   .OR. AT("NATJUCSV",CNOMEORI)>0 .OR.  AT("QUALSCSV",CNOMEORI)>0 .OR. AT("PAISCSV",CNOMEORI)>0
                   ELSE
                       cLINHA:=FREADLINE (nFILE, 1024 ,.T. ,cDELIM)
                       //HB_FSkip(1) //1o. linha reader
                   ENDIF

                   WHILE .T. //.NOT. HB_FEof()
                      //cLINHA:=HB_FREADLN() 
                      cLINHA:=FREADLINE (nFILE, 1024 ,.T. ,cDELIM) //FREADLINE (handle, line_len,lremchrexp,cDELI)
                      IF cLINHA='__FINAL__' //freadline retorna __FINAL__   quando nao e mais linhas
                         EXIT
                      ENDIF
                      
                      IF AT("CNAECSV",CNOMEORI)>0   .OR. AT("NATJUCSV",CNOMEORI)>0 .OR.  AT("QUALSCSV",CNOMEORI)>0 .OR. AT("PAISCSV",CNOMEORI)>0
                         aCAMPOS:=SplitCommaAspas(cLINHA)
                      ELSE
                          aCAMPOS:=HB_ATokens(cLINHA,"|")                            
                      ENDIF  
                      MDS(cLINHA)
                      cSUBLINHA:=""
                      GravaRegEFD(cARQUIVO,1)
                      cTEXTO:="insert into "+cARQUIVO +" values ("
                      cTEXTO+=STRVAL(nLINHA)+","  //cTEXTO+=STRVAL(hb_FRecNo()-1)+"," //1o. linha reader                            
                      cTEXTO+=cSUBLINHA
                      cTEXTO+="1) ;"
                      
                      nLINHA++
                      FWRITE(nGRV,cTEXTO+HB_OSNEWLINE())
                      //HB_FSkip(1)
                   ENDDO
                   //HB_FUse()
                   fclose(nfile)
                   fclose(nGRV)
    
                   filedelete(cARQIMP)
               ENDIF
               DBCLOSEALL()
            ENDIF
            MDS("...")                  
       NEXT I
       RETURN 
    ENDIF
   
    IF cTIPO="EFD" .OR.  cTIPO="ECD" .OR.  cTIPO="EFT" .OR.  cTIPO="MANAD"  .OR.  cTIPO="FCONT"
       cARQIMP := Getfile ( { {'Arquivos SPEDs','*.*'} } , 'Abrir Arquivo' , HB_CWD() , .f. , .t. ) 
       IF EMPTy(cARQIMP)
          RETURN
       ENDIF
       cCAM   := PROFILESTRING( "sped.ini","CNPJXML.DBF","CAMINHO",HB_CWD())+"CNPJXML"
       IF ! netuse(cCAM)
          return
       endif
       cCAM   := PROFILESTRING( "sped.ini","DANFE2.DBF","CAMINHO",HB_CWD())+"DANFE2"
       IF ! netuse(cCAM)
          DBCLOSEALL()
          return
       endif
       cCAM   := PROFILESTRING( "sped.ini","XMLPEND.DBF","CAMINHO",HB_CWD())+"XMLPEND"
       NETPACK(cCAM)
       IF ! netuse(cCAM)
          DBCLOSEALL()
          return
       endif
       cCAM   := PROFILESTRING( "sped.ini","REGH010LXVAL.DBF","CAMINHO",HB_CWD())+"REGH010LXVAL"
       IF ! NETUSE(cCAM)
          DBCLOSEALL()
          RETURN
       ENDIF
       cCAM   := PROFILESTRING( "sped.ini","REGC170FOR.DBF","CAMINHO",HB_CWD())+"REGC170FOR"
       IF ! NETUSE(cCAM)
          DBCLOSEALL()
          RETURN
       ENDIF

      cCAMINHO   := PROFILESTRING( "sped.ini","MD10.DBF","CAMINHO",HB_CWD())+"MD10"
      if ! netuse(cCAMINHO,"DBFCDX")
         dbcloseall()
         return
      endif
       
       
       DO CASE
          CASE cTIPO="EFD" //Sped Fiscal
               cCAM   := PROFILESTRING( "sped.ini","PATH","SPEDEFD",HB_CWD()) 
          CASE cTIPO="ECD" //Sped Contabil
               cCAM   := PROFILESTRING( "sped.ini","PATH","SPEDECD",HB_CWD()) 
          CASE cTIPO="EFT" //Sped Contribuicoes Tributos
               cCAM   := PROFILESTRING( "sped.ini","PATH","SPEDEFT",HB_CWD()) 
          CASE cTIPO="MANAD"
               cCAM   := PROFILESTRING( "sped.ini","PATH","MANAD",HB_CWD())               
          CASE cTIPO="FCONT"
               cCAM   := PROFILESTRING( "sped.ini","PATH","FCONT",HB_CWD())               
               
       END CASE
       
        
        
       mListaArq := Directory(cCAM+"reg*.dbf","D")                           
       nLENX:=LEN(mListaArq)
       aDBFREG:={}
       FOR I= 1 TO nLENX       
           cARQUIVO:= UPPER(mListaArq[i,1]) 
           IF cARQUIVO<>"REGH010LXVAL.DBF"           
              aadd(Adbfreg,tiraext(cARQUIVO))
           ENDIF   
       next i
        
        
/*  blocos            
0 Abertura, Identificação e Referências
A Documentos Fiscais - Serviços (ISS)(NFS)
C Documentos Fiscais I – Mercadorias (ICMS/IPI)(NFE)
D Documentos Fiscais II – Serviços (ICMS)(CTE)
E Apuração do ICMS e do IPI
F Demais Documentos e Operações
G Controle do Crédito de ICMS do Ativo Permanente – CIAP
H Inventário Físico
M Apuração da Contribuição e Crédito de PIS/PASEP e da COFINS e-lalur
P Apuração da Contribuição Previdenciária sobre a Receita Bruta
1 Complemento da Escrituração – Controle de Saldos de Créditos e de Retenções,Operações Extemporâneas e Outras Informações
9 Controle e Encerramento do Arquivo Digital                
--futuros
--B Servicos
--K SPED e-social
*/
         
        for x=1 to len(aDBFREG)
            if ! netzap(cCAM+aDBFREG[X])
               return
            endif    
        next x
        for x=1 to len(aDBFREG)
            if ! netUSE(cCAM+aDBFREG[X])
               dbcloseall()
               return
            endif    
        next x        
    ENDIF
    
    IF cTIPO="IBPTAX"
       cARQIMP:=Getfile ( { {'Arquivos IBPTAX','*.CSV'} } , 'Abrir Arquivo' , HB_CWD() , .f. , .t. )
       cCAM   := PROFILESTRING("sped.ini","FI_NBM.DBF","CAMINHO",HB_CWD())+"FI_NBM"
       IF ! netuse(cCAM)
          return
       endif
       cCAM   := PROFILESTRING("sped.ini","FI_NBMS.DBF","CAMINHO",HB_CWD())+"FI_NBMS"
       IF ! netuse(cCAM)
          return
       endif
       lATUdescri:=MDG("Atualizar Descricoes")
       cARQNBM:="NBM_"+ArqLogDataHora("txt")
       cARQNBMLOGIX:="LOGIX_"+ArqLogDataHora("sql")
       cARQNBMPROTHEUS:="protheus_"+ArqLogDataHora("sql")
       nNBM:=fcreate(cARQNBM)
       nNBMPROTHEUS:=fcreate(cARQNBMPROTHEUS)
    ENDIF
    
    nFile := HB_FUse(cARQIMP)
    nLASTREC:=hb_flastrec()
    zei_fort( nLASTREC,,,0)
    hb_fgotop()
    IF cTIPO="EFD"  .OR. cTIPO="ECD" .OR. cTIPO="EFT" .OR. cTIPO="FCONT" .OR. cTIPO="MANAD"                                                        
       cARQERRO:=cARQIMP+"_inconsistenscias_"+ArqLogDataHora("txt")
       nLOGERRO:=fcreate(cARQERRO)
       cARQERRO:=cARQIMP+"_inventario_"+ArqLogDataHora("csv")
       nLOGDADO:=fcreate(cARQERRO)        
       fwrite(nlOGDADO,"Item|Valor_Custo/Inv|Valor_Referencia|Obs"+hb_osnewline())                    
    ENDIF   
        
    

aEFD150:={ {"SEP"      ,"C",  1,0}, ;
           {"REG"     ,"C",  4,0}, ; 
           {"CODPART"  ,"C", 60,0}, ;
           {"NOME"     ,"C",100,0}, ;
           {"BACEN"    ,"C",  5,0}, ;
           {"CNPJ"     ,"C", 14,0}, ;
           {"CPF"      ,"C", 11,0}, ;
           {"IE"       ,"C", 14,0}, ;
           {"CODIBGE"  ,"C",  7,0}, ;
           {"SUFRAMA"  ,"C",  9,0}, ;
           {"ENDERECO" ,"C", 60,0}, ;
           {"NUMEND"   ,"C", 10,0}, ;
           {"COMPLEM"  ,"C", 60,0}, ;
           {"BAIRRO"   ,"C", 60,0}}

aPARCOD:={}
aPARDADOS:={}           
aBLOCO:={}
aBLQTD:={}

      
      DO WHILE .NOT. HB_FEof()
         cLINHA:=HB_FREADLN()  
         MDS(cLINHA)
         IF cTIPO="SINTEGRA"
           cREG:=LEFT(cLINHA,2)
           cSUBREG:=""
           IF cREG="60" .OR. cREG="88"
              cSUBREG:=SUBSTR(cLINHA,3,1)
           ENDIF
         ENDIF             
         IF cTIPO="MANAD"  
            
            cLINHA:="|"+cLINHA //no manad nao tem o | no comeco da linha 
         ENDIF
         IF cTIPO="EFD" .OR. cTIPO="ECD" .OR. cTIPO="EFT"  .OR. cTIPO="FCONT" .OR. cTIPO="MANAD"                                               
            aCAMPOS:=HB_ATokens(cLINHA,"|") //como a linha comecao com | somar mais um na posicao
            cREG:=aCAMPOS[2]      
            IF cREG="9999"            
               EXIT
            ENDIF               
         ENDIF
         IF cTIPO="IBPTAX"            
            aCAMPOS:=HB_ATokens(cLINHA,";")
            cREG:="IBPTAX"
         Endif
         IF cREG="0000" .AND.  cTIPO<>"MANAD"                                                 
            IF EMPTY(aCAMPOS[5])         
              fWRITE(nLOGERRO,DTOC(STR2DATA(aCAMPOS[7]))+" a "+DTOC(STR2DATA(aCAMPOS[8]))+hb_osnewline())
            ELSE
              fWRITE(nLOGERRO,DTOC(STR2DATA(aCAMPOS[5]))+" a "+DTOC(STR2DATA(aCAMPOS[6]))+hb_osnewline())
            ENDIF  
         ENDIF
         IF cREG="C100" .OR. cREG="D100" .OR. cREG="A100"
            nPOS:=ASCAN(aPARCOD,aCAMPOS[5])            
            cUF:="UF"
            cUFNUM:="99"
            cCNPJ:="XXXXXXXXXXXXXX"            
            IF nPOS>0
               cCNPJ:=aPARDADOS[nPOS,1]
               cUF:=aPARDADoS[nPOS,2]
               cUFNUM:=aPARDADoS[nPOS,3]       
            ENDIF   
         ENDIF
         IF cREG="C100".OR.cREG="D100"
            cMOD:=ACAMPOS[6]
            cCHAVE:=ACAMPOS[10]
            cNFF:=aCAMPOS[9]
            lACHEI:=.F.
            IF cREG="D100"
               cCHAVE:=ACAMPOS[11]
               cNFF:=aCAMPOS[10]               
            ENDIF
            IF ! empty(cCHAVE)
               IF cCNPJ="XXXXXXXXXXXXXX"            
                  cCNPJ:=SUBSTR(cCHAVE,7,14)            
               ENDIF 
               IF IDNAOIEB(cCHAVE) 
                  DBSELECTAR("danfe2")
                  dbsetorder(1)
                  dbgotop()
                  if dbseek(cCHAVE)                
                     lACHEI:=.T.
                     if danfe2->cancelada="S"
                        fwrite(nLOGERRO,"Nota "+cCNPJ+"/"+cNFF+"/"+cCHAVE+" Cancelada "+HB_OSNEWLINE())               
                     endif                  
                     if danfe2->cancelada="I"
                        fwrite(nLOGERRO,"Nota "+cCNPJ+"/"+cNFF+"/"+cCHAVE+" Inutilizada "+HB_OSNEWLINE())               
                     endif                                    
                  endif
               ENDIF   
            ENDIF   
            IF ! lACHEI
               DBSELECTAR("danfe2")
               dbsetorder(2)
               dbgotop()
               if dbseek(CCNPJ+cNFF)
                  IF IDNAOIEB(cCHAVE) 
                     fwrite(nLOGERRO,"Nota "+cCNPJ+"/"+cNFF+"/"+cCHAVE+" Outra Chave "+DANFE2->ID+HB_OSNEWLINE())               
                  endif   
                  lACHEI:=.T. 
               endif            
            ENDIF
            IF ! lACHEI
               IF cMOD="55".OR.cMOD="57"
                  IF aCAMPOS[7]<>"02".AND.aCAMPOS[7]<>"05" //situacao cancelada/numeracao inutilizada
                     cFILEDANFE := pegcamxml(cCHAVE,cCNPJ)                        
                     cDESTINO   :=cNFECNPJ+"NFE"+cCHAVE+".xml"                        
                     IF FILE(cFILEDANFE)
                        IF IDNAOIEB(cCHAVE) 
                           FILECOPY(cFILEDANFE,cDESTINO)
                           fwrite(nLOGERRO,"Recopiada para memorizacao: "+cCHAVE+hb_osnewline())
                        ENDIF   
                     ELSE
                        IF EMPTY(cCHAVE)
                           Fwrite(nLOGERRO,"Falta Preencher chave nfe: "+aCAMPOS[5]+"/"+cNFF+"/"+cMOD+HB_OSNEWLINE())  
                        ELSE
                           Fwrite(nLOGERRO,"Falta xml Nota: "+aCAMPOS[5]+"/"+cNFF+"/"+cMOD+"/"+cCHAVE+HB_OSNEWLINE())  
                           dbselectar("XMLPEND")                        
                           dbgotop()
                           if ! dbseek(cCHAVE)
                              netrecapp()
                              field->id:=cCHAVE
                              dbunlock()
                           ENDIF
                        ENDIF   
                     ENDIF                      
                  else
                   // Fwrite(nLOGERRO,"aviso Nota cancelada/inutilizaca: "+aCAMPOS[5]+"/"+cNFF+"/"+cMOD+"/"+cCHAVE+HB_OSNEWLINE())               
                  endif  
               else
                  if empty(cCHAVE)
                     // Fwrite(nLOGERRO,"aviso Falta xml Nota outros modelos: "+aCAMPOS[5]+"/"+cNFF+"/"+cMOD+"/"+cCHAVE+HB_OSNEWLINE())               
                  ELSE
                     cFILEDANFE := pegcamxml(cCHAVE,cCNPJ) 
                     cDESTINO   :=cNFECNPJ+"NFE"+cCHAVE+".xml"                        
                     IF FILE(cFILEDANFE)
                        IF IDNAOIEB(cCHAVE) 
                           FILECOPY(cFILEDANFE,cDESTINO)
                           fwrite(nLOGERRO,"Recopiada para memorizacao"+cCHAVE)
                        ENDIF   
                     ELSE
                        Fwrite(nLOGERRO,"Nota com chave xml lancado modelos diferente 55/57: "+aCAMPOS[5]+"/"+cNFF+"/"+cMOD+"/"+cCHAVE+HB_OSNEWLINE())                                                      
                     ENDIF    
                  endif                  
               ENDIF   
            ENDIF   
         ENDIF
         lTEMBLOCO:=.F.         
         DO CASE            
            CASE cREG="IBPTAX"
                 aCAMPOS[4]:=strtran(aCAMPOS[4],"-","")    
                 aCAMPOS[4]:=strtran(aCAMPOS[4],"'"," ")    
                 aCAMPOS[4]:=strtran(aCAMPOS[4],CHR(34),"")    
                 //versao antinga
                 //codigo;ex;tabela;NOME;aliqNac;aliqImp
                 // 1      2   3       4         5        6  
                 // tabela 0 ncm 1 servicos 2 titulos servicos
                 //
                 //versao nova
                 //codigo;ex;tipo;NOME;nacionalfederal;importadosfederal;estadual;municipal;vigenciainicio;vigenciafim;chave;versao;fonte
                 // 1      2   3       4         5             6                   7      8
                 //codigo;ex;tipo;NOME;nacionalfederal;importadosfederal;estadual;municipal;vigenciainicio;vigenciafim;chave;versao;fonte
                 IF (aCAMPOS[3]="0".OR.aCAMPOS[3]="1".OR.aCAMPOS[3]="2").AND.EMPTY(aCAMPOS[2]) //IBPTAX tambem contem NBM/servicos                  
                    IF aCAMPOS[3]="0"                                //traz 2 vezes ncm um normal outro ex 
                       dbselectar("FI_NBM")  
                       fwrite(nNBM,aCAMPOS[1]+HB_OSNEWLINE())   
                       cPROTHEUS:="INSERT INTO syd010 (yd_tec,yd_desc_p,r_e_c_n_o_) VALUES ('" +aCAMPOS[1] + "','" + aCAMPOS[4]+"' , "+str(hb_FRecNo()-1,0)+" ) ; "
                       fwrite(nNBMPROTHEUS,cPROTHEUS+HB_OSNEWLINE())                           
                    ELSE
                       dbselectar("FI_NBMS")
                    ENDIF                    
                    dbgotop()
                    IF ! DBSEEK(aCAMPOS[1])
                       netrecapp()
                       field->numeronbm:=aCAMPOS[1]
                       field->descri:=aCAMPOS[4]                       
                    ELSE
                       netreclock()
                    ENDIF
                    if lATUdescri
                       field->descri:=aCAMPOS[4]
                    ENDIF                      
                    field->ex:=VAL(aCAMPOS[2])                    
                    field->aliqnac:=val(acampos[5]) //federal nacional
                    field->aliqimp:=val(Acampos[6]) //federal importado
                    field->aliqest:=val(Acampos[7]) //estadual
                    field->aliqmun:=val(Acampos[8]) //municipal

                    //     5           7       8
                    //federalnac+estadual+municipal  //  aliquota nacional
                    //     6           7         8
                    //federalimp+estadual+municipal  //  aliquota importados

                    
                    if empty(fiELD->tipo)        
                       nLENNBM:=LEN(ALLTRIM(NUMERONBM))                    
                       IF nLENNBM=4
                          fiELD->tipo:="T"
                       ENDIF
                       IF nLENNBM=6.AND.aCAMPOS[3]="0"
                          fiELD->tipo:="S"
                       ENDIF
                       IF nLENNBM=8.AND.aCAMPOS[3]="0"
                          fiELD->tipo:="C"
                       ENDIF
                       IF nLENNBM=9.AND.aCAMPOS[3]="1"
                          fiELD->tipo:="C"
                       ENDIF
                    endif
					FIELD->DATAIMP:=DATE()
                    dbunlock()      
                 ENDIF 
            CASE cREG="0150" .AND. ( cTIPO="EFD" .OR.  cTIPO="EFT"  )
                 xCNPJ:=aCAMPOS[6]
                 IF EMPTY(xcnpj)
                    xCNPJ:=aCAMPOS[7]
                 endif                 
                 cUF:=CODUF(SUBSTR(aCAMPOS[9],1,2))
                 aadd(aPARcod,ACAMPOs[3])
                 aadd(AParDados,{xCNPJ,cUF,SUBSTR(aCAMPOS[9],1,2)})                 
                 if VALCGC(Xcnpj,,.F.) //! empty(Xcnpj).and. (VALCGC(Xcnpj,,.F.)  .OR. Valcpf( XCNPJ ,.F.))
                     DBSELECTAR("CNPJXML")
                     dbgotop()
                     if ! dbseek(XCNPJ)
                         netrecapp()
                         CNPJXML->CNPJ:=XCNPJ
                         CNPJXML->UF:=CUF
                     ELSE
                        netreclock()   
                     ENDIF   
                     FOR X=3 TO 14
                          cCAMPO:=aEFD150[X][1] 
                          eVALOR:=aCAMPOS[X]
                          IF X<>6.AND.X<>7 //cnpj cpf acima
                            IF EMPTY(&cCAMPO.).AND.! EMPTY(eVALOR)
                                CNPJXML->&cCAMPO.=eVALOR
                            ENDIF
                          ENDIF  
                     NEXT X
                     CnpjxmlIbge()
                     dbunlock()
                 ENDIF
                 GravaRegEFD()
            case cREG="0200"  .AND. ( cTIPO="EFD" .OR.  cTIPO="EFT" )                 
                 if aCAMPOS[9]="0" .and. len(Acampos[9])=1 //ncm com 0
                    aCAMPOS[9]=""                 
                 endif
                 if EMPTY(aCAMPOS[9])
                    // Fwrite(nLOGERRO,"Item sem NCM: "+aCAMPOS[3]+HB_OSNEWLINE())               
                 endif
                 GravaRegEFD()
            case cREG="A100"   .AND. ( cTIPO="EFD" .OR.  cTIPO="EFT" )                
                 if EMPTY(aCAMPOS[10])
                     aCAMPOS[10]:=cUFNUM+SUBSTR(aCAMPOS[11],7)+SUBSTR(aCAMPOS[11],3,2)+CCNPJ+"SE"+STRZERO(VAL(aCAMPOS[7]),3)+STRZERO(VAL(aCAMPOS[9]),9)+"1"+STRZERO(VAL(aCAMPOS[9]),8)+"X"            
                 endif
                 GravaRegEFD() 
            case cREG="C100"  .AND. ( cTIPO="EFD" .OR.  cTIPO="EFT" )                 
                 if EMPTY(aCAMPOS[10])
                     aCAMPOS[10]:=cUFNUM+SUBSTR(aCAMPOS[11],7)+SUBSTR(aCAMPOS[11],3,2)+CCNPJ+STRZERO(VAL(aCAMPOS[6]),2)+STRZERO(VAL(aCAMPOS[8]),3)+STRZERO(VAL(aCAMPOS[9]),9)+"1"+STRZERO(VAL(aCAMPOS[9]),8)+"X"            
                 endif
                 cCHAVEC100:=aCAMPOS[10]
                 GravaRegEFD() 
            case cREG="C170"    .AND. ( cTIPO="EFD" .OR.  cTIPO="EFT" )               
                 aCAMPOS[39]:=cCHAVEC100
                 GravaRegEFD() 
            case cREG="D100"   .AND. ( cTIPO="EFD" .OR.  cTIPO="EFT" )                   
                 if EMPTY(aCAMPOS[11])
                    aCAMPOS[11]:=cUFNUM+SUBSTR(aCAMPOS[12],7)+SUBSTR(aCAMPOS[12],3,2)+CCNPJ+STRZERO(VAL(aCAMPOS[8]),2)+STRZERO(VAL(aCAMPOS[8]),3)+STRZERO(VAL(aCAMPOS[10]),9)+"1"+STRZERO(VAL(aCAMPOS[10]),8)+"X"            
                 endif
                 GravaRegEFD() 
            CASE cTIPO="SINTEGRA"
                 GravaRegSint("SINT"+cREG+cSUBREG)
            CASE SUBSTR(cREG,2,3)="001" //Abertura      Bloco 3 digitos finais      
            CASE SUBSTR(cREG,2,3)="990" //totalizadores bloco 3 digitos finais
            CASE SUBSTR(cREG,1,1)="9" //totalizadores 
            CASE cTIPO="MANAD"
                 GravaRegEFD()                                    
            OTHERWISE                        
                 GravaRegEFD()                                    
         ENDCASE
         zei_fort(nLASTREC,,,1)
         if SUBSTR(cREG,1,1)="9" //Totalizadores
            lTEMBLOCO:=.t.
         endif
         if SUBSTR(cREG,2,3)="990" //Totalizadores
            lTEMBLOCO:=.t.
         endif
         if SUBSTR(cREG,2,3)="001" //Abertura Bloco
            lTEMBLOCO:=.t.
         endif         
         IF ! lTEMBLOCO
            nPOSBLO:=ASCAN(aBLOCO,cREG)
            IF nPOSBLO=0
               AADD(aBLOCO,cREG)
               AADD(aBLQTD,1)
            ELSE
               aBLQTD[nPOSBLO]+=1
            ENDIF
         ENDIF 
         HB_FSkip(1)
      ENDDO
      HB_FUse()
 
      IF LEN(aBLOCO)>0
         hb_memowrit("blocos.TXT",strval(aBLOCO)) 
         hb_memowrit("blocosq.TXT",strval(aBLQTD)) 
      ENDIF   
      
      IF cTIPO="EFD"   .OR. cTIPO="EFT"                                    

         dbselectar("regh010")
         dbgotop()
         while ! eof()
             cCOD_ITEM:=ALLTRIM(regh010->cod_item)
             nVL_UNIT:= regh010->vl_unit
             MDS("Checando valor Inventario "+cCOD_ITEM)
             if nVL_UNIT=0
                fwrite(nLOGERRO,"Item se valor bloco H Inventario: "+CCod_item+hb_osnewline())   
                fwrite(nlOGDADO,CCod_item+"|"+str(0,14,6)+"|"+STR(0,14,6)+"|Sem Valor Custo/Inventario"+hb_osnewline())                    
             else               
                dbselectar("regh010lxval")
                dbsetorder(2)
                dbgotop()
                if dbseek(cCOD_ITEM)
                   while cCOD_ITEM=alltrim(regh010lxval->cod_item) .and. ! regh010lxval->(eof())
                         nVALXVAL:=round((regh010lxval->VL_UNIT)+0.01,2)
                         if nVL_UNIT>nVALxval .AND. nVALxval>0
                            if regh010lxval->tipopreco="L".and. len(CCod_item)=12
                               //somente itens final 12
                               fwrite(nLOGERRO,"valor bloco H Inventario: "+Ccod_item+str(nVL_UNIT,14,6)+" maior lista preco "+STR(NVALxval,14,6)+hb_osnewline())    
                               fwrite(nlOGDADO,Ccod_item+"|"+str(nVL_UNIT,14,6)+"|"+STR(NVALxval,14,6)+"|Maior Lista Preco"+hb_osnewline())    
                            endif
                            if regh010lxval->tipopreco="C" .and. left(CCod_item,2)<>'MO' .and. len(CCod_item)<>12  .and. len(CCod_item)<>14
                                      //contrato mo só operacao no custo ja somou materia prima
                                      //mesmo caso itens de faturamento retorno tratamento 
                               fwrite(nLOGERRO,"valor bloco H Inventario: "+CCod_item+str(nVL_UNIT,14,6)+" maior contrato "+STR(NVALxval,14,6)+hb_osnewline())    
                               fwrite(nlOGDADO,Ccod_item+"|"+str(nVL_UNIT,14,6)+"|"+STR(NVALxval,14,6)+"|Maior Contrato"+hb_osnewline())                          
                            endif                      
                            //if regh010lxval->tipopreco="I"
                            //   fwrite(nLOGERRO,"valor bloco H Inventario: "+Ccod_item+str(nVL_UNIT,14,6)+" maior custo industrial "+STR(NVALxval,14,6)+hb_osnewline())    
                            //   fwrite(nlOGDADO,Ccod_item+"|"+str(nVL_UNIT,14,6)+"|"+STR(NVALxval,14,6)+"|Maior custo industrial"+hb_osnewline())                          
                            //endif
                            //if regh010lxval->tipopreco="A"
                            //   fwrite(nLOGERRO,"valor bloco H Inventario: "+Ccod_item+str(nVL_UNIT,14,6)+" maior custo industrial calculado"+STR(NVALxval,14,6)+hb_osnewline())    
                            //   fwrite(nlOGDADO,Ccod_item+"|"+str(nVL_UNIT,14,6)+"|"+STR(NVALxval,14,6)+"|Maior custo industrial calculado"+hb_osnewline())                          
                            //endif                                                
                            if regh010lxval->tipopreco="M"
                               fwrite(nLOGERRO,"valor bloco H Inventario: "+Ccod_item+str(nVL_UNIT,14,6)+" custo medio"+STR(NVALxval,14,6)+hb_osnewline())    
                               fwrite(nlOGDADO,Ccod_item+"|"+str(nVL_UNIT,14,6)+"|"+STR(NVALxval,14,6)+"|Maior custo medio"+hb_osnewline())                          
                            endif
                            if regh010lxval->tipopreco="V"
                               if  len(CCod_item)<>12  .and. len(CCod_item)<>14
                                   fwrite(nLOGERRO,"valor bloco H Inventario: "+Ccod_item+str(nVL_UNIT,14,6)+" media preco nfe"+STR(NVALxval,14,6)+hb_osnewline())    
                                   fwrite(nlOGDADO,Ccod_item+"|"+str(nVL_UNIT,14,6)+"|"+STR(NVALxval,14,6)+"|Media de preco nfe"+hb_osnewline())                          
                               endif    
                            endif
                            if regh010lxval->tipopreco="E"
                               fwrite(nLOGERRO,"valor bloco H Inventario: "+Ccod_item+str(nVL_UNIT,14,6)+" custo estoque"+STR(NVALxval,14,6)+hb_osnewline())    
                               fwrite(nlOGDADO,Ccod_item+"|"+str(nVL_UNIT,14,6)+"|"+STR(NVALxval,14,6)+"|Maior custo estoque"+hb_osnewline())                          
                            endif                                                        
                         ENDIF
                       regh010lxval->(dbskip())
                   enddo      
                endif
             endif
             dbselectar("regh010")
             dbskip()
         enddo  

         dbselectar("regd100")
         nLASTREC:=LASTREC()
         nPOSRECNO  :=1        
         dbgotop()
         while ! eof()
            cID  :=regd100->CHV_CTE        
            mds("validando CTE "+cID+" "+STR(nPOSRECNO)+"/"+STR(nLASTREC))     
            nPOSRECNO++
            cBUSCA:=ALLTRIM(regd100->COD_PART)
            nPOS:=ASCAN(aPARCOD,cBUSCA)            
            cCNPJ:="XXXXXXXXXXXXXX"            
            IF nPOS>0
               cCNPJ:=aPARDADOS[nPOS,1]
            ELSE
               cCNPJ:=SUBSTR(cID,7,14)            
            ENDIF  
            cFILEDANFE:=""
            IF substr(cID,44,1)<>"X".AND.COD_SIT<>"05".AND.COD_SIT<>"02" //X id criada modelos antigos              
               cFILEDANFE := pegcamxml(cID,cCNPJ)                                    
            ENDIF   
            IF ! EMPTY(cFILEDANFE)
               LINHA:=HB_MEMOREAD(cFILEDANFE)               
               LINHA2:=PegaDados('VPREST' ,Alltrim(Linha) )
               cVALOR:=PegaDados('VTPREST' ,Alltrim(Linha2) )
               nVALOR:=val(cVALOR)
               IF nVALOR<>regd100->VL_DOC
                  fwrite(nLOGERRO,"Nota Valor Documento:"+cCNPJ+"/"+STR(NUM_DOC)+"/"+cID+STR(VL_DOC,12,2)+" <> xml"+STR(nVALOR,14,2)+HB_OSNEWLINE())                 
               ENDIF
               LINHA2:=PegaDados('IMP' ,Alltrim(Linha))
               LINHA2:=PegaDados('ICMS' ,Alltrim(Linha2) )
               cVALOR:=PegaDados('VBC' ,Alltrim(Linha2) )
               nVALOR:=val(cVALOR)
               IF nVALOR<>regd100->VL_BC_ICMS                 
                 fwrite(nLOGERRO,"Nota Valor Base Icms:"+cCNPJ+"/"+STR(NUM_DOC)+"/"+cID+STR(VL_bc_icms,12,2)+" <> xml"+STR(nVALOR,14,2)+HB_OSNEWLINE())                  
               ENDIF
               cVALOR:=PegaDados('VICMS' ,Alltrim(Linha2))
               nVALOR:=val(cVALOR)
               IF nVALOR<>regd100->VL_ICMS
                 fwrite(nLOGERRO,"Nota Valor Icms:"+cCNPJ+"/"+STR(NUM_DOC)+"/"+cID+STR(VL_icms,12,2)+" <> xml"+STR(nVALOR,14,2)+HB_OSNEWLINE())                    
               ENDIF          
            endif
            dbselectar("regd100")            
            dbskip()
         enddo               

         dbselectar("reGc100")
         nLASTREC:=LASTREC()
         nPOSRECNO  :=1
         dbgotop()
         while ! eof()
            cID  :=reGc100->CHV_nfe
            mds("validando NFE "+cID+" "+STR(nPOSRECNO)+"/"+STR(nLASTREC))     
            nPOSRECNO++
            cBUSCA:=ALLTRIM(reGc100->COD_PART)
            cCOD_PART:=cBUSCA
            nPOS:=ASCAN(aPARCOD,cBUSCA)            
            cCNPJ:="XXXXXXXXXXXXXX"            
            IF nPOS>0
               cCNPJ:=aPARDADOS[nPOS,1]
            ELSE
               cCNPJ:=SUBSTR(cID,7,14)            
            ENDIF  
            cFILEDANFE:=""
            IF substr(cID,44,1)<>"X".AND.reGc100->COD_SIT<>"05".AND.reGc100->COD_SIT<>"02" //X id criada modelos antigos              
               cFILEDANFE := pegcamxml(cID,cCNPJ)                                                              
            ENDIF   
            IF ! EMPTY(cFILEDANFE) //substr(cID,44,1)<>"X".AND.COD_SIT<>"05".AND.COD_SIT<>"02" 
               LINHA:=HB_MEMOREAD(cFILEDANFE)               
               LINHA2:=PegaDados('TOTAL' ,Alltrim(Linha) )
               LINHA2:=PegaDados('ICMSTOT' ,Alltrim(Linha2) )
               aCAMPOS:={"vl_doc","vl_merC","VL_BC_ICMS","vl_icms","vl_ipi","vl_pis","vl_cofins"}
               aTAGS:={"VNF","VPROD","VBC","VICMS","VIPI","VPIS","VCOFINS"}
               aDIZER:={"NF","Mercadoria","Base ICMS","ICMs","IPI","PIS","COFINS"}
               FOR X=1 TO 7
                  cVALOR:=PegaDados(aTAGS[X],Alltrim(Linha2) )
                  nVALOR:=val(cVALOR)                  
                  cCAMPO:=aCAMPOS[X]
                  eVALOR:=regC100->&cCAMPO.
                  IF nVALOR<>eVALOR
                     fwrite(nLOGERRO,"Nota Valor "+ADIZER[X]+":"+cCNPJ+"/"+STR(NUM_DOC)+"/"+cID+STR(eVALOR,12,2)+" <> xml"+STR(nVALOR,12,2)+HB_OSNEWLINE())                 
                  ENDIF
               NEXT X
               IF IDNAOIEB(cID) 
                  nCONTA:=1
                  while .T. 
                      IF nCONTA<10
                         cCHAVE:="det nItem="+CHR(34)+STRZERO(nCONTA,1)+CHR(34)
                      Else
                         cCHAVE:="det nItem="+CHR(34)+STRZERO(nCONTA,2)+CHR(34)                      
                      endif
                      nPOSINI:=AT(cCHAVE,LINHA)
                      LINHA2:=SUBSTR(LINHA,nPOSINI-1)                      
                      LINHA2:=PegaDados(cCHAVE ,Alltrim(Linha2), ,"det")                      
                      IF lINHA2="0".and.len(linha2)=1
                         Exit
                      ENDIF                      
                      cProd:=PegaDados("CPROD" ,Alltrim(Linha2) )
                      xProd:=PegaDados("XPROD" ,Alltrim(Linha2) )
                      NCM:=PegaDados("NCM" ,Alltrim(Linha2) )
                      IF cPROD="0".and.len(cPROD)=1
                         cPROD:=""
                      ENDIF
                      IF SUBSTR(cPROD,1,1)="-"
                         cPROD:=SUBSTR(cPROD,2)
                      ENDIF
                      IF SUBSTR(cPROD,1,4)="CFOP" //.AND.LEN(cPROD)<=9 //CFOP5101 CFOP 5101
                         cPROD:=""
                      ENDIF
                      IF LEN(cPROD)<3
                         cPROD:=""
                      ENDIF
                      dbselectar("reg0200") //fornecedor esta com o nosso codigo
                      dbgotop()
                      if dBseek(cPROD)
                         cPROD:=""
                      ENDIF
                      IF ! EMPTY(cPROD)                         
                         dbselectar("regc170")
                         dbgotop()
                         if dbseek(cID+STR(nCONTA,3))
                            cCOD_ITEM:=ALLTRIM(regc170->cOD_ITEM)                  
                            if SUBSTR(cCOD_ITEM,1,4)<>"99.9".AND.SUBSTR(CCOD_ITEM,1,4)<>"88.8".AND.alltrim(Cprod)<>alltrim(CcOD_ITEM)                                      
                               cBusca:=PADR(cCOD_PART,20)+PADR(CcOD_ITEM,20)+cPROD
                               dbselectar("regc170for")
                               dbgotop()
                               if ! dbseek(cBUSCA)
                                 netrecapp()
                                 regc170for->COD_PART:=cCOD_PART
                                 regc170for->COD_ITEM:=cCOD_ITEM
                                 regc170for->COD_FORN:=cPROD                              
                                 regc170FOR->descR_forn=Xprod
                                 regc170FOR->ncm_forn=NCM
                               ELSE
                                 netreclock()                                 
                               endif                               
                               regc170FOR->qtd_descR:=regc170FOR->qtd_descR+1
                               dbunlock()
                            ENDIF   
                         ENDIF                               
                      endif   
                      nCONTA++
                  enddo               
               ENDIF
            endif        
            dbselectar("reGc100")            
            dbskip()
         enddo               
         
         
         cARQFOR:=cARQIMP+"_item_forn_"+ArqLogDataHora("sql")
         nHANFOR:=fcreate(cARQFOR)
         dbselectar("regC170FOR")
         dbgotop()
         while ! eof()
             IF regc170FOR->qtd_descR>4
                LINHA:="UPDATE item_fornec SET cod_item_fornec='"+ALLTRIM(regc170for->COD_FORN)+"' WHERE cod_item='"+ALLTRIM(regc170for->COD_ITEM)+"' AND cod_fornecedor='"+ALLTRIM(REGC170FOR->COD_PART)+"' ; "
                FWRITE(nHANFOR,LINHA+HB_OSNEWLINE())
             ENDIF
             DBSKIP()
         ENDDO         
         fclose(nHANFOR)
      ENDIF
      IF cTIPO="IBPTAX"            
         FWRITE(nNBM,"99")
         FCLOSE(nNBM)
//         FWRITE(nNBMPROTHEUS,"INSERT INTO syd010 (yd_tec,yd_desc_p,r_e_c_n_o_) VALUES ('99','Generico SPED')"+HB_OSNEWLINE())
         fCLOSE(nNBMPROTHEUS)
      ENDIF      
      IF cTIPO="EFD"  .OR. cTIPO="ECD"  .OR. cTIPO="EFT"  .OR. cTIPO="FCONT"                                                                                     
      
      
      
      
         fclose(nLOGERRO)
         fclose(nLOGDADO)
      ENDIF 
      IF cTIPO="EFD"    .OR. cTIPO="EFT"
         dbselectar("DANFE2")
         dbsetorder(1)
         dbselectar("XMLPEND")
         dbgotop()
         while ! eof()
           cID:=ID
           dbselectar("danfe2")
           dbgotop()
           lDELETE:=DBSEEK(cID)
           dbselectar("XMLPEND")
           If lDELETE
              netrecdel()
           ENDIF
           dbskip()
         enddo
       ENDIF             
      
      DBCLOSEALL()
      mds("...")
      

      
         IF cTIPO="SINTEGRA".AND.MDG("Gerar SINTCERT")
            ImportaSintDbf()
            IF MDG("Cruzar SINTCERT CNPJXML")
               ChecarSintXml() 
            ENDIF                            
         ENDIF
         IF (cTIPO="EFD" .OR. cTIPO="EFT") .AND. MDG("Gerar SINTCERT")
            ImportaCnpjXml()
            IF MDG("Cruzar SINTCERT CNPJXML")
               ChecarSintXml() 
            ENDIF                
         ENDIF   
      
      msginfo("concluido")      
      
return

FUNCTION GravaRegEFD(cALIAS,nINI) //,aEFD 
LOCAL nFIM
LOCAL eBUSCA
IF VALTYPE(cALIAS)#"C"
   cALIAS:="REG"+cREG
ENDIF   
IF VALTYPE(nINI)#"N" //nos sped o primeiro campo e codigo do registro por isso iniia na 2
   nINI:=2
   aCAMPOS[2]:=cREG                 
ENDIF
lTEMBLOCO:=.T.   
IF cREG="C500" .AND.LEN (Acampos)=16 //variacao no registro conforme o tipo do sped e versao pode variar quantidade campos
   cALIAS:="REGC500cb"
ENDIF    
lINCLUI:=.T.
dbselectar(cALIAS)
aEFD:=DBSTRUCT()
nFIM:=LEN(aEFD)
cALIAS:=UPPER(cALIAS)
//case para upgrade cnae cfo ncm cidades paises outros podera ter return ou array adequada linclui podera virar false nFIM ajustado
//criar seek e escolher ordem
//cria so estrutura necessaria
DO CASE
    CASE cALIAS="MD10"
       lINCLUI:=.F.  
	   dbsetorder(3) // codigo ibge c7  //pegar uf pelo 2 digitos do ibge
	   IF LEN(aCAMPOS)>=3
	       aCAMPOS[3]:=coduf(aCAMPOS[1],"UF")  //tras o codigo da uf pelos 2 digitos do codigo ibge
	   ELSE
	       AADD(aCAMPOS,coduf(aCAMPOS[1],"UF"))
             ENDIF				   
	   aEFD:={{"CODIBGE","C", 7,0},{"NOME" ,"C",35,0},{"UF" ,"C",2,0}}
       CASE cALIAS="PAISES" .AND. AT("EFDFINANCEIRA_PAISES",cARQIMP)=0
       lINCLUI:=.F.
	   dbsetorder(5) //bacen n4 quando bacen grava paises senao grava sped_paises
	   IF LEN(aCAMPOS)>=3
	       aCAMPOS[3]:="EX" 
	   ELSE
	       AADD(aCAMPOS,"EX")
             ENDIF
         aEFD:={{"BACEN","N", 4,0},{"NOME" ,"C",35,0},{"UF" ,"C",2,0}}
       CASE cALIAS="PAISES" .AND. AT("EFDFINANCEIRA_PAISES",cARQIMP)>0 //COD_PAIS, NOM_PAIS, DT_INI, DT_FIM
       lINCLUI:=.F.
	   dbsetorder(1) //ISO3166A
	   IF LEN(aCAMPOS)>=3
	       aCAMPOS[3]:="EX" 
	   ELSE
	       AADD(aCAMPOS,"EX")
             ENDIF
         aEFD:={{"ISO3166A","C", 2,0},{"NOME" ,"C",35,0},{"UF" ,"C",2,0}}
    CASE cALIAS="MD04"
       lINCLUI:=.F.
	   aEFD:={{"CFONEW","C", 4,0},{"DESCRICAO" ,"C",150,0}}
	   dbsetorder(2) // cfonew
    CASE cALIAS="MD05"
       lINCLUI:=.F.
	   dbsetorder(1) // uf
	   aEFD:={{"UFICMS","C", 2,0},{"NOMEEXT" ,"C",20,0}}
    CASE cALIAS="MD05X"
       lINCLUI:=.F.
	   dbsetorder(3) // uficms ufdest
	   aEFD:={{"UFICMS","C", 2,0},{"NOMEEXT" ,"C",20,0}} //checar furamente inclusao por md05 como ufdest **
    CASE cALIAS="CEST"
       lINCLUI:=.F.
	   dbsetorder(1) // codigo
	   aEFD:={{"CODIGO","C", 7,0},{"DESCRICAO" ,"M",255,0}}			   
    CASE cALIAS="FO_CNAE2"
       lINCLUI:=.F.
	   dbsetorder(1) // codigo
	   aEFD:={{"CODIGO","C", 7,0},{"DESCRICAO" ,"C",100,0}}			   
    CASE cALIAS="SINTDOC"
       lINCLUI:=.F.
	   dbsetorder(1) // codigo
	   aEFD:={{"CODIGO","C", 2,0},{"NOME" ,"C",70,0}}
    CASE cALIAS="CST_COFINS"
       lINCLUI:=.F.
	   dbsetorder(1) // codigo
	   aEFD:={{"CODIGO","C", 2,0},{"NOME" ,"C",150,0}}
    CASE cALIAS="CST_IPI"
       lINCLUI:=.F.
	   dbsetorder(1) // codigo
	   aEFD:={{"CODIGO","C", 2,0},{"NOME" ,"C",150,0}}
    CASE cALIAS="CST_ICMS"
       lINCLUI:=.F.
	   dbsetorder(1) // codigo
	   aEFD:={{"CODIGO","C", 3,0},{"NOME" ,"C",150,0}}
    CASE cALIAS="CST_PIS"
       lINCLUI:=.F.
	   dbsetorder(1) // codigo
	   aEFD:={{"CODIGO","C", 2,0},{"NOME" ,"C",150,0}}
    CASE cALIAS="NFECRET"
       lINCLUI:=.F.
	   dbsetorder(1) // codigo
	   aEFD:={{"CODIGO","C", 3,0},{"DESCRICAO" ,"C",120,0}}
    CASE cALIAS="MOEDA" .AND. AT("CBC_MOEDA",cARQIMP)>0 //versão=1 TIP_MOEDA, Nome, DT_INI, DT_FIM, PAIS
       lINCLUI:=.F.
	   dbsetorder(2) // simboro
	   aEFD:={{"SIMBOLO","C", 3,0},{"NOME" ,"C",20,0},{"DATA_INI" ,"D",8,0},{"DATA_FIM" ,"D",8,0},{"PAIS" ,"C",20,0}}
    CASE cALIAS="MOEDA" .AND. AT("CBC_MOEDA",cARQIMP)=0 //versão=1 CODIGO, DESCRICAO, DT_INI, DT_FIM
       lINCLUI:=.F.
	   dbsetorder(1) // codigo
	   aEFD:={{"CODIGO","N", 4,0},{"NOME" ,"C",20,0},{"DATA_INI" ,"D",8,0},{"DATA_FIM" ,"D",8,0}}
ENDCASE
IF lINCLUI=.F. //as tabelas padrao 
	nini:=1 //codigo na tabela tem que ser campo 1 grava checa inclui e grava
	nfim:=2  //nome ou descricao na tabela tem que ser campo 1 grava se a descricao esta vazia
ENDIF
IF cALIAS="MD10" .OR. cALIAS="PAISES" //tras o codigo da uf pelos 2 digitos do codigo ibge
   nFIM:=3
ENDIF
IF cALIAS="MOEDA" .AND. AT("CBC_MOEDA",cARQIMP)>0 //versão=1 TIP_MOEDA, Nome, DT_INI, DT_FIM, PAIS
    nFIM:=5
ENDIF
IF cALIAS="MOEDA" .AND. AT("CBC_MOEDA",cARQIMP)=0 //versão=1 CODIGO, DESCRICAO, DT_INI, DT_FIM
   nFIM:=4
ENDIF

IF  AT("NATJUCSV",CNOMEORI)>0 .OR.  AT("QUALSCSV",CNOMEORI)>0 .OR. AT("PAISCSV",CNOMEORI)>0
	nfim:=2  //CSV DADOS ABERTOS  so tem dois campos
ENDIF


//aCAMPOS VEM do hb_atokens tem os campos dos registros
IF lINCLUI
	netrecapp()
else
   eVALOR:=aCAMPOS[1]
   IF cALIAS="PAISES" .AND. AT("EFDFINANCEIRA_PAISES",cARQIMP)=0
      eVALOR:=VAL(eVALOR)
   ENDIF
   IF cALIAS="PAISES"
      aCAMPOS[2]:=UPPER(TIRACE(aCAMPOS[2])) //Nome maiusculas sem acentuacao
   ENDIF
   IF cALIAS="MOEDA" .AND. AT("CBC_MOEDA",cARQIMP)=0 
     eVALOR:=VAL(eVALOR)
   ENDIF
   dbgotop()
   if ! dbseek(eVALOR)
      netrecapp()
   else 
      dbrlock()   
   endif
ENDIF	
IF nINI=2 .AND. LEN(aCAMPOS)<nFIM   
   fwrite(nLOGERRO,cREG+" Erro Qtde Campos linha:"+STRVAL(hb_FRecNo())+" "+str(len(Acampos))+"/"+str(nfim)+HB_OSNEWLINE())
   nFIM:=LEN(aCAMPOS)
ENDIF
FOR X=nINI TO nFIM 
   cCAMPO:=aEFD[X][1]
   eVALOR:=aCAMPOS[X]
   IF aEFD[X][2]="N"
      eVALOR:=STRTRAN(eVALOR,",",".")
      eVALOR:=VAL(eVALOR)
   endif
   IF aEFD[X][2]="D"
      eVALOR:=str2data(eVALOR,"DMY","","4")
   ENDIF
   DO CASE
      CASE aEFD[X][2]="N"
          cSUBLINHA+=STR(eVALOR)
      CASE aEFD[X][2]="D"           
          IF EMPTY(eVALOR)
             cSUBLINHA+="''"
          ELSE
             //convert(datetime, '01/12/2001', 103)
             cSUBLINHA+="convert(datetime, '"+dtoc(eVALOR)+"', 103)"
             //cSUBLINHA+="'"+data2STR(eVALOR,"YDM","-","4")+"'"
             //cSUBLINHA+=data2STR(eVALOR,"SQL")
          ENDIF   
      OTHERWISE    
          cSUBLINHA+="'"+STRTRAN(eVALOR,"'","")+"'"
   END CASE
   cSUBLINHA+=","
   IF EMPTY(&cCAMPO.) .AND. ! EMPTY(eVALOR)
      field->&cCAMPO.:=eVALOR
   ENDIF
NEXT X
dbcommit()            
RETURN

FUNCTION GravaRegSint(cALIAS)
LOCAL X
DBSELECTAR(cALIAS)
DO CASE
   CASE cALIAS="SINT50"
        aDBF:=aDBF50
   CASE cALIAS="SINT51"
        aDBF:=aDBF51
   CASE cALIAS="SINT53"
        aDBF:=aDBF53
   CASE cALIAS="SINT54"
        aDBF:=aDBF54
   CASE cALIAS="SINT70"
        aDBF:=aDBF70
   CASE cALIAS="SINT75"
        aDBF:=aDBF75
   OTHERWISE
      aDBF:=DBSTRUCT()
      FOR X=1 TO LEN(aDBF)
         IF aDBF[X][2]="D"
            aDBF[X][2]:="SD"   
         ENDIF
      NEXT X
END CASE
aDBF:=sdvarrpos(aDBF)   
netrecapp()
FOR X=1 TO LEN(aDBF)
   cCAMPO:=aDBF[X][1]   
   eVALOR:=sdvpegpos(cLINha,aDBF,X,.T.)
   &cALIAS.->&cCAMPO.:=eVALOR
NEXT X                 
return

function gerarr(aSPED,nSPED)
nLEN:=LEN(aSPED)
FOR X=1 TO nLEN  
   FWRITE(nSPED,ALLTRIM(STRVAL(aSPED[X]))+"|")    
NEXT X
FWRITE(nSPED,HB_OSNEWLINE())
RETURN .T.

FUNCTION IDNAOIEB(cCHAVE)
RETURN AT("61381323000248",cCHAVE)=0 .AND. AT("61381323000167",cCHAVE)=0 .AND. AT("61381323000329",cCHAVE)=0 .AND. AT("61381323000400",cCHAVE)=0 .AND. AT("61381323000590",cCHAVE)=0


function criatabelasped(cARQTXT,cARQDBF)
LOCAL nFILE
LOCAL cLINHA,cCAMPO
LOCAL aCAMPOS,aTAMANHO,aTIPOS,aVALORES,aDB
LOCAL nFIM,I,nPOS,nLEN

IF ! FILE(cARQTXT)
   ALERT(cARQTXT)
   RETURN .F.
ENDIF
nFile := HB_FUse(cARQTXT)	
cLINHA:=UPPER(HB_FREADLN())	
cLINHA:=TIRAOUT(cLINHA)
aCAMPOS:=HB_ATOKENS(cLINHA,',')
aTAMANHO:={}
aTIPOS  :={}
//'versão=1 TIP_MOEDA, Nome, DT_INI, DT_FIM, PAIS
nFIM:=LEN(aCAMPOS)
nPOS:=AT(" ",aCAMPOS[1])
IF nPOS>0  //versão=1 TIP_MOEDA
  aCAMPOS[1]:=SUBSTR(aCAMPOS[1],nPOS+1) //TIP_MOEDA
ENDIF
FOR I:=1 TO nFIM
   aCAMPOS[I]:=STRTRAN(UPPER(ALLTRIM(aCAMPOS[I]))," ","")
   IF aCAMPOS[I]="DT_INI" .OR. aCAMPOS[I]="DT_FIM" .OR. aCAMPOS[I]="DATAINCIO" .OR. aCAMPOS[I]="DATAFIM"
     AADD(aTAMANHO,8)
     AADD(aTIPOS,"D")
   ELSE
     AADD(aTAMANHO,8)
     AADD(aTIPOS,"C")
   ENDIF  
NEXT I

HB_FSkip(1) //1o. linha reader
DO WHILE .NOT. HB_FEof()
  cLINHA:=HB_FREADLN()  
  aVALORES:=HB_ATokens(cLINHA,"|")    
  FOR I:=1 TO nFIM
      nLEN:=LEN(aVALORES[i])
      if nLEN>aTAMANHO[I] .AND. nLEN<255
         aTAMANHO[I]:=nLEN
      ENDIF
  NEXT X                        
  HB_FSkip(1)
ENDDO
HB_FUse()

aDB:={}
FOR I:=1 TO nFIM
    AADD(aDB,{aCAMPOS[I],aTIPOS[I],aTAMANHO[I],0})
NEXT I
IF EMPTY(aDB)
   ALERT("adb create vazia")
   RETURN .F.
ENDIF
DBCREATE(cARQDBF,aDB)
cCAMPO:=aCAMPOS[1]
use &CARQDBF new exclusive
index on &cCAMPO tag chave
dbclosearea()
return .T.