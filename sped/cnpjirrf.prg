REQUEST HB_LANG_PT
REQUEST HB_CODEPAGE_PTISO
REQUEST DBFCDX

function main()

HB_IDLESTATE()
Set( _SET_CODEPAGE, "PTISO")    
HB_LANGSELECT('PT') 
    
rddsetdefault( "DBFCDX" )
Set( _SET_OPTIMIZE, .t.)
Set( _SET_DELETED, .t.)
Set( _SET_SOFTSEEK, .t.)
__SetCentury( .t. )
Set( _SET_EPOCH, year( date() ) - 60 )
Set( _SET_DATEFORMAT, "dd/mm/yyyy" )


setmode(25,80)



//"33600832";"0001";"06";"1";"DALUARI BOUTIQUE";"02";"20190513";"00";"";"";"20190513";"4781400";"4782201,4782202,4783101,4783102";"AVENIDA";"JOSE TOZZI";"1831";"LOJA  04";"CENTRO";"29930245";"ES";"5697";"27";"37638200";"";"";"";"";"CADASTRO@PEREIRABCONTABILIDDE.COM.BR";"";"" 

cARQUIVO:="MD10"
dbusearea( .T., "DBFCDX", cARQUIVO,, .T. )
ordlistadd( cARQUIVO)
dbsetorder(1) //

cARQUIVO:="CIDIRRF"
dbusearea( .T., "DBFCDX", cARQUIVO,, .T. )
ordlistadd( cARQUIVO)
dbsetorder(1) //


 aUF    := { "AC", "AL", "AM", "AP", "BA", "CE", "DF", "ES", "GO", ;
              "MA", "MG", "MS", "MT", "PA", "PB", "PE", "PI", "PR", ;
              "RJ", "RN", "RO", "RR", "RS", "SC", "SE", "SP", "TO","SU" } //SU suframa

nFIM:=LEN(aUF)
FOR X=1 TO nFIM
    cARQUIVO:="CNPJIE"+aUF[X]
    IF FILE(cARQUIVO+".DBF")
      dbusearea( .T., "DBFCDX", cARQUIVO,, .T. )
      ordlistadd( cARQUIVO)
      dbsetorder(1) //
      INITVARS()
    ENDIF
    cARQUIVO:="BAIXA"+aUF[X]
    IF FILE(cARQUIVO+".DBF")
      dbusearea( .T., "DBFCDX", cARQUIVO,, .T. )
      ordlistadd( cARQUIVO)
      dbsetorder(1) //
      INITVARS()
    ENDIF
    cARQUIVO:="CNPJIR"+aUF[X]
//    IF ! FILE(cARQUIVO+".DBF")
 //      FILECOPY("CNPJIR"+".DBF",cARQUIVO+".DBF")
//    ENDIF
//    IF ! FILE(cARQUIVO+".CDX")
//       FILECOPY("CNPJIR"+".CDX",cARQUIVO+".CDX")
//    ENDIF
    IF FILE(cARQUIVO+".DBF")
      dbusearea( .T., "DBFCDX", cARQUIVO,, .T. )
      ordlistadd( cARQUIVO)
      dbsetorder(1) //
      INITVARS()
    ENDIF


NEXT X

