#include <hmg.ch>
function ChecarSintxml()


aCNV:=aconvertend()



nUSO:=FCREATE("SERTXML.TXT")
nUSO2:=FCREATE("SERTXML2.TXT")

cCAMINHO   := PROFILESTRING( "sped.ini","CNPJXML.DBF","CAMINHO",HB_CWD())+"CNPJXML"
IF ! NETUSE(cCAMINHO,"DBFCDX")
   return
endif

cCAMINHO   := PROFILESTRING( "sped.ini","SINTCERT.DBF","CAMINHO",HB_CWD())+"SINTCERT"
IF ! NETUSE(cCAMINHO,"DBFCDX")
   dbcloseall()
   return
endif

cCAMINHO   := PROFILESTRING( "sped.ini","MD10.DBF","CAMINHO",HB_CWD())+"MD10"
if ! netuse(cCAMINHO,"DBFCDX")
   dbcloseall()
   return
endif

cCAMINHO   := PROFILESTRING( "sped.ini","CIDCONV.DBF","CAMINHO",HB_CWD())+"CIDCONV"
if ! netuse(cCAMINHO,"DBFCDX")
   dbcloseall()
   return
endif

cCAMINHO   := PROFILESTRING( "sped.ini","CCMSP.DBF","CAMINHO",HB_CWD())+"CCMSP"
if ! netuse(cCAMINHO,"DBFCDX")
   dbcloseall()
   return
endif


