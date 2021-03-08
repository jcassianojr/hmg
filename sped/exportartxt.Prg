#include <hmg.ch>
function gera150()
cARQSPED:= "SPED_"+ArqLogDataHora("txt")
cARQSPED2:= "SPEDXML_"+ArqLogDataHora("txt")

cCAM   := PROFILESTRING( "sped.ini","CNPJXML.DBF","CAMINHO",HB_CWD())+"CNPJXML"
IF ! netuse(cCAM)
   return
endif
nSPED:=fcreate(cARQSPED)
nSPEDXML:=fcreate(cARQSPED2)
// set filter to recno()>3822
dbgotop()
WHILE ! EOF()
    MDS(CNPJ)
    aSPED:=ARRAY(14)
    aSPED[1]:="" //sep
    aSPED[2]:="0150"
    IF EMPTY(CODPART)
       aSPED[3]:=ALLTRIM(CNPJ)
    ELSE 
       aSPED[3]:=ALLTRIM(CODPART)
    ENDIF   
    aSPED[4]:=ALLTRIM(NOME)
    aSPED[5]:=ALLTRIM(BACEN)
    IF LEN(ALLTRIM(CNPJ))=11 
        aSPED[6]:=""
        aSPED[7]:=ALLTRIM(CNPJ) //Pessoa Fisica CPF
    ELSE
        aSPED[6]:=ALLTRIM(CNPJ) //Pessoa Juridica CNPJ
        aSPED[7]:=""    
    ENDIF
    aSPED[8]:=ALLTRIM(IE) 
    aSPED[9]:=ALLTRIM(CODIBGE) 
    aSPED[10]:=ALLTRIM(SUFRAMA) 
    aSPED[11]:=ALLTRIM(ENDERECO)
    aSPED[12]:=ALLTRIM(NUMEND) 
    aSPED[13]:=ALLTRIM(COMPLEM) 
    aSPED[14]:=ALLTRIM(BAIRRO)
    gerarr(aSPED,nSPED)
    AADD(aSPED,ALLTRIM(NOME)) // fantasia
    AADD(aSPED,ALLTRIM(CIDADE)) 
    AADD(aSPED,ALLTRIM(UF)) 
    AADD(aSPED,ALLTRIM(CEP))
    AADD(aSPED,ALLTRIM(PAIS))
    AADD(aSPED,"("+DDD+")"+ALLTRIM(TELEFONE)) 
    AADD(aSPED,ALLTRIM(IESUBST)) 
    AADD(aSPED,ALLTRIM(EMAIL))
    AADD(aSPED,ALLTRIM(IMUNICIPAL)) 
    AADD(aSPED,ALLTRIM(CNAE))
    gerarr(aSPED,nSPEDXML)     
    DBSKIP()                
ENDDO                   
FCLOSE(nSPED)
FCLOSE(nSPEDXML)
DBCLOSEALL()
MDS("Gerado")