mListaArq := Directory("*ESTABE*.*")                     
nLENX:=LEN(mListaArq)
FOR I= 1 TO nLENX       
    cARQIMP:= UPPER(mListaArq[i,1])
    cDELIM:=FDELIM (cARQIMP,1024) //acha o delimitador chr(13)+chr(10) dos ou chr(10) linux usado abaixo no freadline
    nFILE:=FOPEN(cARQIMP) 
     WHILE .T.    
        cLINHA:=FREADLINE (nFILE, 1024 ,.T. ,cDELIM) //FREADLINE (handle, line_len,lremchrexp,cDELI)
        IF cLINHA='__FINAL__' //freadline retorna __FINAL__   quando nao e mais linhas
           EXIT
        ENDIF
        
        //Usando splitirrf especifico em lugar hb_atokens corrigiu ; dentro de campos ex: "predio 01;apto 02"
        aCAMPOS:=SPLITIRRF(cLINHA) 
        cCNPJ:=aCAMPOS[1]+aCAMPOS[2]+aCAMPOS[3]
        cNOME:=aCAMPOS[5]
        cCNAE:=aCAMPOS[12]
        cUF  :=aCAMPOS[20]
        cCODCID:=aCAMPOS[21] 
        cDDD:=aCAMPOS[22]
        cTELEFONE:=aCAMPOS[23]

       cDATA:=aCAMPOS[11]
       dDATA:=STOD(cDATA)
        
       cENDTIP  := aCAMPOS[14]
       cENDERECO:= aCAMPOS[15]
       cNUMEND  := aCAMPOS[16]
       cCOMPLEM := strtran(strtran(aCAMPOS[17],"  "," "),"  "," ") //duplos espacos
       cBAIRRO  := aCAMPOS[18]
       cCEP     := aCAMPOS[19]
     
        cIBGE:=""
        cCIDADE  := ""
        
        
        //01 – NULA 02 – ATIVA 03 – SUSPENSA 04 – INAPTA 08 – BAIXADA
        cSITUACAO:=aCAMPOS[6]
        
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
 
          dbselectar("cnpjiesu") //suframa
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
             field->MATFIL     :=aCAMPOS[4]
             field->NOME       :=cNOME
             field->EMAIL      :=aCAMPOS[28]
             field->SITUACAO   :=cSITUACAO
             field->DATASIT    :=aCAMPOS[7]
             field->CODSIT     :=aCAMPOS[8]
             field->CIDADEEX   :=aCAMPOS[9]
             field->PAISEX     :=aCAMPOS[10]
             field->DATAINI    :=aCAMPOS[11]
             field->DDD1       :=cDDD
             field->FONE1      :=cTELEFONE
             field->DDD2       :=aCAMPOS[24]
             field->FONE2      :=aCAMPOS[25]
             field->DDD3       :=aCAMPOS[26]
             field->FONE3      :=aCAMPOS[27]
             field->SITESP     :=aCAMPOS[29]
             field->DATAESP    :=aCAMPOS[30]
          ENDIF
       ENDIF
    ENDDO
    FCLOSE(nfile) 
NEXT I
dbcloseall()


function TIRAOUT( TEXTO )
texto := strtran( texto, ".", "" )
texto := strtran( texto, ":", "" )
texto := strtran( texto, "-", "" )
texto := strtran( texto, "/", "" )
return texto    


function tratanome(cNOME)
LOCAL npOS
cNOME:=ALLTRIM(cNOME)
npOS:=AT("(",cNOME)
IF npOS>0   
   cNOME:=SUBSTR(cNOME,1,nPOS-1)
   cNOME:=ALLTRIM(cNOME)
ENDIF
cNOME:=STRTRAN(cNOME,"&39;"," ")
cNOME:=STRTRAN(cNOME,"-"," ")
cNOME:=STRTRAN(cNOME,"'"," ")
RETURN cNOME


*****************************************************************
FUNCTION FREADLINE (handle, line_len,lremchrexp,cDELI)
LOCAL buffer, line_end, num_bytes
* Se o tamanho da linha nao for informado, usa o predefinido MAXLINE
IF VALTYPE(line_len) <> 'N'
    line_len = 1024
ENDIF
if valtype(lremchrexp)<>"L"
   lREMCHREXP:=.T.
endif
IF valtype(cDELI)<>"C"
   cDELI:=CHR(13)+CHR(10)
ENDIF
* Define um buffer temporario p/ guardar o tamanho de linha  especificado
buffer = SPACE(line_len)
* Carrega o texto da posicao atual ate' o tamanho de linha especificado
num_bytes = FREAD(handle, @buffer, line_len)
* Localiza a combinacao de retorno de carro/avanco de linha.
line_end = AT(cDELI, buffer)
IF line_end = 0
    * Nao ha' retorno carro/avanco linha. Ponteiro esta' no final do
    * arq. ou linha e' grande demais. Volta ponteiro p/ inicio do arq.
    FSEEK(handle, 0)
    RETURN('__FINAL__')