dbselectar("CNPJXML")
dbgotop()
while ! eof()
   cCNPJ:= CNPJXML->CNPJ
   cUF:= CNPJXML->UF
   mds(cCNPJ)   
   netreclock()	   
    IF len(cCNPJ)=11.AND.Valcpf( cCNPJ ,.F.)  .and. empty(cnpjxml->XREGAPUR)         
       CNPJXML->XREGAPUR:="CPF" 
       IF EMPTY(CNPJXML->IE)
          cnpjxml->IE:="ISENTO"
       ENDIF                	
    ENDIF
    IF cUF="EX"  .and. empty(cnpjxml->XREGAPUR)       
       CNPJXML->XREGAPUR:="EX"       
    ENDIF
    IF cUF="??"
       CNPJXML->UF:=""
    ENDIF   
   IF EMPTY(XREGAPUR) .and. (cUF="SP" .OR. EMPTY(cUF)) .and. VALCGC(cCNPJ,,.F.) 
	   IF LEFT(ALLTRIM(TIRAOUT(IMUNICIPAL)),5)="ISENT"	 // zera a xregapur para o robo checar novamente     
		   cnpjxml->IMUNICIPAL:=""
       IF LEFT(XREGAPUR,3)='256' .OR. LEFT(XREGAPUR,3)='259' //com erro evita pesquisar novamente
       ELSE 
   		   cnpjxml->XREGAPUR:=""
       endif  
	   ELSE
         IF ! EMPTY(cnpjxml->IMUNICIPAL)
            nTAMCCM:=TamanhoCCM(CNPJXML->CIDADE,CNPJXML->UF)
            IF nTAMCCM>0.AND.LEN(ALLTRIM(TIRAOUT(CNPJXML->IMUNICIPAL)))<>nTAMCCM // zera a xregapur para o robo checar novamente     
               cnpjxml->IMUNICIPAL:=""
               IF LEFT(XREGAPUR,3)='256' .OR. LEFT(XREGAPUR,3)='259' //com erro evita pesquisar novamente
               ELSE 
                  cnpjxml->XREGAPUR:=""
               endif         
            ENDIF
         ENDIF         
      ENDIF
  	   IF LEFT(ALLTRIM(TIRAOUT(IE)),5)="ISENT".OR.EMPTY(IE)     // zera a xregapur para o robo checar novamente     
	        cnpjxml->IE:=""
          IF LEFT(XREGAPUR,3)='256' .OR. LEFT(XREGAPUR,3)='259' //com erro evita pesquisar novamente
          ELSE
             cnpjxml->XREGAPUR:=""
          ENDIF   
	   ENDIF
      IF TIRAOUT(IE)=TIRAOUT(IMUNICIPAL)
         cnpjxml->IE:=""
    	   cnpjxml->IMUNICIPAL:=""
         IF LEFT(XREGAPUR,3)='256' .OR. LEFT(XREGAPUR,3)='259' //com erro evita pesquisar novamente
         ELSE
      	     cnpjxml->XREGAPUR:=""
         endif	   
      ENDIF
   ENDIF
   IF VAL(cnpjxml->IE)=VAL(cnpjxml->IMUNICIPAL) .AND. VAL(cnpjxml->IMUNICIPAL)>0
    	cnpjxml->IMUNICIPAL:=""
      fwrite(nUSO,cnpjxml->CNPJ+" IE=CCM zerada"+cBUSCA+HB_OsNewLine())   
   ENDIF
   IF CNPJXML->BACEN="01058"
      CNPJXML->BACEN:="1058"
   ENDIF   
   IF EMPTY(PAIS) .AND. BACEN='1058'
      CNPJXML->PAIS:="BRASIL"
   ENDIF
   IF EMPTY(BACEN) .AND. PAIS="BRASIL"
      CNPJXML->BACEN:="1058"
   ENDIF
   if len(alltrim(telefone))=12 .and. left(telefone,2)="55"
       cnpjxml->ddd:=substr(telefone,3,2)
	   cnpjxml->telefone:=substr(telefone,5)
   endif
   if len(alltrim(telefone))=11 //Celular com 9 digitos
      cnpjxml->ddd     :=left(telefone,2)
	  cnpjxml->telefone:=substr(telefone,3)
   endif  
   if len(alltrim(telefone))=10
      cnpjxml->ddd     :=left(telefone,2)
	  cnpjxml->telefone:=substr(telefone,3)
   endif
   if len(alltrim(CEP))<8      
	   cnpjxml->cep:=""
   endif   
   if len(alltrim(telefone))<8      
	   cnpjxml->telefone:=""      
   endif   
   IF empty(cnpjxml->ie) .and. len(alltrim(cCNPJ))=14 .AND. ValcGC( cCNPJ ,,.F.) .AND. !  EMPTY(CNPJXML->UF) .AND. CNPJXML->UF<>"??"	  
      cIE:=""      
      cARQ   := PROFILESTRING( "sped.ini","PATH","CNPJIEUF",HB_CWD())
      cARQ+="cnpjie"+CNPJXML->UF	  
	  IF FILE(cARQ+".DBF")
	    IF NETUSE(CARQ)
		  dbgotop()
		  if dbseek(Ccnpj)
			 cIE:=IE
		  endif
		  dbclosearea()
		ENDIF
      ENDIF       
	  dbselectar("cnpjxml")
	  if ! empty(cIE)
	     cnpjxml->IE:=cIE
	  endif
   endif    
   
   CnpjxmlIbge()
   
   
   IF empty(cnpjxml->CODIBGE) .AND. ! empty(cnpjxml->cidade) .AND. ! EMPTY(cnpjxml->UF)
      cBUSCA:=cnpjxml->UF+ALLTRIM(cnpjxml->cidade)
      cCODIBGE:=""      
      dbselectar("MD10")
      DBsetorder(1)
 	   dbselectar("MD10")
	   dbgotop()
	   if dbseek(cBUSCA)         
         cCODIBGE:=MD10->CODIBGE
      endif 
	   dbselectar("cnpjxml")	
      IF ! EMPTY(cCODIBGE)      
         cnpjxml->CODIBGE:=cCODIBGE
      endif   
	   dbselectar("MD10")
      set filter to
      dbsetorder(1)
   ENDIF

   IF EMPTY(cnpjxml->UF) .and. ! empty(cnpjxml->CODIBGE)      
      cCODUF:=coduf(cnpjxml->CODIBGE,"UF")      
      IF cCODUF<>"??"
         cnpjxml->UF:=Ccoduf
      ENDIF   
   ENDIF

   
   if empty(cnpjxml->ddd).And.! empty(cnpjxml->CIDADE)   
      cDDD:=""      
      cBUSCA:=cnpjxml->UF
      cBUSCA+=PEGCIDCONV(cnpjxml->UF,TRATANOME(ALLTRIM(cnpjxml->CIDADE)))
	   dbselectar("MD10")
	   dbgotop()
	   if dbseek(cBUSCA)
	      cDDD:=MD10->DDD
      else 
         fwrite(nUSO,cnpjxml->CNPJ+" cidade nao cadastrada:"+cBUSCA+HB_OsNewLine())   
	   endif
	   dbselectar("cnpjxml")
	   if ! empty(cDDD)
	      cnpjxml->DDD:=cDDD
	   endif	    
   endif   
   
   if (len(alltrim(tiraout(cnpjxml->telefone)))=8 .or. len(alltrim(tiraout(cnpjxml->telefone)))=9) .and. at("-",cnpjxml->telefone)=0     
      cnpjxml->telefone:=formatatel(cnpjxml->telefone)
   endif	  
   
   
    IF cnpjxml->uf="SP" .AND. cnpjxml->cidade="SAO PAULO" .AND. LEN(TIRAOUT(cnpjxml->IMUNICIPAL))=8
       cnpjxml->IMUNICIPAL:=FORMATACCM(cnpjxml->IMUNICIPAL)
    endif   
   
   IF cnpjxml->uf="RS" .AND. LEN(ALLTRIM(TIRAOUT(cnpjxml->IE)))=9  //inscricao de 9 digitos antigas se acresenta 0 para ficar com 10
      cnpjxml->IE:='0'+cnpjxml->IE
   endif
   
   
   dbselectar("cnpjxml")
   

   
      
   CorrigeEndereco("ENDERECO","NUMEND","COMPLEM","ENDTIP")   
   
   
   
   
   dbunlock()	   
   dbskip()
