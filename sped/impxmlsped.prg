         cFOLDER:=GetFolder ( 'Pasta Arquivos XML' )
         cFOLDER+="\"
         mListaArq := Directory(cFOLDER+"*.xml","D")          
         
         cARQSPED:=cFOLDER+"SPED_"+ArqLogDataHora("txt")
         nSPED:=fcreate(cARQSPED)
         cARQSPED2:=cFOLDER+"SPEDXML_"+ArqLogDataHora("txt")
         nSPEDXML:=fcreate(cARQSPED2)

         
         nLENX:=LEN(mListaArq)
         aCNPJ:={}
         FOR I= 1 TO nLENX       
             cARQUIVO:= UPPER(mListaArq[i,1])              
             mds("reg0150 "+cARQUIVO+str(i)+"/"+str(nLENX))             
             cLinhaTxt:=hb_MEMOREAD(cFOLDER+cARQUIVO)   
             lCTE:=.F.
             nFIMZ:=2
             nPos1 := At('cteProc',CLinhaTXT)
             If nPos1>0      
                lCTE:=.T.
                nFIMZ:=4
             ENDIF 
             
             FOR Z=1 TO nFIMZ
                DO CASE
                  CASE Z=1             
                      cLidos2 := PegaDados('emit',Alltrim(cLinhaTxt),,'emit')
                  CASE Z=2
                      cLidos2 := PegaDados('dest',Alltrim(cLinhaTxt),,'dest')
                  CASE Z=3
                      cLidos2 := PegaDados('dest',Alltrim(cLinhaTxt),,'rem')
                  CASE Z=4
                      cLidos2 := PegaDados('dest',Alltrim(cLinhaTxt),,'exped')                                           
                ENDCASE
                Linha2 := cLidos2
                XCNPJ  := PegaDados( 'CNPJ'  ,Alltrim(Linha2) )                
                IF ASCAN(aCNPJ,XCNPJ)=0.AND.(VALCGC(Xcnpj,,.F.).OR.Valcpf( XCNPJ ,.F.))                   
                   AADD(aCNPJ,XCNPJ)                   
                   aSPED:=ARRAY(14)
                   aSPED[1]:="" //sep
                   aSPED[2]:="0150"
                   aSPED[3]:=XCNPJ
                   aSPED[4]:=PegaDados( 'xNome' ,Alltrim(Linha2) )
                   aSPED[5]:=PegaDados( 'cPais' ,Alltrim(Linha2) )
                   aSPED[6]:=XCNPJ
                   aSPED[7]:=PegaDados( 'CPF'  ,Alltrim(Linha2) )
                   aSPED[8]:=PegaDados( 'IE'   ,Alltrim(Linha2) )
                   aSPED[9]:=PegaDados( 'cMun'  ,Alltrim(Linha2) )
                   aSPED[10]:=PegaDados( 'ISUF'  ,Alltrim(Linha2) ) 
                   aSPED[11]:=PegaDados( 'xLgr'  ,Alltrim(Linha2))
                   aSPED[12]:=PegaDados( 'nro'  ,Alltrim(Linha2) )
                   aSPED[13]:=PegaDados( 'xcpl'  ,Alltrim(Linha2) )
                   aSPED[14]:=PegaDados( 'xBairro' ,Alltrim(Linha2) )
                   gerarr(aSPED,nSPED)
                   /*
                   0150;14;nome fantasia
                   0150;15;cidade
                   0150;16;estado
                   0150;17;cep
                   0150;18;pais
                   0150;19;telefone
                   0150;20;inscricao estadual do subistito tributario                   
                   0150;21;email
                   0150;22;inscricao municipal
                   0150;23;cnae
                   */
                   AADD(aSPED,PegaDados( 'xFANT' ,Alltrim(Linha2) ))
                   AADD(aSPED,PegaDados( 'xMun'  ,Alltrim(Linha2) ))
                   AADD(aSPED,PegaDados( 'UF'   ,Alltrim(Linha2) ))
                   AADD(aSPED,PegaDados( 'CEP'  ,Alltrim(Linha2) ))
                   AADD(aSPED,PegaDados( 'xPais' ,Alltrim(Linha2) ))
                   AADD(aSPED,PegaDados( 'fone'  ,Alltrim(Linha2) ))
                   AADD(aSPED,PegaDados( 'IEST'   ,Alltrim(Linha2) ))                  
                   AADD(aSPED,PegaDados( 'email'   ,Alltrim(Linha2) ))
                   AADD(aSPED,PegaDados( 'IM'   ,Alltrim(Linha2) ))
                   AADD(aSPED,PegaDados( 'cnae'   ,Alltrim(Linha2) ))                 
                  gerarr(aSPED,nSPEDXML)
                ENDIF  
             NEXT Z             
         NEXT I
         
         FOR I= 1 TO nLENX   //nfe C100/C170             
             cARQUIVO:= UPPER(mListaArq[i,1]) 
             mds("regC100 "+cARQUIVO+str(i)+"/"+str(nLENX))                          
             cLinhaTxt:=hb_MEMOREAD(cFOLDER+cARQUIVO)
             nPOS1:=AT('nfeProc',ClinhaTXT)
             IF nPOS1>0
                nPOS1:=AT('chNFe',ClinhaTXT)
                aSPED:=ARRAY(30)
                cID:= Substr(clinhatxt,nPOS1+6,44)
                cCNPJ:=SubStr(cID,7,14)      
                cUFCOD:=SUBSTR(cID,1,2)
                cANO:=SUBSTR(cID,3,2)
                cMES:=SUBSTR(cID,5,2)               
                CNNF:= alltrim(str(val(SUBsTR(cID,26,9))))
                CSERIE:=alltrim(str(val(SUBsTR(cID,23,3))))
                cMODELO:=SUBSTR(cID,21,2)               
                LINHA2:=PegaDados('TOTAL' ,Alltrim(CLinhaTXT) )
                LINHA2:=PegaDados('ICMSTOT' ,Alltrim(Linha2) )
                aTAGS:={"VNF","VPROD","VBC","VICMS","VIPI","VPIS","VCOFINS","VBCST","VST","VOUTRO","VDESC","VSEG","VFRETE"}
                aPOS  :={13,17,22,23,26,27,28,24,25,21,15,20,19}
                FOR K=1 TO LEN(aTAGS)
                    aSPED[aPOS[K]]:=PegaDados(aTAGs[K],Alltrim(Linha2) )
                NEXT K
                 cDATA:=DTOC(STOD(STRTRAN(PegaDados('dEmi' ,Alltrim(CLinhaTXT) ),"-",""))) 
                 cDATA:=STRTRAN(cDATA,"/","")                                
                 aSPED[1]:=""
                 aSPED[2]:="C100"
                 aSPED[3]:="0" //IND_OPER 0=Entrada
                 aSPED[4]:="1" //IND_EMIT 1=Terceiros
                 aSPED[5]:=cCNPJ
                 aSPED[6]:=cMODELO
                 aSPED[7]:="00" //COD_SIT
                 aSPED[8]:=cSERIE
                 aSPED[9]:=cNNF
                 aSPED[10]:=cID
                 aSPED[11]:=cDATA
                 aSPED[12]:="" //data2str(oregistro:fields("dat_entrada_nf"):value,"DMY","",2)
                 aSPED[14]:="9" //IND_PGTO 0- À vista; 1- A prazo; 9- Sem pagamento                 
                 aSPED[16]:=0 //VL_ABAT_NT
                 aSPED[18]:=PegaDados('modFrete' ,Alltrim(CLinhaTXT) ) // modFrete "9" //IND_FRT 0- Por conta de terceiros; 1- Por conta do emitente;2- Por conta do destinatário;9- Sem cobrança de frete                 
                 aSPED[29]:=0 //VL_PIS_ST
                 aSPED[30]:=0 //VLCOFINSST
                 gerarr(aSPED,nSPED) 
                 gerarr(aSPED,nSPEDXML) 
                 
                  nCONTA:=1
                  while .T. 
                      IF nCONTA<10
                         cCHAVE:="det nItem="+CHR(34)+STRZERO(nCONTA,1)+CHR(34)
                      Else
                         cCHAVE:="det nItem="+CHR(34)+STRZERO(nCONTA,2)+CHR(34)                      
                      endif                       
                      nPOSINI:=AT(cCHAVE,cLINHATXT)
                      LINHA2:=SUBSTR(cLINHATXT,nPOSINI-1)                      
                      LINHA2:=PegaDados(cCHAVE ,Alltrim(Linha2), ,"det")                      
                      IF lINHA2="0".and.len(linha2)=1
                         Exit
                      ENDIF
                      
                      aSPED:=ARRAY(38)
                      aSPED[1]=""
                      aSPED[2]="C170" //C170;01;REG;Texto fixo contendo “C170”;C;004
                      aSPED[3]=ALLTRIM(STR(nCONTA)) //C170;02;NUM_ITEM;Número seqüêncial do item no documento fiscal;N;003
                      aSPED[4]:=PegaDados("CPROD" ,Alltrim(Linha2) ) //C170;03;COD_ITEM;Código do item (campo 02 do Registro 0200);C;060
                      aSPED[5]:=PegaDados("XPROD" ,Alltrim(Linha2) ) //C170;04;DESCR_COMPL;Descrição complementar do item como adotado no documento fiscal;C;-
                      aSPED[6]:=PegaDados("qCom" ,Alltrim(Linha2) ) //C170;05;QTD;Quantidade do item;N;-
                      aSPED[7]:=PegaDados("uCom" ,Alltrim(Linha2) ) //C170;06;UNID;Unidade do item(Campo 02 do registro 0190);C;006
                      aSPED[8]:=PegaDados("vUnCom" ,Alltrim(Linha2)) //C170;07;VL_ITEM;Valor total do item (mercadorias ou serviços);N;-
                      aSPED[9]:="" //PegaDados("" ,Alltrim(Linha2)) //C170;08;VL_DESC;Valor do desconto comercial;N;-
                      aSPED[10]:="" //PegaDados("" ,Alltrim(Linha2) ) //C170;09;IND_MOV;Movimentação física do ITEM/PRODUTO: 0. SIM 1. NÃO;C;001
                      
                      LINHA3:=PegaDados("ICMS" ,Alltrim(Linha2) )
                      aSPED[11]:=PegaDados("CST" ,Alltrim(Linha3) ) //C170;10;CST_ICMS;Código da Situação Tributária referente ao ICMS, conforme a Tabela indicada no item 4.3.1;N;003                      
                      aSPED[12]:=PegaDados("CFOP" ,Alltrim(Linha3) ) //C170;11;CFOP;Código Fiscal de Operação e Prestação;N;004
                      aSPED[13]:="" //PegaDados("" ,Alltrim(Linha2) ) //C170;12;COD_NAT;Código da natureza da operação (campo 02 do Registro 0400);C;010
                      aSPED[14]:=PegaDados("VBC" ,Alltrim(Linha3) ) //C170;13;VL_BC_ICMS;Valor da base de cálculo do ICMS;N;-
                      aSPED[15]:=PegaDados("pICMS" ,Alltrim(Linha3)) //C170;14;ALIQ_ICMS;Alíquota do ICMS;N;006
                      aSPED[16]:=PegaDados("vICMS" ,Alltrim(Linha3) ) //C170;15;VL_ICMS;Valor do ICMS creditado/debitado;N;-
                      
                      
                      aSPED[17]:=PegaDados("vBCST" ,Alltrim(Linha2) ) //C170;16;VL_BC_ICMS_ST;Valor da base de cálculo referente à substituição tributária;N;-
                      aSPED[18]:=PegaDados("pICMSST" ,Alltrim(Linha2) ) //C170;17;ALIQ_ST;Alíquota do ICMS da substituição tributária na unidade da federação de destino;N;-
                      aSPED[19]:=PegaDados("vICMSST" ,Alltrim(Linha2) ) //C170;18;VL_ICMS_ST;Valor do ICMS referente à substituição tributária;N;-
                      
                      aSPED[20]:="" // PegaDados("" ,Alltrim(Linha2) ) //C170;19;IND_APUR;Indicador de período de apuração do IPI: 0 - Mensal, 1 - Decendial;C;001
                      
                      LINHA3:=PegaDados("IPI" ,Alltrim(Linha2) )
                      aSPED[21]:=PegaDados("CST" ,Alltrim(Linha3) ) //C170;20;CST_IPI;Código da Situação Tributária referente ao IPI, conforme a Tabela indicada no item 4.3.2.;C;002
                      aSPED[22]:=PegaDados("CENQ" ,Alltrim(Linha3) ) //C170;21;COD_ENQ;Código de enquadramento legal do IPI, conforme tabela indicada no item 4.5.3.;C;003                      
                      aSPED[23]:=PegaDados("VBC" ,Alltrim(Linha3) ) //C170;22;VL_BC_IPI;Valor da base de cálculo do IPI;N;-
                      aSPED[24]:=PegaDados("pIPI" ,Alltrim(Linha3) ) //C170;23;ALIQ_IPI;Alíquota do IPI;N;006
                      aSPED[25]:=PegaDados("vIPI" ,Alltrim(Linha3) ) //C170;24;VL_IPI;Valor do IPI creditado/debitado;N;-
                      
                      LINHA3:=PegaDados("PIS" ,Alltrim(Linha2) )                      
                      aSPED[26]:=PegaDados("CST" ,Alltrim(Linha3) ) //C170;25;CST_PIS;Código da Situação Tributária referente ao PIS.;N;002                      
                      aSPED[27]:=PegaDados("VBC" ,Alltrim(Linha3) ) //C170;26;VL_BC_PIS;Valor da base de cálculo do PIS;N;-                      
                      aSPED[28]:=PegaDados("PPIS" ,Alltrim(Linha3) ) //C170;27;ALIQ_PIS;Alíquota do PIS (em percentual);N;-
                      aSPED[29]:=PegaDados("qBCProd" ,Alltrim(Linha3) ) //C170;28;QUANT_BC_PIS;Quantidade - Base de cálculo PIS;N;-
                      aSPED[30]:=PegaDados("vAliqProd" ,Alltrim(Linha3) ) //C170;29;ALIQ_PIS;Alíquota do PIS (em reais);N;-
                      aSPED[31]:=PegaDados("VPIS" ,Alltrim(Linha3) ) //C170;30;VL_PIS;Valor do PIS;N;-
                      
                      LINHA3:=PegaDados("COFINS" ,Alltrim(Linha2) )                      
                      aSPED[32]:=PegaDados("CST" ,Alltrim(Linha3) ) //C170;31;CST_COFINS;Código da Situação Tributária referente ao COFINS;N;002                      
                      aSPED[33]:=PegaDados("VBC" ,Alltrim(Linha3) )//C170;32;VL_BC_COFINS;Valor da base de cálculo da COFINS;N;-
                      aSPED[34]:=PegaDados("PCOFINS" ,Alltrim(Linha3) ) //C170;33;ALIQ_COFINS;Alíquota do COFINS (em percentual);N;006
                      aSPED[35]:=PegaDados("qBCProd" ,Alltrim(Linha3) ) //C170;34;QUANT_BC_COFINS;Quantidade - Base de cálculo COFINS;N;-
                      aSPED[36]:=PegaDados("vAliqProd" ,Alltrim(Linha3) ) //C170;35;ALIQ_COFINS;Alíquota da COFINS (em reais);N;-
                      aSPED[37]:=PegaDados("VCOFINS" ,Alltrim(Linha3) ) //C170;36;VL_COFINS;Valor da COFINS;N;-
                      aSPED[38]:="" //PegaDados("" ,Alltrim(Linha2)) //C170;37;COD_CTA;Código da conta analítica contábil debitada/creditada;C;-
                      
                     gerarr(aSPED,nSPED) 
                     gerarr(aSPED,nSPEDXML) 

                      
                      //NCM:=PegaDados("NCM" ,Alltrim(Linha2) )
                      
                      nCONTA++
                  enddo               
            ENDIF
         NEXT I
         
         FOR I= 1 TO nLENX        //cte D100
             cARQUIVO:= UPPER(mListaArq[i,1]) 
             mds("REGD100 "+cARQUIVO+str(i)+"/"+str(nLENX))                          
             cLinhaTxt:=hb_MEMOREAD(cFOLDER+cARQUIVO)              
             nPOS1:=AT('cteProc',ClinhaTXT)           
             IF nPOS1>0
                nPOS1:=AT('Id=',clinhaTXT)             
                aSPED:=ARRAY(24)
                cID:= Substr(clinhatxt,nPOS1+7,44)               
                cCNPJ:=SubStr(cID,7,14)      
                cUFCOD:=SUBSTR(cID,1,2)
                cANO:=SUBSTR(cID,3,2)
                cMES:=SUBSTR(cID,5,2)               
                CNNF:= alltrim(str(val(SUBsTR(cID,26,9))))
                CSERIE:=alltrim(str(val(SUBsTR(cID,23,3))))
                cMODELO:=SUBSTR(cID,21,2)
                LINHA2:=PegaDados('VPREST' ,Alltrim(cLinhaTXT) )
                cVTPREST:=PegaDados('VTPREST' ,Alltrim(Linha2) )                
                LINHA2:=PegaDados('IMP' ,Alltrim(cLinhaTXT) )                
                LINHA2:=PegaDados('ICMS' ,Alltrim(Linha2) )
                cVBC  :=PegaDados('VBC' ,Alltrim(Linha2) )
                cVICMS :=PegaDados('VICMS' ,Alltrim(Linha2) )
                cCST  :=PegaDados('CST' ,Alltrim(Linha2) )
                cDATA:=DTOC(STOD(STRTRAN(SUBSTR(PegaDados('dhEmi' ,Alltrim(CLinhaTXT),.f. ),1,10),"-","")))     
                cDATA:=STRTRAN(cDATA,"/","")               
                aSPED[1]:=""
                aSPED[2]:="D100" // D100;01;REG;Texto fixo contendo “D100”;C;004
                aSPED[3]:="" //D100;02;IND_OPER;Indicador do tipo de operação: 0- Aquisição, 1- Prestação;C;001
                aSPED[4]:="1" //D100;03;IND_EMIT;Indicador do emitente do documento fiscal: 0- Emissão própria, 1- Terceiros;C;001
                aSPED[5]:=cCNPJ //D100;04;COD_PART;Código do participante (campo 02 do Registro 0150): - do prestador de serviço, no caso de aquisição de serviço, - do tomador do serviço, no caso de prestação de serviços.;C;060
                aSPED[6]:=cMODELO //D100;05;COD_MOD;Código do modelo do documento fiscal, conforme a Tabela 4.1.1;C;002
                aSPED[7]:="" //D100;06;COD_SIT;Código da situação do documento fiscal, conforme a Tabela 4.1.2;N;002
                aSPED[8]:=cSERIE //D100;07;SER;Série do documento fiscal;C;004
                aSPED[9]:="" //D100;08;SUB;Subsérie do documento fiscal;C;002
                aSPED[10]:=cNNF //D100;09;NUM_DOC;Número do documento fiscal;N;009
                aSPED[11]:=cID //D100;10;CHV_CTE;Chave do Conhecimento de Transporte Eletrônico;N;044
                aSPED[12]:=cDATA //D100;11;DT_DOC;Data da emissão do documento fiscal;N;008
                aSPED[13]:="" //D100;12;DT_A_P;Data da aquisição ou da prestação do serviço;N;008
                aSPED[14]:=PegaDados('tpCTe' ,Alltrim(CLinhaTXT) ) //D100;13;TP_CT-e;Tipo de Conhecimento de Transporte Eletrônico conforme definido no Manual de Integração do CT-e;N;001
                aSPED[15]:=PegaDados('refCTE' ,Alltrim(CLinhaTXT) ) //D100;14;CHV_CTE_REF;Chave do CT-e de referência cujos valores foram complementados (opção “1” do campo anterior) ou cujo débito foi anulado(opção “2” do campo anterior).;N;044
                aSPED[16]:=cVTPREST //D100;15;VL_DOC;Valor total do documento fiscal;N;-
                aSPED[17]:="" //D100;16;VL_DESC;Valor total do desconto;N;-
                aSPED[18]:="" //D100;17;IND_FRT;Indicador do tipo do frete: 0- Por conta de terceiros, 1- Por conta do emitente, 2- Por conta do destinatário, 9- Sem cobrança de frete.;C;001                
                aSPED[19]:="" //D100;18;VL_SERV;Valor total da prestação de serviço;N;-
                aSPED[20]:=CVBC //D100;19;VL_BC_ICMS;Valor da base de cálculo do ICMS;N;-
                aSPED[21]:=CVICMS //D100;20;VL_ICMS;Valor do ICMS;N;-
                aSPED[22]:="" //D100;21;VL_NT;Valor não-tributado;N;-
                aSPED[23]:="" //D100;22;COD_INF;Código da informação complementar do documento fiscal (campo 02 do Registro 0450);C;006
                aSPED[24]:="" //D100;23;COD_CTA;Código da conta analítica contábil debitada/creditada.;C;-               
                gerarr(aSPED,nSPED)
                gerarr(aSPED,nSPEDXML)
             ENDIF             
         NEXT I
         
         
         FCLOSE(nSPED)
         FCLOSE(nSPEDXML)
         mds("concluido ...")
