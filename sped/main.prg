#include <hmg.ch>
#include "adordd.ch"                           
#include "try.ch"

REQUEST HB_CODEPAGE_PTISO
REQUEST DBFCDX

//REQUEST HB_LANG_PT

Function Main

	HB_IDLESTATE()  
	Set( _SET_CODEPAGE, "PTISO" )
	rddsetdefault( "DBFCDX" )
	Set( _SET_OPTIMIZE, .t.)
	Set( _SET_DELETED, .t.)
	Set( _SET_SOFTSEEK, .t.)
	__SetCentury( .t. )
	Set( _SET_EPOCH, year( date() ) - 60 )
	Set( _SET_DATEFORMAT, "dd/mm/yyyy" )


	
   makedir('script')
   aCNPJITA:={"61381323000248","61381323000167","61381323000329","61381323000400","61381323000590"}
   
   cMEMORIZADOS:= PROFILESTRING( "SPED.INI","PATH","MEMORIZADOS")   
   cNFECNPJ    := PROFILESTRING( "SPED.INI","PATH","NFECNPJ")
   cLOGIX      := PROFILESTRING( "SPED.INI","PATH","LOGIX")   
   cLOGIXARQ   := PROFILESTRING( "SPED.INI","PATH","LOGIXARQ")         
   cESPIAOCNPJ  := PROFILESTRING( "SPED.INI","PATH","ESPIAOCNPJ")   
    
//    cNFE         := PROFILESTRING( "SPED.INI","PATH","NFE")

   

    Load Window main
//            ON KEY RETURN OF MAIN ACTION _SetNextFocus()
//        ON KEY ESCAPE OF MAIN ACTION ThisWindow.Release()

    Main.Center
    Main.Activate

Return

function GerarInovar()
dINI:=MAIN.DataIni.VALUE
dFIM:=MAIN.Datafim.VALUE
inovarlogix(dINI,dFIM)
return .t.

function mdt(cTEXTO)
main.label1.value:=cTEXTO
INKEY(1)
main.label1.value:=""
return .t.

function mds(cTEXTO)
main.label1.value:=cTEXTO
return .t.


function gravacert(aDADOS,lIE)
LOCAL nFIM
hb_default(@lIE,.F.)
aCAMPOS:={"CNPJ","IE","CCM","UF","CIDADE","RAZAO","ORI","CEP","DDD","SUFRAMA","CNAE","EMAIL","TELEFONE","PESSOA","BAIRRO","ENDERECO","NUMEND","COMPLEM","ENDTIP"}
nFIM:=LEN(aDADOS)
If at("/",aDADOS[1])=0
   aDADOS[1]:=FORMATaCNPJ(aDADOS[1])
endif
IF ! VALCGC(aDADOS[1],,.F.)
   return
endif
if aDADOS[4]="EX".OR.aDADOS[4]="XX"
   return
endif
dbselectar("SINTCERT")
dbgotop()
if ! dbseek(aDADOS[1])
   netrecapp()
   SINTCERT->CNPJ:=aDADOS[1]
ELSE
   netreclock()   
ENDIF   
FOR X=2 TO nFIM //13 //8 // 1 cnpj 14 pessoa nao gravam
   if x<>14
	 cCAMPO:=ACAMPOS[X]
	 IF EMPTY(&cCAMPO.).AND.! EMPTY(aDADOS[X])
		SINTCERT->&cCAMPO.:=aDADOS[X]
	 ENDIF
   endif		
NEXT X
IF left(SINTCERT->IE,5)="ISENT".AND.left(aDADOS[2],5)<>"ISENT".AND. ! EMPTY(aDADOS[2])         
    SINTCERT->IE:=aDADOS[2]