enddo



aGERLOG:={.T.   ,.T. ,.T. ,.T.     ,.T.    ,.T.  ,.F.  ,.F.  ,.F.       ,.F.    ,.F.   ,.T. , .F.}
aCAMPOS:={"CNPJ","IE","UF","CIDADE","RAZAO","CCM","CEP","DDD","TELEFONE","EMAIL","CNAE","SUFRAMA","ENDTIP"}
dbselectar("sintcert")
dbgotop()
while ! eof()
   netreclock()
   aDADOS:={"","","","","","","","","","","","",""}
	cCNPJ:=ALLTRIM(TIRAOUT(CNPJ))
   mds(cCNPJ)	
	dbselectar("cnpjxml")
	dbgotop()
	if dbseek(cCNPJ)	 	   
	   aDADOS:={CNPJ,IE,UF,CIDADE,NOME,IMUNICIPAL,TIRAOUT(CEP),DDD,TELEFONE,lower(EMAIL),CNAE,SUFRAMA,ENDTIP}   
   endif  
   dbselectar("sintcert")
	IF ! EMPTY(aDADOS[1])
      FOR X=2 TO 13 // nao gravar cnpj
         cCAMPO:=ACAMPOS[X]
         IF EMPTY(&cCAMPO.).AND.! EMPTY(aDADOS[X])
            SINTCERT->&cCAMPO.:=aDADOS[X]
         ENDIF
		  cUSO01:=alltrim(tiraout(&cCAMPO.))
		  cUSO02:=alltrim(tiraout(aDADOS[X]))
		  IF x<>5 .and. cUSO01 <> cUSO02
		     lGRAVA:=.T.		     
 			 IF X=6.AND.(cUSO01="ISENTO" .OR. cUSO01="ISENTA" .OR. EMPTY(CCM)) //CCM
			    FWRITE(nUSO2,cCNPJ+" "+UF+" "+CIDADE+" "+CcAMPO+": "+cUSO01+"<>"+cUSO02+HB_OsNewLine())
	          SINTCERT->CCM:=cUSO02
				 lGRAVA:=.F.
			 ENDIF
			IF X=2.AND.(cUSO01="ISENTO" .OR. cUSO01="ISENTA" .OR. EMPTY(IE)) //IE
			    FWRITE(nUSO2,cCNPJ+" "+UF+" "+CcAMPO+": "+cUSO01+"<>"+cUSO02+HB_OsNewLine())
				SINTCERT->IE:=cUSO02
			    lGRAVA:=.F.
			 ENDIF			 
			 IF lGRAVA.AND.aGERLOG[X]
			    FWRITE(nUSO,cCNPJ+" "+UF+" "+CIDADE+" "+CcAMPO+": "+cUSO01+"<>"+cUSO02+HB_OsNewLine())
			 ENDIF
		  ENDIF
      NEXT X
      IF VAL(SINTCERT->IE)=VAL(SINTCERT->CCM).AND.VAL(SINTCERT->CCM)>0
        	SINTCERT->CCM:=""
         fwrite(nUSO,SINTCERT->CNPJ+" IE=CCM zerada"+cBUSCA+HB_OsNewLine())   
      ENDIF      
	  IF EMPTY(CNPJOK).AND.cCNPJ=ALLTRIM(TIRAOUT(aDADOS[1]))
	     SINTCERT->CNPJOK:="S"
	  ENDIF
	  IF EMPTY(IEOK).AND.ALLTrIM(TIRAOUT(IE))=alltrim(TIRAOUT(aDADOS[2]))
	     SINTCERT->IEOK:="S"
	  ENDIF
	  IF EMPTY(CCMOK).AND.alltrim(TIRAOUT(CCM))=alltrim(TIRAOUT(aDADOS[6]))
	     SINTCERT->CCMOK:="S"
	  ENDIF	 
      if uf = "SP" .Or. uf = "RS" .Or. uf = "MG" .Or. uf = "PE"	  // Estados com checagem 3digitos
	  else
	     if empty(DIG3OK)
		    sintcert->dig3ok:="S"  // Estados sem checagem 3digitos marca como ok
		 endif
	  endif
	endif
	if at("/",cnpj)=0
	   SINTCERT->CNPJ:=FORMATaCNPJ(CNPJ)
	endif
   if empty(sintcert->ddd).and. ! empty(sintcert->CIDADE)         //.OR.empty(sintcert->codibge))        
       cBUSCA:=sintcert->UF
       cBUSCA+=PEGCIDCONV(sintcert->UF,TRATANOME(ALLTRIM(sintcert->CIDADE)))
	    dbselectar("MD10")
	    dbgotop()
	    if dbseek(cBUSCA)          
          IF empty(sintcert->ddd)
             sintcert->DDD:=MD10->DDD
          ENDIF
       else 
          fwrite(nUSO,SINTCERT->CNPJ+" cidade nao cadastrada:"+cBUSCA+HB_OsNewLine())   
	    endif
    endif 
    IF SINTCERT->CCMOK="S" .AND. SINTCERT->uf="SP" .AND. SINTCERT->cidade="SAO PAULO" 
       cCCM:=ALLTRIM(TIRAOUT(sintcert->ccm))
       IF LEN(cCCM)=8 
          dbselectar("ccmsp")
          dbgotop()
          if dbseek(cCNPJ) 
             netreclock()          
             ccmsp->CCM:=cCCM
             dbunlock()
          endif 
          SINTCERT->CCM:=FORMATACCM(SINTCERT->CCM)
       endif   
    endif
    dbselectar("sintcert")    
    if len(alltrim(telefone))<8      
	   sintcert->telefone:=""
    endif  
    if len(alltrim(cep))<8      
	   sintcert->cep:=""
    endif  
	
   IF sintcert->uf="RS" .AND. LEN(ALLTRIM(TIRAOUT(sintcert->IE)))=9  //inscricao de 9 digitos antigas se acresenta 0 para ficar com 10
      sintcert->IE:='0'+sintcert->IE
   endif
	
	
   CorrigeEndereco("ENDERECO","NUMEND","COMPLEM","ENDTIP")  
	
    dbunlock()

	
	 
    dbskip()
