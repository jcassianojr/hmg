function cnpjirimp()

//"33600832";"0001";"06";"1";"DALUARI BOUTIQUE";"02";"20190513";"00";"";"";"20190513";"4781400";"4782201,4782202,4783101,4783102";"AVENIDA";"JOSE TOZZI";"1831";"LOJA  04";"CENTRO";"29930245";"ES";"5697";"27";"37638200";"";"";"";"";"CADASTRO@PEREIRABCONTABILIDDE.COM.BR";"";"" 

/*
        cCNPJ:=aCAMPOS[1]+aCAMPOS[2]+aCAMPOS[3]
        cNOME:=aCAMPOS[5]
        cCNAE:=aCAMPOS[12]
        cUF  :=aCAMPOS[20]
        cCODCID:=aCAMPOS[21] 
        cDDD:=aCAMPOS[22]
        cTELEFONE:=aCAMPOS[23]
       cDATA:=aCAMPOS[11]
       cENDTIP  := aCAMPOS[14]
       cENDERECO:= aCAMPOS[15]
       cNUMEND  := aCAMPOS[16]
       cCOMPLEM := strtran(strtran(aCAMPOS[17],"  "," "),"  "," ") //duplos espacos
       cBAIRRO  := aCAMPOS[18]
       cCEP     := aCAMPOS[19]
       cSITUACAO:=aCAMPOS[6]

 estabelecimento.columns = [1'cnpj_basico',
                            2   'cnpj_ordem',
                            3   'cnpj_dv',
                            4   'identificador_matriz_filial',
                            5   'nome_fantasia',
                            6   'situacao_cadastral',
                            7   'data_situacao_cadastral',
                            8   'motivo_situacao_cadastral',
                            9   'nome_cidade_exterior',
                            10   'pais',
                            11   'data_inicio_atividade',
                            12   'cnae_fiscal_principal',
                            13   'cnae_fiscal_secundaria',
                            14   'tipo_logradouro',
                            15   'logradouro',
                            16   'numero',
                            17   'complemento',
                            18   'bairro',
                            19   'cep',
                            20   'uf',
                            21   'municipio',
                            22   'ddd_1',
                            23   'telefone_1',
                            24   'ddd_2',
                            25   'telefone_2',
                            26   'ddd_fax',
                            27   'fax',
                            28   'correio_eletronico',
                            29   'situacao_especial',
                            30   'data_situacao_especial']
 */                              

cCAM   := PROFILESTRING( "sped.ini","MD10.DBF","CAMINHO",HB_CWD())


cARQUIVO:=cCAM+"MD10"
dbusearea( .T., "DBFCDX", cARQUIVO,, .T. )
ordlistadd( cARQUIVO)
dbsetorder(1) //

cCAM := PROFILESTRING( "sped.ini","PATH","CNPJIEUF",HB_CWD())


cARQUIVO:=cCAM+"CIDIRRF"
dbusearea( .T., "DBFCDX", cARQUIVO,, .T. )
ordlistadd( cARQUIVO)
dbsetorder(1) //


 aUF    := { "AC", "AL", "AM", "AP", "BA", "CE", "DF", "ES", "GO", ;
              "MA", "MG", "MS", "MT", "PA", "PB", "PE", "PI", "PR", ;
              "RJ", "RN", "RO", "RR", "RS", "SC", "SE", "SP", "TO","SU" } //SU suframa

nFIM:=LEN(aUF)
FOR X=1 TO nFIM
    cARQUIVO:=cCAM+"CNPJIE"+aUF[X]
    IF FILE(cARQUIVO+".DBF")
      dbusearea( .T., "DBFCDX", cARQUIVO,, .T. )
      ordlistadd( cARQUIVO)
      dbsetorder(1) //
      INITVARS()
    ENDIF
    cARQUIVO:=cCAM+"BAIXA"+aUF[X]
    IF FILE(cARQUIVO+".DBF")
      dbusearea( .T., "DBFCDX", cARQUIVO,, .T. )
      ordlistadd( cARQUIVO)
      dbsetorder(1) //
      INITVARS()
    ENDIF
    cARQUIVO:=cCAM+"CNPJIR"+aUF[X]
    IF FILE(cARQUIVO+".DBF")
      dbusearea( .T., "DBFCDX", cARQUIVO,, .T. )
      ordlistadd( cARQUIVO)
      dbsetorder(1) //
      INITVARS()
    ENDIF
NEXT X

       cFOLDER:=GetFolder ( 'Pasta Arquivos tabelas auxiliares sped' )
       cFOLDER+="\"

