//SELECT DISTINCT CAST(tiraout(cnpjcpf(clientes.num_cgc_cpf)) AS CHAR(8)) 
//FROM clientes 
//LEFT JOIN par_edi_mgr ON clientes.cod_cliente=par_edi_mgr.cod_cliente
//WHERE clientes.cod_cliente[1,2] IN ('10','11','30','40','57','64','86','87')
//AND par_edi_mgr.local_arq='p:\totvs\sintel\avb\'

// logixsup (I)nutilizada(C)ancelada(<)3 tres meses(X)nao e itaesbra/outros(S)suprimentos(Y)transf filial(F)aturamento
// logixsup (I)nutilizada(C)ancelada(<)3 tres meses(X)nao e itaesbra/outros(S)suprimentos(Y)transf filial(F)aturamento


#include <hmg.ch>
#include "adordd.ch"                           
#include "try.ch"
#include "common.ch"
#include "hbclass.ch"
#include "dbinfo.ch"


REQUEST HB_CODEPAGE_PTISO

//REQUEST HB_LANG_PT
//REQUEST HB_CODEPAGE_PT850
REQUEST DBFCDX


Function Main

  HB_IDLESTATE()  
  Set( _SET_CODEPAGE, "PTISO" )
 // HB_LANGSELECT('PT')       
 // HB_SETCODEPAGE('PT850')
//  hb_cdpSelect( "PT850" )
  
  rddsetdefault( "DBFCDX" )
	Set( _SET_OPTIMIZE, .t.)
	Set( _SET_DELETED, .t.)
	Set( _SET_SOFTSEEK, .t.)

__SetCentury( .t. )
Set( _SET_EPOCH, year( date() ) - 60 )
Set( _SET_DATEFORMAT, "dd/mm/yyyy" )

//  set century on
//  set date BRITI
//  set epoch to year( date() ) - 60
 
  
  public oSEFAZ  
  
   oSefaz             := SefazClass():New()   
   oSefaz:cUF        := "SP"  
   oSefaz:cCertificado := CapicomEscolheCertificado()     
   
   oSefaz:cAmbiente    := "1"
   
   //
   //oSefaz:cAmbiente    := WS_AMBIENTE_PRODUCAO         "1" //  #include "sefazclass.ch"
  
   cCAM:=hb_cwd()

  aPar := HB_AParams()
  lROBO:=.F.
  lFALTAXML:=.T.
  
  
  
  //SERVER=smtp.kinghost.net
//PORTA=587
//FROM=nfe.ieb@itaesbra.com.br
//USUARIO=nfe.ieb@itaesbra.com.br
//SENHA=1t@3sbra
//POP=smtp.kinghost.net


   cSERVERIP    :="smtp.kinghost.net" //PROFILESTRING( "LERXML.INI","EMAIL","SERVER")
   nPORT        := "587" //VAL(PROFILESTRING( "LERXML.INI","EMAIL","PORTA"))
   cFROM        := "nfe.ieb@itaesbra.com.br" //PROFILESTRING( "LERXML.INI","EMAIL","FROM")
   cUSER        := "nfe.ieb@itaesbra.com.br" //PROFILESTRING( "LERXML.INI","EMAIL","USUARIO")
   cPASS        := "1t@3sbra" //PROFILESTRING( "LERXML.INI","EMAIL","SENHA")
   cPOP         := "smtp.kinghost.net" //PROFILESTRING( "LERXML.INI","EMAIL","POP")
   
   cMEMORIZADOS  := PROFILESTRING( "LERXML.INI","PATH","MEMORIZADOS")   
   cMEMORIZAR    := PROFILESTRING( "LERXML.INI","PATH","MEMORIZAR")   
   cMEMOFISCAL    := PROFILESTRING( "LERXML.INI","PATH","MEMOFISCAL") //caso seja necessario memorizar em outra pasta alem do danfeview
   
   cNFE           := PROFILESTRING( "LERXML.INI","PATH","NFE")     
   cNFECNPJ      := PROFILESTRING( "LERXML.INI","PATH","NFECNPJ")
   cPDF           := PROFILESTRING( "LERXML.INI","PATH","PDF")          //reenvie email do pdf alem do xml
   cDANFEVIEW    := PROFILESTRING( "LERXML.INI","PATH","DANFEVIEW")   //caminho dos exe do danfeview para exec sub-funcios
   cCAMCCM       := PROFILESTRING( "lerxml.ini","PATH","CNPJIEUF",HB_CWD())  //caminho cadastro inscricoes municipais e estaduais
   
   cELECTROLUXAVB:=PROFILESTRING( "LERXML.INI","PATH","ELECTROLUXAVB",cCAM)  //caminho avb e xml do neogrid/electrolux
   cELECTROLUXENV:=PROFILESTRING( "LERXML.INI","PATH","ELECTROLUXENV",cCAM)  
   cELECTROLUXLOG:=PROFILESTRING( "LERXML.INI","PATH","ELECTROLUXLOG",cCAM)  
   
   cLOGIX      := PROFILESTRING( "LERXML.INI","PATH","LOGIX")       //logix mes corrente matriz e filiais
   cLOGIX2      := PROFILESTRING( "LERXML.INI","PATH","LOGIX2")    //
   cLOGIX3      := PROFILESTRING( "LERXML.INI","PATH","LOGIX3")    //
   cLOGIX4      := PROFILESTRING( "LERXML.INI","PATH","LOGIX4")    //
   
   cLOGIXARQ   := PROFILESTRING( "LERXML.INI","PATH","LOGIXARQ")   //logix mes anteriores   
   cANOBASE    := PROFILESTRING( "LERXML.INI","PATH","ANOBASE")      //ano base
   cANOBASR    := RIGHT(cANOBASE,2)                                  //ano base 2 digitos
   
   cIMPORTA01  := PROFILESTRING( "LERXML.INI","PATH","IMPORTA01")   //outros diretorios para importacao alem do padrao
   cIMPORTA02  := PROFILESTRING( "LERXML.INI","PATH","IMPORTA02")
   cIMPORTA03  := PROFILESTRING( "LERXML.INI","PATH","IMPORTA03")   
   cIMPORTA04  := PROFILESTRING( "LERXML.INI","PATH","IMPORTA04")   
   cIMPORTA05  := PROFILESTRING( "LERXML.INI","PATH","IMPORTA05")      
   cIMPORTA06  := PROFILESTRING( "LERXML.INI","PATH","IMPORTA06")      
   cIMPORTA07  := PROFILESTRING( "LERXML.INI","PATH","IMPORTA07")      
   cIMPORTA08  := PROFILESTRING( "LERXML.INI","PATH","IMPORTA08")      
   cIMPORTA09  := PROFILESTRING( "LERXML.INI","PATH","IMPORTA09")      
   cIMPORTA10  := PROFILESTRING( "LERXML.INI","PATH","IMPORTA10")      
   
   cSLFProfile := PROFILESTRING( "LERXML.INI","PATH","SLFProfile")      
   
   cGRVLOGGMPROT := PROFILESTRING( "LERXML.INI","PATH","GRVLOGGMPROT")        //grava protocolo gm rechecagem xml
   cNFECHECK     := PROFILESTRING( "LERXML.INI","PATH","NFECHECK")           //verifica situacao nos sefaz SIM/NAO

   cTMP     := PROFILESTRING( "LERXML.INI","ACNPJXML","CNPJ")   
   aCNPJXML:=HB_ATOKENS(cTMP,",") 
   cTMP     := PROFILESTRING( "LERXML.INI","ACNPJAVB","CNPJ")   
   aCNPJAVB:=HB_ATOKENS(cTMP,",")   

   aCNPJITA:={"61381323000248","61381323000167","61381323000329","61381323000400","61381323000590"}
      
   aACOES:=AcoesDanfe()
   
   aCONSULTA:={}
   AADD(aCONSULTA,"Nacional") 
   AADD(aCONSULTA,"Sao Paulo")
   AADD(aCONSULTA,"SEFAZ RS->AC,AL,AM,AP,DF,MS,PB,RJ,RO,RR,RS,SC,SE,TO") 
   AADD(aCONSULTA,"Consultar Status")  
  
  Load Window Main

  Main.Center
  Main.Activate
  
Return

function statussefaz()
      cXmlRetorno := oSefaz:NfeStatusServico() //oSefaz:NfeStatus()
      cTexto := "Tipo Ambiente:"     + XmlNode( cXmlRetorno, "tpAmb" ) + HB_EOL()
      cTexto += "Versão Aplicativo:" + XmlNode( cXmlRetorno, "verAplic" ) + HB_EOL()
      cTexto += "Status:"            + XmlNode( cXmlRetorno, "cStat" ) + HB_EOL()
      cTexto += "Motivo:"            + XmlNode( cXmlRetorno, "xMotivo" ) + HB_EOL()
      cTexto += "UF:"                + XmlNode( cXmlRetorno, "cUF" ) + HB_EOL()
      cTexto += "Data/Hora:"         + XmlNode( cXmlRetorno, "dhRecbto" ) + HB_EOL()
      cTexto += "Tempo Médio:"       + XmlNode( cXmlRetorno, "tMed" ) + HB_EOL()
      wapi_MessageBox( , cTexto, "Informação Extraída" )
return .t.



function checkcad()
mds("Iniciando checkcad")
mds("Abrindo Arquivo CNPJXML")
IF ! NETUSE("CNPJXML","DBFCDX")
    return
endif   
mds("Abrindo Arquivo SINTcert")
IF ! NETUSE("SINTCERT","DBFCDX")
    return
endif        
for z=1 to 2
   if z=1
       dbSelectar("CNPJXML")              
       aORI:={'IE','cSIT','indCredNFe','indCredCTe','NOME','xRegApur','CNAE','dIniAtiv','dUltSit','CIDADE','CEP','BAIRRO','CODIBGE','ENDERECO','NUMEND','complem','endtip','ultimaimp'}	   //cnpjxml 
	   aDES:={'IE','cSIT','indCredNFe','indCredCTe','RAZAO','xRegApur','CNAE','dIniAtiv','dUltSit','CIDADE','CEP','BAIRRO','CODIBGE','ENDERECO','NUMEND','complem','endtip','ultimaimp'}     //sintcert
   else
       dbSelectar("SINTCERT")
       aORI:={'IE','cSIT','indCredNFe','indCredCTe','RAZAO','xRegApur','CNAE','dIniAtiv','dUltSit','CIDADE','CEP','BAIRRO','CODIBGE','ENDERECO','NUMEND','complem','endtip','ultimaimp'} //cnpjxml
	   aDES:={'IE','cSIT','indCredNFe','indCredCTe','NOME','xRegApur','CNAE','dIniAtiv','dUltSit','CIDADE','CEP','BAIRRO','CODIBGE','ENDERECO','NUMEND','complem','endtip','ultimaimp'}  //sintcert	   
   endif      
   dbgotop()
   while ! eof()
       cUF  :=FIELD->UF       
       cCNPJ:=FIELD->CNPJ   
       cIE  :=ALLTRIM(TIRAOUT(FIELD->IE))       
       cCNPJ:=ALLTRIM(TIRAOUT(cCNPJ))
       MDS(cUF+"/"+cCNPJ)
	   IF EMPTY(field->XREGAPUR)
	      NETRECLOCK()
		  DO CASE 
			  CASE len(cCNPJ)=11 .AND. Valcpf( cCNPJ ,.F.)			 
				 field->XREGAPUR:="CPF"					  
			  CASE cUF="EX"       			  
				 field->XREGAPUR:="EX"			 
			  CASE cUF="BX"       			  
				 field->XREGAPUR:="BX"			  
			  CASE FIELD->ultimaimp <= DATE()-180	  	 
		         field->XREGAPUR:="6M"			  
		  ENDCASE
		  DBUNLOCK()	       
       ENDIF 	   
       IF cUF="??"
          NETRECLOCK()
          field->UF:=""
          DBUNLOCK()	      
       ENDIF
	   IF at('ITAESBRA',UPPER(field->EMAIL))>0   .and. .not. IsCNPJITA(tiraout(field->cnpj))
	      NETRECLOCK()
          Field->EMAIL:=''
		  DBUNLOCK()	      
       ENDIF 
       if z=1
          IF field->BACEN="01058"
             NETRECLOCK()
             field->BACEN:="1058"
             DBUNLOCK()	      
          ENDIF       
       endif  
	   aVALOR:=ARRAY(17)	   
       for nCAMPOS=1 TO 17
	        cCAMPO:=aORI[nCAMPOS]
	        aVALOR[nCAMPOS]:=field->&CCAMPO.
	   next nCAMPOS
	   eBUSCA:=""
  	   if z=1
   		   dbSelectar("SINTCERT")		   
		   eBUSCA:=formatacnpj(cCNPJ)  //sintcert cnpj 99.999.999-9999/99
	   else
  		   dbSelectar("CNPJXML")       //cNPJXML    99999999999999
		   eBUSCA:=TIRAOUT(Ccnpj)
	   endif     	   	   
	   dbgotop()
	   if dbseek(eBUSCA)	      
	      netreclock()
		   for nCAMPOS=2 TO 17 //Comeca 2 ie nao sincroniza
			   IF ! EMPTY(aVALOR[nCAMPOS])
				  cCAMPO:=aDES[nCAMPOS]
				  IF EMPTY(FIELD->&cCAMPO.)		
                     IF Z=1
					    SINTCERT->&cCAMPO.:=aVALOR[nCAMPOS]
                     ELSE					 
					    CNPJXML->&cCAMPO.:=aVALOR[nCAMPOS]
				     ENDIF		
				  ENDIF
			   ENDIF
		   next nCAMPOS
		   if ! empty(field->endtip)
		      nPOS:=LEN(ALLTRIM(field->ENDTIP))			  
			  IF SUBSTR(field->endereco,1,nPOS)=ALLTRIM(field->ENDTIP)			     
			     if SUBSTR(field->endereco,nPOS+1,1)=" "  .or. SUBSTR(field->endereco,nPOS+1,1)="." .or. SUBSTR(field->endereco,nPOS+1,1)=":"
					eVALOR=ALLTRIM(SUBSTR(field->endereco,nPOS+2))
					IF Z=1
					   SINTCERT->ENDERECO:=eVALOR
					ELSE					 
					   CNPJXML->ENDERECO:=eVALOR
					ENDIF		
			     endif		 
			  ENDIF
		   endif
		   dbunlock()
	   endif	   
	   if z=1
		   dbSelectar("CNPJXML")
	   else
		   dbSelectar("SINTCERT")
	   endif   
	   cCNPJ:=Cnpj         	   
       dbskip()
	   IF ! EOF() .AND. cCNPJ=Cnpj         	   //apaga duplicidades
	      netrecdel()
	   endif
   enddo
next z   
dbcloseall()


nLOG:=fcreate("logcadastro.log")
mds("Abrindo Arquivo CNPJXML")
IF ! NETUSE("CNPJXML","DBFCDX")
   return
endif   
SET FILTER TO EMPTY(XREGAPUR) .AND. UF<>'BX'  .and. ! empty(uf) .AND. ! DELETED() 
while ! eof()            
	cUF  :=CNPJXML->UF
	cCNPJ:=CNPJXML->CNPJ
	mds(cUF+" "+cCNPJ)    
	if len(ALLTRIM(tiraout(cCNPJ)))=11 .AND. Valcpf( cCNPJ ,.F.)		//grava cpf 
       dbrlock()	
	   cNPJXML->XREGAPUR:="CPF"					  
	   dbunlock()
	endif
    if VALCGC(cCNPJ,,.F.)	//alguns casos sao cpf
		oSefaz:cProjeto := "nfe"
		cXmlRetorno := oSefaz:NfeConsultaCadastro( cCnpj, cUF )
		cTexto := "versao:    " + XmlNode( cXmlRetorno, "versao" ) + HB_EOL()
		cTexto += "Aplicativo:" + XmlNode( cXmlRetorno, "verAplic" ) + HB_EOL()
		cTexto += "Status:    " + XmlNode( cXmlRetorno, "cStat" ) + HB_EOL()
		cTexto += "Motivo:    " + XmlNode( cXmlRetorno, "xMotivo" ) + HB_EOL()
		cTexto += "UF:        " + XmlNode( cXmlRetorno, "UF" ) + HB_EOL()
		cTexto += "IE:        " + XmlNode( cXmlRetorno, "IE" ) + HB_EOL()
		cTexto += "CNPJ:      " + XmlNode( cXmlRetorno, "CNPJ" ) + HB_EOL()
		cTexto += "CPF:       " + XmlNode( cXmlRetorno, "CPF" ) + HB_EOL()
		cTexto += "Data/Hora: " + XmlNode( cXmlRetorno, "dhCons" ) + HB_EOL()
		cTexto += "UF:        " + XmlNode( cXmlRetorno, "cUF" ) + HB_EOL()
		cTexto += "Nome(1):   " + XmlNode( cXmlRetorno, "xNome" ) + HB_EOL()
		cTexto += "CNAE(1):   " + XmlNode( cXmlRetorno, "CNAE" ) + HB_EOL()
		cTexto += "Lograd(1): " + XmlNode( cXmlRetorno, "xLgr" ) + HB_EOL()
		cTexto += "nro(1):    " + XmlNode( cXmlRetorno, "nro" ) + HB_EOL()
		cTexto += "Compl(1):  " + XmlNode( cXmlRetorno, "xCpl" ) + HB_EOL()
		cTexto += "Bairro(1): " + XmlNode( cXmlRetorno, "xBairro" ) + HB_EOL()
		cTexto += "Cod.Mun(1):" + XmlNode( cXmlRetorno, "cMun" ) + HB_EOL()
		cTexto += "Municip(1):" + XmlNode( cXmlRetorno, "xMun" ) + HB_EOL()
		cTexto += "CEP(1):    " + XmlNode( cXmlRetorno, "CEP" ) + HB_EOL()


		aCAMPOS:={'IE','NOME','CNAE','CIDADE','CEP','BAIRRO','CODIBGE','ENDERECO','NUMEND','dUltSit','cSIT','indCredNFe','indCredCTe','xRegApur','dIniAtiv','complem'}
		//         1     2      3       4        5    6         7          8        9        10        11        12           13         14       15          16

		aDADOS :={XmlNode( cXmlRetorno, "IE" )        ,XmlNode( cXmlRetorno, "xNome" ), ;
				  XmlNode( cXmlRetorno, "CNAE" )      ,XmlNode( cXmlRetorno, "xMun" ),  ;
				  XmlNode( cXmlRetorno, "CEP" )       ,XmlNode( cXmlRetorno, "xBairro" ), ;
				  XmlNode( cXmlRetorno, "cMun" )      ,XmlNode( cXmlRetorno, "xLgr" ),   ;
				  XmlNode( cXmlRetorno, "nro" )       ,XmlNode( cXmlRetorno, "dUltSit" ), ;
				  XmlNode( cXmlRetorno, "cSIT" )      ,XmlNode( cXmlRetorno, "indCredNFe" ), ;
				  XmlNode( cXmlRetorno, "indCredCTe") ,XmlNode( cXmlRetorno, "xRegApur" ), ;
				  XmlNode( cXmlRetorno, "dIniAtiv" )  ,XmlNode( cXmlRetorno, "xCpl" ) }

		HB_MEMOWRIT(cCNPJ+".LOG",cXmlRetorno)

		cSTATUS:=XmlNode( cXmlRetorno, "cStat" )
		if cSTATUS="256" .OR. cSTATUS="259"   
		   dbrlock()
		   if empty(CNPJXML->ultimaimp)		
			  CNPJXML->ultimaimp:=date()		  
		   endif
		   cNPJXML->xRegApur:=cstatus
		   dbunlock()            
		else
		   NETRECLOCK()
		   FOR X=1 TO 15
			  cCAMPO:=ACAMPOS[X]
			  IF X=2 .OR. X=4 .OR. X=6 .OR. X=8 .OR. X=16
				 cCAMPO:=TIRACE(cCAMPO)
			  ENDIF
			  IF EMPTY(&cCAMPO.) .AND. ! EMPTY(aDADOS[X])                    
				 CNPJXML->&cCAMPO.:=xmltransform(aDADOS[X])                  //CNPJXML->&cCAMPO.:=aDADOS[X] //tirace
				 fwrite(nLOG,cCNPJ+" "+cCAMPO+" "+aDADOS[X]+HB_OSNEWLINE())                     
			  ENDIF
		   NEXT 
		   IF LEFT(CNPJXML->IE,5)="ISENT" .AND. ! EMPTY(aDADOS[1])		      
			  CNPJXML->IE:=XmlNode( cXmlRetorno, "IE" )
		   ENDIF
  		   if empty(CNPJXML->ultimaimp)
			  CNPJXML->ultimaimp:=date()
		   endif	
           cXmlRetorno:=UPPER(cXmlRetorno)
		   
		   IF AT('ERRO SOAP:',cXmlRetorno)>0
			  CNPJXML->xRegApur:="ERRSOAP"
		   ENDIF

		   IF AT('CAMPO CUF INEXISTENTE NO ELEMENTO NFECABECMSG DO SOAP HEADER',cXmlRetorno)>0
			  CNPJXML->xRegApur:="UFSOAP"
		   ENDIF

            IF AT('SIGLA DA UF DA CONSULTA DIFERE DA UF DO WEB SERVICE',cXmlRetorno)>0
			  CNPJXML->xRegApur:="UFDIFWEB"
		   ENDIF
		   		
           IF AT( "*ERRO* XMLSOAPPOST()" , cXmlRetorno)>0
			  CNPJXML->xRegApur:="ERRSOAP"
		   ENDIF

           IF AT('SOAPENV:SERVER.USEREXCEPTION',cXmlRetorno)>0
			  CNPJXML->xRegApur:="ERRSOAP"
		   ENDIF
		   
           IF AT('O CADASTRADO COMO CONTRIBUINTE NA UF',cXmlRetorno)>0
			  CNPJXML->xRegApur:="SEMCAD"
		   ENDIF

           IF EMPTY(CNPJXML->xRegApur) .AND. AT('CONSULTA CADASTRO COM UMA OCORRENCIA',cXmlRetorno)>0
		      CNPJXML->xRegApur:="REGNAOCAD"
		   ENDIF
		   
		   //CONSULTA CADASTRO COM UMA OCORRENCIA
		   //IF AT('',cXmlRetorno)>0
			//  CNPJXML->xRegApur:=""
		   //ENDIF
		   
		   //tratando como o retorno inteiro pois nem todo sefaz tem a tag xmotivo
		   //cMOTIVO:=XmlNode( cXmlRetorno, "xMotivo" )
		   //IF AT('Sigla da UF da consulta difere',cMOTIVO)>0
			//  CNPJXML->UF:=XmlNode( cXmlRetorno, "UF" )
		   //ENDIF
		   //IF AT("o cadastrado como contribuinte na UF",cXmlRetorno)>0
		   //	  CNPJXML->xRegApur:='NC'
		   //ENDIF
		   dbunlock()            
		endif
		//IF EMPTY(CNPJXML->xRegApur) .AND.  CNPJXML->ultimaimp<=DATE()-180
		//IF CNPJXML->UF='BX'  ja nao tras bx no filtro
		//	  NETRECLOCK()
		//	  CNPJXML->xRegApur:='6M'
		//	  dbunlock()            
		//ENDIF
		//ENDIF
	endif	
	dbskip()
enddo  
dbclosearea()
fclose(nLOG)
MDS("...")
return .t.


function checkGMprot() // Agora  GM e electrolux vw continentalautomotive yamaha
if ! NETUSE("DANFE2","DBFCDX")    
   retu
endif
IF ! NETUSE("NFE","DBFCDX")
   dbcloseall()
   return .t.
ENDIF
IF ! NETUSE("CNPJXML","DBFCDX")
   dbcloseall()
   return .t.
ENDIF
nRECNO :=NFE->GMPROTREC  
nRECINI:=NFE->GMPROTREC  
cARQGRV:="c"+ArqLogDataHora("sql")
cARQLOG:="gmprot"+ArqLogDataHora()
nHANDLE:=FCREATE(cARQGRV)
nLOG01:=FCREate(cARQLOG)
if Nrecno=0
   nRECNO :=1
   nRECINI:=1
endif

dbselectar("DANFE2")
dbsetorder(0)
if nRECNO=1
   set filter to empty(xml)
   dbgotop()
   nRECNO:=RECNO()-1
   set filter to
endif
danfe2->(dbgoto(nRECNO))
while ! eof()   
   cid=id
   cCNPJ       :=alltrim(cnpj)
   cCNPJDEST   :=alltrim(cnpjdest)
   cANO        :=eMISSAOANO(DANFE2->emissao)
   cMES        :=emissaomes(danfe2->emissao)   
   IF EMPTY(danfe2->xml)      
      IF cANO<cANOBASE .OR. EmissaoData(danfe2->emissao)<DATE()-180           
	     netreclock()
         danfe2->xml:="<"                        
         dbunlock()
      ENDIF 
   ENDIF  
   IF EMPTY(danfe2->avb)      
      IF cANO<cANOBASE .OR. EmissaoData(danfe2->emissao)<DATE()-180                    
         netreclock()
         danfe2->avb:="<"                        
         dbunlock()
      ENDIF 
   ENDIF
   mds("Gm Protocolo: "+Cid) 
   lACHEI:=.F.       
   if cANO >= cANOBASE .AND. EMPTY(XML) .AND. CANCELADA<>"S" .AND. CANCELADA <> "I" 
      nPOSaCNPJ:=ASCAN(aCNPJXML,LEFT(CCNPJdest,8))   
      if nPOSaCNPJ>0  
         fwrite(Nlog01,cID+HB_OsNewLine())
         cARQIMP :=pegcamxml(cID,cCNPJ,cCNPJDEST,cANO,cMES) 
         if ! empty(cARQIMP)
            lACHEI:=.T. 
            mds(cID+" reenvio xml protocolo")
            if cANO>=cANOBASE .AND. cMES=STRZERO(MONTH(DATE()),2)
               cEMPLOG:=CNPJEmpLogix(cCNPJ)
			   cEMAIL:=PegaEmailCnpj(cCNPJDEST)               
			   GrvLogEdi('lerxml', , , ALLTRIM(DANFE2->PROTOCOLO), DANFE2->ID, DANFE2->NNF, cEMPLOG, 'XMLREENVIO','PROT')                              
               IF ! EMPTY(cEMAIL)
                  enviaemail(cARQIMP,"NFE "+cID,cEMAIL)                                      
               ENDIF               
            ENDIF   
         ENDIF      
      endif   
   endif
   dbselectar("DANFe2")
   IF EMPTY(danfe2->xml)      
      netreclock()
      IF lACHEI      
         danfe2->xml:="S"               
      ENDIF 
      IF DANFE2->CANCELADA="S" 
         grvcancelada()         
      endif
      IF ASCAN(aCNPJXML,LEFT(CCNPJdest,8))=0 
         danfe2->xml:="O"               
      ENDIF
      IF DANFE2->CANCELADA="I" 
         danfe2->xml:="I"                        
      endif
      dbunlock()
   ENDIF  
   nRECNO:=danfe2->(RECNO())
   danfe2->(dbskip())