enddo
FCLOSE(nUSO)
FCLOSE(nUSO2)

aCAMPOS:={"CNPJ","IE","UF","CIDADE","NOME","IMUNICIPAL","CEP","DDD","TELEFONE","EMAIL","CNAE","SUFRAMA","ENDTIP"}   
dbselectar("sintcert")
dbgotop()
while ! eof()
   aDADOS:={CNPJ,IE,UF,CIDADE,RAZAO,CCM,CEP,DDD,TELEFONE,lower(EMAIL),CNAE,SUFRAMA,ENDTIP}
 	cCNPJ:=TIRAOUT(CNPJ)   
	cIE  :=TIRAOUT(IE)
	cUF  :=UF
    mds(cCNPJ)	
 	dbselectar("cnpjxml")
	dbgotop()
	if dbseek(cCNPJ)	 	   
	  netreclock()
      FOR X=3 TO 13 // nao gravar cnpj/ie abaixo       
          cCAMPO:=ACAMPOS[X]
          IF EMPTY(&cCAMPO.) .AND. ! EMPTY(aDADOS[X])
             CNPJXML->&cCAMPO.:= aDADOS[X]
          ENDIF	  
      NEXT X
	  IF EMPTY(CNPJXML->IE) .and.  ValIE( cIE , cUF, , .f. )
		 CNPJXML->IE:= cIE
	  Endif
	  if .not. ValIE(CNPJXML->IE , CNPJXML->UF, , .f. )
	     CNPJXML->IE:= ""
	  endif
	  if .not. valcgc(CNPJXML->cnpj, , .f.) .and. .not. valcpf(CNPJXML->cnpj , .f. )
	      dbdelete()
	  endif
	  dbunlock()
   ENDIF      
   dbselectar("sintcert")
   dbskip()
