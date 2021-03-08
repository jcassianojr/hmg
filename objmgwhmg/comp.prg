#include "try.ch"
*+нннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннн
*+
*+    Function NNETWHOAMI()
*+
*+нннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннн
*+
function NNETWHOAMI()
LOCAL cUSER
cUSER:=HB_USERNAME()
IF EMPTY(cUSER)
   cUSER:=upper(GetEnv( "username" ))
   if empty(cUSER)
      cUSER:="USUARIO"
   endif
endif   
RETU cUSER

*+нннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннн
*+
*+    Function MDG()
*+
*+нннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннн
*+

function alert(cMES)
msginfo(cMES)
return .t.


*+нннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннн
*+
*+    Function MDG()
*+
*+нннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннннн
*+
function MDG( cMES, nOPT )
if valtype( nOPT ) = "N"
   nOPT := if( nOPT = 1, nOPT, 2 )
else
   nOPT := 2
endif
nOpT:=MSGYESNO(cMES,"Confirme Opcao",nOPT)
return nOPT  


****************************************
FUNCTION CheckEmail( cEmail )
*
* Purpose: validate an email addres for syntax
*

LOCAL lReturn := .f.
LOCAL cRegEx := "^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$"
LOCAL aCHAR  := {"@","/","?",".","-","=","+","<",">",";","'","[","]","\","|","`","~","!","#","$","%","^","&","*","(",")","_"}
LOCAL X

ZNERRO:=0
ZERRO:=""
cEMAIL:=ALLTRIM(cEMAIL)    

IF EMPTY(cEMAIL)
   ZNERRO:=1
   ZERRO:="Email Nao Preenchido"
ENDIF
    //lReturn := ( cAddress LIKE cRegEx ) .or. empty(cAddress)
    lRETURN:=HB_REGEXLIKE( cRegEx, cEMail ) .or. empty(cEMAIL)

if at("@",cEMAIL)=0    
   ZNERRO:=2
   ZERRO:="Email sem @"
   lReturn := .f.
endif

if NUMat("@",cEMAIL)>1
   ZNERRO:=3
   ZERRO:="Email com mais de 1 @"
   lReturn := .f.
endif

FOR X=1 TO LEN(aCHAR)  
   if LEFT(cEMAIL,1)=aCHAR[X]
      ZNERRO:=4      
      ZERRO:="Email sem Iniciando com "+Achar[x]
      lReturn := .f.
      exit
   endif  
   if right(cEMAIL,1)=aCHAR[X]
      ZNERRO:=5
      ZERRO:="Email sem encerrando com "+Achar[x]
      lReturn := .f.
      exit
   endif   
NEXT     

if at(".",right(cEMAIL,4))=0    
   ZNERRO:=6
   ZERRO:="tem que ter ponto . nos 4 ultimos digitos"
   lReturn := .f.
endif
    

RETURN  lReturn 


****************************************
*FUNCTION CheckEmail( cEmail )
*
* Purpose: validate an email addres for syntax
*
*    LOCAL lReturn := .f.
*    LOCAL cRegEx := "^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$"
*    //lReturn := ( cAddress LIKE cRegEx ) .or. empty(cAddress)
*    lRETURN:=HB_REGEXLIKE( cRegEx, RTrim(cEMail) ) .or. empty(cEMAIL)
*RETURN( lReturn )
* 

function preparaset()
set typeahead to 1000  // QTDE DE TECLAS LIBERADAS BUFFER
set wrap on            // HABILITA AS TECLAS DE SETAS P/SE MOVEREM
set deleted on         // IGNORAR OS REGISTROS DELETADOS (NAO MOSTRAR NA TELA)
set date BRITISH       // SISTEMA DE DATA BRITANICO [ EM PORTUGUES]
set softseek on        // QDO PROCURA UM REGISTRO VIA SEEK E NAO ACHA PARA NO PROXIMO
set exclusive OFF      // EM AMBIENTE DE REDE DIVERSOS USUARIOS
set exact OFF          // NIVEL DE COMPARACAO PARCIAL
set cursor on          // HABILITA O CURSOR A APARECER
set epoch to year( date() ) - 60
set century on
return .t.

function ArqLogDataHora(cEXT)
IF VALTYPE(cEXT)<>"C"
   cEXT:=".log"
ELSE
   cEXT:="."+cEXT
ENDIF
return HB_TTOS(HB_DATETIME())+cEXT
//return dtos(date())+strtran(time(),":","")+cEXT


function rmacro(eBLOCO,ePAD,lMES)
IF VALTYPE(lMES)#"L"
   lMES:=.F.
ENDIF
eRETU:=ePAD
TRY
    eRETU:=eVAL(eBLOCO)   
CATCH oERROR
    ALERT(HB_VALTOEXP(eBLOCO))
END
RETURN eRETU