ELSE
    * Move o ponteiro para o inicio da proxima linha.
    FSEEK(handle, (num_bytes * -1) + line_end + 1, 1)
    * E retorna a linha atual.
    IF lREMCHREXP
       cRETU:= SUBSTR(buffer, 1, line_end - 1)
       cRETU:=  RANGEREPL(CHR(0),CHR(9),cRETU," ")       // CHR(13)+CHR(10)
       cRETU := RANGEREPL( chr( 11 ), chr( 12 ), cRETU," " )  // Line Feed Manter
       cRETU := RANGEREPL( chr( 14 ), chr( 31 ), cRETU," " )  //32 space
       cRETU := RANGEREPL( chr( 127 ), chr( 255 ), cRETU," " )
       RETURN cRETU
    ELSE
       RETURN( SUBSTR(buffer, 1, line_end - 1) )
    ENDIF
ENDIF


FUNCTION FDELIM (cARQ, line_len)
LOCAL buffer, line_end, num_bytes,nhandle,cRETU

IF VALTYPE(line_len) <> 'N'
    line_len = 1024
ENDIF

cRETU:=""
buffer = SPACE(line_len)

nHANDLE:=FOPEN(cARQ)
num_bytes = FREAD(nhandle, @buffer, line_len)
FCLOSE(NHANDLE)


line_end = AT(CHR(13)+CHR(10), buffer)
IF line_end > 0
   cRETU:=CHR(13)+CHR(10) //dos
  // alert("dos")
   return cRETU
endif

  line_end = AT(CHR(10), buffer)
  IF line_end > 0
     cRETU:=CHR(10)  //linux
    // alert("linux")
     return cRETU
  endif

IF EMPTY(cRETU)
  line_end = AT(CHR(255)+CHR(254), buffer)
  IF line_end > 0
     cRETU:=CHR(255)+ CHR(254) //unicode
  endif
ENDIF
IF EMPTY(cRETU)
  line_end = AT(CHR(239)+CHR(187)+CHR(191), buffer)
  IF line_end > 0
     cRETU:=CHR(239)+ CHR(187)+CHR(191) //utf-8
  endif
ENDIF
RETURN cRETU


FUNCTION SPLITIRRF(cLINHA)
LOCAL aRETU,cVALOR,nPOS
//CLINHA:='"33600823";"0001";"07";"1";"SALGADOS DA ERIDIANA";"08";"20190722";"01";"";"";"20190513";"5620104";"1096100,1093702";"RUA";"EMILIO VASCONCELOS";"288";"";"CENTRO";"39790000";"MG";"4011";"33";"88333829";"";"";"";"";"adelano.deptofiscal@gmail.com";"";"'
aRETU:={}
while at('";"',cLINHA)>0
    nPOS:=at('";"',cLINHA)
    cVALOR:=SUBSTR(cLINHA,2,nPOS-2)
    cLINHA:=SUBSTR(cLINHA,nPOS+2)
//    ALERT(cVALOR)
//    ALERT(cLINHA)
    AADD(aRETU,cVALOR)
enddo
IF LEN(cLINHA)>0 //caso o ultimo campo nao tenha delimitador
    AADD(aRETU,strtran(cLINHA,'"',''))
ENDIF
RETURN aRETU


function gravairrf()
IF cUF="MA" .OR. cUF="PR" .OR. cUF="RS" .OR. cUF="GO" .OR. cUF="SC" .OR. cUF="PA"
  IF ! EMPTY(cCNAE) .AND. EMPTY(FIELD->CNAE) .AND. VAL(cCNAE)>0 .AND. LEN(ALLTRIM(cCNAE))=7
     FIELD->CNAE:=cCNAE
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