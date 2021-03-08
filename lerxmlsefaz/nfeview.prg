
#include <hmg.ch>
#include "adordd.ch"                           
#include "try.ch"
#include "common.ch"
#include "hbclass.ch"


function AcoesDanfe()
local aACOES
aACOES:={}      
   AADD(aACOES,"AbrirPrograma Padrao Windows")     //  1
   AADD(aACOES,"Opcao nao Disponivel")             //  2   
   AADD(aACOES,"Visualizar Imprimir Danfe View")  //  3      
   AADD(aACOES,"Visualizar Imprimir Unidanfe")    //  4     
   AADD(aACOES,"Opcao Nao disponivel")             //  5
   AADD(aACOES,"Copiar Xml")                        //  6
   AADD(aACOES,"Enviar Email")                     //  7
   AADD(aACOES,"Web unimake.com.br")              //  8
   AADD(aACOES,"Web webdanfe.com.br")             //  9   
   AADD(aACOES,"Web leitorxml.com")                // 10
   AADD(aACOES,"Web danfeonline.com.br")          // 11   
   AADD(aACOES,"Validar Schema Semx")             // 12
   AADD(aACOES,"Validar Schema Sefaz RS")         // 13
   AADD(aACOES,"Validar Schema Tecno")            // 14
   AADD(aACOES,"Gerar e Abrir PDF")               // 15
   AADD(aACOES,"Gerar PDF")                        // 16
RETURN aACOES   
   

function nfeview(nTIPO,cID,cARQIMP,cDEST)
  System.Clipboard := cID
  
  
   if nTIPO=2 .OR. nTIPO=5
     alert("Opcao nao disponivel")
	 return
  endif	 

  
  //abrir pagina internet
  IF nTIPO=8
     abrirpagina("http://www.unimake.com.br/produtos/visualizador")
     return
  endif    
  IF nTIPO=9       
     if idcte(cID)
        abrirpagina("http://www.webdanfe.com.br/danfe/WebDacte.aspx")
     ELSE
        abrirpagina("https://www.webdanfe.com.br/danfe/index.html")
     ENDIF            
     return
  endif  
  IF nTIPO=10
     abrirpagina("http://www.leitorxml.com")
     return
  endif  
  IF nTIPO=11
     abrirpagina("http://www.danfeonline.com.br/")
     return
  endif  
  IF nTIPO=12
     abrirpagina("http://www.semx.com.br/")
     return
  endif     
  //outras acoes  
  IF ! EMPTY(cARQIMP)
     DO CASE
        CASE nTIPO=1 
            wapi_shellExecute(0,"open",cARQIMP)
       CASE nTIPO=3
			ShellExecute ( NIL, "Open", cDANFEVIEW+"danfeview.exe", cARQIMP, cDANFEVIEW, SW_SHOWNORMAL )
        CASE nTIPO=4
			ShellExecute ( NIL, "Open", cDANFEVIEW+"unidanfe.exe", "arquivo="+cARQIMP+" visualizar=1", cDANFEVIEW, SW_SHOWNORMAL )
       case nTIPO=6
            cDIR:=GETFOLDER()
            FILEcopy(carqimp,cDIR+"\"+cARQIMP)
       case nTIPO=7            
            enviaemail(cARQIMP,"NFE "+cID,cDEST)   
       case nTIPO=13
            System.Clipboard := HB_MEMOREAD(cARQIMP)
            if idcte(cID)
               abrirpagina("https://www.sefaz.rs.gov.br/CTE/CTE-VAL.aspx?")
            else
               abrirpagina("https://www.sefaz.rs.gov.br/nfe/nfe-val.aspx?")            
            endif   
       case nTIPO=14       
            System.Clipboard := HB_MEMOREAD(cARQIMP)
            abrirpagina("http://validadornfe.tecnospeed.com.br/")			
       case nTIPO=15
	        gerapdf(cARQIMP,,,.T.)
       case nTIPO=16       	   
 	        gerapdf(cARQIMP,,,.F.)
     ENDCASE 
  else
     msginfo("xml nao localizado")   
  ENDIF
RETURN


function gerapdf(cXmlDocumento,cXmlAuxiliar,cLogoFile,lOPEN)
LOCAL ctempfile
cTEMPFILE:=STRTRAN(UPPER(cXmlDocumento),".XML",".PDF")
IF VALTYPE(lOPEN)<>'L'
   lOPEN:=.F.
endif
IF File( cXmlDocumento )
    cXmlDocumento := MemoRead( cXmlDocumento )
ENDIF
IF cXmlAuxiliar != NIL
   IF File( cXmlAuxiliar )
      cXmlAuxiliar := MemoRead( cXmlAuxiliar )
   ENDIF
ENDIF
IF cLogoFile != NIL
    IF File( cLogoFile )
        cLogoFile := MemoRead( cLogoFile )
    ENDIF
ENDIF

oDanfe := hbNFeDaGeral():New()
oDanfe:cDesenvolvedor := "NFEXMLDANFE"
oDanfe:cLogoFile      := cLogoFile
oDanfe:ToPDF( cXmlDocumento, ctempfile, cXmlAuxiliar )
IF lOPEN
    PDFOpen( ctempfile)
ENDIF
return


FUNCTION PDFOpen( cFile )
 IF File( cFile )    
    WAPI_ShellExecute( NIL, "open", cFile, "",, )
    Inkey(1)
ENDIF
RETURN NIL



function abrirpagina(cAddress,cPORTAL,cID)
LOCAL lMAPA
lMAPA:=.F.
IF VALTYPE(cPORTAL)<>"C"
   cPORTAL:=""
ENDIF
 try
    oMapa := GetActiveObject( "InternetExplorer.Application" )
	lMAPA:=.t.
 catch
    try
      oMapa := CreateObject( "InternetExplorer.Application" )
	  lMAPA:=.t.
    catch
      try
        wapi_shellExecute(0,"open",cAddress)		
      catch
         Alert( "ERRO ! Internet Explorer nao disponivel")
      end   
    end
 end
 if lMAPA
	 oMapa:Visible := .T.
	 omapa:ToolBar := .f. // Desativa a barra de ferramentas
	 omapa:StatusBar := .f. // Desativa a barra de status
	 omapa:MenuBar := .f. // desativa a barra de menu
	 //omapa:FullScreen:=.t.

	 oMapa:Navigate( cAddress)
	 
	 WHILE oMAPA:Busy
		inkey(.5)
	 END
	 oMAPA := oMAPA:Document()    
ENDIF	 
return nil


function enviaemail(cARQ,cASSUNTO,cDEST,cMENSAGEM)
DO CASE 
   CASE AT(",",cDEST)>0
        aTO=HB_ATOKENS(cDEST,",")
   CASE AT(";",cDEST)>0
        aTO=HB_ATOKENS(cDEST,";")
   OTHERWISE
        aTo      :={cDEST}   
ENDCASE   
cCORPOMSG:=cASSUNTO
IF VALTYPE(cMENSAGEM)="C"
   cCORPOMSG:=cMENSAGEM
ENDIF   
IF VALTYPE(cARQ)="C"
   aARQEMAIL:={cARQ}
ENDIF
IF VALTYPE(aARQEMAIL)<>"A"
   aARQEMAIL:={}
ENDIF
TRY
  lVar:=HB_SendMail(cServerIP,nPort,cFrom,aTo,,,cCorpoMsg,cAssunto,aArqEmail,cUser,cPass,cPop,1,.F.,.F.,.T.)
catch 
  hb_memowrit("email"+ArqLogDataHora(),STRVAL(aTO))
  lVar:=.f.
END
return lVAR