enddo

IF nrecno<nRECINI //corrige quedas de energia ou repost de antigas que abaixam o recno()
   nrecno:=nRECINI
endif
if nrecno=0 //corrige algum problema que zerou 
   nrecno:=1
endif
DBSELECTAR("nfe")
NETreclock()
NFE->GMPROTREC:=nRECNO
DBUNLOCK()
dbcloseall()
fclose(nlog01)  
fclose(nHANDLE)
IF FILESIZE(cARQLOG)=0 .OR. cGRVLOGGMPROT="NAO"
   ferase(cARQLOG)
endif
gravaprot(cARQGRV)
mds("...")
return .t.




function impdanfe(nTIPO)
//            Validarxml(cARQIMP) nao esta funcionando para 3.10
  buscachave(1)
  cID         :=alltrim(main.chave.value)  
  cCNPJ       :=alltrim(main.cnpj.value)
  cCNPJDEST   :=alltrim(main.cnpjdest.value)
  cANO        :=emissaoano(main.emissao.value)
  cMES        :=emissaomes(main.emissao.value)
  cARQIMP     :=PEGCAMXML(cID,cCNPJ,cCNPJDEST,cANO,cMES) 
  cDEST:=Alltrim(main.email.value)
  nfeview(nTIPO,cID,cARQIMP,cDEST)
return

function  cademp()
LOCAL aOptions
IF NETUSE("CNPJXML","DBFCDX")        
   aFieldName   := {"CNPJ","IE","NOME","ENDERECO","CIDADE","CEP","TELEFONE","UF","IESUBST","IMUNICIPAL","COGNOME","EMAIL","NUMEND","COMPLEM","BAIRRO","BACEN","PAIS","CNAE","SUFRAMA","CODIBGE"}
   aFieldEdit   := array(20)
   AFILL(aFieldEdit ,.T.)
   aFieldEdit[1]:=.F.
   
    aOptions     := Array( 8, 8 )
    
    aOptions[1,1] := "Consulta Inscricao Municipal"
    aOptions[1,2] := { || verendereco(1 ) }

    
    aOptions[2,1] := "Mapa Endereco"
    aOptions[2,2] := {|| verendereco(2) }
    aOptions[3,1] := "Mapa Cep"
    aOptions[3,2] := { || verendereco(3 ) }
    aOptions[4,1] := "Consulta cep achecep"
    aOptions[4,2] := { || verendereco(4 ) }
    aOptions[5,1] := "Consulta cep guiamais"
    aOptions[5,2] := { || verendereco(5 ) }
    aOptions[6,1] := "Consulta correios"
    aOptions[6,2] := { || verendereco(6 ) }
    aOptions[7,1] := "Consulta viacep"
    aOptions[7,2] := { || verendereco(7 ) }


    
    aOptions[8,1] := "Fechar Tela"
    aOptions[8,2] := { || this.release }
        

   
       
   EDIT EXTENDED WORKAREA CNPJXML  FIELDNAMES aFieldName  FIELDENABLED aFieldEdit OPTIONS aOptions         
   dbclosearea()
ENDIF
RETURN .T.

function verendereco(nTIPO)
LOCAL cAddress :=""
DO CASE
   case nTIPO=1
        cAddress :="http://www.informe.issqn.com.br/sitcadsch.cfm" 
   CASE nTIPO=2
        cAddress := "http://maps.google.com/maps?q="       
        cAddress+=alltrim(CNPJXML->ENDERECO)
        cAddress+= " , "+alltrim(CNPJXML->NUMEND)
        cAddress+= " - " 
        cAddress+= alltrim(CNPJXML->cidADE) 
        cAddress+= " - " 
        cAddress+= CNPJXML->UF         
   CASE nTIPO=3
        cAddress := "http://maps.google.com/maps?q="       
        cAddress +=CNPJXML->CEP
   case nTIPO=4
        cAddress :="http://www.achecep.com.br/Sao-Paulo/" + CNPJXML->CEP
   case nTIPO=5
        cAddress :="http://cep.guiamais.com.br/busca/" + CNPJXML->CEP
   case nTIPO=6
        cAddress :="http://www.buscacep.correios.com.br/servicos/dnec/consultaLogradouroAction.do?CEP=" + CNPJXML->CEP +"&Metodo=listaLogradouro&TipoConsulta=cep"
   case nTIPO=7
        cAddress := "http://viacep.com.br/ws/" + CNPJXML->CEP + "/piped/"       
ENDCASE
abrirpagina(cAddress)
return .t.

function  cadNFE()
IF NETUSE("DANFE2","DBFCDX")
   aFieldName   := {"ID","CNPJ","NNF","SERIE","EMISSAO","PROTOCOLO"}
   aFieldEdit   := array(6)
   AFILL(aFieldEdit ,.F.)       
   EDIT EXTENDED WORKAREA DANFE2  FIELDNAMES aFieldName  FIELDENABLED aFieldEdit   
   main.CHAVE.value:=DANFE2->ID      
   dbclosearea()
   buscachave(1)
ENDIF
RETURN .T.


function buscachave(nTIPO)
locAL lACHEI,cCHAVE
cCNPJ:=""
cNOME:=""
lACHEI:=.F.
lCANCEL:=.F.
SWITCH nTIPO
      CASE 1 ; cCHAVE:=ALLTRIM(main.CHAVE.value) ; EXIT
      CASE 2 ; cCHAVE:=ALLTRIM(main.cnpj.value)+ALLTRIM(main.nnf.value) ; EXIT
      CASE 3 ; cCHAVE:=ALLTRIM(main.nnf.value) ; EXIT
ENDSWITCH
if ! NETUSE("DANFE2","DBFCDX")
   return
endif
dbselectar("DANFE2")
dbsetorder(nTIPO)
dbgotop()
if dbseek(cCHAVE)
   cCNPJ:=CNPJ
   main.CHAVE.value:=ID
   main.cnpj.value:=CNPJ
   main.cnpjDEST.value:=CNPJDEST
   main.nnf.value:=nnf
   main.emissao.value:=danfe2->emissao
   main.arquivo.value:=protocolo
   IF CANCELADA="S"
      lCANCEL:=.T.
   ENDIF
   lACHEI:=.T.
ELSE
   main.cnpj.value:=""   
   main.cnpjDEST.value:=""
   main.nnf.value:=""
   main.emissao.value:=""
   main.nome.value:=""
   main.arquivo.value:=""
endif
dbclosearea()
IF lACHEI
   IF NETUSE("CNPJXML","DBFCDX")
      dbgotop()
      if dbseek(cCNPJ)
         main.nome.value:=CNPJXML->nome
         main.email.value:=CNPJXML->email
      endif
      dbclosearea()
   endif   
ENDIF
IF ! lACHEI
   MSGINFO("Nota Nao Cadastrada:"+cCHAVE)
ENDIF
IF lCANCEL
   MSGINFO("Nota Fiscal Cancelada:"+cCHAVE)
ENDIF
return .T.