mListaArq := Directory(cFOLDER+"*ESTABE*.*")                     
nLENX:=LEN(mListaArq)
FOR I= 1 TO nLENX       
    cARQIMP:= UPPER(mListaArq[i,1])
    cDELIM:=FDELIM (cFOLDER+cARQIMP,1024) //acha o delimitador chr(13)+chr(10) dos ou chr(10) linux usado abaixo no freadline
    nFILE:=FOPEN(cFOLDER+cARQIMP) 
	nLINHA:=0
	
     WHILE .T.    
        cLINHA:=FREADLINE (nFILE, 1024 ,.T. ,cDELIM) //FREADLINE (handle, line_len,lremchrexp,cDELI)
		nLINHA++
        IF cLINHA='__FINAL__' //freadline retorna __FINAL__   quando nao e mais linhas
           EXIT
        ENDIF
        MDS(STR(nLINHA)+" "+cLINHA)
		
		
        
        //Usando splitcommaspas especifico em lugar hb_atokens corrigiu ; dentro de campos ex: "predio 01;apto 02"
        aCAMPOS:=SplitCommaAspas(cLINHA) 
		IF LEN(aCAMPOS)<30
		   ALERT(cARQUIVO)
		   ALERT(STR(nLINHA))
		   IF MDG("Erro Encerrar")
		      quit
		   else 
              loop		   
		   ENDIF
		ENDIF
		
        cCNPJ:=aCAMPOS[1]+aCAMPOS[2]+aCAMPOS[3]  //1'cnpj_basico',   2   'cnpj_ordem',    3   'cnpj_dv',
        cNOME:=aCAMPOS[5]                        //5   'nome_fantasia',
        cCNAE:=aCAMPOS[12]                       // 12   'cnae_fiscal_principal',
        cUF  :=aCAMPOS[20]                       //20   'uf',
        cCODCID:=aCAMPOS[21]                     //21   'municipio',
        cDDD:=aCAMPOS[22]                        //22   'ddd_1',
        cTELEFONE:=aCAMPOS[23]                   //23   'telefone_1',

       cDATA:=aCAMPOS[11]                        //11   'data_inicio_atividade',
       dDATA:=STOD(cDATA)
        
       cENDTIP  := aCAMPOS[14]                        //14   'tipo_logradouro',
       cENDERECO:= aCAMPOS[15]                        //15   'logradouro',
       cNUMEND  := aCAMPOS[16]                        //16   'numero',
       cCOMPLEM := strtran(strtran(aCAMPOS[17],"  "," "),"  "," ") //duplos espacos 17   'complemento',
       cBAIRRO  := aCAMPOS[18]                        //18   'bairro',
       cCEP     := aCAMPOS[19]                        //19   'cep',
 
        //01 � NULA 02 � ATIVA 03 � SUSPENSA 04 � INAPTA 08 � BAIXADA
        cSITUACAO:=aCAMPOS[6]                    //6   'situacao_cadastral',
      
        cIBGE:=""
        cCIDADE  := ""
        dbselectar("cidirrf")
        dbgotop()
        if dbseek(cCODCID)
           cCIDADE:=UPPER(ALLTRIM(tratanome(cidirrf->nomecid)))
        endif
        
        dbselectar("md10")
        dbgotop()
        if dbseek(cUF+cCIDADE)
           cIBGE:=MD10->CODIBGE
        else
           cCIDADE:=""
           cUF:=""
        endif

        @ 24,00 say cUF  +  " "+ cIBGE +  " "+ cCNPJ +  " "+  cCNAE  
        IF ASCAN(aUF,cUF)  >0 .AND. ! eMPTY(cUF)  .AND. lEN(ALLTRIM(cUF))=2
          cARQUIVO:="CNPJIE"+cUF
          cARQBX  :="BAIXA"+cUF
          cARQIR  :="CNPJIR"+cUF
          
          dbselectar(cARQUIVO) //ativas
          dbgotop()
          IF DBSEEK(cCNPJ)
             rlock()
             gravairrf()
             dbunlock()
          ENDIF
          
          dbselectar(cARQBX) //baixadas
          dbgotop()
          IF DBSEEK(cCNPJ)
             rlock()
             gravairrf()
             dbunlock()
          ENDIF
 
 
 
          IF cSITUACAO="08" //baixada
             dbselectar(cARQUIVO) //ativas
             dbgotop()
             IF DBSEEK(cCNPJ)
                EQUVARS()
                rlock()
                dbdelete()
                dbselectar(cARQBX) //baixadas
                dbgotop()
                IF ! DBSEEK(cCNPJ)
                   dbappend()
                   replvars()
                ENDIF
             ENDIF       
          ENDIF

          dbselectar(cARQIR) //cnpjir
          dbgotop()
          IF ! DBSEEK(cCNPJ)
             dbappend()
             field->CNPJ       :=cCNPJ
             field->CNAE       :=cCNAE
             field->IBGE       :=cIBGE
             field->CEP        :=cCEP
             field->NUMEND     :=cNUMEND
             field->COMPLEM    :=cCOMPLEM
             field->MATFIL     :=aCAMPOS[4]    //4   'identificador_matriz_filial',
             field->NOME       :=cNOME
             field->EMAIL      :=aCAMPOS[28]   //28   'correio_eletronico',
             field->SITUACAO   :=cSITUACAO
             field->DATASIT    :=aCAMPOS[7]    //7   'data_situacao_cadastral',
             field->CODSIT     :=aCAMPOS[8]    // 8   'motivo_situacao_cadastral',
             field->CIDADEEX   :=aCAMPOS[9]    //9   'nome_cidade_exterior',
             field->PAISEX     :=aCAMPOS[10]   //10   'pais',
             field->DATAINI    :=aCAMPOS[11]   ///11   'data_inicio_atividade',
             field->DDD1       :=cDDD
             field->FONE1      :=cTELEFONE
             field->DDD2       :=aCAMPOS[24]   //24   'ddd_2',
             field->FONE2      :=aCAMPOS[25]   //25   'telefone_2',
             field->DDD3       :=aCAMPOS[26]   //26   'ddd_fax',
             field->FONE3      :=aCAMPOS[27]   //27   'fax',
             field->SITESP     :=aCAMPOS[29]   //29   'situacao_especial',
             field->DATAESP    :=aCAMPOS[30]   //30   'data_situacao_especial']
          ENDIF
          
          xUF:=cUF  //muda para SU mas retorna embaixo
          cUF:="SU"
          dbselectar("cnpjiesu") //suframa
          dbgotop()
          IF DBSEEK(cCNPJ)
             rlock()
             gravairrf()
             dbunlock()
          ENDIF
          cUF:=XUF
          
          
       ENDIF
    ENDDO
    FCLOSE(nfile) 
    ferase(cFOLDER+cARQIMP)