enddo


dbselectar("sintcert") //Checa duplicidades
dbgotop()
while ! eof()
   cCNPJ:=TIRAOUT(CNPJ)   
   MDS(cCNPJ)   
   dbskip()
   if ! eof()
      IF TIRAOUT(CNPJ)=cCNPJ
	     netrecdel()
	  endif
   endif
enddo
mds("...")
dbcloseall()
return .t.

function CnpjxmlIbge()
IF (empty(cnpjxml->cidade) .OR. EMPTY(cnpjxml->UF)) .and. ! empty(cnpjxml->CODIBGE) 
      cBUSCA:=cnpjxml->CODIBGE
      cUF:=""
      cCIDADE:=""
      dbselectar("MD10")
      DBsetorder(3)
 	   dbselectar("MD10")
	   dbgotop()
	   if dbseek(cBUSCA)
         cUF:=MD10->UF
         cCIDADE:=MD10->NOME
      endif 
	   dbselectar("cnpjxml")
	   if ! empty(cUF).AND.EMPTY(cnpjxml->UF)
	      cnpjxml->UF:=cUF
	   endif	    
	   if ! empty(cCIDADE).AND.EMPTY(cnpjxml->cidade)
	      cnpjxml->CIDADE:=cCIDADE
	   endif        
      dbselectar("MD10")
      set filter to
      dbsetorder(1)
   ENDIF
return .t.



FUNCTION CorrigeEndereco(eENDER,eENDNUM,eENDCOMPL,eENDTIP)
local  cENDER,cENDNUM,cENDCOMPL,cENDTIP,nLEN,nFIM,X,nLENEND

cENDER   :=&eENDER.
nLENEND:=LEN(cENDER)
cENDER:=ALLTRIM(cENDER)
cENDNUM  :=aLLTRIM(&eENDNUM.)
cENDCOMPL:=aLLTRIM(&eENDCOMPL.)
cENDTIP:=aLLTRIM(&eENDTIP.)

cENDER:=STRTRAN(cENDER,cENDNUM,"")
cENDER:=STRTRAN(cENDER,cENDCOMPL,"")
cENDER:=STRTRAN(cENDER,","," ")
cENDER:=STRTRAN(cENDER,"  "," ") //duplo espacos
cENDER:=STRTRAN(cENDER,"."," ")
cENDER:=STRTRAN(cENDER,":"," ")
IF ! EMPTY(cENDTIP)
   cENDER:=STRTRAN(cENDER,cENDTIP+" "," ")
ENDIF   
cENDER:=STRTRAN(cENDER,"  "," ") //duplo espacos
nFIM:=LEN(ACNV)
for x=1 to nFIM
    nLEN:=LEN(aCNV[X,1])
    if aCNV[X,1]=SUBSTR(cENDER,1,NlEN)
       cENDER :=alltrim(SUBSTR(cENDER,NlEN+1))
       cENDTIP:=aCNV[X,2]
       exit
    endif
next x
DO CASE
   CASE ALIAS()="SINTCERT"        
        SINTCERT->ENDERECO:=cENDER
		SINTCERT->ENDTIP  :=cENDTIP
   CASE ALIAS()="CNPJXML"        
        CNPJXML->ENDERECO:=cENDER
		CNPJXML->ENDTIP  :=cENDTIP
   OTHERWISE
        FIELD->ENDERECO:=cENDER
		FIELD->ENDTIP  :=cENDTIP
ENDCASE		
IF EMPTY(cENDER)
   FIELD->ENDTIP:=''   // apaga o tipo se nao tiver endereco
endif   
RETURN cENDER