function fazmesano()
  mdt(oSefaz:cCertificado) 
  IF ASCAN(aPAR,"/ROBO")>0
     lROBO:=.T.
	 mdt('ROBO')     
  ENDIF
  IF ASCAN(aPAR,"/DUP")>0 
     XMLMESANO("/DUP")
     main.release
  ENDIF
  makedir('erro')
  makedir('danfe')  
  makedir('script')
  makedir('log')
  cANO  := strzero(year(date()),4,0)
  cMES  := strzero(month(date()),2,0)
  makedir(cCAM+"\"+cANO)
  makedir(cCAM+"\"+cANO+"\"+cMES)                  
return .t.


Function XMLMESANO(cTIPO)

  // Pegando Arquivo na Pasta
  mDIRETORIO:=''
  mArquivo := '*.XML'
  If cTIPO="/DU2"
     mArquivo := '*.pdf'
  endif
  
  mListaArq := Directory(mDiretorio+mArquivo) //,"D") include diretorios
  cLista  := {}
  
  nFIM:=Len(mListaArq)
  IF nFIM>100 //4000
     NFIM:=100 //4000
  ENDIF
  
  If cTIPO="/DUP".OR. cTIPO="/DU2"
    lDUP:=.T.
    For i := 1 to nFIM    
     cARQUIVO:= UPPER(mListaArq[i,1])     
     main.Progressbar1.value:=I
     mds(str(i,8)+"/"+str(nFIM,8)+" "+CARQUIVO)
     for x=1 to 9
	     If cTIPO="/DUP"
            cTMP:= STRTRAN(cARQUIVO,".XML","-"+STR(X,1)+".XML")
            filedelete(Ctmp)
            cTMP:= STRTRAN(cARQUIVO,".XML",STR(X,1)+".XML")
            filedelete(Ctmp)
		 ELSE
            cTMP:= STRTRAN(cARQUIVO,".PDF","-"+STR(X,1)+".PDF")
            filedelete(Ctmp)
            cTMP:= STRTRAN(cARQUIVO,".PDF",STR(X,1)+".PDF")
            filedelete(Ctmp)		 
         endif		
		 lDUP:=.F.
     next x
    Next
    return lDUP
  ENDIF  
  
  For i := 1 to nfim 
    cNomeForne := PegaNomeArquivo(mDiretorio+mListaArq[i,1])
    main.Progressbar1.value:=I
    mds(str(i,8)+"/"+str(nFIM,8)+" "+Cnomeforne)
    Aadd( cLista, { cNomeForne, alltrim(mDiretorio)+alltrim( mListaArq[i,1] ) } )
  Next
  
Return nil


Function danfemove()
//diretorio para importacao
danfeXmove("IMP" , '*.*' ,cIMPORTA01 )
danfeXmove("IMP" , '*.*' ,cIMPORTA02 )
danfeXmove("IMP" , '*.*' ,cIMPORTA03 )
danfeXmove("IMP" , '*.*' ,cIMPORTA04 )
danfeXmove("IMP" , '*.*' ,cIMPORTA05 )
danfeXmove("IMP" , '*.*' ,cIMPORTA06 )
danfeXmove("IMP" , '*.*' ,cIMPORTA07 )
danfeXmove("IMP" , '*.*' ,cIMPORTA08 )
danfeXmove("IMP" , '*.*' ,cIMPORTA09 )
danfeXmove("IMP" , '*.*' ,cIMPORTA10 )
//arquivos compactados
danfeXmove("DAT",'*.dat',"")         
danfeXmove("ZIP",'*.ZIP',"")	 
danfeXmove("RAR",'*.rar',"")         
danfeXmove("Z"    ,'*.z',"")
danfeXmove("Z"    ,'*.7z',"")
//log        
danfeXmove("LOG",'*.LOG',"")
//danfeview         
danfeXmove("DNF",'*.DNF',"")	          
danfeXmove("MEM"   ,'cancnfe*.xml',cMEMORIZAR   )          
//partial
danfeXmove("PAR",'*.partial',"")
//formatos danfe
aAPAGA:={'PDF','JPG','JPEG','doc','docx','rtf','png','xls','xlsx','wmf','gif','ppt'}
nFIM:=LEN(aAPAGA)
FOR I:=1 TO nfim
   danfeXmove("PDF",'*.'+aAPAGA[I],"")
NEXT I
//apagar extensao sem uso ou possiveis virus
aAPAGA:={'ADE','ADP','BAT','CHM','CMD','COM','CPL','HTA','INS','ISP','JSE','LIB','LNK', ;
         'MDE','MSC','MSI','MSP','MST','NSH','PIF','SCR','SCT','SHB','SYS','VB','VXD', ;
		 'WSC','WSH','vbs','jar','wsf','TMP','HTM*','TIF', ;
         'vbe','vbs','jar','mht','bin','exe','js','class'}
nFIM:=LEN(aAPAGA)
FOR I:=1 TO nfim
   danfeXmove("DEL", '*.' +aAPAGA[I] , "" )
NEXT I

danfeXmove("DEL", 'Se??o*.*' , "" )
danfeXmove("DEL", 'body*.*' , "" )


//desabilitidado tratado de outra forma
//danfeXmove("XMLCANC",'*.xml'      ,cMEMORIZARTMP)
return  



Function danfeXmove(cOPERACAO,mArquivo,mDIRETORIO)
IF VALTYPE(mDIRETORIO)<>"C"
   mDIRETORIO:=""
ENDIF
IF cOPERACAO="IMP" .AND. EMPTY(mDIRETORIO) //nao processa diretorios vazios importacao
   RETURN
ENDIF



  mds("Checando "+cOPERACAO+" "+mArquivo+" "+mDIRETORIO )
  mListaArq := Directory(mDiretorio+mArquivo)   //,"D"            Include directories
  nFIM:=Len(mListaArq)
  IF nFIM>1000
     NFIM:=1000
  ENDIF
  main.Progressbar1.Rangemin:=1
  main.Progressbar1.Rangemax:=nFIM 
  
  For i := 1 to nfim
     
     cFILEDANFE:=mListaArq[i,1]
     main.Progressbar1.value:=I
     mds("Processo: "+cOPERACAO+" - "+str(i,8)+"/"+str(nFIM,8)+" "+cFILEDANFE)
	  lDELETE=.F.
	  IF FILESIZE(mDIRETORIO+cFILEDANFE)<2
	    lDELETE:=.T.
	  ELSE	 
		 do case
		 	case cOPERACAO="DAT"
				cARQIMP:="wmopener "+cFILEDANFE+" "+cCAM
				HB_RUN(cARQIMP)
				WAITPERIOD(500) 
				IF filecopy(cCAM+cFILEDANFE,cCAM+'danfe\'+cFILEDANFE)>0
				   lDELETE:=.T.				
				ENDIF   
			case cOPERACAO="ZIP"
				IF lerunzip(cFILEDANFE) 				   	
       		        lDELETE:=.T.				 				   
				endif
			case cOPERACAO="DNF"
				IF filecopy(cCAM+cFILEDANFE,cNFE+'importar\'+cFILEDANFE)>0
   		           lDELETE:=.T.				
				ENDIF   
			case cOPERACAO="RAR"
				cARQIMP:="unrar e "+cFILEDANFE
				HB_RUN(cARQIMP)
				WAITPERIOD(500) 
 		        lDELETE:=.T.				
			case cOPERACAO="LOG"
				IF filecopy(cCAM+cFILEDANFE,cCAM+'LOG\'+cFILEDANFE)>0
   		          lDELETE:=.T.								
				ENDIF               
			case cOPERACAO="IMP"
			    lCOPIA:=.T.
				//IF ARQUIVOITA(cFILEDANFE) //nao copia xml da propria itaesbra
				//   lCOPIA:=.F.
				//   lDELETE:=.T.
				//ENDIF
				//copia agora itaesbra pois tem c:\nfe\nfecnpj e P:\nfe\nfecnpj
				IF lCOPIA                 //nao tem copia para nfecpnj para armazernar e apaga
				   IF FILECOPY(mDIRETORIO+cFILEDANFE,cCAM+cFILEDANFE)>0	
				      lDELETE:=.T.							                  
			      ENDIF	
				ENDIF   
			case cOPERACAO = "Z"
				cARQIMP:="7za e -y "+cFILEDANFE
				HB_RUN(cARQIMP)
				WAITPERIOD(500) 				
 		         lDELETE:=.T.				
         CASE cOPERACAO="DEL"
	 	     lDELETE:=.T.		      
              if upper(cfiledanfe)="LERXML.EXE" .OR. upper(cfiledanfe)="7ZA.EXE" .OR. upper(cfiledanfe)="UNRAR.EXE" .OR.  upper(cfiledanfe)="WMOPENER.EXE"  .or. upper(cfiledanfe)="LERXMLteste.EXE"
   			    lDELETE:=.f.
			  endif
         CASE cOPERACAO="MEM"
             lDELETE:=.F.
             cFILEDANFE:=mListaArq[i,1]             
             cFILEDANFE:=strtran(cFILEDANFE,"canc","")             
             IF ! FILE(cMEMORIZAR+cFILEDANFE)                      
                cFILEDANFE:=strtran(strtran(cFILEDANFE,".xml",""),"cancNFe","")
				cFILEDANFE:=strtran(cFileDanfe,"cancCTE","") 
				if IDANO(cFILEDANFE) >= cANOBASR
					cFILEDANFE+="-nfe_vis.xml"
					IF ! FILE(cNFECNPJ+cFILEDANFE)           
					   MDS("copiando canc/vis para memorizar:"+cFILEDANFE)
					   copiavislogix(cFILEDANFE,cNFECNPJ+cFILEDANFE)					   
					ELSE
					  IF ! FILE(cNFECNPJ+cFILEDANFE)
						 cFILEDANFE:=mListaArq[i,1]             
						 cFILEDANFE:=strtran(strtran(cFILEDANFE,".xml",""),"cancNFe","")
						 cFILEDANFE:=strtran(cFiledanfe,"cancCTE","")					 
					     cFILEDANFE:=PegCamXml(cFILEDANFE)
						 IF ! EMPTY(cFILEDANFE)
						    FILECOPY(cFILEDANFE,cNFECNPJ+cFILEDANFE)
					     ENDIF   
					  ENDIF   
					ENDIF
                ENDIF				
             ENDIF             
		case cOPERACAO="PAR"
			 IF filecopy(cCAM+cFILEDANFE,cCAM+'erro\'+cFILEDANFE)>0
   		        lDELETE:=.T.								
		 	 ENDIF   
  //       CASE cOPERACAO="XMLCANC"
    //          IF filecopy(cMEMORIZARTMP+cFILEDANFE,cMEMORIZAR+cFILEDANFE)>0
//   		         filedelete(cMEMORIZARTMP+cFILEDANFE) 
//			 ENDIF            
			 
		CASE cOPERACAO="PDF"
			IF filecopy(cCAM+cFILEDANFE,cCAM+'danfe\'+cFILEDANFE)>0     
 		       lDELETE:=.T.				
			ENDIF   
		 ENDCASE   
     ENDIF 
        
     if lDELETE
        if ! empty(mDIRETORIO)  
           filedelete(mDIRETORIO+cFILEDANFE)
        else
           filedelete(cCAM+cFILEDANFE)
        endif   
     endif   	         
   next i       

mds("...")
Return nil



function aturobo()
IF lROBO
   dbcloseall() 
   atualizar()
ENDIF

function atualizar() //tempo 4 minutos (o robo esta com 5 para nao rodar duas vezes)
   lerxml()     
   danfemove()
   gravaelec()
   FALTAXML(.F.)   
   checkgmprot() 
   nHORA:=CTOHORA(TIME()) 
   IF nHORA>0.20.AND.nHORA<=0.24
      checkdanfev()
   ENDIF
   IF nHORA>0.30.AND.nHORA<=0.34
      checkcad()
   ENDIF
   IF nHORA>0.40.AND.nHORA<=0.44
      checkstatus()      
      lFALTAXML:=.T. //habilita a checagem completa
   ENDIF   
   IF nHORA-INT(nHORA)>0.56  
      IF lFALTAXML
         faltaxml(.t.)
         lFALTAXML:=.F. //deshabilita a checagem completa
      ENDIF   
   ENDIF   
   IF nHORA>1.00.AND.nHORA<=1.04
      fecha5anos()  
      lFALTAXML:=.F.	  //desahabilita a checagem completa //caso nao face das .56 as 1:00
   endif
   mds("...")
return nil      
   
Function LerXML()
  Parameters cFileDanfe
  
  XMLMESANO("/DUP")
  XMLMESANO("/DU2")
 
  

  if ! NETUSE("DANFE2","DBFCDX")
     dbcloseall()
     return
  endif
  
  if ! netuse("cnpjxml","DBFCDX")
     dbcloseall()
     return
  endif

  // Pegando Arquivo na Pasta
  mDIRETORIO:=''
  mArquivo := '*.XML'
  mListaArq := Directory(mDiretorio+mArquivo) //,"D") include diretorio
  cLista  := {}
  
  nFIM:=Len(mListaArq)
  IF nFIM>100
     NFIM:=100
  ENDIF

  main.Progressbar1.Rangemin:=1
  main.Progressbar1.Rangemax:=nFIM


  For i := 1 to nfim 
    cNomeForne := PegaNomeArquivo(mDiretorio+mListaArq[i,1])
    main.Progressbar1.value:=I
    mds(str(i,8)+"/"+str(nFIM,8)+" "+Cnomeforne)
    Aadd( cLista, { cNomeForne, alltrim(mDiretorio)+alltrim( mListaArq[i,1] ) } )
  Next

  if len(cLista) >0           
     RecuperaDadosXml()
  endif

  mds('...')
  
  dbcloseall()

Return nil
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *>

Static Function PegaNomeArquivo(cArq)
 Local cFileDanfe := cArq
 Local Linha   := hb_memoread(cFileDanfe)  
 Local cLinhaTxt := Linha
 Local m_cNF   := PegaDados('nNF' ,Alltrim(Linha) )
 Local m_serie  := PegaDados('serie' ,Alltrim(Linha))
 Local m_dEmi   := PegaDados('dEmi' ,Alltrim(Linha) )
 Local m_Razao  := PegaDados('xNome' ,Alltrim(Linha) )
 cString := "NF:"+m_cNF+' / '+m_serie+" - "+m_Razao+' Emissao '+m_dEmi
Return cString

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *>

function RecuperaDadosXml()
nOPCAO:=1
nFIM:=LEN(cLISTA)
cARQGRV:="e"+ArqLogDataHora("sql")
nHANDLE:=FCREATE(cARQGRV)
aSTATUS:={}
aCANCEL:={}

FOR nOPCAO:=1 TO nFIM

   cFileDanfe := cLISTA[nOpcao,2]
   main.Progressbar1.value:=nOPCAO
   mds(str(nopcao,8)+"/"+str(nFIM,8)+" "+cFILEDANFE)
   
   
   
   If cFileDanfe==Nil   
     nOPCAO++
     LOOP
   Endif
   
   If ! file(cFileDanfe)
     nOPCAO++
     LOOP
   Endif
      
   if filesize(cFILEDANFE)<200  //arquivos muito pequenos     
	  cCHAVE:=SONUMEROS(cFILEDANFE)	  
      cARQIMP:=cChave+"-nfe_vis.xml"
	  IF copiavislogix(cARQIMP,cNFECNPJ+cARQIMP)
		 filedelete(cCAM+cFILEDANFE)
	  else	  
	     cARQIMP := pegcamxml(cCHAVE)
		 IF FILE(cARQIMP)
            FILECOPY(cARQIMP,cNFECNPJ+cARQIMP)		 
		    filedelete(cCAM+cFILEDANFE)
         ELSE 	  
		    if file(cCAM+"erro\"+cCHAVE+".tamanho") .or. file(cCAM+"erro\"+cFILEDANFE+".tamanho") //arquivo duplicado apaga destino para copiar novamente
			   filedelete(cCAM+cFILEDANFE,cCAM+"erro\"+cCHAVE+".tamanho")
			   filedelete(cCAM+cFILEDANFE,cCAM+"erro\"+cFILEDANFE+".tamanho")
			endif
			IF filecopy(cCAM+cFILEDANFE,cCAM+"erro\"+cCHAVE+".tamanho")>0     
			   filedelete(cCAM+cFILEDANFE)
			ENDIF 		 
	     ENDIF		  
   	  ENDIF
	  nOPCAO++
      LOOP
   endif   
   



   Linha   := hb_memoread(cFileDanfe)  
   linha := STRTRAN(linha,CHR(10),"") //arquivos com erro de linha
   linha := STRTRAN(linha,CHR(13),"")
    
   lCALVOREM:=.F.
   lCTEPAGA:=.F.   
   cPGCTE:="X"
   lCANCEL:=.F.   
   lCCE:=.F.
   lCCECANCEL:=.F.   
   lCTE:=.F.
   lCTEOS:=.F.
   lCTECANCEL:=.F.   
   lINUT:=.F.   
   lRETC:=.F.
   lRESCTE:=.F.
   lRESNFE:=.F.

   nPos1 := At('<tpAmb>2</tpAmb>',Linha) //homologacao
   If nPos1>0          
      IF filecopy(cCAM+cFILEDANFE,cCAM+"erro\"+cFILEDANFE+".homologacao")>0     
         filedelete(cCAM+cFILEDANFE)
      ENDIF 		 
      nOPCAO++
      LOOP
   endif      

   nPos1 := At('enviNFe',Linha) //envio de situacao lote 
   If nPos1>0          
      IF filecopy(cCAM+cFILEDANFE,cCAM+"erro\"+cFILEDANFE+".enviNFe")>0     
         filedelete(cCAM+cFILEDANFE)
      ENDIF 		 
      nOPCAO++
      LOOP
   endif   
   
   
   nPos1 := At('procEventoNFe',Linha)  //procEventoNFe   procEventoCTe abaixo evCancCTe
   If nPos1>0          
      lCCE:=.T.
      nPos1 := At('<descEvento>Cancelamento</descEvento>',Linha)
      If nPos1>0      
         lCCECANCEL:=.T.
         lCCE:=.F.
      endif      
   ENDIF  

   nPos1 := At('retEnvEvento',Linha)  //procEventoNFe   procEventoCTe abaixo evCancCTe
   If nPos1>0          
      lCCE:=.T.
   ENDIF  

   nPos1 := At('envEvento',Linha)  //procEventoNFe   procEventoCTe abaixo evCancCTe
   If nPos1>0          
      lCCE:=.T.
   ENDIF  
   
   
   nPos1 := At('procEventoCTe',Linha)  //procEventoCTe abaixo tambem evCancCTe cancelamento
   If nPos1>0          
      lCCE:=.T.
      nPos1 := At('<descEvento>Cancelamento</descEvento>',Linha)
      If nPos1>0      
         lCCECANCEL:=.T.
         lCCE:=.F.
      endif      
   ENDIF   
   

   nPos1 := At('retConsReciNFe',Linha) //retorno de situacao lote 
   If nPos1>0
      lRETC:=.T.   
   endif   
   

   nPos1 := At('retCTeConsultaDFe',Linha) //retorno de situacao lote 
   If nPos1>0
      lRESCTE:=.T.   
   endif   
   
   
   nPos1 := At('resNFe',Linha) //retorno de situacao lote 
   If nPos1>0
      lRESNFE:=.T.   
   endif   
   
   
   nPos1 := At('Lote de evento processado',Linha) // lote  envio processado
   If nPos1>0
      lRETC:=.T.   
   endif   
      
   
   nPos1 := At('evCancCTe',Linha) //cancelamento cte
   IF nPOS1>0
       lCTECANCEL:=.T.   
   ENDIF
   
   
   

   nPos1 := At('resEvento',Linha) 
   If nPos1>0     
      nPos1 := At('Cancelamento de CT-e',Linha)
      If nPos1>0      
         lCTECANCEL:=.T.         
      endif      
      nPos1 := At('<tpEvento>610615</tpEvento>',Linha) //autorizacao cte
      If nPos1>0      
         lCTECANCEL:=.T.      
      endif      	  
      nPos1 := At('<tpEvento>610600</tpEvento>',Linha) //autorizacao cte
      If nPos1>0      
         lCCE:=.T.         
      endif      
      nPos1 := At('<tpEvento>610614</tpEvento>',Linha) //mde autorizacao cte
      If nPos1>0      
         lCCE:=.T.         
      endif    
      nPos1 := At('<tpEvento>610514</tpEvento>',Linha) //registro de passagem
      If nPos1>0      
         lCCE:=.T.         
      endif    
      nPos1 := At('<tpEvento>610554</tpEvento>',Linha) //registro de passagem
      If nPos1>0      
         lCCE:=.T.         
      endif    
      nPos1 := At('<tpEvento>610552</tpEvento>',Linha) //registro de passagem
      If nPos1>0      
         lCCE:=.T.         
      endif
      nPos1 := At('<tpEvento>610500</tpEvento>',Linha) //registro de passagem
      If nPos1>0      
         lCCE:=.T.         
      endif

      nPos1 := At('<tpEvento>610610</tpEvento>',Linha) //mde autorizado
      If nPos1>0      
         lCCE:=.T.         
      endif

	  


	  
   ENDIF   
   
   
   nPos1 := At('cancNFe',Linha) //cancelamento nfe
   
   If nPos1>0 .OR. lCCECANCEL .OR. lCTECANCEL                        
      lCANCEL:=.T.      
      IF lCCECANCEL .OR. lCTECANCEL                        
         m_dEmi := SUBSTR(PegaDados('dhEvento' ,Alltrim(Linha) ),1,10)    	  
      ELSE      
	      m_dEmi := SUBSTR(PegaDados('dhRecbto' ,Alltrim(Linha) ),1,10)    	  
      endif   
	  cANO     := EMISSAOANO(m_DEMI)
      cMES     := EMISSAOMES(m_DEMI)	  
      
	  cCGCDest := ""
	  cCGCEmit := ""		         
      cCHAVE   := ""
      
      nPOS1:=AT('chNFe',linha)
      IF lCTECANCEL .and. nPOS1=0  //algum cancelamento cte vem com chave nfe 
         nPOS1:=AT('chCTe',linha)		 
      ENDIF
	  
      IF nPOS1>0
        cPesq := Substr(linha,nPOS1+6,44)
        cChave:= cPesq
        dbSelectar("danfe2")
        dbsetorder(1)
        dbGotop()
        If ! dbseek(cPESQ)        
           Netrecapp()
           Danfe2->Id     :=cPESQ
		   IF cANO>=cANOBASE		
              AADD(aSTATUS,cPESQ)		   		   
		   ENDIF	  
        else
           cCGCDest := ALLTRIM(CNPJDEST)
           cCGCEmit := ALLTRIM(CNPJ)
           IF EMPTY(cANO) .OR. EMPTY(CMES) .OR. val(cANO)=0 .OR. val(cMES)=0
               cANO  := emissaoano(danfe2->EMISSAO)
               cMES  := emissaomes(danfe2->EMISSAO)
           ENDIF
           netreclock()   
        Endif
        IF EMPTY(cCGCEMIT) .OR. VAL(cCGCEMIT)=0
           cCGCEmit := IDEMISSOR(cPESQ)
           danfe2->CNPJ:=cCGCEMIT
        ENDIF   
        IF EMPTY(EMISSAO)
           danfe2->emissao:=m_dEmi
        ENDIF
        grvcancelada()
        IF cANO>=cANOBASE		
           aadd(aCANCEL,cPESQ)
		ENDIF
		
        dbunlock()        
     ENDIF	  
    

    //Envia cancelamento ao fornecedor    
	  IF IsCNPJITA(cCGCEmit)
	     IF ! EMPTY(cCGCDest) .AND. ! IsCNPJITA(cCGCDEST) 
             IF cANO>=cANOBASE				 
			   cEMAIL:=PegaEmailCnpj(cCGCDEST)        
			   if ! empty(cemail)                
				  ENVIAEMAIL("","NFE-XML CANCELADA",cEMAIL,"Cancelamento de Nota Fiscal "+cFILEDANFE)                 
			   endif        
			endif   
        ENDIF            
      ENDIF     

      cTIPCANC:="cancNFe"
      IF lCTECANCEL
         cTIPCANC:="cancCTE"
      ENDIF
      IF IsCNPJITA(cCGCEmit)
         IF EMPTY(cCGCDEST)
            cARQIMP:=cChave+"-nfe_vis.xml"
            IF copiavislogix(cARQIMP,cNFECNPJ+cARQIMP) 
               GrvCamXml(cFILEDANFE,cCGCDEST,cMES,cANO,cChave,cTIPCANC,.T.,.T.)                       
            ELSE
               GrvCamXml(cFILEDANFE,cCGCDEST,cMES,cANO,cChave,cTIPCANC,.T.,.T.)                       
            ENDIF         
         ELSE         
            GrvCamXml(cFILEDANFE,cCGCDEST,cMES,cANO,cChave,cTIPCANC,.T.,.T.)                       
         ENDIF   
      ELSE
         GrvCamXml(cFILEDANFE,cCGCEmit,cMES,cANO,cChave,cTIPCANC,.T.,.T.)                       
      ENDIF               
      
      
      nOPCAO++
      LOOP      
   ENDIF
   
   nPos1 := At('<inutNFe',Linha)
   If nPos1>0
      
      lINUT:=.T.                   
      nPOS1:=AT('Id=',linha)
      cCHAVE:= Substr(LINHA,nPOS1+6,39)
      cCNPJ:=ALLTRIM(PegaDados('CNPJ' ,Alltrim(Linha) ))
      cDATA:=PegaDados('dhRecbto' ,Alltrim(Linha))
      cMES:=EMISSAOMES(Cdata)
      cANO:=EMISSAOANO(Cdata)
      cPROTOCOLO:=PegaDados('nProt' ,Alltrim(Linha) )
      cNNF:=ALLTRIM(PegaDados('nNFIni' ,Alltrim(Linha) ))
      cBUSCA:=cCNPJ+cNNF
      cCHAVE2:="35"+cANO+cMES+Padr(cCNPJ,14)+"55001"+STRZERO(VAL(cNNF),9)+"1"+STRZERO(VAL(cNNF),8)+"0"
     

      dbselectar('danfe2')
      dbsetorder(1)
      dbgotop()      
      if ! dbseek(cCHAVE2)
         netrecapp()                   
         danfe2->id:=cCHAVE2
      else
         netreclock()
      endif      
      
       DANFE2->CANCELADA:="I"
       DANFE2->PROTOCOLO:=cPROTOCOLO
       IF EMPTY(DANFE2->CNPJ)
          DANFE2->CNPJ:=cCNPJ
       ENDIF           
       IF VAL(DANFE2->NNF)=0
          DANFE2->NNF:=cNNF
       ENDIF          
       IF EMPTY(DANFE2->AVB)
          DANFE2->AVB:="I"
       ENDIF
       IF EMPTY(DANFE2->XML)
          DANFE2->XML:="I"
       ENDIF
       IF EMPTY(DANFE2->DANFEVIEW) //Inutilizada o danfeview nao le
          DANFE2->DANFEVIEW:="I"
       ENDIF
       IF EMPTY(DANFE2->CSTATUS)
          DANFE2->CSTATUS:="INU"
       ENDIF
       IF EMPTY(DANFE2->LOGIXSUP)
          DANFE2->LOGIXSUP:="I"
       ENDIF
       IF EMPTY(DANFE2->EMISSAO)
          DANFE2->EMISSAO:=cDATA
       ENDIF
       dbunlock()
      
      GrvCamXml(cFILEDANFE,cCNPJ,cMES,cANO,cChave,"inutNFe",.T.,.F.)                             
      dbselectar("danfe2")
      dbsetorder(1)
      nOPCAO++
      LOOP   
      
   ENDIF 
   
   
   
   if lCCE  .OR. lRETC  .OR. lRESNFE .OR. lRESCTE
      cTITCCE:="cce"   
      IF lRETC
         cTITCCE:="retConsReciNFe"   
      ENDIF

      IF lRESNFE
         cTITCCE:="resnfe"   
      ENDIF
	  
	  IF lRESCTE
	     cTITCCE:="retCTeConsultaDFe"   
	  ENDIF

      
      lEVENTOESP:=.F.      
      tpEvento:=PegaDados('tpEvento' ,Alltrim(Linha))     
	  
	  


      
      do case  
         case tpEvento='110110'
              cTITCCE:='CTECartaCorrecao'
              lEVENTOESP:=.T.
         case tpEvento='240130'
              cTITCCE:='CTEComplementar'
              lEVENTOESP:=.T.
         case tpEvento='210200'
              cTITCCE:='ConfirmacaoOperacao'
              lEVENTOESP:=.T.      
         case tpEvento='210210'
              cTITCCE:='CienciaOperacao'
              lEVENTOESP:=.T.      
         case tpEvento='210220'
              cTITCCE:='DesconhecimentoOperacao'
              lEVENTOESP:=.T.      
         case tpEvento='210240'
              cTITCCE:='OperacaoNaoRealizada'
              lEVENTOESP:=.T.      
         case tpEvento='610601'
              cTITCCE:='CancCte'   
              lEVENTOESP:=.T.    
         case tpEvento='610615'
              cTITCCE:='CancMdeCte'   
              lEVENTOESP:=.T.    
         case tpEvento='610500' 
              cTITCCE:='RegistroPassagemNFe'   
              lEVENTOESP:=.T.    
         case tpEvento='610554'
              cTITCCE:='RegistroPassagemMDENFE'   
              lEVENTOESP:=.T.    
         case tpEvento='610514'
              cTITCCE:='RegistroPassagemMDECTE'   
              lEVENTOESP:=.T.    
	     case tpEvento='610552'
              cTITCCE:='RegistroPassagemMDEAuto'   
              lEVENTOESP:=.T.    
         case tpEvento='610600'
              cTITCCE:='cteAut'   
              lEVENTOESP:=.T.      			  
         case tpEvento='610614'
              cTITCCE:='MdecteAut'   
              lEVENTOESP:=.T.      
         case tpEvento='610610'
              cTITCCE:='MdeAutorizado'   
              lEVENTOESP:=.T.      
         case tpEvento='990910'
              cTITCCE:='SuframaInterna'   
              lEVENTOESP:=.T.      
         case tpEvento='990900'
              cTITCCE:='SuframaVistoria'   
              lEVENTOESP:=.T.                    
         case tpEvento='110111'
              cTITCCE:='CancRegistrado'   
              lEVENTOESP:=.T.          
         case tpEvento='110112'
              cTITCCE:='Encerramento'   
              lEVENTOESP:=.T.          
         case tpEvento='110114'
              cTITCCE:='Condutor'   
              lEVENTOESP:=.T.         
         case tpEvento='110140'
              cTITCCE:='Epec'   
              lEVENTOESP:=.T.          
      end case
      
      m_protocolo:=PegaDados('nProt' ,Alltrim(Linha))   
      cCGCEmit:= PegaDados( 'CNPJ'  ,Alltrim(Linha) )	
      cCHAVE  := PegaDados( 'chNFe'   ,Alltrim(Linha) )    
      
	  
	  if At('procEventoCTe',Linha)>0
	     cCHAVE  := PegaDados( 'chCTe'   ,Alltrim(Linha) )    
	  endif
	  
      IF lRETC .or. lRESNFE
         m_dEmi  := SUBSTR(PegaDados('dhRecbto' ,Alltrim(Linha) ),1,10) 
      ELSE
         m_dEmi  := SUBSTR(PegaDados('dhEvento' ,Alltrim(Linha)),1,10) 
      ENDif
      IF tpEvento='990900' .OR. tpEvento='990910' //suframa vistoria interna
         m_dEmi  := SUBSTR(PegaDados('dVistoria' ,Alltrim(Linha)),1,10) 
      ENDIF
      
	  cANO    := emissaoano(m_DEMI)
      cMES    := emissaomes(m_DEMI)	  
      cNFF    :=""
      cCGCDest :=""
      
	  
	  
      dbSelectar("danfe2")
      dbGotop()
      If dbseek(cCHAVE)
         cCGCDest:=CNPJDEST
         cNFF:=NNF      
         IF EMPTY(cCGCEMIT) .OR. VAL(cCGCEMIT)=0
            cCGCEmit :=CNPJ
         ENDIF
      endif   
      IF EMPTY(cNFF).OR.(LEN(cNFF)=1.AND.cNFF="0")
         cNFF:=IDNFF(cCHAVE)
      ENDIF         

      
      IF EMPTY(cCGCEMIT) .OR. VAL(cCGCEMIT)=0
         cCGCEmit := IDEMISSOR(cCHAVE)
      ENDIF  
	  
 	  
	  nSeqEvento:="_"+tpEvento+"_"+PegaDados('nSeqEvento' ,Alltrim(Linha))      //as sequencia sao por eventos evita sobrepor seq e seq de tipos diferentes


     IF EMPTY(cCGCDEST)  //copia para memorizar nota itaesbra quando ja chegaram eventos desta nota
        cARQIMP:=cChave+"-nfe_vis.xml"
		IF copiavislogix(cARQIMP,cNFECNPJ+cARQIMP)
   	    else
		    // o evento chegou antes nao estara disponivel para copia
			//cARQIMP := pegcamxml(cCHAVE)
			//IF FILE(cARQIMP)           
			//   FILECOPY(cARQIMP,cNFECNPJ+cARQIMP)
			//ENDIF
	    endif		
     ENDIF			

      IF IsCNPJITA(cCGCEmit)	  	  
         if lRETC .OR. lEVENTOESP  .OR. lRESNFE //nao grava memorizar danfeview
		    if empty(cCGCDEST) //o evento chegou antes da nota 
			   baixanfe(cChave)
			endif
            GrvCamXml(cFILEDANFE,cCGCDEST,cMES,cANO,cChave,cTITCCE,.T.,.F.,nSeqEvento)             
         ELSE
            if file(cCAM+cCGCDest+"\"+cANO+"\"+cMES+"\"+cChave+".xml")
               nfecce(cCAM+cCGCDest+"\"+cANO+"\"+cMES+"\"+cChave+".xml") //envia se for carta correcao
            endif
            GrvCamXml(cFILEDANFE,cCGCDEST,cMES,cANO,cChave,cTITCCE,.T.,.T.,nSeqEvento)            
         endif   
      ELSE 
         if lRETC .OR. lEVENTOESP  .OR. lRESNFE  //nao grava memorizar danfeview
            GrvCamXml(cFILEDANFE,cCGCEmit,cMES,cANO,cChave,cTITCCE,.T.,.F.,nSeqEvento)  
  	        if empty(cCGCEmit) //o evento chegou antes da nota 
			   baixanfe(cChave)
			endif
         ELSE
            if file(cCAM+cCGCEmit+"\"+cANO+"\"+cMES+"\"+cChave+".xml")
               nfecce(cCAM+cCGCEmit+"\"+cANO+"\"+cMES+"\"+cChave+".xml") //envia se for carta correcao
            endif
            GrvCamXml(cFILEDANFE,cCGCEmit,cMES,cANO,cChave,cTITCCE,.T.,.T.,nSeqEvento)                       
         endif   
      ENDIF  
      if val(m_protocolo)=0      
         GrvLogEdi(cCGCDest,,,cFILEDANFE,cCHAVE,cNFF,cCGCEmit,cTITCCE,'XML')  
      else
         GrvLogEdi(cCGCDest,,,m_protocolo,cCHAVE,cNFF,cCGCEmit,cTITCCE,'XML')  
      endif      
      nOPCAO++
      LOOP          
   ENDIF

   
   nPos1 := At('cteProc',Linha) 
   If nPos1>0      
      lCTE:=.T.
   ENDIF       
   nPos1 := At('CTeOS',Linha) 
   If nPos1>0      
      lCTE:=.T.
	  lCTEOS:=.T.
   ENDIF         
   nPos1 := At('procCTe',Linha) 
   If nPos1>0      
      lCTE:=.T.
   ENDIF        
   
     
     
   
   cLinhaTxt := Linha
  
   XCNPJ    :="" 
   xNome    := ''
   xFant    := ''
   xLgr     := ''
   xCpl     := ''
   Xnro     := ''
   xBairro  :=  ''
   cMun     := ''
   xMun     := ''
   XUF      := ''
   XCEP     := ''
   Xemail   := ''
   Xfone    := ''
   XCNAE    := ""  
   cPais    := "" 
   xPais    := "" 
   XIE      := ""
   XIEST    := ""
   XISUF    := ""
   XCPF     := ""
   XIM      := ""   
   cRPS     := ""
   cCODVERI := ""
   cDATASER := ""
   
   
   // nfe sp
   if at("www.prefeitura.sp.gov.br",linha)>0
      cLidos1 := PegaDados('CPFCNPJPrestador',Alltrim(Linha))            
      XCNPJ :=PegaDados('CNPJ' ,Alltrim(cLIDOS1) )            
      XCPF  :=PegaDados('CPF' ,Alltrim(cLIDOS1) )       
      xNome   := PegaDados('RazaoSocialPrestador' ,Alltrim(LINHA) )            
      cLidos1 := PegaDados('EnderecoPrestador',Alltrim(Linha))            
      xLgr    := PegaDados('TipoLogradouro' ,Alltrim(cLIDOS1))+" "+PegaDados('Logradouro' ,Alltrim(cLIDOS1) )             
      Xnro    :=PegaDados('NumeroEndereco' ,Alltrim(cLIDOS1) )        
      xBairro :=  PegaDados('Bairro' ,Alltrim(cLIDOS1) )       
      cMun   :=  PegaDados('Cidade' ,Alltrim(cLIDOS1) )            
      XUF     := PegaDados('UF' ,Alltrim(cLIDOS1) )       
      XCEP     := PegaDados('CEP' ,Alltrim(cLIDOS1) )       
      Xemail   := PegaDados('EmailPrestado' ,Alltrim(LINHA) )     
      cLidos1  := PegaDados('ChaveNFe',Alltrim(Linha))            
      XIM     :=PegaDados('InscricaoPrestador' ,Alltrim(cLIDOS1) ) 
      cNNF    :=PegaDados('NumeroNFe' ,Alltrim(cLIDOS1) ) 
      cRPS    :=PegaDados('NumeroRPS' ,Alltrim(cLIDOS1) ) 
      cDATASER:=PegaDados('DataEmissaoNFe' ,Alltrim(Linha))        
      cCODREVI:=PegaDados('CodigoVerificacao' ,Alltrim(Linha))              
      cMES:=emissaomes(cDATASER)
      cANO:=emissaoano(cDATASER)
      
      cLidos1 := PegaDados('CPFCNPJTomador',Alltrim(Linha))            
      cCGCDest :=PegaDados('CNPJ' ,Alltrim(cLIDOS1) )                  
      GRAVARPS()

            
	  
	  
      IF  netuse(CcamCCM+"CCMSP")       
		  dbgotop()
          IF ! dbseek(XCNPJ)
             netrecapp()
             CCMSP->cnpj:=XCNPJ           
		  else	 
             dbrlock()
          endif
		  if emptY(CCMSP->CCM)
			 CCMSP->CCM:=XIM
		  endif
		 dbunlock()
		 dbcloseAREA()
	  endif
	  
      nOPCAO++           
      LOOP     
   endif



   //NOTAS CAE
   
   if at("<NOTA_FISCAL><Cae>",linha)>0      
      cNNF  :=PegaDados('NumeroNota' ,Alltrim(linha) )      
	  cCODREVI:=PegaDados('ChaveValidacao' ,Alltrim(Linha))     
      cCGCDest := PegaDados('ClienteCNPJCPF' ,Alltrim(linha) )	  
      cDATASER := PegaDados('DataEmissao' ,Alltrim(Linha))     
      cMES     := emissaomes(cDATASER)
      cANO     := emissaoano(cDATASER)                  
      XCNPJ :='00000000000000'           // nao vem cnpj quando e cae 
	  xNome := 'CAE'	
      cMUN  := 'CAE'	
      
      GRAVARPS()      
      nOPCAO++           
      LOOP     
   endif


   //NOTAS
   if at("<NOTAS>",linha)>0      
      cNNF  :=PegaDados('NUMERO' ,Alltrim(linha) )      
      XCNPJ :=PegaDados('CNPJ' ,Alltrim(linha) )            
      XIM   :=PegaDados('INSCRICAO_MUNICIPAL' ,Alltrim(linha) )            
      xNome := PegaDados('PRE_RAZAO_SOCIAL' ,Alltrim(LINHA) )               
      xLgr  := PegaDados('PRE_ENDERECO',Alltrim(Linha))            
      Xnro  :=PegaDados('PRE_ENDERECO_NUMERO' ,Alltrim(linha) )        
      xCpl  :=PegaDados('PRE_ENDERECO_COMPLEMENTO' ,Alltrim(linha) )        
      xBairro :=  PegaDados('PRE_ENDERECO_BAIRRO' ,Alltrim(linha) )    
      XCEP     := PegaDados('PRE_ENDERECO_CEP' ,Alltrim(linha) )       
      Xemail   := PegaDados('PRE_EMAIL' ,Alltrim(LINHA) )          
      cMUN     := PegaDados('PRE_ENDERECO_ES_MUNICIPIO' ,Alltrim(LINHA) )            
      cDATASER := PegaDados('DT_COMPETENCIA' ,Alltrim(Linha))     
      cMES     := emissaomes(cDATASER)
      cANO     := emissaoano(cDATASER)            
      cCGCDest := PegaDados('TOM_CPF_CNPJ' ,Alltrim(linha) )
      XCNAE    := PegaDados('ES_CNAE' ,Alltrim(LINHA) )          
      Xfone    := PegaDados('PRE_TELEFONE' ,Alltrim(LINHA) ) 
      XIE      := PegaDados('PRE_INSCRICAO_ESTADUAL' ,Alltrim(LINHA) ) 
      
      
      GRAVARPS()      
      nOPCAO++           
      LOOP     
   endif

   
   // nfes boituva        
   if At('<MunicipioPrestacaoServico>Boituva</MunicipioPrestacaoServico>',Linha)>0          
   
      cLidos1 := PegaDados('IdentificacaoNfse',Alltrim(cLinhaTxt),,'IdentificacaoNfse')
      Linha1  := cLidos1      
      cNNF    :=PegaDados('Numero' ,Alltrim(Linha1) )             
      
      cDATASER:=PegaDados('DataEmissao' ,Alltrim(Linha) )                  
      cMES:=SUBSTR(cDATASER,4,2)
      cANO:=SUBSTR(cDATASER,7,4)
      
      cLidos1 := PegaDados('IdentificacaoTomador',Alltrim(cLinhaTxt),,'IdentificacaoTomador')
      Linha1 := cLidos1         
      cCGCDESt:=PegaDados('Cnpj' ,Alltrim(Linha1) )             
      cLidos2 := PegaDados('PrestadorServico',Alltrim(cLinhaTxt))
      Linha2 := cLidos2      
      XCNPJ    := PegaDados( 'Cnpj'  ,Alltrim(Linha2) )
      xNome   := PegaDados( 'RazaoSocial' ,Alltrim(Linha2) )
      XIm      := PegaDados( 'InscricaoMunicipal'   ,Alltrim(Linha2) )
      cLidos3 := PegaDados('Endereco',Alltrim(Linha2))
      Linha3 := cLidos3      
      xLgr    := PegaDados( 'Rua'  ,Alltrim(Linha3))
      Xnro     := PegaDados( 'Numero'  ,Alltrim(Linha3))
      xBairro := PegaDados( 'Bairro' ,Alltrim(Linha3))
      xMun    := PegaDados( 'Cidade' ,Alltrim(Linha3))
      XUF      := PegaDados( 'Estado'   ,Alltrim(Linha3))
      XCEP     := tiraout(PegaDados( 'Cep'  ,Alltrim(Linha2)))
      cLidos3 := PegaDados('Contato',Alltrim(Linha2))
      Linha3 := cLidos3
      Xemail   := PegaDados( 'Email'   ,Alltrim(Linha3) )     
      Xfone    := PegaDados( 'Telefone'   ,Alltrim(Linha3))
      GRAVARPS()
      nOPCAO++           
      LOOP     
   endif   

   // nfes arthur nogueira
   if At('<CIDADE_PRESTADOR>ARTUR NOGUEIRA</CIDADE_PRESTADOR>',Linha)>0    
      cLidos1 := PegaDados('IdentificacaoNfse',Alltrim(cLinhaTxt),,'IdentificacaoNfse')
      Linha1  := cLidos1      
      cNNF    :=PegaDados('Numero' ,Alltrim(Linha1) )            
      cDATASER:=PegaDados('EMISSAO_NF' ,Alltrim(Linha) )                  
      cMES:=SUBSTR(cDATASER,4,2)
      cANO:=SUBSTR(cDATASER,7,4)
      cLidos1 := PegaDados('DADOS_TOMADOR',Alltrim(cLinhaTxt))
      Linha1 := cLidos1         
      cCGCDESt:=PegaDados('CNPJ_TOMADOR' ,Alltrim(Linha1) )             
      cLidos2 := PegaDados('DADOS_PRESTADOR',Alltrim(cLinhaTxt))
      Linha2 := cLidos2          
      XCNPJ    := PegaDados( 'CNPJ_PRESTADOR'  ,Alltrim(Linha2) )
      xNome   := PegaDados( 'NOME_PRESTADOR' ,Alltrim(Linha2) )
      XIm      := PegaDados( 'INSCRMUNICIPAL_PRESTADOR'   ,Alltrim(Linha2) )
      XIE      := PegaDados( 'INSCRESTADUAL_PRESTADOR'   ,Alltrim(Linha2))
      XCNAE    := PegaDados( 'CNAE_PRESTADOR'   ,Alltrim(Linha2) )      
      xLgr    := PegaDados( 'ENDERECO_PRESTADOR'  ,Alltrim(Linha2) )
      xBairro := PegaDados( 'BAIRRO_PRESTADOR' ,Alltrim(Linha2) )
      xMun    := PegaDados( 'CIDADE_PRESTADOR' ,Alltrim(Linha2) )
      XUF      := PegaDados( 'UF_PRESTADOR'   ,Alltrim(Linha2) )
      XCEP     := tiraout(PegaDados( 'CEP_PRESTADOR'  ,Alltrim(Linha2)))
      Xemail   := PegaDados( 'EMAIL_PRESTADOR'   ,Alltrim(Linha2) )     
      Xfone    := PegaDados( 'FONE_PRESTADOR'   ,Alltrim(Linha2))
      GRAVARPS()
      nOPCAO++     
      LOOP     
   endif   
      
   
      // nfes www.abrasf.org.br www.betha.com.br   

   
   if At('www.betha.com.br',Linha)>0   .or. at('consultarNotaResponse',linha)>0   .or. At('www.abrasf.org.br',Linha)>0 
   
      Linha1 := PegaDados('IdentificacaoRps',Alltrim(cLinhaTxt),,'IdentificacaoRps')        
      if empty(linha1) .or. linha1=="0"      
        Linha1 := PegaDados('InfNfse',Alltrim(cLinhaTxt),,'InfNfse')        
      endif
      cNNF    :=PegaDados('Numero' ,Alltrim(Linha1) )             
      cDATASER:=PegaDados('DataEmissao' ,Alltrim(Linha) )   
      cMES:=emissaomes(cDATASER)
      cANO:=emissaoano(cDATASER)      
	  cCODREVI:=PegaDados('CodigoVerificacao' ,Alltrim(Linha)) 

      
		if left(Cnnf,4)=CANO
		   cNNF    :=substr(cnnf,5)
		endif
      
      Linha1 := PegaDados('IdentificacaoTomador',Alltrim(cLinhaTxt),,'IdentificacaoTomador')      
      cCGCDESt:=PegaDados('Cnpj' ,Alltrim(Linha1) )             
      if empty(cCGCDESt).OR.cCGCDESt="0"
        cCGCDESt:=PegaDados('Cpf' ,Alltrim(Linha1))           
      endif  
   
      
	  
      Linha2 := PegaDados('IdentificacaoPrestador',Alltrim(cLinhaTxt))      
      IF EMPTY(linha2) .OR. linha2=="0"
         Linha2 := PegaDados('Prestador',Alltrim(cLinhaTxt))      
      endif
	  
	  
	  
 
	  
      XCNPJ    := PegaDados( 'Cnpj'  ,Alltrim(Linha2) )
      XCPF     := PegaDados( 'cpf'  ,Alltrim(Linha2) )
      XIm      := PegaDados( 'InscricaoMunicipal'   ,Alltrim(Linha2) )  
      
      Linha2 := PegaDados('IdentificacaoPrestador',Alltrim(cLinhaTxt))
      xNome   := PegaDados( 'RazaoSocial'  ,Alltrim(Linha2) )
      xFant   := PegaDados( 'NomeFantasia'  ,Alltrim(Linha2))
      nPOS:=AT('endereco',linha2)      
      Linha3 := substr(linha2,npos+9)          
      xLgr    := PegaDados( 'endereco'  ,Alltrim(Linha3))      
      Xnro     := PegaDados( 'numero'  ,Alltrim(Linha3))
      xBairro :=  PegaDados( 'bairro'  ,Alltrim(Linha3))
      cMun    := PegaDados( 'CodigoMunicipio'  ,Alltrim(Linha3) )      
      XUF      := PegaDados( 'Uf'  ,Alltrim(Linha3) )
      Xfone    := PegaDados( 'Telefone'  ,Alltrim(Linha2))      
      XCEP     := PegaDados( 'cep'  ,Alltrim(Linha2) )
      Xemail   := PegaDados( 'email'  ,Alltrim(Linha2))      
	  
      GRAVARPS()
      nOPCAO++          
      LOOP     
   endif   


   
   
   // nfes ginfes    
   if At('ginfes.com.br',Linha)>0 .OR. At('InfNFPSe',Linha)>0 .OR. At('InfNfse',Linha)>0      
   
   
   
	  IF hb_StrIsUTF8(linha)   
        linha:=hb_UTF8ToStr(linha)
      ENDIF
	  

	  IF hb_StrIsUTF8(cLinhaTxt)   
         cLinhaTxt:=hb_UTF8ToStr(cLinhaTxt)
      ENDIF
   
      //hb_memowrit("linha.txt",linha)
	  //hb_memowrit("linhatxt.txt",clinhatxt)
      //quit
	  
      cNVS:=""      
	  cSUBcNVS:=""
      IF AT("ns3:",Linha)>0
         cNVS:="ns3:"      
      ENDIF
      IF AT("ns4:Nfse",Linha)>0
         cNVS:="ns4:"      
      ENDIF         
      IF AT("ns2:InfNFPSe",Linha)>0 
         cNVS:="ns2:"      
		 cSUBcNVS:="InfNFPSe"
      ENDIF  
      IF AT("ns2:InfNfse",Linha)>0
         cNVS:="ns2:"
         cSUBcNVS:="InfNfse"		 
      ENDIF  
      IF AT("tc:InfNfse",Linha)>0  ///www.issnetonline.com.br
         cNVS:="tc:"      
      ENDIF  

	  
	  //alguns vem com &gt; &lt; ajustados para achar as tags na pegdados
      linha := StrTran( linha, "&lt;", "<" )
      linha := StrTran( linha, "&gt;", ">" )	 
      clinhatxt := StrTran( clinhatxt, "&lt;", "<" )
      clinhatxt := StrTran( clinhatxt, "&gt;", ">" )	 	  
      cLIDOS1:=""
      nPOSNFSE:=0
      DO CASE
         CASE cNVS="ns3:"      
             cLidos1 := PegaDados(cNVS+'IdentificacaoNfse',Alltrim(cLinhaTxt))        
             nPOSNFSE:=AT('IdentificacaoNfse',cLINHATXT)
         CASE cNVS="ns2:"      
             cLidos1 := PegaDados(cNVS+cSUBcNVS,Alltrim(cLinhaTxt))
             nPOSNFSE:=AT('InfNFPSe',cLINHATXT)
         OTHERWISE
             cLidos1 := PegaDados(cNVS+'InfNfse',Alltrim(cLinhaTxt))
             nPOSNFSE:=AT('InfNfse',cLINHATXT)
      ENDCASE      	  
      IF LEN(cLIDOS1)=1 .AND. cLIDOS1='0' .AND. nPOSNFSE>0
         cLIDOS1:=SUBSTR(clinhatxt,Nposnfse)
         IF EMPTY(cLIDOS1)
            cNVS:=""      
         ENDIF
      ENDIF      
      Linha1  := cLidos1  
	  do case
        case  cNVS="tc:"            
              cNNF    :=PegaDados(cNVS+'Numero' ,Alltrim(Linha) )       
              cDATASER:=PegaDados(cNVS+'DataEmissaoRps' ,Alltrim(Linha) )                  
        case  cNVS="ns2:"  .and. cSUBcNVS="InfNFPSe"         
              cNNF    :=PegaDados(cNVS+'NumeroSerie' ,Alltrim(Linha) )                   
              cDATASER:=PegaDados(cNVS+'DataEmissao' ,Alltrim(Linha) )                  
        otherwise
              cNNF    :=PegaDados(cNVS+'Numero' ,Alltrim(Linha1) )       
              cDATASER:=PegaDados(cNVS+'DataEmissao' ,Alltrim(Linha) )                  
      ENDcase 
      
      cMES:=emissaomes(cDATASER)
      cANO:=emissaoano(cDATASER)
      
      cLidos1 := PegaDados(cNVS+'CpfCnpj',Alltrim(cLinhaTxt))
      Linha1 := cLidos1         
      cCGCDESt:=PegaDados(cNVS+'Cnpj' ,Alltrim(Linha1) )           
      if empty(cCGCDESt).OR.cCGCDESt="0"
         cCGCDESt:=PegaDados(cNVS+'Cpf' ,Alltrim(Linha1) )           
      endif
      
      do case
   	     case cNVS="ns2:"      
              cLidos2 := PegaDados(cNVS+'Prestador',Alltrim(cLinhaTxt))
        case  cNVS="tc:"            			  
		      cLidos2 := PegaDados(cNVS+'IdentificacaoPrestador',Alltrim(cLinhaTxt))
         otherwise
              cLidos2 := PegaDados(cNVS+'PrestadorServico',Alltrim(cLinhaTxt))
      ENDcase
    
      
	  if ( empty(cLidos2) .or. clidos2="0"  ).and. cNVS="ns2:"      
	     cLidos2 := PegaDados(cNVS+'IdentificacaoPrestador',Alltrim(cLinhaTxt))
	  endif
	  
	  
      Linha2 := cLidos2    
      XCNPJ    := PegaDados( cNVS+'Cnpj'  ,Alltrim(Linha2) )      
      xNome   := PegaDados( cNVS+'RazaoSocial' ,Alltrim(Linha2))
      XIm      := PegaDados( cNVS+'InscricaoMunicipal'   ,Alltrim(Linha2) ) 
      
      nPOS:=AT(cNVS+'ENDERECO',linha2)      
      Linha3 := substr(linha2,npos+11)           

      IF cNVS="ns2:"      
         xLgr    := PegaDados( cNVS+'Logradouro'  ,Alltrim(Linha3) )
         xCpl    := PegaDados( cNVS+'ComplementoEndereco'  ,Alltrim(Linha3))
         Xnro     := PegaDados( cNVS+'NumeroEndereco'  ,Alltrim(Linha3))
      ELSE       
         xLgr    := PegaDados( cNVS+'Endereco'  ,Alltrim(Linha3) )
         xCpl    := PegaDados( cNVS+'Complemento'  ,Alltrim(Linha3) )
         Xnro     := PegaDados( cNVS+'Numero'  ,Alltrim(Linha3) )
      ENDIF       

	  
      xBairro := PegaDados( cNVS+'Bairro' ,Alltrim(Linha3) )
	  XCEP     := tiraout(PegaDados( cNVS+'Cep'  ,Alltrim(Linha2)))
	  
	  do case
	     case cNVS="tc:"
              cMun    := PegaDados( cNVS+'Cidade'  ,Alltrim(Linha3)) //no tc cidade fica o codigo
              XUF      := PegaDados( cNVS+'Estado'   ,Alltrim(Linha3) )
	     otherwise
              cMun    := PegaDados( cNVS+'CodigoMunicipio'  ,Alltrim(Linha3))
              XUF      := PegaDados( cNVS+'Uf'   ,Alltrim(Linha3) )
      endcase			  
      
      
      
      cLidos3 := PegaDados(cNVS+'Contato',Alltrim(Linha2))
      Linha3 := cLidos3
      Xemail   := PegaDados( cNVS+'Email'   ,Alltrim(Linha3) )     
      Xfone    := PegaDados( cNVS+'Telefone'   ,Alltrim(Linha3) )  
      
      GRAVARPS()
      
      nOPCAO++      
      LOOP                
   endif   
   
   
   // identificao arquivo
   nPos1 := At('Id="',Linha)    
   If nPos1==0     
     GrvCamXml(cFILEDANFE,"","","","",.T.,.T.)                               
     nOPCAO++
     LOOP
   Endif   
   nPos1 := nPos1+Len('Id="')
   cChave:= Substr(Linha,nPos1,47)      

   // cnpj
   nPos1 := At('<CNPJ>',Linha)   
   If nPos1==0
      GrvCamXml(cFILEDANFE,"","","",cCHAVE,.T.,.T.)                                     
      nOPCAO++
      LOOP   
   Endif

   
   nPos1 := At('<nProt',Linha)
   If nPos1==0
       if len(cCHAVE)<>44
	      cCHAVE:=SONUMERO(cFILEDANFE)
	   ENDIF
      cARQIMP:=cChave+"-nfe_vis.xml"
      IF copiavislogix(cARQIMP,cNFECNPJ+cARQIMP)                  
		 filedelete(cCAM+cFILEDANFE)
	  else	  
	     cARQIMP := pegcamxml(cCHAVE)
		 IF FILE(cARQIMP)
            FILECOPY(cARQIMP,cNFECNPJ+cARQIMP)		 
		    filedelete(cCAM+cFILEDANFE)
         ELSE 	  
		    if file(cCAM+"erro\"+cCHAVE+".protocolo") .or. file(cCAM+"erro\"+cFILEDANFE+".protocolo") //arquivo duplicado apaga destino para copiar novamente
			   filedelete(cCAM+cFILEDANFE,cCAM+"erro\"+cCHAVE+".protocolo")
			   filedelete(cCAM+cFILEDANFE,cCAM+"erro\"+cFILEDANFE+".protocolo")
			endif
			IF filecopy(cCAM+cFILEDANFE,cCAM+"erro\"+cCHAVE+".protocolo")>0     
			   filedelete(cCAM+cFILEDANFE)
			ENDIF 		 
	     ENDIF		  
   	  ENDIF	   
	   
       nOPCAO++
       LOOP
   endif
   
   nPos1 := At('<SignatureValue',Linha)
   If nPos1==0
       filecopy(cCAM+cFILEDANFE,cCAM+"erro\"+cFILEDANFE+".assinatura")     
       filedelete(cCAM+cFILEDANFE)
       nOPCAO++
       LOOP
   endif   

   nPos1 := At('<DigestValue',Linha)
   If nPos1==0
       filecopy(cCAM+cFILEDANFE,cCAM+"erro\"+cFILEDANFE+".digestvalue")     
       filedelete(cCAM+cFILEDANFE)
       nOPCAO++
       LOOP
   endif   
   
   
   m_cNF := PegaDados('nNF' ,Alltrim(Linha) )
   
   
   IF lCTE .AND. ! lCTEOS      
      m_cNF := PegaDados('nCT' ,Alltrim(Linha) )
   ENDIF
   
   m_serie := PegaDados('serie' ,Alltrim(Linha) )   
   m_dEmi := PegaDados('dEmi' ,Alltrim(Linha))   
   IF lCTE .or. (m_DEMI='0' .AND. AT('dhEmi' ,Linha)>0)
      m_dEmi := SUBSTR(PegaDados('dhEmi' ,Alltrim(Linha)),1,10)
   ENDIF 
      
   m_TPNF:=PegaDados('tpNF' ,Alltrim(Linha) )
   m_protocolo:=PegaDados('nProt' ,Alltrim(Linha) )
   IF lCTE .AND. m_TPNF="0"
      m_TPNF:="1"
   ENDIF
   cANO     := EMISSAOANO(m_DEMI)
   cMES     := EMISSAOMES(m_DEMI)
   IF EMPTY(cANO).OR.EMPTY(CMES).OR.val(cANO)=0.OR.val(cMES)=0
      cANO  := strzero(year(date()),4,0)
      cMES  := strzero(month(date()),2,0)
	ENDIF

   


   cLIDOS1:=[] ; LINHA1:=[]
   cLidos1 := PegaDados('dest',Alltrim(cLinhaTxt),,'dest')
   Linha1 := cLidos1
   if lcte .and. at('DESTCALC>',linha1)>0   
      nPOS:=at('</destCalc>',cLINHATXT)
      IF nPOS>0
         linha1:=substr(cLINHATXT,nPOS+13)
         cLidos1 := PegaDados('dest',Alltrim(linha1),,'dest')
         Linha1 := cLidos1   
      ENDIF
   endif 
   Pegacadastro(linha1)   
   cCGCDest := Substr(trim(XCNPJ),1,14)  
   gravacpnjxml()
   
   lELEC:=.F.
   IF AT("ELECTROLUX",xNOME)>0
      lELEC:=.T.
   ENDIF
   
   
   
   Pegacadastro(PegaDados('emit',Alltrim(cLinhaTxt),,'emit'))     
   cCGCEmit:= Substr(XCNPJ,1,14)
   
   gravacpnjxml()

   
   IF cCGCEmit='00640071000159' //calvo nao lanca entrega a funcionario   00640071000159
      nPos1 := At('<CFOP>5923</CFOP>',cLINHATXT)
      If nPos1>0      
         lCALVOREM:=.T.
      ENDIF        
   ENDIF
   

   cTOMA    :=""
   cCGCRemt :=""
   cCGCExped:=""
   cCGCtoma :=""
   cCGCReceb:=""
   
   
   
   IF lCTE       
      //PegaDados('dest',Alltrim(cLinhaTxt),,'dest')
     //Pegacadastro(PegaDados('emit',Alltrim(cLinhaTxt),,'emit'))      ja pegou acima
    
      Pegacadastro(PegaDados('receb',Alltrim(cLinhaTxt),,'receb'))   
      cCGCReceb:= Substr(XCNPJ,1,14)
      gravacpnjxml()
      Pegacadastro(PegaDados('rem',Alltrim(cLinhaTxt),,'rem'))   
      cCGCRemt:= Substr(XCNPJ,1,14)
      gravacpnjxml()
      Pegacadastro(PegaDados('exped',Alltrim(cLinhaTxt),,'exped'))   
      cCGCExped:= Substr(XCNPJ,1,14)
      gravacpnjxml()
      Pegacadastro(PegaDados('toma4',Alltrim(cLinhaTxt),,'toma4'))   
      cCGCtoma:= Substr(XCNPJ,1,14)  
      gravacpnjxml() 	  
	  
	  
	  //tenta toma03
      IF (len(cCGCTOMA)=1 .and. cCGCTOMA='0' ) .or. VALCGC(cCGCTOMA,,.F.) //o tomador em branco pegar conforme o tipo
	      cLidos1 := PegaDados('toma03',Alltrim(cLinhaTxt))		  
		  cTOMA   := PegaDados('toma',Alltrim(clidos1))		  
		  do case
		     case cTOMA='0'
			      cCGCTOMA:=cCGCRemt
		     case cTOMA='1'
			      cCGCTOMA:=cCGCExped
		     case cTOMA='2'
			      cCGCTOMA:=cCGCReceb
		     case cTOMA='3'
			      cCGCTOMA:=cCGCDEST				  
		  endcase         
      ENDIF

	 
     //tenta toma3
      IF (len(cCGCTOMA)=1 .and. cCGCTOMA='0' ) .or. VALCGC(cCGCTOMA,,.F.) //o tomador em branco pegar conforme o tipo
	      cLidos1 := PegaDados('toma3',Alltrim(cLinhaTxt))		  
		  cTOMA   := PegaDados('toma',Alltrim(clidos1))		  
		  do case
		     case cTOMA='0'
			      cCGCTOMA:=cCGCRemt
		     case cTOMA='1'
			      cCGCTOMA:=cCGCExped
		     case cTOMA='2'
			      cCGCTOMA:=cCGCReceb
		     case cTOMA='3'
			      cCGCTOMA:=cCGCDEST				  
		  endcase         
      ENDIF  
   ENDIF
 
   
   
   IF lCTE .AND. ! lCTEOS      
      cPGCTE:=PegaDados('forPag' ,Alltrim(Linha),"?" ) 
      //0 - Pago;
      //1 - À pagar;
      //2 - Outros	  
      IF cPGCTE="0"
         lCTEPAGA:=.T.
      ENDIF
      IF cPGCTE="1" .or.  cPGCTE="2"
         lCTEPAGA:=.F.
      ENDIF   
	  if cPGCTE="?" .and. cTOMA='3' 
	     lCTEPAGA:=.F.
	  endif
   ENDIF
   
   
   if lcteos 
      IF (len(cCGCTOMA)=1 .and. cCGCTOMA='0' ) .or. VALCGC(cCGCTOMA,,.F.)
   	      cLidos1  := PegaDados('toma',Alltrim(cLinhaTxt))
		  cCGCTOMA :=PegaDados('cnpj',Alltrim(clidos1))		  
		  IF (len(cCGCDest)=1 .and. cCGCDest='0' ) .or. VALCGC(cCGCDest,,.F.)
		      cCGCDest:=cCGCTOMA
		  endif
	  endif
	  
   endif
   
   
   IF lELEC.AND.! lCTE
	   if ! file(cELECTROLUXLOG+cCHAVE+"-nfe_vis.xml") //ja trasmitido	            
	      IF cANO>=cANOBASE	.AND. cMES=STRZERO(MONTH(DATE()),2)       //somente da competencia atual      		 
	         filecopy(cCAM+cFILEDANFE,cELECTROLUXAVB+cChave+"_ele.xml") //nome diferente para rastrear erro e log diferente
	      ENDIF		
	   endif	 
   ENDIF
   
   IF IsCNPJITA(cCGCEmit)
     GrvCamXml(cFILEDANFE,cCGCDESt,cMES,cANO,cChave,"",.T.,.T.)                  
   ELSE
     GrvCamXml(cFILEDANFE,cCGCEmit,cMES,cANO,cChave,"",.T.,.T.)                       
   ENDIF
   
    
	
    cPesq := Substr(cChave,4,47)     
    dbSelectar("danfe2")
    dbsetorder(1)
    dbGotop()
    If ! dbseek(cPESQ)
       netrecapp()
       Danfe2->Id     :=cPESQ
	   IF cANO>=cANOBASE	
          AADD(aSTATUS,cPESQ)
	   ENDIF	  
    else
       netreclock()   
    Endif
    Danfe2->cnpj     :=cCGcEmit
    danfe2->Nnf      :=M_cnf
    danfe2->serie    :=M_serie
    danfe2->emissao  :=m_demi
    Danfe2->cnpjdest :=cCGCDest 
    danfe2->protocolo:=m_protocolo
    dbunlock()
  
   
   
   dDATALOG  :=EmissaoData(m_demi)   
   cID       :=alltrim(Substr(cChave,4,47))
   cNNF      :=ALLTRIM(M_cnf)   
   cCGCLOG   :=ALLTRIM(PADR(ALLTRIM(cCGCEmit),15))     

   
   
   if lCALVOREM  //notas de envio cesta basica(lCALVOREM)
      GrvLogEdi(cCGCLOG,dDATALOG,,m_protocolo,cID,cNNF,cCGCDest,'EMAIL','XML')                     
   endif
   
   
   IF IsRaizIta(cCGCEmit)
      if IsRaizIta(cCGCDEST) //emitende e destinatario itaesbra
          if m_TPNF="0" // nota fiscal de entrada inverter emitente destinatario
             GrvLogEdi(cCGCDest,dDATALOG,,m_protocolo,cID,cNNF,cCGCEmit,'EMAIL','XML')
          else      
             GrvLogEdi(cCGCLOG,dDATALOG,,m_protocolo,cID,cNNF,cCGCDest,'EMAIL','XML')
          endif  
      endif
   ELSE      
      IF m_TPNF<>"0" .and. ! lCALVOREM        //notas 0 e de entradas nao gerar log  -- notas de envio cesta basica(lCALVOREM)(gravacao acima )	     
	     IF lCTE   	            		 
  		    if ( IsCNPJITA(cCGCtoma) .and. ! lCTEPAGA )  // cte somente se a itaesbra for o tormador e gerar pagamento	ainda nao paga(1,2)   			
                GrvLogEdi(cCGCLOG,dDATALOG,,m_protocolo,cID,cNNF,cCGCDest,'EMAIL','XML')                     
		    endif		
		 ELSE
		    if IsCNPJITA(cCGCDEST)
			   GrvLogEdi(cCGCLOG,dDATALOG,,m_protocolo,cID,cNNF,cCGCDest,'EMAIL','XML')                     
			endif
         endif		 
      ENDIF 
  ENDIF
  
NEXT nOPCAO
  
aCANCEL2:=checkstaent(aSTATUS)
FOR I=1 TO LEN(aCANCEL2)
    IF ASCAN(aCANCEL,aCANCEL2[I])=0
       AADD(aCANCEL,aCANCEL2[I])
    ENDIF
NEXT I
IF LEN(aCANCEL)>0
   FOR I= 1 TO LEN(aCANCEL)
       dbselectar("danfe2")
       dbgotop()
       if dbseek(aCANCEL[I])
         netreclock()
         grvcancelada()                     
         dbunlock()
         cCGCEmit=CNPJ
         IF IsCNPJITA(cCGCEmit) 
         ELSE
             dDATA:=emissaodata(danfe2->EMISSAO)                          
             cPROTOCOLO:=ALLTRIM(PROTOCOLO)
             cID:=alltrim(ID)
             cNNF:=ALLTRIM(NNF)
             if VAL(cNNF)=0 //Cancelamento chegou antes da nota
                cNNF:=IDNFF(DANFE2->ID)
             endif
             if ! EMPTY(cCGCEmit)
                GrvLogEdi(cCGCEmit,dDATA,,cPROTOCOLO,cID,cNNF,CNPJDEST,'cancNFe','XML')           //gravando cte tambem mesmo 
             ENDIF
         ENDIF         
      ENDIF   
   NEXT I  
ENDIF
FCLOSE(nHANDLE)
gravaprot(cARQGRV)  
return nil



function gravacpnjxml()
IF IsCNPJITA(XCNPJ) //agiliza nao checando ita 
   return
endif
IF ! VALCGC(XCNPJ,,.F.) .and. ! Valcpf(XCNPJ,.F.) 
   return
endif  
dbselectar("cnpjxml")
dbgotop()
if ! dbseek(XCNPJ)
   netrecapp()
   CNPJXML->CNPJ:=XCNPJ
ELSE
   netreclock()   
ENDIF   
	xEMAIL:=lower(xEMAIL)
	xCEP:=TIRAOUT(xCEP)
	aDADOS:={xNome,xFant,xLgr     ,xCpl   ,xnro,   xBairro,cMun,xMun,XUF,XCEP,cPais,xPais,Xfone,XIE,XIEST,Xemail,XIm,XCNAE,XISUF}
	aCAMPOS:={"NOME","COGNOME","ENDERECO","COMPLEM","NUMEND","BAIRRO","CODIBGE","CIDADE","UF","CEP","BACEN","PAIS","TELEFONE","IE","IESUBST","EMAIL","IMUNICIPAL","CNAE","SUFRAMA"}
	//           1         2       3         4          5        6          7      8       9   10    11        12    13        14    15         16      17           18   19
	FOR X=1 TO 19
		cCAMPO:=ACAMPOS[X]
	    IF X=1 .OR. X=2 .OR. X=3 .OR. X=4 .OR. X=6 .OR. X=8  //.OR. X=16
		  cCAMPO:=TIRACE(cCAMPO)
		ENDIF
		IF EMPTY(&cCAMPO.) .AND. ! EMPTY(aDADOS[X]) .AND. aDADOS[X]<>'0' .AND. LEN(aDADOS[X])>1
 		   CNPJXML->&cCAMPO.:=aDADOS[X]
		ENDIF
	NEXT X
   if (len(alltrim(tiraout(cnpjxml->telefone)))=8 .or. len(alltrim(tiraout(cnpjxml->telefone)))=9) .and. at("-",cnpjxml->telefone)=0     
      cnpjxml->telefone:=formatatel(cnpjxml->telefone)
   endif	     
   CNPJXML->ULTIMAIMP:=DATE()
   dbunlock()
return .t.




function consulta1(cAddress)
	DEFINE WINDOW Win1 ;
		AT 0,0 ;
		WIDTH 800 ;
		HEIGHT 500 ;
		TITLE 'Consulta NFE' ;
		ON INIT Win1.Test.Object:Navigate(cAddress)   
		 

		@ 10 , 50 ACTIVEX Test ;
			WIDTH 700  ;
			HEIGHT 400  ;
			PROGID "shell.explorer.2"  

	END WINDOW

	Center Window Win1

	Activate Window Win1
return

function nfecancelada(cARQ)
if cANO>=cANOBASE.AND. cMES=STRZERO(MONTH(DATE()),2)
   cDEST:=PROFILESTRING( "LERXML.INI","EMAIL","DESTDANFE")
   ENVIAEMAIL("","NFE-XML CANCELADA",cDEST,cARQ) //antigo anexo/hb_memoread(cARQ) agora o caminho como link
endif   
return .t.

function nfecce(cARQ)
if cANO>=cANOBASE.AND. cMES=STRZERO(MONTH(DATE()),2)
  cDEST:=PROFILESTRING( "LERXML.INI","EMAIL","DESTDANFE")
  ENVIAEMAIL("","carta correcao eletronica",cDEST,cARQ) //antigo anexo/hb_memoread(carq) agora o caminho como link
endif  
return .t.

function sememail(cARQ)
cDEST:=PROFILESTRING( "LERXML.INI","EMAIL","DESTDANFE")
ENVIAEMAIL(cARQ,"Falta Cadastrar email",cDEST)
return .t.



function gravaprot(cARQ,lQUIT)
local oConn, oComm,  oErr
local cConn:="Provider=MSDASQL.1;Persist Security Info=False;Data Source=ol_logix"
local cCOMANDO:=""
cCOMANDO:=hb_memoread(cARQ)
if len(cCOMANDO)=0
   filedelete(cCAM+cARQ)
   return .T.
endif
IF VALTYPE(lQUIT)<>"L"
   lQUIT:=.F.
ENDIF
try

    oConn:=CreateObject( "ADODB.Connection" )
    with object oConn
        :ConnectionString:=cConn
        :Open()
    end
    
    
    oComm:=CreateObject( "ADODB.Command" )
    with object oComm
      :CommandText:=cCOMANDO
      :CommandType:=adCmdText
      :ActiveConnection:=oConn
      oRs:=:Execute()
    end
    

    oConn:Close()                                             
    oComm:=NIL
    oConn:=NIL

catch oErr
  //msginfo("Error: " + oErr:Operation + " " + oErr:Description)
  IF lQUIT
     main.release
  ENDIF   
end
IF filecopy(cCAM+cARQ,cCAM+"script\"+cARQ)>0
   filedelete(cCAM+cARQ)
ENDIF   
return

function executasql(cSQL,cMSG)
PUBLIC oCONNX,oCOMMX,cCOMANDOX
IF VALTYPE(cMSG)='C'
   mds("...")     
ENDIF

cConnX:="Provider=MSDASQL.1;Persist Security Info=False;Data Source=ol_logix"
oConnX:=CreateObject( "ADODB.Connection" )
oCommX:=CreateObject( "ADODB.Command" )
try
	with object oConnX
		:ConnectionString:=cConnX
		:Open()  	
    end
catch oErr
    return
end	

//set isolantion
cCOMANDOX:="SET ISOLATION TO DIRTY READ"
try
	with object oCommX
		:CommandText:=cCOMANDOX
		:CommandType:=adCmdText
		:ActiveConnection:=oConnX
		:Execute()
	end
catch oErr   
end

IF VALTYPE(cMSG)='C'
   mds(cMSG)     
ENDIF


cCOMANDOX:=cSQL
try
	with object oCommX
		:CommandText:=cCOMANDOX
		:CommandType:=adCmdText
		:ActiveConnection:=oConnX
		:Execute()
	end
catch oErr
end
oCONNx:CLOSE()
IF VALTYPE(cMSG)='C'
   mds("...")     
ENDIF
return 



Function faltaxml(lCHAVESUP)
PUBLIC oCONN,oCOMM,oREGISTRO,oREGISTR2


cConn:="Provider=MSDASQL.1;Persist Security Info=False;Data Source=ol_logix"
oConn:=CreateObject( "ADODB.Connection" )

oComm:=CreateObject( "ADODB.Command" )
oRegistro:= CreateObject('ADODB.RecordSet')
oRegistro:CursorLocation := 3
oRegistr2:= CreateObject('ADODB.RecordSet')
oRegistr2:CursorLocation := 3


try
	with object oConn  
		:ConnectionString:=cConn
		:Open()  	
    end
catch oErr
    return
end	

cCOMANDO:="SET ISOLATION TO DIRTY READ"

try
	with object oComm
		:CommandText:=cCOMANDO
		:CommandType:=adCmdText
		:ActiveConnection:=oConn
		:Execute()
	end
catch oErr
   //ShowAdoError(oERR,oConn,cCOMANDO)
end
 
cCOMANDO := " INSERT INTO log_edi_mgr  "
cCOMANDO += " SELECT  "
cCOMANDO += "  usuario AS cod_usuario,  "
cCOMANDO +=  "       data AS dat_geracao,  "
cCOMANDO +=   "      hora AS hor_geracao   ,  "
cCOMANDO +=  "        email AS nom_arquivo,      "   
cCOMANDO +=  "       seq_email || obf_auditoria_email_nfe.trans_nota_fiscal AS tam_arquivo,  "
cCOMANDO +=  "       fat_nf_mestre.nota_fiscal AS num_nff,                "
cCOMANDO +=  "       obf_auditoria_email_nfe.empresa AS cod_empresa,   "
cCOMANDO +=  "       'EMAILVDP' AS prg_origem,  "
cCOMANDO +=  "       'XML' AS tipo_arq  "
cCOMANDO +=  " FROM obf_auditoria_email_nfe  "
cCOMANDO +=  " LEFT JOIN fat_nf_mestre ON obf_auditoria_email_nfe.empresa  = fat_nf_mestre.empresa AND obf_auditoria_email_nfe.trans_nota_fiscal=fat_nf_mestre.trans_nota_fiscal  "
cCOMANDO +=  " WHERE data>=today-7 AND tipo_documento='X'  "
cCOMANDO +=  " AND seq_email || obf_auditoria_email_nfe.trans_nota_fiscal  "
cCOMANDO +=  " NOT IN (SELECT tam_arquivo FROM log_edi_mgr ) ;  "  
executasql(cCOMANDO,'Verificando email-vdp')

cCOMANDO := "delete FROM log_edi_mgr WHERE prg_origem='resnfe' AND tipo_arq='XML' AND tam_arquivo IN ( SELECT tam_arquivo FROM log_edi_mgr  WHERE  prg_origem='EMAIL' AND tipo_arq='XML' ) ;  "
executasql(cCOMANDO,'Apagando resnfe ja com xml')

cCOMANDO := "INSERT INTO log_edi_mgr_hist SELECT *,'' FROM log_edi_mgr WHERE prg_origem='resnfe' AND tipo_arq='XML' AND dat_geracao<=today-60 ; "
executasql(cCOMANDO,'gravando historico resnfe ja 60 dias')

cCOMANDO := "delete FROM log_edi_mgr WHERE prg_origem='resnfe' AND tipo_arq='XML' AND dat_geracao<=today-60 ; "
executasql(cCOMANDO,'apagando resnfe ja 60 dias')

        
IF ! NETUSE("CNPJXML","DBFCDX")
   dbcloseall()
   return
endif 
if ! netuse("danfe2")
   dbcloseall()
   return
endif
dbsetorder(2) //cnpj + nff
cLOGEMAIL:="nfsaida"+ArqLogDataHora()
nUSO:=fcreate(cLOGEMAIL)
faz01("61381323000167",'05')  //05 logix
faz01("61381323000248",'01')  //01 logix
//faz01("61381323000329",'10')  //10 logix empresa 10 encerrada fiscalmente
faz01("61381323000400",'11')  //11 logix
faz01("61381323000590",'12')  //11 logix
FCLOSE(nUSO)
IF FILESIZE(cLOGEMAIL)=0
   ferase(cLOGEMAIL)
endif
nRECNO:=0
nNOTA:=0

mds('Verificando protocolos')
dbselectar("danfe2")
dbsetorder(1)
// checar faltando protocolo GM recopia os xmls
      cCOMANDO:="SELECT  sup_nf_eletronica.chave_acesso,a.nota_fiscal,CAST (a.dat_hor_emissao AS date) as emissao,d.NUM_cgc_cpf[2,19] "
      cCOMANDO+=" ,obf_nf_eletr.chave_acesso AS chavenfe2 "
      cCOMANDO+=" FROM fat_nf_mestre a "
      cCOMANDO+=" INNER JOIN par_edi_mgr c ON c.cod_empresa=a.empresa AND c.cod_cliente=a.cliente "
      cCOMANDO+=" INNER JOIN clientes d ON d.cod_cliente=a.cliente "
      cCOMANDO+=" LEFT JOIN sup_nf_eletronica ON a.empresa=sup_nf_eletronica.empresa AND a.nota_fiscal=sup_nf_eletronica.nota_fiscal "
      cCoMANDO+=" LEFT JOIN obf_nf_eletr ON a.trans_nota_fiscal=obf_nf_eletr.trans_nota_fiscal     "
      cCOMANDO+=" WHERE a.empresa='01' AND a.sit_nota_fiscal <> 'C' "
      cCOMANDO+=" AND a.cliente IN (SELECT cod_cliente FROM v_clientes_gm_970) "
      cCOMANDO+="  AND CAST (a.dat_hor_emissao AS date)>=today-7 "
      cCOMANDO+=" AND d.num_cgc_cpf[1,11]='059.275.792' "
      cCOMANDO+="      AND a.serie_nota_fiscal<>'01' " //serie nota fiscais de servicos 
      cCOMANDO+=" AND NOT EXISTS (SELECT num_nff FROM log_edi_mgr "
      cCOMANDO+=" WHERE cod_empresa=a.empresa AND num_nff=a.nota_fiscal AND tipo_arq='PROT') "      
      TRY
         oRegistro:Open(cCOMANDO, oConN, adOpenForwardOnly,adLockReadOnly) 
      catch oErr
         ShowAdoError(oERR,oConn,cCOMANDO)
      END      
       while .NOT. oregistro:eof         
         cID:=ALLTRIM(STRVAL(oregistro:fields("chave_acesso"):value))
         IF EMPTY(cID)
            cID:=ALLTRIM(STRVAL(oregistro:fields("chavenfe2"):value))
         ENDIF
         dEMISSAO:=oregistro:fields("emissao"):value
         cANO  := strzero(year(dEMISSAO),4,0)
         cMES  := strzero(month(dEMISSAO),2,0)
         cCNPJDEST:=TIRAOUT(ALLTRIM(STRVAL(oregistro:fields("NUM_cgc_cpf"):value)))
         mds("Checando protocolo:"+cID)
         dbselectar("DANFE2")
         dbgotop()
         IF ! DBSEEk(cID)
            cFILEDANFE := pegcamxml(cID,,cCNPJDEST,cANO,cMES)                        
            cDESTINO   :=cNFECNPJ+"NFE"+cID+".xml"                        
            IF ! FILE(cDESTINO) .AND. FILE(cFILEDANFE)
               FILECOPY(cFILEDANFE,cDESTINO)
            ENDIF    
            nNOTATMP:=oregistro:fields("nota_fiscal"):value
            IF nNOTAtMP<nNOTA
               nNOTA:=nNOTAtMP
            ENDIF
         ELSE
            IF nRECNO=0.OR.DANFE2->(RECNO())<nRECNO
               nRECNO:=DANFE2->(RECNO())
            ENDIF            
         ENDIF   
         oRegistro:MoveNext()         
      enddo
oRegistro:CLOSE()



mds('xml aguardando email plug-in')
cARQIII:="i"+ArqLogDataHora("sql")
nHANDLE:=FCREATE(cARQIII)


// checar faltando log reposta para o plugin avb reenviar
cCOMANDO  = " SELECT fat_nf_mestre.empresa,fat_nf_mestre.nota_fiscal,fat_nf_mestre.serie_nota_fiscal,clientes.cod_cliente,clientes.nom_reduzido,  "
cCOMANDO += "        CAST(fat_nf_mestre.dat_hor_emissao AS DATE) AS dat_hor_emissao,par_edi_Mgr.local_xml "
cCOMANDO += "   FROM fat_nf_mestre "                                                           
cCOMANDO += "     INNER JOIN par_edi_mgr ON par_edi_Mgr.cod_empresa=fat_nf_mestre.empresa AND par_edi_Mgr.cod_cliente=fat_nf_mestre.cliente  "
cCOMANDO += "     INNER JOIN clientes  ON clientes.cod_cliente=fat_nf_mestre.cliente "                                
cCOMANDO += " WHERE fat_nf_mestre.sit_nota_fiscal <> 'C' "                                                 
cCOMANDO += "       AND fat_nf_mestre.cliente NOT IN (SELECT cod_cliente FROM v_clientes_gm_970) "                
cCOMANDO += "      AND CAST(fat_nf_mestre.dat_hor_emissao AS date)>=today-7 " 
cCOMANDO += "      AND NOT EXISTS (SELECT num_nff FROM log_edi_mgr   WHERE cod_empresa=fat_nf_mestre.empresa AND num_nff=fat_nf_mestre.nota_fiscal AND tipo_arq='XML') "    
cCOMANDO += "      AND NOT EXISTS (SELECT nota_fiscal FROM err_email_nfe_970  WHERE err_email_nfe_970.empresa=fat_nf_mestre.empresa AND err_email_nfe_970.nota_fiscal=fat_nf_mestre.nota_fiscal) "     

TRY
   oRegistro:Open(cCOMANDO, oConN, adOpenForwardOnly,adLockReadOnly) 
catch oErr
    ShowAdoError(oERR,oConn,cCOMANDO)
END      
while .NOT. oregistro:eof          
    mds('xml aguardando email plug-in'+STRVAL(oregistro:fields("nota_fiscal"):value))        
    cTexto := "INSERT INTO err_email_nfe_970 (empresa,nota_fiscal,serie_nota_fiscal,local_arq) VALUES "
    fwrite(nHANDLE,cTEXTO+HB_OSNEWLINE())
    cTEXTO := " ( '"+STRVAL(oregistro:fields("empresa"):value)+"' , "+STRVAL(oregistro:fields("nota_fiscal"):value)
    cTEXTO += " , '"+STRVAL(oregistro:fields("serie_nota_fiscal"):value)+"' , '"+STRVAL(oregistro:fields("local_xml"):value)+"' ) ;"
    fwrite(nHANDLE,cTEXTO+HB_OSNEWLINE())               
    oRegistro:MoveNext()      
 enddo
oRegistro:CLOSE()


fclose(nHANDLE)
gravaprot(cARQIII,.F.)

//verifica se o xml esta disponivel para o plug-in reenviar
mds('copiando xml aguardando email plug-in')
cCOMANDO=" SELECT err_email_nfe_970.empresa,sup_nf_eletronica.chave_acesso,fat_nf_mestre.cliente,clientes.num_cgc_cpf "
cCOMANDO+=" ,obf_nf_eletr.chave_acesso AS chavenfe2 "
cCOMANDO+=" ,err_email_nfe_970.local_arq "
cCOMANDO+=" FROM err_email_nfe_970"
cCOMANDO+=" LEFT JOIN  sup_nf_eletronica "
cCOMANDO+=" ON err_email_nfe_970.empresa=sup_nf_eletronica.empresa"
cCOMANDO+=" AND err_email_nfe_970.nota_fiscal=sup_nf_eletronica.nota_fiscal"
cCOMANDO+=" AND err_email_nfe_970.serie_nota_fiscal=sup_nf_eletronica.serie_nota_fiscal"
cCOMANDO+="  LEFT JOIN  obf_nf_eletr "
cCOMANDO+="  ON err_email_nfe_970.empresa=obf_nf_eletr.empresa "
cCOMANDO+="  AND err_email_nfe_970.nota_fiscal=obf_nf_eletr.nota_fiscal "
cCOMANDO+="  AND err_email_nfe_970.serie_nota_fiscal=obf_nf_eletr.serie_nota_fiscal "
cCOMANDO+=" LEFT JOIN fat_Nf_mestre"
cCOMANDO+=" on err_email_nfe_970.empresa=fat_nf_mestre.empresa"
cCOMANDO+=" AND err_email_nfe_970.nota_fiscal=fat_nf_mestre.nota_fiscal"
cCOMANDO+=" AND err_email_nfe_970.serie_nota_fiscal=fat_nf_mestre.serie_nota_fiscal"
cCOMANDO+=" LEFT JOIN clientes"
cCOMANDO+=" on fat_nf_mestre.cliente=clientes.cod_cliente"
TRY
   oRegistro:Open(cCOMANDO, oConN, adOpenForwardOnly,adLockReadOnly) 
catch oErr
    ShowAdoError(oERR,oConn,cCOMANDO)
END      
while .NOT. oregistro:eof       
    cIDENV:=STRVAL(oregistro:fields("chave_acesso"):value)
    IF EMPTY(cIDENV)
       cIDENV:=STRVAL(oregistro:fields("chavenfe2"):value)
    ENDIF
    mds('copiando xml aguardando email plug-in'+cIDENV)
	cLOCALARQ:=STRVAL(oregistro:fields("local_arq"):value)
    cCNPJENV:=SUBSTR(tiraout(STRVAL(oregistro:fields("num_cgc_cpf"):value)),2)
    cARQIMP :=pegcamxml(cIDENV,,cCNPJENV)
    IF ! EMPTY(cARQIMP)
       if ! file(cLOGIX+cIDENV+'-nfe_vis.xml')
	      filecopy(cARQIMP,cLOGIX+cIDENV+'-nfe_vis.xml') //recopia para a origem alguns plugin pegam la 
       endif   
	   if ! file(cLOCALARQ+cIDENV+'-nfe_vis.xml')
	      filecopy(cARQIMP,cLOCALARQ+cIDENV+'-nfe_vis.xml') //recopia  para o definido no par_edi_Mgr esta no local_arq da err_email_nfe_970 alguns plug pegam la
	   endif
    ENDIF
    oRegistro:MoveNext()      
 enddo
oRegistro:CLOSE()


//Gravar as chaves do nfe,cte caso o usario ainda nao preencheu
IF lCHAVESUP
   IF ! NETUSE("NFE","DBFCDX")
       dbcloseall()
      return .f.
   ENDIF
   nRECNO:=CHAVESUP
   if nRECNO=0
      nRECNO:=1
   endif

   cCHAVESUP:="chavesup"+ArqLogDataHora("sql")
   nSQLCHAVE:=FCREATE(cCHAVESUP)
   dbselectar("danfe2")
   dbsetorder(0)   
   dbgoto(nRECNO)
   while ! danfe2->(eof())
       if EMPTY(danfe2->logixsup) .OR. (danfe2->logixsup="X" .AND. idcte(danfe2->ID) )   .OR. (danfe2->logixsup="X" .AND. idcteos(danfe2->ID) )                
          nRECNO:=recno()
          exit
       endif 
       danfe2->(dbskip()) 
   enddo   
   if nRECNO=0
      nRECNO:=1
   endif
   dbselectar("nfe")
   netreclock()
   nfe->chavesup:=nrecno
   dbunlock()
   dbclosearea() 
  
   
   dbselectar("danfe2")
   dbgoto(nRECNO)
   while ! danfe2->(eof())
      cID         :=alltrim(danfe2->id)
      cANO        :=emissaoAno(danfe2->emissao)
      mds("sqlchave: "+strzero(danfe2->(recno()),8)+"/"+cID)      
      IF EMPTY(danfe2->logixsup) .and. (cANO<cANOBASE .OR. EmissaoData(danfe2->emissao)<DATE()-180)                            
         netreclock()         
         danfe2->logixsup:="<" //anos anteriores                  
         dbunlock()      
      ENDIF
      IF EMPTY(danfe2->logixsup) .OR. (danfe2->logixsup="X" .AND. idcte(cID) )   .OR. (danfe2->logixsup="X" .AND. idcteos(cID) )               
         cCNPJ       := alltrim(danfe2->cnpj)
         cCNPJDEST   := alltrim(danfe2->cnpjdest)         
         cMES        := emissaomes(danfe2->emissao)
         cNNF        := alltrim(danfe2->NNF)      
         netreclock()
         if IsRaizIta(cCNPJ)
            if IsRaizIta(cCNPJDEST)           
               danfe2->logixsup:="Y" //faturamento transferencia        
            else
               danfe2->logixsup:="F" //faturamento         
            endif   
         endif
         if ! IsRaizIta(cCNPJDEST) .and. ! idcte(cID) .and. ! idcteos(cID)     //cte pode ter outro destino    
            danfe2->logixsup:="X" //a nota nao e para a Itaesbra          
         endif      
         if ! IsRaizIta(cCNPJ) .AND. cANO=cANOBASE 
            cEMP=CNPJEmpLogix(cCNPJDest)
            aFORN:={"0"+cCNPJ}
			//mao de obra sempre a entrada pelo cnpj utilizando vdp_relc_cliente_fornecedor nao e mais necessario ajustar electrolux
            //IF LEFT(cCNPJ,8)="76487032" .or. LEFT(cCNPJ,8)="02421684"  
               //aadd(Aforn,"1100")
               //aadd(Aforn,"1100-MO")
               //aadd(Aforn,"1101-MO")
               //aadd(Aforn,"1101-MO")
            //ENDIF
            ZFIM:=LEN(aFORN)
            FOR Z=1 TO ZFIM
               cCNPJSQL:=aFORN[Z]         
               cCOMANDO=" SELECT num_aviso_rec from nf_sup "
               cCOMANDO+="  WHERE cod_empresa='"+cEMP+"' "   
               cCOMANDO+="    AND num_nf="+cNNF
               cCOMANDO+="    AND cod_fornecedor='"+cCNPJSQL+"' "   
               TRY
                  oRegistro:Open(cCOMANDO, oConN, adOpenForwardOnly,adLockReadOnly) 
               catch oErr
                   ShowAdoError(oERR,oConn,cCOMANDO)
               END      
               IF .NOT. oregistro:eof                  
                  cAVISO:=STRVAL(oregistro:fields("num_aviso_rec"):value)
                  cTEXTO:=" INSERT INTO SUP_PAR_AR (EMPRESA, AVISO_RECEBTO, SEQ_AVISO_RECEBTO, PARAMETRO, PAR_IND_ESPECIAL, PARAMETRO_TEXTO, PARAMETRO_VAL, PARAMETRO_DAT) "
                  cTEXTO+=" VALUES( '"+cEMP+"', "+cAVISO+", 0, 'chav_aces_nf_eletr', NULL, '"+cID+"' , NULL, NULL) ;"
                  fwrite(nSQLCHAVE,cTEXTO+HB_OsNewLine())              
                  Danfe2->logixsup:="S"              
               endif    
               oRegistro:CLOSE()             
            NEXT Z
         endif
         //conhecimento transporte    
         if cANO=cANOBASE  .and.  (idcte(cID) .or. idcteos(cID))
            CFORN:="0"+cCNPJ         
            cEMP="XX" //trava empresa conchecimentos em que nao e destinatario
            if IsCNPJITA(cCNPJDest)
               cEMP=CNPJEmpLogix(cCNPJDest)
            ENDIF   
            if cEMP="XX"
               cCOMANDO=" SELECT cod_emPresa from frete_sup "
               cCOMANDO+="  WHERE NUM_CONHEC="+cNNF            
               cCOMANDO+="    AND cod_transpor='"+cFORN+"' "   
               TRY
                  oRegistro:Open(cCOMANDO, oConN, adOpenForwardOnly,adLockReadOnly) 
               catch oErr
                   ShowAdoError(oERR,oConn,cCOMANDO)
               END      
               IF .NOT. oregistro:eof                  
                  cEMP:=STRVAL(oregistro:fields("cod_empresa"):value)
               ENDIF
               Oregistro:close()
            endif
            IF cEMP<>"XX"                     
               cTEXTO:=" INSERT INTO sup_par_frete (empresa, num_conhec, serie_conhec, subserie_conhec, transportadora, parametro, par_ind_especial, parametro_texto, parametro_val, parametro_dat) "
               cTEXTO+=" VALUES ('"+cEMP+"', "+cNNF+", '1', 1, '"+cFORN+"', 'chave_acesso_cte', NULL, '"+cID+"', NULL, today); "
               fwrite(nSQLCHAVE,cTEXTO+HB_OsNewLine())                                         
               danfe2->logixsup:="T"
            ENDIF   
         endif       
         dbunlock()
      ENDIF   
      danfe2->(dbskip())
   enddo
   
   MDS("Notas entre filiais")
   FOR X=1 TO 2
      IF X=1 //Sup_nf_eletronica
         // o 01 e o 05 e invertido para corrigir origem destino por isso o case no codigo_empresa
         cCOMANDO:="     SELECT nf_sup.cod_empresa,nf_sup.num_nf,nf_sup.ies_especie_nf,nf_sup.cod_fornecedor, "
         cCOMANDO+="          sup_par_ar.parametro_texto, "
         cCOMANDO+="       cnpjempresa_970(nf_sup.cod_fornecedor) AS origem, "
         cCOMANDO+="          sup_nf_eletronica.chave_acesso,nf_sup.num_aviso_rec "
         cCOMANDO+="   FROM nf_sup  "
         cCOMANDO+="   LEFT JOIN sup_par_ar "
         cCOMANDO+="              ON nf_sup.cod_empresa=sup_par_ar.empresa "
         cCOMANDO+="              AND nf_sup.num_aviso_rec=sup_par_ar.aviso_recebto "
         cCOMANDO+="              AND sup_par_ar.parametro='chav_aces_nf_eletr' "
         cCOMANDO+="   LEFT JOIN SUP_NF_ELETRONICA  "
         cCOMANDO+="              ON sup_nf_eletronica.empresa=cnpjempresa_970(nf_sup.cod_fornecedor) "
         cCOMANDO+="             AND nf_sup.num_nf=sup_nf_eletronica.nota_fiscal            "
         cCOMANDO+="   WHERE nf_sup.cod_fornecedor[1,9]='061381323' "
         cCOMANDO+="   AND sup_par_ar.parametro_texto IS NULL "
         cCOMANDO+="   AND sup_nf_eletronica.chave_acesso IS NOT null "
      else //obf_nf_eletr
         cCOMANDO:=" SELECT nf_sup.cod_empresa,nf_sup.num_nf,nf_sup.ies_especie_nf,nf_sup.cod_fornecedor, "
         cCOMANDO+="     sup_par_ar.parametro_texto, "
         cCOMANDO+=" cnpjempresa_970(nf_sup.cod_fornecedor) AS origem, "
         cCOMANDO+="     obf_nf_eletr.chave_acesso,nf_sup.num_aviso_rec"
         cCOMANDO+="  FROM nf_sup "
         cCOMANDO+="       LEFT JOIN sup_par_ar"
         cCOMANDO+="                 ON nf_sup.cod_empresa=sup_par_ar.empresa "
         cCOMANDO+="                  AND nf_sup.num_aviso_rec=sup_par_ar.aviso_recebto"
         cCOMANDO+="                  AND sup_par_ar.parametro='chav_aces_nf_eletr'"
         cCOMANDO+="       LEFT JOIN obf_nf_eletr "
         cCOMANDO+="  ON obf_nf_eletr.empresa= cnpjempresa_970(nf_sup.cod_fornecedor) "
         cCOMANDO+="                 AND nf_sup.num_nf=obf_nf_eletr.nota_fiscal           "
         cCOMANDO+="  WHERE nf_sup.cod_fornecedor[1,9]='061381323'"
         cCOMANDO+="    AND sup_par_ar.parametro_texto IS NULL"  
         cCOMANDO+="    AND obf_nf_eletr.chave_acesso IS NOT null          "  
      endif      
      TRY
         oRegistro:Open(cCOMANDO, oConN, adOpenForwardOnly,adLockReadOnly) 
      catch oErr
         ShowAdoError(oERR,oConn,cCOMANDO)
      END      
      while .NOT. oregistro:eof       
          cID:=STRVAL(oregistro:fields("chave_acesso"):value)
          cAVISO:=STRVAL(oregistro:fields("num_aviso_rec"):value)
          cEMP:=STRVAL(oregistro:fields("cod_empresa"):value)
          cTEXTO:=" INSERT INTO SUP_PAR_AR (EMPRESA, AVISO_RECEBTO, SEQ_AVISO_RECEBTO, PARAMETRO, PAR_IND_ESPECIAL, PARAMETRO_TEXTO, PARAMETRO_VAL, PARAMETRO_DAT) "
          cTEXTO+=" VALUES( '"+cEMP+"', "+cAVISO+", 0, 'chav_aces_nf_eletr', NULL, '"+cID+"' , NULL, NULL) ; "
          fwrite(nSQLCHAVE,cTEXTO+HB_OsNewLine())              
          oRegistro:MoveNext()      
       enddo
      oRegistro:CLOSE()
   NEXT X      
   
   FCLOSE(nSQLCHAVE)       
   gravaprot(cCHAVESUP,.F.)

   mds("Xml pendentes")
   cPENDXML:="pendxml"+ArqLogDataHora("log")
   cPENDCHV:="pendCHV"+ArqLogDataHora("txt")
   nPENDXML:=FCREATE(cPENDXML)  
   nPENDCHV:=FCREATE(cPENDCHV)  

   
   for x=1 to 7    
      if x=1 //notas fiscais eletronicas
         MDS("Falta xml/nfe ultimos 60 dias")      
         FWRITE(NPENDXML,"Falta xml/nfe ultimos 60 dias"+hb_osnewline())   
         cCOMANDO="    SELECT nf_sup.cod_empresa,nf_sup.num_nf,nf_sup.ies_especie_nf,sup_par_ar.parametro_texto, "
         cCOMANDO+="          log_edi_mgr.tam_arquivo,nf_sup.dat_emis_nf "
         cCOMANDO+="   FROM nf_sup   "
         cCOMANDO+="   LEFT JOIN sup_par_ar "
         cCOMANDO+="              ON nf_sup.cod_empresa=sup_par_ar.empresa "
         cCOMANDO+="              AND nf_sup.num_aviso_rec=sup_par_ar.aviso_recebto "
         cCOMANDO+="              AND sup_par_ar.parametro='chav_aces_nf_eletr'  "
         cCOMANDO+="   LEFT JOIN log_edi_mgr ON sup_par_ar.parametro_texto=log_edi_mgr.tam_arquivo            "
         cCOMANDO+="   WHERE  nf_sup.dat_emis_nf>=TODAY-60 and nf_sup.dat_emis_nf<=TODAY-2"
         cCOMANDO+="   AND ies_especie_nf not in  ('NFS','NFE','DOC','CON')  "
         cCOMANDO+="   AND sup_par_ar.parametro_texto Is NOT NULL "
         cCOMANDO+="   AND tam_arquivo IS null "          
      ENDIF   
      IF X=2 //conhecimentos de transporte
         MDS("Falta cte/nfe ultimos 60 dias")
         FWRITE(NPENDXML,"Falta cte/nfe ultimos 60 dias"+hb_osnewline())   
         cCOMANDO:= " SELECT frete_sup.cod_empresa,frete_sup.num_conhec,sup_par_frete.parametro_texto, "
         cCOMANDO+="       log_edi_mgr.tam_arquivo,frete_sup.dat_emis_conhec "
         cCOMANDO+=" FROM frete_sup   "
         cCOMANDO+=" LEFT JOIN sup_par_frete         "
         cCOMANDO+="            ON frete_sup.cod_empresa=sup_par_frete.empresa "
         cCOMANDO+="        AND frete_sup.num_conhec=sup_par_frete.num_conhec AND frete_sup.ser_conhec=sup_par_frete.serie_conhec "
         cCOMANDO+="        AND frete_sup.ssr_conhec=sup_par_frete.subserie_conhec AND frete_sup.cod_transpor=sup_par_frete.transportadora "
         cCOMANDO+="        AND sup_par_frete.parametro='chave_acesso_cte' "
         cCOMANDO+=" LEFT JOIN log_edi_mgr ON sup_par_frete.parametro_texto=log_edi_mgr.tam_arquivo            "
         cCOMANDO+="        WHERE  frete_sup.dat_emis_conhec>=TODAY-60  AND frete_sup.dat_emis_conhec<=TODAY-2"
         cCOMANDO+="    AND sup_par_frete.parametro_texto Is NOT NULL AND tam_arquivo IS null           "
      endif  
      IF X=3 // Falta xml
         MDS("Chaves nao lancadas")
         FWRITE(NPENDXML,"Chave nao lancada informacoes complementares / falta xml nfe ou cte / lancamento empresa errada - ultimos 60 dias"+hb_osnewline())   
         //cCOMANDO:=" SELECT TO_CHAR(a.num_nf),a.ser_nf,a.ies_especie_nf,a.cod_fornecedor,b.raz_social,b.num_cgc_cpf,a.dat_emis_nf,a.val_tot_nf_d "
         cCOMANDO:=" SELECT a.cod_empresa,TO_CHAR(a.num_nf) AS nf,a.ser_nf,a.ies_especie_nf,a.cod_fornecedor,b.raz_social, "         
         cCOMANDO+=" cnpjcpf(b.num_cgc_cpf) AS cnpj,to_char(a.dat_emis_nf) AS dat_emis_nf,a.val_tot_nf_d "
         cCOMANDO+=" FROM nf_sup a "
         cCOMANDO+=" INNER JOIN fornecedor b ON b.cod_fornecedor=a.cod_fornecedor "
         cCOMANDO+="    AND b.cod_fornecedor <> (select cod_cliente from empresa where cod_empresa=a.cod_empresa)       "
         cCOMANDO+=" INNER JOIN sup_par_fornecedor c ON c.fornecedor=b.cod_fornecedor AND empresa = 'SE' "
         cCOMANDO+="       AND parametro='dat_ini_utiliz_nf-e' "
		 cCOMANDO+="  LEFT JOIN sup_compl_nf_sup ON a.cod_empresa=sup_compl_nf_sup.empresa  AND a.num_aviso_rec=sup_compl_nf_sup.aviso_recebto  "    		 		 
         cCOMANDO+=" WHERE a.dat_emis_nf >= today-60  AND a.dat_emis_nf <= today-2 "
         cCOMANDO+="       AND a.dat_emis_nf >= c.parametro_dat    AND a.ies_especie_nf not in  ('NFS','NFE','DOC')       "
		 cCOMANDO+="  AND (reservado[5,6]='55' OR reservado[5,6]='57') "    		 
         cCOMANDO+="  AND NOT EXISTS (SELECT num_nff FROM log_edi_mgr WHERE cod_empresa=a.cod_empresa "
         cCOMANDO+="  AND num_nff=a.num_nf AND prg_origem='EMAIL'  "
         cCOMANDO+=" AND '0'||cod_usuario=tiraout(b.num_cgc_cpf)) " //replace(replace(replace(b.num_cgc_cpf,'/',''),'.',''),'-','')) "
         cCOMANDO+="       ORDER BY b.raz_social,a.num_nf,a.dat_emis_nf "
      ENDIF    
      if x=4
         mds("Cancelamentos Recebidos")
         fWRITE(NPENDXML,"Cancelamentos recebidos ultimos 60 dias"+hb_osnewline())   
         cCOMANDO:=" SELECT log_edi_mgr.cod_empresa,log_edi_mgr.cod_usuario AS cnpj ,TO_CHAR(log_edi_mgr.num_nff), "
         cCOMANDO+=" to_char(log_edi_mgr.dat_geracao) AS data,log_edi_mgr.tam_arquivo AS chave "      
         cCOMANDO+=" FROM log_edi_mgr  "
         cCOMANDO+=" LEFT JOIN chavenfecte_970 ON log_edi_mgr.tam_arquivo=chavenfecte_970.chave "
         cCOMANDO+=" WHERE  log_edi_mgr.prg_origem='cancNFe' AND log_edi_mgr.dat_geracao>=today-60 "
         cCOMANDO+=" AND log_edi_mgr.cod_usuario[1,8]<>'61381323' "
         cCOMANDO+=" ORDER BY log_edi_mgr.dat_geracao desc "      
      endif 
      IF X=5
         mds("Clientes sem Email")
         fWRITE(NPENDXML,"Clientes sem email"+hb_osnewline())   
         cCOMANDO:=" SELECT cnpjcpf(tiraout(clientes.num_cgc_cpf)) AS cnpjcpf ,clientes.cod_cliente,clientes.nom_cliente"
         cCOMANDO+="       ,err_email_nfe_970.nota_fiscal,fat_nf_mestre.dat_hor_emissao,sup_nf_eletronica.chave_acesso "
         cCOMANDO+=" FROM err_email_nfe_970 "
         cCOMANDO+=" LEFT JOIN fat_nf_MESTRE ON err_email_nfe_970.empresa=fat_nf_mestre.empresa "
         cCOMANDO+=" 	AND  err_email_nfe_970.nota_fiscal=fat_nf_mestre.nota_fiscal "
         cCOMANDO+=" LEFT JOIN clientes ON fat_nf_mestre.cliente=clientes.cod_cliente "
         cCOMANDO+=" LEFT JOIN vdp_cli_grp_email ON fat_nf_mestre.cliente=vdp_cli_grp_email.cliente "
         cCOMANDO+=" LEFT JOIN sup_nf_eletronica ON err_email_nfe_970.empresa=sup_nf_eletronica.empresa "
         cCOMANDO+=" 	   AND  err_email_nfe_970.nota_fiscal=sup_nf_eletronica.nota_fiscal "
         cCOMANDO+="      WHERE vdp_cli_grp_email.email IS null"         
      ENDIF    


      IF X=6
         mds("resnfe sem xml")
         fWRITE(NPENDXML,"resnfe sem xml"+hb_osnewline())   
         cCOMANDO:=" SELECT DISTINCT tam_arquivo FROM log_edi_mgr "
         cCOMANDO+=" WHERE  prg_origem='resnfe' AND tipo_arq='XML' "
		 cCOMANDO+="  AND log_edi_mgr.dat_geracao>=today-60 "
         cCOMANDO+=" AND tam_arquivo NOT IN  "
         cCOMANDO+=" ( SELECT tam_arquivo FROM log_edi_mgr "
         cCOMANDO+=" WHERE  prg_origem='EMAIL' AND tipo_arq='XML' ) "        
      ENDIF    


      IF X=7
         mds("manifesto sem xml")
         fWRITE(NPENDXML,"manifesto sem xml"+hb_osnewline())   
         cCOMANDO:="  SELECT obf_manifesto_destinatario.empresa,obf_manifesto_destinatario.nota_fiscal,obf_manifesto_destinatario.chave_acesso, "
         cCOMANDO+="    obf_manifesto_destinatario.nota_fiscal "
         cCOMANDO+="  FROM obf_manifesto_destinatario "
         cCOMANDO+=" LEFT JOIN log_edi_mgr ON obf_manifesto_destinatario.chave_acesso=log_edi_mgr.tam_arquivo " 
         cCOMANDO+=" WHERE log_edi_mgr.prg_origem='EMAIL' "
         cCOMANDO+=" AND obf_manifesto_destinatario.dat_emis_nf=today-120 "
         cCOMANDO+=" AND tam_arquivo IS null "
      ENDIF    

	  
	  
      TRY      
         oRegistro:Open(cCOMANDO, oConN, adOpenForwardOnly,adLockReadOnly) 
      catch oErr
         ShowAdoError(oERR,oConn,cCOMANDO)
      END      
      while .NOT. oregistro:eof       
	      //pegando a chave cIDENV
          IF X=1 .OR. X=2 
             cIDENV:=alltrim(STRVAL(oregistro:fields("parametro_texto"):value))
          ENDIF  
          IF X=3 
             cIDENV:=""          
             for Z=0 to 8
                IF Z=0 
                   cIDENV+=PADR(STRVAL(oregistro:fields(Z):value),9)+" " //no NF
                ELSE
                   cIDENV+=STRVAL(oregistro:fields(Z):value)+" "
                ENDIF                
             next Z
          endif
          if x=4
             cIDENV:=""          
             for Z=0 to 4
			    do case
                  case Z=2
                      cIDENV+=PADR(STRVAL(oregistro:fields(Z):value),9)+" " //No NF
			      case z=4
					  cIDENV+=idformatada(STRVAL(oregistro:fields(Z):value))+" "+cIDENV+" "+STRVAL(oregistro:fields(Z):value)+" "
                  otherwise
                      cIDENV+=STRVAL(oregistro:fields(Z):value)+" "
                ENDcase 
             next          
          endif
          if x= 5
             cIDENV:=""          
             FOR Z=0 TO 5
                 cIDENV+=STRVAL(oregistro:fields(Z):value)+" "
             NEXT Z
          endif          
          IF X=6
             cIDENV:=alltrim(STRVAL(oregistro:fields("tam_arquivo"):value))
          ENDIF 
          IF X=7
             cIDENV:=alltrim(STRVAL(oregistro:fields("chave_acesso"):value))
          ENDIF 
		  IF X=1 .OR. X=2 //NFE CTE
             fwrite(nPENDCHV,cIDENV+hb_osnewline())			
             baixanfe(cIDENV)			 
             fwrite(nPENDXML,cIDENV+" "+idformatada(cIDENV)+" "+idcnpj(cIDENV)+hb_osnewline())						 
		  ENDIF
          IF X=1 
             IF ASCAN(aCNPJITA,IDEMISSOR(cIDENV))>0
                cARQIMP:=PegCamXml(cIDENV)
                IF FILE(cARQIMP)
                   FILECOPY(cARQIMP,cNFECNPJ+"NFE"+cIDENV+".xml")
                ELSE
                   cIDENV+=" Cnpj: "+IDEMISSOR(cIDENV)+" NF: "  +IDNFF(cIDENV)
                ENDIF
             ELSE
                cIDENV+="Cnpj: "+IDEMISSOR(cIDENV)+" NF: "  +IDNFF(cIDENV)                
             ENDIF             
          ELSE		    
		     if x<>2  //2 ja gravado acima
                fwrite(nPENDXML,cIDENV+hb_osnewline())			
		     endif		
          ENDIF  
          oRegistro:MoveNext()      
       enddo
       oRegistro:CLOSE()
   next x
   fclose(nPENDXML)   
   fclose(nPENDCHV)      
   IF FILESIZE(cPENDXML)=0
      FERASE(cPENDXML)
   ELSE
      cDEST:=PROFILESTRING( "LERXML.INI","EMAIL","DESTDANFE")
      ENVIAEMAIL("","XML Pendentes",cDEST,HB_MEMOREAD(cPENDXML))   
   ENDIF   
   IF FILESIZE(cPENDCHV)=0
      FERASE(cPENDCHV)
   ENDIF
   
   
   cCOMANDO:=" INSERT INTO log_edi_mgr_hist SELECT *,'' FROM log_edi_mgr WHERE tipo_arq = '' 	OR tipo_arq IS NULL; "
   cCOMANDO+=" DELETE FROM log_edi_mgr WHERE tipo_arq = '' 	OR tipo_arq IS NULL;  "
   executasql(cCOMANDO,"Limpesa log 01")
   
   cCOMANDO:=" INSERT INTO log_edi_mgr_hist SELECT *,'' FROM log_edi_mgr WHERE tipo_arq = 'AVB' 	AND dat_geracao <= today - 365; "
   cCOMANDO+=" DELETE FROM log_edi_mgr WHERE tipo_arq = 'AVB' 	AND dat_geracao <= today - 365; "
   executasql(cCOMANDO,"Limpesa log 02")
   
   cCOMANDO:=" INSERT INTO log_edi_mgr_hist SELECT *,'' FROM log_edi_mgr WHERE tipo_arq = 'PROT'	AND dat_geracao <= today - 365;   "
   cCOMANDO+=" DELETE FROM log_edi_mgr WHERE tipo_arq = 'PROT'	AND dat_geracao <= today - 365;  "
   executasql(cCOMANDO,"Limpesa log 03")
   
   cCOMANDO:=" INSERT INTO log_edi_mgr_hist SELECT *,'' FROM log_edi_mgr WHERE tipo_arq = 'XML'	AND prg_origem = 'POSTAGEM' 	AND dat_geracao <= today - 365; "
   cCOMANDO+=" DELETE FROM log_edi_mgr WHERE tipo_arq = 'XML' 	AND prg_origem = 'POSTAGEM' 	AND dat_geracao <= today - 365; "
   executasql(cCOMANDO,"Limpesa log 04")
   
   cCOMANDO:=" INSERT INTO log_edi_mgr_hist SELECT *,'' FROM log_edi_mgr WHERE tipo_arq = 'XML' AND prg_origem = '		0641' 	AND dat_geracao <= today - 365;     "
   cCOMANDO+=" DELETE FROM log_edi_mgr WHERE tipo_arq = 'XML' 	AND prg_origem = 'PGI0641' 	AND dat_geracao <= today - 365; "
   executasql(cCOMANDO,"Limpesa log 05")
   
   cCOMANDO:=" INSERT INTO log_edi_mgr_hist SELECT *,'' FROM log_edi_mgr WHERE tipo_arq = 'XML' 	AND prg_origem = 'PGI0643' 	AND dat_geracao <= today - 365;     "
   cCOMANDO+=" DELETE FROM log_edi_mgr WHERE tipo_arq = 'XML' 	AND prg_origem = 'PGI0643' 	AND dat_geracao <= today - 365;  "
   executasql(cCOMANDO,"Limpesa log 06")
   
   cCOMANDO:=" INSERT INTO log_edi_mgr_hist SELECT *,'' FROM log_edi_mgr WHERE tipo_arq = 'NFSE' 	AND prg_origem = 'EMAIL' 	AND dat_geracao <= today - 365; "
   cCOMANDO+=" DELETE FROM log_edi_mgr WHERE tipo_arq = 'NFSE' 	AND prg_origem = 'EMAIL' 	AND dat_geracao <= today - 365; "
   executasql(cCOMANDO,"Limpesa log 07")
   
   cCOMANDO:=" INSERT INTO log_edi_mgr_hist SELECT *,'' FROM log_edi_mgr WHERE tipo_arq = 'XML' 	AND prg_origem = 'SuframaInterna' 	AND dat_geracao <= today - 365; "
   cCOMANDO+=" DELETE FROM log_edi_mgr WHERE tipo_arq = 'XML' 	AND prg_origem = 'SuframaInterna'	AND dat_geracao <= today - 365; "
   executasql(cCOMANDO,"Limpesa log 08")
   
   cCOMANDO:=" INSERT INTO log_edi_mgr_hist SELECT *,'' FROM log_edi_mgr WHERE tipo_arq = 'XML' 	AND prg_origem = 'SuframaVistoria' 	AND dat_geracao <= today - 365; "
   cCOMANDO+=" DELETE FROM log_edi_mgr WHERE tipo_arq = 'XML' 	AND prg_origem = 'SuframaVistoria' 	AND dat_geracao <= today - 365; " 
   executasql(cCOMANDO,"Limpesa log 09")
   
   cCOMANDO:=" INSERT INTO log_edi_mgr_hist SELECT *,'' FROM log_edi_mgr WHERE tipo_arq = 'XML' 	AND prg_origem = 'cce' 	AND dat_geracao <= today - 365; "
   cCOMANDO+=" DELETE FROM log_edi_mgr WHERE tipo_arq = 'XML' 	AND prg_origem = 'cce' 	AND dat_geracao <= today - 365; " 
   executasql(cCOMANDO,"Limpesa log 10")
   
   cCOMANDO:=" INSERT INTO log_edi_mgr_hist SELECT *,'' FROM log_edi_mgr WHERE tipo_arq = 'XML' 	AND prg_origem = 'cteAut' 	AND dat_geracao <= today - 365; "
   cCOMANDO+=" DELETE FROM log_edi_mgr WHERE tipo_arq = 'XML' 	AND prg_origem = 'cteAut' 	AND dat_geracao <= today - 365; " 
   executasql(cCOMANDO,"Limpesa log 11")
   
   cCOMANDO:=" INSERT INTO log_edi_mgr_hist SELECT *,'' FROM log_edi_mgr WHERE tipo_arq = '' 	AND prg_origem = '' 	AND dat_geracao <= today - 365; "
   cCOMANDO+=" DELETE FROM log_edi_mgr WHERE tipo_arq = '' 	AND prg_origem = '' 	AND dat_geracao <= today - 365; "    
   executasql(cCOMANDO,"Limpesa log 12")
   
   cCOMANDO:=" INSERT INTO log_edi_mgr_hist SELECT *,'' FROM log_edi_mgr WHERE num_nff=0  ; "
   cCOMANDO+=" DELETE FROM log_edi_mgr WHERE num_nff=0 ; "    
   executasql(cCOMANDO,"Limpesa log 13")
   
   cCOMANDO:=" INSERT INTO log_edi_mgr_hist SELECT *,'' FROM log_edi_mgr WHERE (cod_usuario='' OR cod_usuario='99999999999999' OR cod_usuario IS NULL)  ; "
   cCOMANDO+=" DELETE FROM log_edi_mgr WHERE (cod_usuario='' OR cod_usuario='99999999999999' OR cod_usuario IS NULL) ; "    
   executasql(cCOMANDO,"Limpesa log 14")
   
   cCOMANDO:=" INSERT INTO log_edi_mgr_hist SELECT *,'X' FROM log_edi_mgr WHERE cod_usuario[1,8]='61381323' AND tam_arquivo IN (SELECT chave_acesso FROM sup_nf_eletronica WHERE sit_nota_fiscal='C')  ; "
   cCOMANDO+=" DELETE FROM log_edi_mgr WHERE cod_usuario[1,8]='61381323' AND tam_arquivo IN (SELECT chave_acesso FROM sup_nf_eletronica WHERE sit_nota_fiscal='C') ; "    
   executasql(cCOMANDO,"Limpesa log 15")
   
   cCOMANDO:=" INSERT INTO log_edi_mgr_hist SELECT *,'E' FROM log_edi_mgr WHERE cod_usuario[1,8]='61381323' AND tam_arquivo IN (SELECT chave_acesso FROM sup_nf_eletronica WHERE tip_nota_fiscal='E')  ; "
   cCOMANDO+=" DELETE FROM log_edi_mgr WHERE  cod_usuario[1,8]='61381323' AND tam_arquivo IN (SELECT chave_acesso FROM sup_nf_eletronica WHERE tip_nota_fiscal='E') ; "   
   executasql(cCOMANDO,"Limpesa log 16")
   
   //envia para historio logs onde nao gravaou a empresa
   cCOMANDO:=" INSERT INTO log_edi_mgr_hist SELECT *,'' FROM log_edi_mgr WHERE cod_empresa<>'01' AND cod_empresa<>'05' AND cod_empresa<>'10'  AND cod_empresa<>'11'  AND cod_empresa<>'12'  ; "
   cCOMANDO+=" DELETE FROM log_edi_mgr WHERE cod_empresa<>'01' AND cod_empresa<>'05' AND cod_empresa<>'10'  AND cod_empresa<>'11'  AND cod_empresa<>'12' ; "   
   executasql(cCOMANDO,"Limpesa log 17")
   
   //email internos
   cCOMANDO:=" DELETE FROM log_edi_mgr_hist WHERE nom_arquivo LIKE '%@itaesbra%' AND dat_geracao<=today-180  ; "  
   executasql(cCOMANDO,"Limpesa log 18")
   
  //apaga log que tenha sido reprocessados
   cCOMANDO:=" delete FROM log_edi_mgr WHERE tam_arquivo||prg_origem||tipo_arq IN (SELECT tam_arquivo||prg_origem||tipo_arq FROM log_edi_mgr_hist  WHERE prg_origem='EMAIL' ) ; "
   executasql(cCOMANDO,"Limpesa log 19")
   
   //5anos + ano corrente =6 
   cCOMANDO:=" INSERT INTO log_edi_mgr_hist SELECT *,'' FROM log_edi_mgr WHERE  dat_geracao <= today - 2192; "
   cCOMANDO+=" DELETE FROM log_edi_mgr WHERE dat_geracao <= today - 2192; "    
   executasql(cCOMANDO,"Limpesa log 20")
   
ENDIF
mds("...")     
Dbcloseall()
oCONN:CLOSE()

return .T.


FUNCTION FAZ01(cCNPJ,cEMP)
nINI:=1 
nFIM:=1
IF ! NETUSE("NFE","DBFCDX")
   return .t.
ENDIF
dbgotop()
IF dbseek(cEMP)
   nINI:=NFS
endif  
cCOMANDO="SELECT nvl_integer(max(nota_fiscal)) FROM fat_nf_mestre where empresa='"+cEMP+"' and cast(dat_hor_emissao as date)>='01/01/"+cANOBASE+"'"
if cEMP='10' //notas faturadas erradas com numeracao da 01
   cCOMANDO+=" and nota_fiscal not in (113303,113304,113305)"
endif
oRegistr2:Open(cCOMANDO, oConN, adOpenForwardOnly,adLockReadOnly) 
IF .NOT. oregistr2:eof
   nFIM:=oregistr2:fields(0):value
endif
oRegistr2:CLOSE()

//se estiver vazio a nota inicial
if empty(nINI)
  cCOMANDO="SELECT nvl_integer(min(nota_fiscal)) FROM fat_nf_mestre where empresa='"+cEMP+"' and cast(dat_hor_emissao as date)>='01/01/"+cANOBASE+"' and serie_nota_fiscal='1' and status_nota_fiscal='F'"
  if cEMP='01' //notas faturadas erradas com numeracao da 10
     cCOMANDO+=" and nota_fiscal not in(19,20)"
  endif 
  oRegistr2:Open(cCOMANDO, oConN, adOpenForwardOnly,adLockReadOnly) 
  IF .NOT. oregistr2:eof
     nINI:=oregistr2:fields(0):value
  endif
  oRegistr2:CLOSE()  
ENDIF

IF nFIM=0  //firma sem emitir nota a um ano pega a referencia
   nFIM:=nINI
ENDIF

IF nINI=nFIM .or. nini=0 .or. nfim=0 // a ultima nota e igual a ultima emitida nao envia novamente ou sem inicial ou final 
   dbselectar("nfe")
   dbcloseAREA()
   return .T.
ENDIF
nINI++ // Comeca na nota seguinte para nao enviar a ultima novamente



fOR X=nINI TO nFIM
   cBUSCA:=cCNPJ+ALLTRIM(STR(X,8))
   mds(cEMP+" "+cCNPJ+" NF: "+ALLTRIM(STR(X,8)))
   dbselectar("danfe2") //dbsetorder(2) //cnpj + nff acima na chamado do faz(empresas .....
   dbgotop()
   IF ! dbseek(cBUSCA) //so ira processar as que ainda nao estiver na danfe2
      lACHEI:=.F.
      lCANCEL:=.F.
      cID:=""
      
      cCOMANDO=" SELECT  sup_nf_eletronica.chave_acesso AS ID, "
      cCOMANDO+="   empresacnpj_970(sup_nf_eletronica.empresa) AS CNPJ , "
      cCOMANDO+="        tiraout(clientes.num_cgc_cpf[2,19]) AS CNPJDEST, "
      cCOMANDO+="        sup_nf_eletronica.nota_fiscal AS  NNF,sup_nf_eletronica.sit_nota_fiscal, "
      cCOMANDO+="        fat_nf_mestre.serie_nota_fiscal AS serie,cast(fat_nf_mestre.dat_hor_emissao as date) AS emissao "
      cCOMANDO+="         ,obf_nf_eletr.chave_acesso AS chavenfe2  "
      cCOMANDO+="     FROM fat_nf_mestre            "
      cCOMANDO+="        LEFT JOIN sup_nf_eletronica ON fat_nf_mestre.empresa=sup_nf_eletronica.empresa  "
      cCOMANDO+="                         AND fat_nf_mestre.nota_fiscal = sup_nf_eletronica.nota_fiscal "
      cCOMANDO+="        LEFT JOIN obf_nf_eletr ON fat_nf_mestre.empresa =obf_nf_eletr.empresa  "
      cCOMANDO+="                         AND fat_nf_mestre.nota_fiscal = sup_nf_eletronica.nota_fiscal "
      cCOMANDO+="       LEFT JOIN clientes ON fat_nf_mestre.cliente = clientes.cod_cliente "
      cCOMANDO+="     WHERE   fat_nf_mestre.empresa ='" + cEMP + "'"
      cCOMANDO+="      AND   fat_nf_mestre.nota_fiscal ="+STR(X,8)
      
      TRY
         oRegistro:Open(cCOMANDO, oConN, adOpenForwardOnly,adLockReadOnly) 
      catch oErr
         ShowAdoError(oERR,oConn,cCOMANDO)
      END
      dEMISSAO:=DATE()+1   //evira erro na data
      cCNPJDEST:="_"   
      while .NOT. oregistro:eof
         cID:=STRVAL(oregistro:fields("ID"):value)
         IF EMPTY(cID)
            cID:=STRVAL(oregistro:fields("chavenfe2"):value)
         ENDIF
         IF STRVAL(oregistro:fields("sit_nota_fiscal"):value)="C"
            lCANCEL:=.T.
            dbselectar("danfe2")
            dbsetorder(1)
            dbgotop()
            IF ! dbseek(cID)                        
               netrecapp()
               Danfe2->Id        := cID
               Danfe2->cnpj      := STRVAL(oregistro:fields("CNPJ"):value)
               danfe2->Nnf       := STRVAL(oregistro:fields("NNF"):value)
               danfe2->serie     := STRVAL(oregistro:fields("SERIE"):value)
               danfe2->emissao   := data2str(oregistro:fields("emissao"):value,"YMD-4") 
               Danfe2->cnpjdest  := STRVAL(oregistro:fields("CNPJDEST"):value)
               grvcancelada()
            endif   
         ENDIF
         dEMISSAO :=left(STRVAL(oregistro:fields("emissao"):value,,,"DMY/4"),10)
         dEMISSAO := CTOD(dEMISSAO)
         cCNPJDEST:=STRVAL(oregistro:fields("CNPJDEST"):value)
         oRegistro:MoveNext()      
      enddo
      oRegistro:CLOSE()
      cANO:=STRZERO(YEAR(dEMISSAO),4)
      cMES:=STRZERO(MONTH(dEMISSAO),2)      
      cFILEPDF   := cPDF+cEMP+STRTRAN(DTOC(dEMISSAO),"/","")+"001"+strzero(x,8)+"_danfe.pdf"      //formato logix da danfe 
      IF ! EMPTY(cID) .AND. ! lCANCEL                
         cFILEDANFE := pegcamxml(cID,cCNPJ,cCNPJDEST,cANO,cMES)
         IF ! EMPTY(cFILEDANFE)            
            FILECOPY(cFILEDANFE,cNFECNPJ+"NFE"+cID+".xml")
            lACHEI:=.T.
         endif         
      endif
      IF lACHEI .AND. ! EMPTY(cCNPJDEST) 
         cDESTMAIL:=PegaEmailCnpj(cCNPJDEST)              
            if ! EMPTY(Cdestmail)
               IF cANO>=cANOBASE	.AND. cMES=STRZERO(MONTH(DATE()),2) 
                  enviaemail(cFILEDANFE,"NFE "+cID,cDESTMAIL)	
				  if file(cFILEPDF)
				     enviaemail(cFILEPDF,"Danfe "+cID,cDESTMAIL)	
				  endif				  
               endif                  
            else
               fwrite(nuso,cFILEDANFE+" "+cCNPJDEST+" Erro Email"+HB_OsNewLine())
            endif   
      ENDIF
      if ! EMPTY(cID) .AND. ! lCANCEL .AND. ! lACHEI
         nFIM:=X // posiciona a nota atual menos um pois a rotina somara +1 
         EXIT   //sai fora do loop para agilizar
      endif      
   ENDIF
NEXT X
dbselectar("nfe")
dbgotop()
IF dbseek(cEMP)
  netreclock()
  NFE->nfs:=nFIM
  dbcommit()
  dbunlock()
endif   
dbclosearea()
mds("...")
return .t.

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
      main.release
RETURN nil




function gravaelec()
  // Pegando Arquivo na Pasta
  mDIRETORIO:=cELECTROLUXENV
  
  for z= 1 to 2
      if z=1
        mArquivo := '*.xml'
      else
        mArquivo := '*.txt'
      endif  
      mListaArq := Directory(mDiretorio+mArquivo) //,"D") include diretorios
      
      nFIM:= Len(mListaArq)
      IF nFIM=0        
         return nil
      ENDIF
      
      cARQGRV:="l"+ArqLogDataHora("sql")
      nHANDLE:=FCREATE(cARQGRV)
    
      main.Progressbar1.Rangemin:=1
      main.Progressbar1.Rangemax:=nFIM
    
      For i := 1 to nFIM
      
        cARQUIVO := mListaArq[i,1]
        main.Progressbar1.value:=I
        mds(str(i,8)+"/"+str(nFIM,8)+" "+CARQUIVO)
        cTEXTO:=hb_memoread(cELECTROLUXENV+cARQUIVO)
        IF filecopy(cELECTROLUXENV+cARQUIVO,cELECTROLUXLOG+cARQUIVO)>0     
           filedelete(cELECTROLUXENV+cARQUIVO)
        endif       
        cPROTOCOLO:=ALLTRIM(STR(LEN(cTEXTO))) 
        IF Z=1  //xml      
          cNNF      :=PegaDados('nNF'   ,cTEXTO )
          cPROTOCOLO:=PegaDados('nProt' ,cTEXTO )          
          IF VAL(cNNF)=0
             cNNF:=IDNFF(STRTRAN(UPPER(cARQUIVO),"NFE",""))
          ENDIF
        ELSE         //avb
          cNNF:=ALLTRIM(STR(VAL(SUBSTR(cTEXTO,3,6)))) 
          IF VAL(cNNF)=0
             cNNF:=strtran(SUBSTR(upper(cARQUIVO),2),".TXT","")
          ENDIF          
        ENDIF
        
         
        
        IF val(cPROTOCOLO)>0 .AND. val(cNNF)>0
           cCNPJ2:='61381323000167'
           IF AT("61381323000248",cARQUIVO)>0
              cCNPJ2:='61381323000248'
           ENDIF
           IF AT("61381323000329",cARQUIVO)>0
              cCNPJ2:='61381323000329'
           ENDIF
           IF AT("61381323000400",cARQUIVO)>0
              cCNPJ2:='61381323000400'
           ENDIF           
           IF AT("61381323000590",cARQUIVO)>0
              cCNPJ2:='61381323000590'
           ENDIF           
		   
           IF Z=1 //xml
               cID:=STRTRAN(cARQUIVO,"NFe","")
               cID:=SUBSTR(cID,1,44)
               GrvLogEdi('mercador',,,cPROTOCOLO,cID,cNNF,cCNPJ2,'POSTAGEM','XML')
           ELSE  //avb
               GrvLogEdi('mercador',,,cARQUIVO,cPROTOCOLO,cNNF,cCNPJ2,'POSTAGEM','AVB')                  
           ENDIF                  
       ENDIF 
     
      next i
      fclose(nHANDLE)
      gravaprot(cARQGRV)    
   next z
   mds("...")

Return nil


function checkdanfev() 
if ! NETUSE("DANFE2","DBFCDX")     
   return .t.
endif
IF ! NETUSE("NFE","DBFCDX")
   dbcloseall()
   return .t.
ENDIF
nRECNO:=danfevrec
nRECGRV:=0  
cARQLOG:="danfeviewsync"+ArqLogDataHora("log")
nHANDLE:=FCREATE(cARQLOG)
cARQLO2:="danfeviewsync"+ArqLogDataHora("log")
nHANDL2:=FCREATE(cARQLO2)
dbselectar("DANFE2")

dbsetorder(0)  //sem ordem controle pelo recno()
danfe2->(dbgoto(nRECNO))
while ! eof()
  cID         :=alltrim(id)  
  cARQUIVO    :="NFE"+cID+".XML"
  cCNPJ       :=alltrim(cnpj)
  cCNPJDEST   :=alltrim(cnpjdest)
  cANO        :=emissaoano(danfe2->emissao)
  cMES        :=emissaomes(danfe2->emissao)
  cARQIMP     :=""
  mds(strzero(danfe2->(recno()),8)+"/"+cID)
  
  IF EMPTY(DANFE2->DANFEVIEW) .OR. DANFE2->DANFEVIEW="M" //somente com tres meses  checa M(Tambem pra 3 meses)
     IF EmissaoData(danfe2->emissao) < DATE()-30         
        netreclock()  
        DANFE2->DANFEVIEW:="<"
        dbunlock()
    ENDIF
  ENDIF

  IF EMPTY(DANFE2->DANFEVIEW) .and. danfe2->cancelada="I" //Inutilizada o danfeview nao le
     netreclock()  
     DANFE2->DANFEVIEW:="I"
     dbunlock()
  ENDIF
  
  
  if DANFE2->CANCELADA="S" .and. EmissaoData(danfe2->emissao) >= DATE()-30      //so verifica 30 dias  
     cARQIMP:=pegcamxml(cID,cCNPJ,cCNPJDEST,cANO,cMES)
     if empty(cARQIMP)
        fwrite(nHANDLE,cID+" "+cMES+"/"+cANO+" canc sem xml"+HB_OsNewLine())      
     endif
  endif  

  
  IF EMPTY(DANFE2->DANFEVIEW) .OR. DANFE2->DANFEVIEW="M"
      cARQIMP:=pegcamxml(cID,cCNPJ,cCNPJDEST,cANO,cMES) 
      IF ! EMPTY(cARQIMP)
         netreclock()  
         if ! file(cmemorizados + cCNPJ    +"\"+cANO+"\"+cMES+"\"+cARQUIVO) .AND. ;
            ! file(cmemorizados + cCNPJDEST+"\"+cANO+"\"+cMES+"\"+cARQUIVO) .AND. ;                       
            ! file(cmemorizados + 'EmitidosPorMim\'+cCNPJ    +"\"+cANO+"\"+cMES+"\"+cARQUIVO) .AND. ;                       
            ! file(cmemorizados + 'EmitidosPorMim\'+cCNPJDEST+"\"+cANO+"\"+cMES+"\"+cARQUIVO) .AND. ;                       
            ! file(cmemorizados + 'Recebidos\'+cCNPJ    +"\"+cANO+"\"+cMES+"\"+cARQUIVO) .AND. ;                       
            ! file(cmemorizados + 'Recebidos\'+cCNPJDEST+"\"+cANO+"\"+cMES+"\"+cARQUIVO) 
            
            
            cDEST:="61381323000248" 
            IF cCNPJ="61381323000167" .OR. cCNPJDEST="61381323000167"
               cDEST="61381323000167"
            ENDIF
            IF cCNPJ="61381323000329" .OR. cCNPJDEST="61381323000329"
               cDEST="61381323000329"
            ENDIF
            IF cCNPJ="61381323000400" .OR. cCNPJDEST="61381323000400"
               cDEST="61381323000400"
            ENDIF            
            IF cCNPJ="61381323000590" .OR. cCNPJDEST="61381323000590"
               cDEST="61381323000590"
            ENDIF            

            IF EMPTY(DANFEVIEW)            //1a. tentativa grava na pasta memorizar para o danfeview automemorizar
                cDEST:=cmemorizar+cARQUIVO       
                danfe2->danfeview:="M"
                IF nRECGRV=0              //2a. tentativa grava direto na pasta memorizadas
                   nRECGRV:=RECNO()                   
                ENDIF
            ELSE                           //grava na pasta memorizados segunda tentativa                               
               cDEST:=cmemorizados+cDEST+"\"+cANO+"\"+cMES+"\"+cARQUIVO               
               danfe2->danfeview:="S"               
            ENDIF
            FILEcopy(carqimp,cDEST)
         else //ja esta memorizado grava "S"         
             danfe2->danfeview:="S"             
         endif
         dbunlock()
      else
         IF cANO<cANOBASE .OR. EmissaoData(danfe2->emissao)<DATE()-180
            netreclock()
            danfe2->danfeview:="<"             
            dbunlock()
            IF nRECGRV=0              
               nRECGRV:=RECNO()                   
            ENDIF
         endif
         fwrite(nHANDL2,cID+HB_OsNewLine())      
      ENDIF    
   ENDIF    
   dbskip()
enddo
if nRECGRV=0
   dbgobottom()     //nao teve nenhum memoriza
   nRECGRV:=RECNO()  //grava o ulitmo
ENDIF
DBSELECTAR("nfe")
NETreclock()
NFE->danfevrec:=nRECGRV
DBUNLOCK()
dbcloseall() 
fclose(nhandle)
if filesize(cARQLOG)=0
   ferase(cARQLOG)
endif
fclose(nhandl2)
if filesize(cARQLO2)=0
   ferase(cARQLO2)
endif
mds("...")
return .t.

function checkstatus()
cTO:=PROFILESTRING( "LERXML.INI","EMAIL","DESTDANFE")
IF AT(",",cTO)>0
   aTO=HB_ATOKENS(cTO,",")
ELSE
   aTo      :={cTO}
ENDIF
if ! NETUSE("DANFE2","DBFCDX")     
    return .f.
endif
IF ! NETUSE("NFECRET","DBFCDX")
   dbcloseall()
   return .f.
ENDIF
IF ! NETUSE("NFE","DBFCDX")
   dbcloseall()
   return .f.
ENDIF
nRECNO:=statusrec
nFIM:=LASTREC()

cARQ:="nfestatus"+ArqLogDataHora()
nGRV:=fcreAte(cARQ)
cARQ101:="a"+ArqLogDataHora("sql")
nHANDLE:=fcreAte(cARQ101)


nCONTA:=1
dbselectar("DANFE2")
nFIM:=LASTREC()
main.Progressbar1.Rangemin:=1
main.Progressbar1.Rangemax:=nFIM
dbsetorder(0)
danfe2->(dbgotop())
while ! eof()
    dDATA2:=emissaodata(danfe2->EMISSAO)
    main.Progressbar1.value:=nRECNO
    mds(str(RECNO()),8)
    netreclock()
    if danfe2->cancelada="S" .and. empty(danfe2->cstatus) //grava cancelada
       grvcancelada()                   
    endif	
	if IDANO(DANFE2->ID) < cANOBASR //mais de um ano //tambem marca por dia abaixo
	   danfe2->cstatus:=">3M"    
	endif
    IF EMPTY(cSTATUS) .AND. (DATE()-dDATA2)>120 // somente 120 dias podemos ter protoculo	    
       danfe2->cstatus:=">3M"    
    ENDIF	    
 	IF EMPTY(danfe2->CNPJ)        //pega pela chave se estiver em branco
      danfe2->CNPJ:=IDEMISSOR(DANFE2->ID)
	ENDIF   
    IF val(danfe2->NNF)=0   //pega pela chave se estiver em branco
	   danfe2->NNF:= IDNFF(DANFE2->ID)
	endif
	IF EMPTY(danfe2->SERIE)	    //pega pela chave se estiver em branco
	   danfe2->SERIE:=idserie(danfe2->ID)
	endif  
   IF DANFE2->CANCELADA="S"  //Cancelada nao tem xml,avb,ou recebimento
      IF EMPTY(danfe2->xml) .OR. EMPTY(danfe2->avb) .OR. empty(danfe2->logixsup)       
         grvcancelada()            
      ENDIF
   ENDIF   
   IF EMPTY(danfe2->xml) .AND. ASCAN(aCNPJXML,LEFT(DANFE2->CNPJdest,8))=0       //nao faz parte do grupo do xml   
      danfe2->xml:="O"        
   ENDIF    
   IF EMPTY(danfe2->avb) .AND. ASCAN(aCNPJAVB,LEFT(DANFE2->CNPJdest,8))=0      //nao faz parte do grupo de avb          
      danfe2->avb:="O"                     
   ENDIF   
   IF EMPTY(danfe2->avb) .and. ! IsCNPJITA(DANFE2->CNPJ)   //nota fiscal de entrada nao tem avb
      danfe2->avb:="E"	  
   endif
   if empty(danfe2->logixsup) .AND. IsCNPJITA(DANFE2->CNPJ) //nota fiscal de saida grava sup
      danfe2->logixsup:="S"        
   endif   
   dbunlock()  
   danfe2->(dbskip())
enddo


dbsetorder(0)
danfe2->(dbgoto(nRECNO))
while ! eof()
     dDATA2:=emissaodata(danfe2->emissao)
     nRECNO:=RECNO()
     cID:=ALLTRIM(DANFE2->ID)
     main.Progressbar1.value:=nRECNO
     mds(str(nRECNO,8)+"/"+str(nFIM,8)+"-"+str(nCONTA)+" "+cID)
     IF EMPTY(cSTATUS) .AND. CANCELADA<>"S" .AND. CANCELADA<>"I"     
        aRET:=PegStatusRet(cID)
        cRET:=aRET[1]
        cPRO:=aRET[2]
        IF val(cRET)>0 .OR. cRET="CTE" 
          netreclock()
          danfe2->cstatus:=cRET
          if cRET="101"
             grvcancelada()             
          endif
          IF VAL(CPRO)>0 .AND. EMPTY(DANFE2->PROTOCOLO)
             danfe2->protocolo:=cPRO
          ENDIF
          dbunlock()                
          if cRET<>"100".AND.cRET<>"217".AND.cRET<>"226".AND.cRET<>"618".AND.cRET<>"CTE" //nota normal outro estado cte/618
             dbselectar("NFECRET")
             dbgotop()
             if dbseek(cRET)
                cRET+=" - "+ALLTRIM(DESCRICAO)
             endif
             dbselectar("DANFE2")
             IF IsCNPJITA(DANFE2->CNPJ) 
                cARQIMP:=ID+"-nfe_vis_canc.xml"
				copiavislogix(cARQIMP,cNFECNPJ+cARQIMP) 
             ELSE
                fwrite(ngrv,ID+" "+CNPJ+" "+NNF+" "+EMISSAO+" "+cRET+HB_OsNewLine())
             ENDIF   
          endif
          if cRET="101"
             cCGCEmit:=CNPJ
             IF IsCNPJITA(cCGCEmit) 
             ELSE
                dDATA:=emissaodata(danfe2->emissao)                
                cPROTOCOLO:=ALLTRIM(PROTOCOLO)
                cID:=alltrim(ID)
                cNNF:=ALLTRIM(NNF)                
                if ! EMPTY(cCGCEmit)                                  
                    GrvLogEdi(cCGCEmit,dDATA,,cPROTOCOLO,cID,cNNF,CNPJDEST,'cancNFe','XML')                                    
                ENDIF     
             ENDIF
          endif
       endif
       nCONTA++
    endif
    dbselectar("DANFE2")
    dbsKIP()
    IF DANFE2->CANCELADA<>"S".AND.CANCELADA<>"I"
       dTMP:=emissaodata(danfe2->EMISSAO)    
       IF (DATE()-dTMP)<3  //<3 ate dois dias para cancelar a nota fiscal (Regra Nova)        
         EXIT 	            //<8 ate sete dias para cancelar a nota fiscal (Regra Antiga)
       ENDIF
    ENDIF   
enddo
fclose(nGRV)
fclose(nHANDLE)
DBSELECTAR("nfe")
NETreclock()
NFE->statusrec:=nRECNO
DBUNLOCK()
dbcloseall()
IF FILESIZE(cARQ)>0 
   aARQEMAIL:={} //vai no corpo com o caminho arquivo  evitar repostagem eudora //hb_memoread
   cASSUNTO :="NFE Erro"
   cCORPOMSG:=cARQ 
   try
      lVar     :=HB_SendMail(cServerIP,nPort,cFrom,aTo,,,cCorpoMsg,cAssunto,aArqEmail,cUser,cPass,cPop,1,.F.,.F.,.T.,)
   catch
      hb_memowrit("email"+ArqLogDataHora(),STRVAL(aTO))
      lVAR     :=.F.
   end      
   IF filecopy(cCAM+cARQ,cCAM+"erro\"+cARQ)>0     
      filedelete(cARQ)
   ENDIF	  
ELSE
   FILEDELETE(cARQ)            
ENDIF
GRAVAPROT(cARQ101)
mds("...")
Return nil

function consultar(nTIPO)
consultex(main.ComboConsulta.Value,main.CHAVE.value)  
return


FUNCtion PegStatusRet(cChave,lMES)
IF cNFECHECK='NAO'
   RETURN {'',''}
ENDIF
IF VALTYPE(lMES)<>'L'
   lMES:=.F.
ENDIF
cRET:=""
cPRO:=""
if idcte(cchave) .or. idcteos(cchave)
   //cXmlRetorno:=oSefaz:CteConsulta( cChave,oSefaz:cCertificado ) //, cCertificado )   
   cXmlRetorno:=oSefaz:CteConsultaprotocolo( cChave,oSefaz:cCertificado ) //, cCertificado )
   cRET:="CTE"
else
   //cXmlRetorno:=oSefaz:NfeConsulta( cChave )
   cXmlRetorno:=oSefaz:NfeConsultaprotocolo( cChave )
   cRET:="0" 
endif

//cXmlRetorno
cRET:=XmlNode( cXmlRetorno, "cStat" )
cPRO:=XmlNode( cXmlRetorno, "nProt" )
if lMES		 
   cERRO:="Ambiente   :" + XmlNode(cXmlRetorno,'tpAmb')+  HB_EOL()
   cERRO+="Aplicacao  :" + XmlNode(cXmlRetorno,'verAplic')+ HB_EOL()
   cERRO+="Data       :"  + XmlNode(cXmlRetorno,'dhRecbto')+ HB_EOL()
   cERRO+="Protocolo  :" + XmlNode(cXmlRetorno,'nProt')+ HB_EOL()
   cERRO+="DigestValue:"+ XmlNode(cXmlRetorno,'digVal')+ HB_EOL()
   cERRO+="Status     :" + XmlNode(cXmlRetorno,'cStat')+ HB_EOL()
   cERRO+="Motivo     :" + XmlNode(cXmlRetorno,'xMotivo')+ HB_EOL()
   cERRO+="Protocolo  :"+ XmlNode(cXmlRetorno, 'protNFe')+ HB_EOL()
   wapi_MessageBox(,cERRO)
ENDIF		 
RETURN {cRET,cPRO}


FUNCTION CHECASITUACAO()
PegStatusRet(alltrim(main.chave.value),.T.)
return

function checkstaent(aUSO)
aCANCEL:={}
nFIM:=LEN(aUSO)
IF nFIM=0
   RETURN aCANCEL
ENDIF
cSERVERIP := PROFILESTRING( "LERXML.INI","EMAIL","SERVER")
nPORT:= VAL(PROFILESTRING( "LERXML.INI","EMAIL","PORTA"))
cFROM := PROFILESTRING( "LERXML.INI","EMAIL","FROM")
cUSER := PROFILESTRING( "LERXML.INI","EMAIL","USUARIO")
cPASS := PROFILESTRING( "LERXML.INI","EMAIL","SENHA")
cPOP  := PROFILESTRING( "LERXML.INI","EMAIL","POP")
cTO:=PROFILESTRING( "LERXML.INI","EMAIL","DESTDANFE")
IF AT(",",cTO)>0
   aTO=HB_ATOKENS(cTO,",")
ELSE
   aTo      :={cTO}
ENDIF


IF ! NETUSE("NFECRET","DBFCDX")
   dbcloseall()
   return aCANCEL
ENDIF
cARQ:="nfestatus"+ArqLogDataHora()
nGRV:=fcreAte(cARQ)


main.Progressbar1.Rangemin:=1
main.Progressbar1.Rangemax:=nFIM

FOR I=1 TO nFIM
   cID:=aUSO[I]
   main.Progressbar1.value:=I
   mds(str(I,8)+"/"+str(nFIM,8)+" "+cID)  
   aRET:=PegStatusRet(cID)
   cRET:=aRET[1]
   cPRO:=aRET[2]
   IF VAL(cRET)>0.OR.cRET="CTE"
       if cRET<>"100".AND.cRET<>"217".AND.cRET<>"226".AND.cRET<>"618".AND.cRET<>"CTE"
          dbselectar("NFECRET")
          dbgotop()
          if dbseek(cRET)
             cRET+=" - "+ALLTRIM(DESCRICAO)
          endif
          fwrite(ngrv,cID+" "+cRET+HB_OsNewLine())
       endif
       IF cRET="101"
          AADD(aCANCEL,cID)
       ENDIF
   endif
NEXT I
fclose(nGRV)
IF FILESIZE(cARQ)>0 
   aARQEMAIL:={cARQ}
   cASSUNTO :="NFE Canceladas"
   cCORPOMSG:=hb_memoread(cARQ)
   TRY
     lVar     :=HB_SendMail(cServerIP,nPort,cFrom,aTo,,,cCorpoMsg,cAssunto,aArqEmail,cUser,cPass,cPop,1,.F.,.F.,.T.,)
   catch
     hb_memowrit("email"+ArqLogDataHora(),STRVAL(aTO))
     lvar    :=.t.
   end   
ELSE
   FILEDELETE(cARQ)             
ENDIF
mds("...")
Return aCANCEL

FUNCTION VERCERTIFICADO()
oSefaz:cCertificado := CapicomEscolheCertificado()
wapi_MessageBox( , oSefaz:cCertificado )
RETURN .T.


function mdt(cTEXTO)
mds(cTEXTO)
INKEY(1)
mds("...")
return .t.

function mds(cTEXTO)
if valtype(cTEXTO)="C"
   main.label1.value:=cTEXTO
endif  
return .t.

FUNCTION GrvLogEdi(cCGCLOG,cDATA,cHORA,cARQUIVO,cCHAVE,cNNF,cCGCDest,CTIPGRV,cTIPLOG)
IF VALTYPE(cDATA)="D"
   cDATA:=DTOC(cDATA)
ENDIF
IF EMPTY(cDATA) .OR. VALTYPE(cDATA)<>"C"  
   cDATA:=DTOC(DATE())
ENDIF
if VALTYPE(cDATA)="C"  .and. strtran(Cdata," ","")='//'
   cDATA:=DTOC(DATE())
endif
IF VALTYPE(cHORA)<>"C" .OR. cHORA="::"
   cHORA:=TIME()
ENDIF
IF val(cNNF)=0 .AND. LEN(cCHAVE)=44
   cNFF:=IDNFF(cCHAVE)
ENDIF     
IF EMPTY(cCGCLOG).AND. LEN(cCHAVE)=44 //cce cceaut outros 
   cCGCLOG:=IdEmissor(cCHAVE)
ENDIF
IF cCGCLOG='99999999999999' .AND. LEN(cCHAVE)=44 //nota fiscal de entrada importacao
   cCGCLOG:=IdEmissor(cCHAVE)
ENDIF
cGRV:="INSERT INTO log_edi_mgr (cod_usuario, dat_geracao, hor_geracao, nom_arquivo, tam_arquivo, num_nff, cod_empresa, prg_origem,tipo_arq)"+HB_OsNewLine()
DO CASE
   CASE LEN(cCGCDEST)=11 //Pessoa Fisica
        cGRV+="   VALUES ('"+cCGCLOG+"', '"+cDATA+"', '"+cHORA+"', '"+cARQUIVO+"', '"+cCHAVE+"', "+cNNF+", 'PF', '"+CTIPGRV+"','"+cTIPLOG+"');"+HB_OsNewLine()
   OTHERWISE
      cEMP2:=cCGCDEST
      IF LEN(cCGCDEST)>2
         cEMP2:=CNPJEMPLOGIX(cCGCDEST)
      ENDIF
      cGRV+="   VALUES ('"+cCGCLOG+"', '"+cDATA+"', '"+cHORA+"', '"+cARQUIVO+"', '"+cCHAVE+"', "+cNNF+",'"+cEMP2+"', '"+CTIPGRV+"','"+cTIPLOG+"');"+HB_OsNewLine()
      
ENDCASE 
FWRITE(nHANDLE,cGRV)	  
return .t.


function GrvCamXml(cARQUIVO,cCNPJ,cMES,cANO,cCHAVE,cINIARQ,lAPAGA,lMEMO,cSEQCCE)
LOCAL cCAMGRV
IF EMPTY(cANO).OR.EMPTY(CMES).OR.val(cANO)=0.OR.val(cMES)=0
   cCHAVETMP:=STRTRAN(UPPER(cCHAVE),"NFE","")
   cCHAVETMP:=STRTRAN(UPPER(cCHAVETMP),"CTE","")
   cCHAVETMP:=STRTRAN(UPPER(cCHAVETMP),"CCE","")
   cCHAVETMP:=STRTRAN(UPPER(cCHAVETMP),"CANCNFE","")
   cCHAVETMP:=STRTRAN(UPPER(cCHAVETMP),"NFES","")
   IF LEN(cCHAVE)=44
      cANO  := "20"+idano(cCHAVETMP)
      cMES  := idmes(cCHAVETMP)
   ENDIF   
ENDIF
IF VALTYPE(lMEMO)<>'L'
   lMEMO:=.F.
ENDIF
IF VALTYPE(lAPAGA)<>'L'
   lAPAGA:=.T.
ENDIF
IF VALTYPE(cSEQCCE)="N"
   cSEQCCE:=STRZERO(cSEQCCE,2)
ENDIF
IF VALTYPE(cSEQCCE)<>"C"
   cSEQCCE:=""
ENDIF
IF EMPTY(cANO).OR.EMPTY(CMES).OR.val(cANO)=0.OR.val(cMES)=0
   dARQUIVO:=FILEDATE(cARQUIVO)
   cANO  := strzero(year(dARQUIVO),4,0)
   cMES  := strzero(month(dARQUIVO),2,0)         
ENDIF
IF EMPTY(cANO).OR.EMPTY(CMES).OR.val(cANO)=0.OR.val(cMES)=0
   cANO  := strzero(year(date()),4,0)
   cMES  := strzero(month(date()),2,0)
ENDIF
cCAMGRV:=cNFECNPJ //grava para o destino do cnpj pois o robo pode estar local ou em drive mapeado
IF EMPTY(cCNPJ)
   cCAMGRV:=cCAM //grava destino a onde o robo esta rodando quando o cnpj e zero
   cCNPJ:="0"
ENDIF
IF VALTYPE(CINIARQ)<>"C"
   cINIARQ:=""   
ENDIF
IF EMPTY(cCHAVE)
   cCHAVE:="erro"+HB_TTOS(HB_DATETIME()) 
ENDIF
makedir(cCAMGRV+cCNPJ)   //cria as pastas confome destino
makedir(cCAMGRV+cCNPJ+"\"+cANO)
makedir(cCAMGRV+cCNPJ+"\"+cANO+"\"+cMES) 
IF ! EMPTY(cSEQCCE)      //complementa nome do arquivo com o codigo do evento com a sequencia
   cCHAVE:=cCHAVE+cSEQCCE                 
ENDIF   
IF lMEMO 
   filecopy(cCAM+cARQUIVO,cmemorizar+cINIARQ+cCHAVE+".xml")    //pega do local e grava para memorizacao 
   IF ! EMPTY(cMEMOFISCAL)
      filecopy(cCAM + cARQUIVO , cmemoFISCAL + cINIARQ + cCHAVE + ".xml")       //pega do local e grava segundo caminho memorizacao 
   ENDIF
ENDIF    
if filecopy(cCAM+cARQUIVO,cCAMGRV+cCNPJ+"\"+cANO+"\"+cMES+"\"+cINIARQ+cCHAVE+".xml")>0 
   IF lAPAGA
      filedelete(cCAM+cARQUIVO)              
   ENDIF   
endif   
return .t.


FUNCTION grvcancelada()
 	IF EMPTY(CNPJ)        
      danfe2->CNPJ:=IDEMISSOR(ID)
	ENDIF   
    IF val(NNF)=0
	   danfe2->NNF:= IDNFF(DANFE2->ID)
	endif
	IF EMPTY(SERIE)	   
	   danfe2->SERIE:=idserie(danfe2->id)
	endif    
   IF EMPTY(danfe2->xml)
      danfe2->xml:="C" 
   ENDIF   
   IF EMPTY(danfe2->cancelada)
      danfe2->cancelada:="S" 
   ENDIF
   IF EMPTY(danfe2->AVB)      
      danfe2->AVB:="C"  
   ENDIF   
   /*precisa postar mesmo cancelada
   IF EMPTY(danfe2->DANFEVIEW)      
      danfe2->DANFEVIEW:="C"  
   ENDIF   
   */
   IF EMPTY(danfe2->logixsup)
      danfe2->logixsup :="C"                                            
   ENDIF    
   if empty(danfe2->cstatus)
       danfe2->cstatus:="101"
   endif
RETURN


function executarcombo
impdanfe(main.ComboAcoes.Value)
return


function PegaEmailCnpj(cCNPJBUS)
local cALIAS:=ALIAS()
cEMAIL:=PROFILESTRING("LERXML.INI",cCNPJBUS,"EMAIL")
IF EMPTY(cEMAIL)
   cEMAIL:=PROFILESTRING( "LERXML.INI",LEFT(cCNPJBUS,8),"EMAIL")
ENDIF
IF EMPTY(cEMAIL)
   DBSELECTAR("CNPJXML")
   dbgotop()
   if dbseek(cCNPJBUS)
      cEMAIL:=ALLTRIM(CNPJXML->email)
   endif   
endif   
IF ! EMPTY(cALIAS)
   dbselectar(cALIAS)
ENDIF
IF ! CheckEmail( cEMAIL )			
   cEMAIL:=""
ENDIF
RETURN cEMAIL


FUNCTION Lerunzip(cFILENAME)
LOCAL hUnzip,  cExt, cFile, cFILEUSO, ;
      dDate, cTime, nSize, nCompSize, nErr, ;
      lCrypted, cPassword, cComment
      
   hUnzip := hb_unzipOpen( cFileName )
   IF ! Empty( hUnzip )
      hb_unzipGlobalInfo( hUnzip, @nSize, @cComment )
      nErr := hb_unzipFileFirst( hUnzip )
      DO WHILE nErr == 0
         hb_unzipFileInfo( hUnzip, @cFile, @dDate, @cTime, , , , @nSize, @nCompSize, @lCrypted, @cComment )
         hb_fNameSplit( cFile,,@cFILEuso, @cExt )
         cFILEUSO:=cFILEUSO+cEXT          
         hb_unzipExtractCurrentFile( hUnzip, cFILEUSO, cPassword )
         nErr := hb_unzipFileNext( hUnzip )
      ENDDO
      hb_unzipClose( hUnzip )
   ENDIF
return .t.


FUNCTION GRAVARPS()
LOCAL dDATASER
cPROTOCOLO:=IF(empty(cMUN),coduf(xUF,"SI"),LEFT(cMUN,2))
cPROTOCOLO+=IF(LEN(CANO)=4,RIGHT(cANO,2),cANO)
cPROTOCOLO+=cMES+XCNPJ+"SE"+STRZERO(1,3)+STRZERO(VAL(cNNF),9)+"1"
cPROTOCOLO+=IF(EMPTY(cRPS),STRZERO(VAL(cNNF),8),STRZERO(VAL(cRPS),8))+"X"                 
dDATASER:=EmissaoData(cDATASER)
GrvCamXml(cFILEDANFE,XCNPJ,cMES,cANO,cPROTOCOLO,"NFeS",.T.,.F.)              
GrvLogEdi(XCNPJ ,dDATASER,,cFiledanfe,cPROTOCOLO,cNNF,cCGCDest,'EMAIL','NFSE')                         
gravacpnjxml()               
RETURN .T.

FUNCTION APAGACHAVEDUPLICADAS()
LOCAL iARQ,cARQDUP
FOR iARQ=1 TO 2
    cARQDUP:="DANFE2"
    IF iARQ=2
	   cARQDUP:="DANFE2FEC"
	ENDIF	
	if ! NETUSE(cARQDUP,"DBFCDX")     
	   return .f.
	endif
	
	
	dbsetorder(0)
	dbgotop()
	while ! eof()
	  cID    :=alltrim(field->id)   
	  mds("Checagem Campos: "+strzero(recno(),8)+"/"+cID)
	  netreclock()  
	  IF iARQ=1
		  if val(DANFE2->cnpj)=0		  
			  DANFE2->CNPJ:=IdcnPj(cID)
		   endif
		   if val(DANFE2->cnpjdest)=0
			  DANFE2->cnpjdest:=""
		   endif
		   if val(DANFE2->nnf)=0		  
			  DANFE2->nnf:=IdNFF9(cid)   //""		  
		   endif
		   if val(DANFE2->serie)=0		  
			  DANFE2->serie:=idSerie(cID)   //""		  
		   endif
		   if DANFE2->emissao='0000-00-00'		  
			  DANFE2->emissao:=""
		   endif
		   if len(alltrim(DANFE2->emissao))=1
			  DANFE2->emissao:=""
		   endif
	   endif	   

	  IF iARQ=2
		  if val(DANFE2fec->cnpj)=0		  
			  DANFE2fec->CNPJ:=IdcnPj(cID)
		   endif
		   if val(DANFE2fec->cnpjdest)=0
			  DANFE2fec->cnpjdest:=""
		   endif
		   if val(DANFE2fec->nnf)=0		  
			  DANFE2fec->nnf:=IdNFF9(cid)   //""		  
		   endif
		   if val(DANFE2fec->serie)=0		  
			  DANFE2fec->serie:=idSerie(cID)   //""		  
		   endif
		   if DANFE2fec->emissao='0000-00-00'		  
			  DANFE2fec->emissao:=""
		   endif
		   if len(alltrim(DANFE2fec->emissao))=1
			  DANFE2fec->emissao:=""
		   endif
	   endif	   	   
	   dbunlock()   	   
	   dbskip()
	enddo	
    
	
	dbsetorder(1)
	dbgotop()
	while ! eof() //field->(eof()) field->(eof())
	   cID    :=alltrim(field->id)   
	   mds("Duplicidade: "+strzero(recno(),8)+"/"+cID)
	   IF EmissaoData(field->emissao)<DATE()-180           
		  IF EMPTY(field->DANFEVIEW) 
			 netreclock()  
			 field->DANFEVIEW:="<"
			 dbunlock()
		  endif
		  IF EMPTY(field->AVB)
			 netreclock()  
			 field->AVB:="<"
			 dbunlock()
		  ENDIF
		  IF EMPTY(field->XML)
			 netreclock()  
			 field->XML:="<"
			 dbunlock()
		  ENDIF
		  IF EMPTY(field->LOGIXSUP)
			 netreclock()  
			 field->LOGIXSUP:="<"
			 dbunlock()
		  ENDIF
		  IF EMPTY(field->CSTATUS)
			 netreclock()  
			 field->LOGIXSUP:=">3M"
			 dbunlock()
		  ENDIF		  
	   ENDIF
	   IF LOGIXSUP="X" .AND. IsRaizIta(CNPJ)
		  netreclock()      
		  field->logixsup:="F" 		//faturamento transferencia        
		  dbunlock()   
	   ENDIF
	
	   if EMPTY(LOGIXSUP) .OR. LOGIXSUP="F" 
		  if IsRaizIta(CNPJ) 
			 if IsRaizIta(CNPJDEST)    
				netreclock()      
				field->logixsup:="Y"	 //faturamento transferencia        
				dbunlock()
			 endif
		  endif   
	   endif 
	   IF LOGIXSUP="X" .AND. ! IsRaizIta(field->CNPJ) .AND. ! IsRaizIta(field->CNPJDEST) .AND. ! idcte(cID) .and. ! idcteos(cID)
		  netrecdel()
	   endif
	   if Canobase=EmissaoAno(field->emissao)      
		  if empty(protocolo) .and. ! IsRaizIta(field->CNPJ) 
			 cARQIMP :=pegcamxml(cID,field->CNPJ,field->CNPJDEST) 
			 if ! empty(cARQIMP)
				linha:=hb_memoread(Carqimp)
				cPROTOCOLO:=PegaDados('nProt' ,Alltrim(Linha) )
				if val(cPROTOCOLO)>0
				   netreclock()
				   field->protocolo:=cPROTOCOLO
				   dbunlock()
				endif
			 endif     
		  endif
		  dbskip()
		  if ! eof() 
			 if cID=alltrim(field->id)
				netrecdel()
			 endif
		  endif
	   else   
		  dbskip()
	   endif 
	enddo
	

	
	dbclosearea()
next iarq	
mds("...")
RETURN .T.




FUNCTIOn IsCNPJITA(cCNPJ)
RETURN ascan(aCNPJITA,cCNPJ)>0

FUNCTION CNPJEmpLogix(cCNPJ)
LOCAL cEMPLOG
cEMPLOG:="01"
IF cCNPJ="61381323000248"
   cEMPLOG:="01"
ENDIF
IF cCNPJ="61381323000167"
   cEMPLOG:="05"
ENDIF
IF cCNPJ="61381323000329"
   cEMPLOG:="10"
ENDIF
IF cCNPJ="61381323000400"
   cEMPLOG:="11"
ENDIF
IF cCNPJ="61381323000590"
   cEMPLOG:="12"
ENDIF
RETURN cEMPLOG


FUNCTION EmpLogixCnpj(cEMPLOG)
LOCAL cCNPJ
cCNPJ:="61381323000167"
IF cEMPLOG="01"
    cCNPJ:="61381323000248"   
ENDIF
IF cEMPLOG="05"
    cCNPJ:="61381323000167"   
ENDIF
IF cEMPLOG="10"
    cCNPJ:="61381323000329"   
ENDIF
IF cEMPLOG="11"
    cCNPJ:="61381323000400"   
ENDIF
IF cEMPLOG="12"
    cCNPJ:="61381323000590"   
ENDIF
RETURN cCNPJ

FUNCTION IsRaizIta(cCNPJ)
RETURN LEFT(cCNPJ,8)="61381323" 

FUNCTION ArquivoIta(cFILEDANFE) 
RETURN AT("61381323000248",cFILEDANFE)>0  .OR. AT("61381323000167",cFILEDANFE)>0  .OR. AT("61381323000329",cFILEDANFE) >0  .OR. AT("61381323000400",cFILEDANFE) >0 .OR. AT("61381323000590",cFILEDANFE) >0



function fecha5anos()
LOCAL X,cORIGEM,cDESTINO
nDATAFIM:=date()-1825
nDATA2ANO:=date()-720
FOR X=1 TO 2
    IF X=1 
	   cORIGEM :="CNPJXML"
	   cDESTINO:="CNPJXMLFEC"
	ELSE
	   cORIGEM :="SINTCERT"
	   cDESTINO:="SINTCERTFEC"	
	ENDIF
	IF ! NETUSE(cORIGEM,"DBFCDX")
		return
	endif   
	nFIMREC:=FCOUNT()
	aDADOS:=ARRAY(nFIMREC)
	IF ! NETUSE(cDESTINO,"DBFCDX")
		return
	endif   
	dbselectar(cORIGEM)
	dbgotop()
	while ! eof()
		 mds(FIELD->cnpj)
		 if emptY(FIELD->ultimaimp)
			netreclock()
			FIELD->ultimaimp:=nDATA2ANO
			dbunlock()
		 endif
		 if ! empty(FIELD->ultimaimp) .and. (FIELD->ultimaimp)<nDATAFIM
			FOR J=1 TO nFIMREC
				aDADOS[j]:=fieldget(j)
			NEXT J        
			dbselectar(cDESTINO)
			netrecapp()		
			FOR J=1 TO nFIMREC
				fieldput(j,aDADOS[J])
			NEXT J
			dbselectar(cORIGEM)
			netreclock()
			netrecdel()		
			dbunlock()
		 endif
		 dbselectar(cORIGEM)
		 dbskip()
	enddo
	dbcloseall()
NEXT X


IF ! NETUSE("DANFE2","DBFCDX")
    return
endif   
nFIMREC:=FCOUNT()
aDADOS:=ARRAY(nFIMREC)
IF ! NETUSE("DANFE2FEC","DBFCDX")
    return
endif   
dbselectar("DANFE2")
dbgotop()
while ! eof()
     mds(DANFE2->ID)	 
	 if emissaodata(danfe2->EMISSAO)<nDATAFIM
   	    FOR J=1 TO nFIMREC
            aDADOS[j]:=fieldget(j)
        NEXT J        
        dbselectar("DANFE2FEC")
		netrecapp()		
   	    FOR J=1 TO nFIMREC
            fieldput(j,aDADOS[J])
        NEXT J
		dbselectar("DANFE2")
		netreclock()		
		dbdelete()
		dbunlock()
	 endif
     dbselectar("DANFE2")
	 dbskip()
enddo
dbcloseall()

mds("fixando cnpjxml")
netpack("cnpjxml")

mds("fixando danfe2")
netpack("danfe2")
NGMPROTREC:=0
NDANFEVREC:=0
NSTATUSREC:=0
NCHAVESUP :=0
IF ! NETUSE("DANFE2","DBFCDX")
    return
endif   
dbsetorder(0)
dbgotop()
while ! eof()
    if NGMPROTREC=0 .and.  empty(XML)
	   NGMPROTREC:=recno()
    endif 
    if NDANFEVREC=0 .and.  empty(DANFEVIEW)
	   NDANFEVREC:=recno()
    endif 
    if NSTATUSREC=0 .and.  empty(CSTATUS)
	   NSTATUSREC:=recno()
    endif 
    if NCHAVESUP=0 .and.  empty(LOGIXSUP)
	   NCHAVESUP:=recno()
    endif 
    dbskip()
enddo
dbcloseall()
  
if NGMPROTREC=0 
   NGMPROTREC:=1
endif 
if NDANFEVREC=0 
   NDANFEVREC:=1
endif 
if NSTATUSREC=0 
   NSTATUSREC:=1
endif 
if NCHAVESUP=0
   NCHAVESUP:=1
endif 

IF ! NETUSE("NFE","DBFCDX")
    return
endif   
dbgotop()
while ! eof()
   netreclock()
   NFE->GMPROTREC:=NGMPROTREC
   NFE->DANFEVREC:=NDANFEVREC
   NFE->STATUSREC:=NSTATUSREC
   NFE->CHAVESUP :=NCHAVESUP
   dbunlock()
   dbskip()
enddo
dbcloseAREA()
mds("")
return 


function vertxt() //dump
return .t.


function copiavislogix(cARQIMP,cARQDEST)
IF FILE(cLOGIX+cARQIMP)           
   IF FILECOPY(cLOGIX+cARQIMP,cARQDEST)>0
      RETURN .T.
   ENDIF	  
ENDIF
IF FILE(cLOGIX2+cARQIMP)           
   IF FILECOPY(cLOGIX2+cARQIMP,cARQDEST)>0
      RETURN .T.
   ENDIF	  
ENDIF
IF FILE(cLOGIX3+cARQIMP)           
   IF FILECOPY(cLOGIX3+cARQIMP,cARQDEST)>0
      RETURN .T.
   ENDIF	  
ENDIF
IF FILE(cLOGIX4+cARQIMP)           
   IF FILECOPY(cLOGIX4+cARQIMP,cARQDEST)>0
      RETURN .T.
   ENDIF	  
ENDIF
return .F.


function baixanfe(cCHAVE)
LOCAL cFILENAME,cARQIMP
IF VALTYPE(cCHAVE)<>"C"
   cCHAVE:=alltrim(main.chave.value)  
ENDIF   
cFileName:="c:\temp\"+cCHAVE+".zip"
if file(cFileName)  
  Lerunzip(cFILENAME)
else
	oSefaz:NfeDownload( "61381323000248", cChave, oSefaz:cCertificado, oSefaz:cAmbiente  )
//	msginfO(oSefaz:cXmlRetorno)
	IF oSefaz:cStatus == "138"	   
	   hb_MemoWrit(cFileName, hb_Base64Decode( XmlNode( oSefaz:cXmlRetorno, "docZip" ) ) )	
       WAITPERIOD(500) 					   
   	   cARQIMP:="7za e -y -oc:\temp\ "+cFILENAME
	   HB_RUN(cARQIMP)
	   WAITPERIOD(500) 				
   	   IF FILECOPY("c:\temp\"+cCHAVE,cCAM+cCHAVE+".xml")>0	 //copiando local pois para o lerxml funcionar local ou drive mapeado
//	   IF FILECOPY("c:\temp\"+cCHAVE,cNFECNPJ+cCHAVE+".xml")>0	
	      ferase("c:\temp\"+cCHAVE)
		  ferase(cFILENAME)
       endif
	ENDIF
endif
return .t.