NEXT I
dbcloseall()
alertx("concluido")
mds("...")

function gravairrf()
//27/12/2022 MG agora tem cnae
IF cUF="MA" .OR. cUF="PR" .OR. cUF="RS" .OR. cUF="GO" .OR. cUF="SC" .OR. cUF="PA"  .OR. cUF="MG"
  IF ! EMPTY(cCNAE) .AND. VAL(cCNAE)>0 .AND. LEN(ALLTRIM(cCNAE))=7
     IF  EMPTY(FIELD->CNAE) 
         FIELD->CNAE:=cCNAE
     ENDIF    
  ENDIF
ENDIF
IF ! EMPTY(cNOME)		  
  IF cUF="MA" .OR. cUF="RO" .OR. cUF="GO" .OR. cUF="PB" .OR. cUF="PA" .OR. cUF="MG" .OR. cUF="PI" .OR. cUF="SU" 
     IF EMPTY(FIELD->NOME)
        FIELD->NOME:=cNOME
     ENDIF   
  ENDIF	
ENDIF
IF .NOT. EMPTY(cIBGE) .AND. VAL(cIBGE)>0 .AND. LEN(ALLTRIM(cIBGE))=7  
   IF cUF="GO" .OR. cUF="PB" .OR. cUF="SC" .OR. cUF="DF" .OR. cUF="PR" .OR. cUF="SU"
      IF EMPTY(FIELD->IBGE)
         FIELD->IBGE:=cIBGE
      ENDIF   
   ENDIF	
ENDIF	
IF cUF="SU" 
  IF EMPTY(FIELD->DDD).AND. ! EMPTY(cDDD)
     FIELD->DDD:=cDDD
  ENDIF
  IF EMPTY(FIELD->TELEFONE).AND. ! EMPTY(cTELEFONE)
     FIELD->TELEFONE:=cTELEFONE
  ENDIF
ENDIF
IF cUF="PB"  .OR. cUF="SU"
    IF EMPTY(FIELD->ENDTIP).AND. ! EMPTY(cENDTIP)
       FIELD->ENDTIP:=cENDTIP
    ENDIF
    IF EMPTY(FIELD->ENDERECO).AND. ! EMPTY(cENDERECO)
       FIELD->ENDERECO:=cENDERECO
    ENDIF
    IF EMPTY(FIELD->NUMEND).AND. ! EMPTY(cNUMEND)
       FIELD->NUMEND:=cNUMEND
    ENDIF
    IF EMPTY(FIELD->COMPLEM).AND. ! EMPTY(cCOMPLEM)
       FIELD->COMPLEM:=cCOMPLEM
    ENDIF
    IF EMPTY(FIELD->BAIRRO).AND. ! EMPTY(cBAIRRO)
       FIELD->BAIRRO:=cBAIRRO
    ENDIF
    IF EMPTY(FIELD->CEP).AND. ! EMPTY(cCEP)
       FIELD->CEP:=cCEP
    ENDIF
ENDIF
IF cUF="PA" .OR. cUF="GO" .OR. cUF="SC"
   IF EMPTY(field->DATA) .AND. ! EMPTY(dDATA)
      field->DATA:=dDATA
   ENDIF   
ENDIF	
return