ENDIF
IF LEFT(aDADOS[3],5)<>"ISENT".AND.! EMPTY(aDADOS[3])
   IF LEFT(SINTCERT->CCM,5)="ISENT".OR.EMPTY(SINTCERT->CCM)
      SINTCERT->CCM:=aDADOS[3]
   ELSE
      nTAMCCM:=TamanhoCCM(SINTCERT->CIDADE,SINTCERT->UF)
      IF nTAMCCM>0      
         IF LEN(tiraout(ALLTRIM(SINTCERT->CCM)))<>nTAMCCM.AND.LEN(TIRAOUT(aDADOS[3]))=nTAMCCM
            SINTCERT->CCM:=aDADOS[3]                     
         ENDIF
      ENDIF   
   ENDIF    
ENDIF
IF SINTCERT->CIDADE<>aDADOS[5].AND.! EMPTY(aDADOS[5])
   SINTCERT->CIDADE:=aDADOS[5]
ENDIF
IF lIE .AND. SINTCERT->IE<>aDADOS[2]
   SINTCERT->IE:=aDADOS[2]
ENDIF
dbunlock()
return .t.


function tratanome(mNOME,lANSI,lACEN)
IF VALTYPE(lANSI)<>"L"
   lANSI:=.F.
ENDIF
IF VALTYPE(lACEN)<>"L"
   lACEN:=.F.
ENDIF
mNOME     := strtran( alltrim( mNOME ), "'", " " )    //tirar como d'agua d'olho
mNOME     := strtran( mNOME, "  ", " " )              //tirar os duplos espacos
mNOME     := strtran( mNOME, "-", " " )               //tirar os tracos
mNOME     := strtran( mNOME, "  ", " " )              //tirar os duplos espacos
mNOME     := strtran( mNOME, ".", " " )               //tirar os .
mNOME     := strtran( mNOME, ",", " " )               //tirar os ,
mNOME     := strtran( mNOME, "?", "C" )               //tirar os ?
mNOME     := strtran( mNOME, "?", "c" )               //tirar os ?
mNOME     := strtran( mNOME, "  ", " " )              //tirar os duplos espacos
IF lANSI
   mNOME     := win_ansitooem(mNOME)  //HB_ansitooem(mNOME)
ENDIF
IF lACEN
   mNOME     := TIRACE2(mNOME)
//   mNOME     := TIRACE(mNOME)
//   mNOME     := strtran( mNOME, "¶", "A" )
//   mNOME     := strtran( mNOME, "", "E" )
//   mNOME     := strtran( mNOME, "µ", "A" )
//   mNOME     := strtran( mNOME, "Ö", "I" )
//   mNOME     := strtran( mNOME, "µ", "A" )
//   mNOME     := strtran( mNOME, "à", "O" )
//   mNOME     := strtran( mNOME, "Ç", "A" )
//   mNOME     := strtran( mNOME, "â", "O" )
//   mNOME     := strtran( mNOME, "€", "C" )
//   mNOME     := strtran( mNOME, "é", "U" )
//   mNOME     := strtran( mNOME, "Ò", "E" )
//   mNOME     := strtran( mNOME, "å", "O" )
    //mNOME     := strtran( mNOME, "", "" )
ENDIF
mNOME     := ALLTRIM(UPPER(mNOME))
RETUrn mNOME

function pegcidconv(cUF,cNOME)
cDBF:=ALIAS()
IF EMPTY(cUF).OR.EMPTY(cNOME)
   return cNOME
ENDIF
dbselectar("cidconv")
dbgotop()
if dbseek(cUF+cNOME)
   cNOME:=CIDDES
ENDIF
DBSELECTAR(cDBF)
RETUrn cNOME


function gravasql(cARQ)
local oConn, oComm,  oErr
local cConn:="Provider=MSDASQL.1;Persist Security Info=False;Data Source=ol_logix"
local cCOMANDO:=""
cCOMANDO:=hb_memoread(cARQ)
if len(cCOMANDO)=0
   filedelete(cARQ)
   return .T.
endif
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
  main.release
end
IF filecopy(cARQ,HB_CWD()+"script\"+cARQ)>0
   filedelete(cARQ)
ENDIF   
return
