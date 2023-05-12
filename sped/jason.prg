rEQUEST HB_CODEPAGE_PTISO
REQUEST DBFCDX

function main()

HB_IDLESTATE()

Set( _SET_CODEPAGE, "PTISO")    
	
setmode(25,80)	
cls

//hb_Alert( "teste", , , 2 )

	
rddsetdefault( "DBFCDX" )
Set( _SET_OPTIMIZE, .t.)
Set( _SET_DELETED, .t.)
Set( _SET_SOFTSEEK, .t.)
__SetCentury( .t. )
Set( _SET_EPOCH, year( date() ) - 60 )
Set( _SET_DATEFORMAT, "dd/mm/yyyy" )


//JASONCSV("estados.json")           //so necessario importar caso haja criacao de um novo estado
//JASONCSV("sefazcnae.json")          //tamanhos campos  6,80  cnae antigo 6 digitos nao importando

JASONCSV("sefazanpprod.json")       //tamanhos campos 9,91   anp produtos                      agencia nacional do petroleo
JASONCSV("sefazanpprounidade.json") //tamanhos campos 9,2,39 anp produtos unidade de medida    agencia nacional do petroleo
JASONCSV("sefazcest.json")          //tamanhos campos 7,8,255  cest
JASONCSV("sefazcestporta.json")     //tamanhos campos 7,8,255  cest porta
JASONCSV("sefazcfop.json")          //tamanhos campos 5,253,1,1,1,1
JASONCSV("sefazcidade.json")         //tamanhos campos 2,7,30
JASONCSV("sefazcorrecao.json")      //tamanhos campos nao geraou
JASONCSV("sefazicmcst.json")        //tamanhos campos 3,45
JASONCSV("sefazindpres.json")       //tamanhos campos 1,43
JASONCSV("sefazipicst.json")         //tamanhos campos 1,35
JASONCSV("sefazipienq.json")          //tamanhos campos 3,516
JASONCSV("sefazmodbc.json")         //tamanhos campos 1,26
JASONCSV("sefazmodbcst.json")       //tamanhos campos 
JASONCSV("sefazmodfis.json","sintdoc")        //tamanhos campos 2,45 modelo fiscal
JASONCSV("sefazmodfrete.json")          //tamanhos campos   1,52 modelo frete
JASONCSV("sefazncmexterior.json")        //tamanhos campos   8,6 unidade de medidao exportacao ncm
JASONCSV("sefaznfestatus.json")         //tamanhos campos   7,154
JASONCSV("sefazorigem.json")        //tamanhos campos  1,107 origem
JASONCSV("sefazpiscst.json")        //tamanhos campos  2,75
JASONCSV("sefazpisenq.json")        //tamanhos campos  
JASONCSV("sefazqualificacao.json") //tamanhos campos   3,67
JASONCSV("sefaztband.json")         //tamanhos campos
JASONCSV("sefaztpag.json")          //tamanhos campos
JASONCSV("sefazunidade.json")    //tamanhos campos6,14


FUNCTION JASONCSV(cARQJSON,cARQDBF)
LOCAL cJsonString
LOCAL cDESTINO
LOCAL eVALOR
LOCAL Z
LOCAL aVALOR
LOCAL nFILEGRV
local nodos
local hdata
local ldbf

ldbf:=.f.

IF ! FILE(cARQJSON)
   RETURN .F.
ENDIF

IF VALTYPE(cARQDBF)="C"
   if file(cARQDBF+".dbf")
      dbusearea( .T., "DBFCDX", cARQDBF,, .T. )
      if file(cARQDBF+".cdx")
         ordlistadd( cARQDBF)
         dbsetorder(1) //
      endif 
      ldbf:=.t.  
   ENDIF
endif

cJsonString:=HB_MEMOREAD(cARQJSON)
hData := hb_jsonDecode( cJsonString )
cDESTINO:=strtran(LOWER(cARQJSON),".json",".csv")
nFILEGRV:=FCREATE(cDESTINO)


for each nodos in hDATA
    eVALOR:=HB_VALTOEXP(nodos)
//    Fwrite(nFilegrv,eVALOR+hb_osnewline())
    eVALOR:=STRTRAN(eVALOR,"{","")
    eVALOR:=STRTRAN(eVALOR,"}","")
    eVALOR:=STRTRAN(eVALOR,", ","|")
    eVALOR:=TIRACE2(eVALOR)
    
    
    Fwrite(nFilegrv,eVALOR+hb_osnewline())
    
    
    
    aVALOR:=HB_ATokens(eVALOR,"|")
    
    if len(aVALOR)>0 .and. lDBF
       eBUSCA :=STRTRAN(aVALOR[1],'"',"")
       mCODIGO:=STRTRAN(aVALOR[1],'"',"")
       mNOME  :=STRTRAN(aVALOR[2],'"',"")
       altd()
       dbgotop()
       if ! dbseek(eBUSCA)
          dbappend()
          field->codigo:=mCODIGO
       endif
       IF EMPTY(field->nome) .and. ! empty(mNOME)
          field->nome:=mNOME
       ENDIF
       
    ENDIF
    
 //   FOR Z = 1 TO LEN(avaLOR)
 //      Fwrite(nFilegrv,avalor[z]+hb_osnewline())
  //  NEXT Z   
next

fclose(nfilegrv)

IF VALTYPE(cARQDBF)="C"
   dbcloseall()
ENDIF
RETURN .T.

fUNCTION tirace2( cXml )

   LOCAL nCont, cRemoveTag, cLetra, nPos, lTroca, nAscii

   cRemoveTag := { ;
      [<?xml version="1.0" encoding="utf-8"?>], ; // Petrobras inventou de usar assim
      [<?xml version="1.0" encoding="ISO-8859-1"?>], ; // Petrobras agora assim
      [<?xml version="1.0" encoding="UTF-8"?>], ; // o mais correto
      [<?xml version="1.00"?>], ;
      [<?xml version="1.0"?>] }

   FOR nCont = 1 TO Len( cRemoveTag )
      cXml := StrTran( cXml, cRemoveTag[ nCont ], "" )
   NEXT
   IF ! ["] $ cXml // Pode ser usado aspas simples
      cXml := StrTran( cXml, ['], ["] )
   ENDIF
   IF Chr(195) $ cXml
      nPos := At( Chr(195), cXml )
      IF Asc( Substr( cXml, nPos + 1 ) ) > 122
         cXml := hb_Utf8ToStr( cXml )
      ENDIF
   ENDIF
   FOR nCont = 1 TO 2
      cXml := StrTran( cXml, Chr(26), "" )
      cXml := StrTran( cXml, Chr(13), "" )
      cXml := StrTran( cXml, Chr(10), "" )
      IF Substr( cXml, 1, 1 ) $ Chr(239) + Chr(187) + Chr(191)
         cXml := Substr( cXml, 2 )
      ENDIF
      cXml := StrTran( cXml, " />", "/>" )
      cXml := StrTran( cXml, Chr(195) + Chr(173), "i" )              
      cXml := StrTran( cXml, Chr(195) + Chr(135), "C" )
      cXml := StrTran( cXml, Chr(195) + Chr(141), "I" )
      cXml := StrTran( cXml, Chr(195) + Chr(163), "a" )
      cXml := StrTran( cXml, Chr(195) + Chr(167), "c" )
      cXml := StrTran( cXml, Chr(195) + Chr(161), "a" )
      cXml := StrTran( cXml, Chr(195) + Chr(131), "A" )
      cXml := StrTran( cXml, Chr(194) + Chr(186), "o." )
      cxml := StrTran( cxml, Chr(195) + Chr(162), "a" )
      cxml := StrTran( cxml, Chr(195) + Chr(161), "a" )
      cxml := StrTran( cxml, Chr(195) + Chr(163), "a" )
      cxml := StrTran( cxml, Chr(195) + Chr(173), "i" )
      cxml := StrTran( cxml, Chr(195) + Chr(179), "o" )
      cxml := StrTran( cxml, Chr(195) + Chr(167), "c" )
      cxml := StrTran( cxml, Chr(195) + Chr(169), "e" )
      cxml := StrTran( cxml, Chr(195) + Chr(170), "e" )
      cxml := StrTran( cxml, Chr(195) + Chr(181), "o" )
      cxml := StrTran( cxml, Chr(195) + Chr(160), "o" )
      cxml := StrTran( cxml, Chr(195) + Chr(181), "o" )
      cxml := StrTran( cxml, Chr(195) + Chr(129), "A" )
      cxml := StrTran( cxml, Chr(226) + Chr(128) + Chr(156), [*] ) // aspas de destaque "cames"
      cxml := StrTran( cxml, Chr(226) + Chr(128) + Chr(157), [*] ) // aspas de destaque "cames"
      cxml := StrTran( cxml, Chr(195) + Chr(180), "o" )
      cxml := StrTran( cxml, Chr(195) + Chr(186), "u" )
      cxml := StrTran( cxml, Chr(195) + Chr(147), "O" )
      cxml := StrTran( cxml, Chr(226) + Chr(128) + Chr(153), [ ] ) // caixa d'agua
      cxml := StrTran( cxml, Chr(226) + Chr(128) + Chr(147), [-] ) // - mesmo
      cxml := StrTran( cxml, Chr(194) + Chr(179), [3] ) // m3
      // so pra corrigir no MySql
      cXml := StrTran( cXml, "+" + Chr(129), "A" ) 
      cXml := StrTran( cXml, "+" + Chr(137), "E" )
      cXml := StrTran( cXml, "+" + Chr(131), "A" )
      cXml := StrTran( cXml, "+" + Chr(135), "C" )
      cXml := StrTran( cXml, "?" + Chr(167), "c" )
      cXml := StrTran( cXml, "?" + Chr(163), "a" )
      cXml := StrTran( cXml, "?" + Chr(173), "i" )
      cXml := StrTran( cXml, "?" + Chr(131), "A" )
      cXml := StrTran( cXml, "?" + Chr(161), "a" )
      cXml := StrTran( cXml, "?" + Chr(141), "I" )
      cXml := StrTran( cXml, "?" + Chr(135), "C" )
      cXml := StrTran( cXml, Chr(195) + Chr(156), "a" )
      cXml := StrTran( cXml, Chr(195) + Chr(159), "A" )
      cXml := StrTran( cXml, "?" + Chr(129), "A" )
      cXml := StrTran( cXml, "?" + Chr(137), "E" )
      cXml := StrTran( cXml, Chr(195) + "?", "C" )
      cXml := StrTran( cXml, "?" + Chr(149), "O" )
      cXml := StrTran( cXml, "?" + Chr(154), "U" )
      cXml := StrTran( cXml, "+" + Chr(170), "o" )
      cXml := StrTran( cXml, "?" + Chr(128), "A" )
      cXml := StrTran( cXml, Chr(195) + Chr(166), "e" )
      cXml := StrTran( cXml, Chr(135) + Chr(227), "ca" )
      cXml := StrTran( cXml, "n" + Chr(227), "na" )
      cXml := StrTran( cXml, Chr(162), "o" )
      cXml := StrTran( cXml, " " + Chr(241) + " ", " " )
      cXml := StrTran( cXml, Chr(176), "" ) // graus
      cXml := StrTran( cXml, Chr(186), "o" ) // numero	  
	  cXml := StrTran( cXml, Chr(220), "U" ) // u com trema
	  cXml := StrTran( cXml, Chr(170), "" ) // desconhecido
   NEXT
   FOR nCont = 1 TO Len( cXml )
      cLetra := Substr( cXml, nCont, 1 )
      nAscii := Asc( cLetra )
      lTroca := .T.
      DO CASE
      CASE cLetra $ "abcdefghijklmnopqrstuvwxyz"; lTroca := .F.
      CASE cLetra $ "ABCDEFGHIJKLMNOPQRSTUVWXYZ"; lTroca := .F.
      CASE cLetra $ "01234567889"; lTroca := .F.
      CASE cLetra $ ",.:/;%*$@?<>()+-#=:_" + Chr(34) + Chr(32); lTroca := .F.
      CASE nAscii == 231; cLetra := "c"
      CASE nAscii == 199; cLetra := "C"
      CASE AScan( { 193, 194, 195, 192 }, nAscii ) != 0 ; cLetra := "A"
      CASE AScan( { 224, 225, 226, 227, 228, 229 }, nAscii ) != 0 ; cLetra := "a"
      CASE AScan( { 242, 243, 244, 245, 246 }, nAscii ) != 0 ; cLetra := "o"
      CASE AScan( { 210, 211, 212, 213, 214 }, nAscii ) != 0 ; cLetra := "O"
      CASE AScan( { 200, 201, 202, 203 }, nAscii ) != 0 ; cLetra := "E"
      CASE AScan( { 232, 233, 234, 235 }, nAscii ) != 0 ; cLetra := "e"
      CASE AScan( { 236, 237, 238, 239 }, nAscii ) != 0 ; cLetra := "i"
      CASE AScan( { 204, 205, 206, 207 }, nAscii ) != 0 ; cLetra := "I"
      CASE AScan( { 249, 250, 251, 252 }, nAscii ) != 0 ; cLetra := "u" 
      CASE AScan( { 217, 218, 219 }, nAscii ) != 0 ; cLetra := "U"
      CASE nAscii == 128 ; cLetra := "C" // experimental  
      CASE nAscii == 144 ; cLetra := "E" // experimental
      CASE nAscii == 248 ; cLetra := "" // experimental
      CASE nAscii == 167 ; cLetra := "o" // experimental
      ENDCASE
      IF lTroca
         cXml := Substr( cXml, 1, nCont - 1 ) + cLetra + Substr( cXml, nCont + 1 )
      ENDIF
   NEXT

   RETURN cXml
   
   function GetJson(cJson)
    Local xReturn := hb_jsonDecode( cJson )

    If !( ValType( xReturn ) $ 'HA' )
        xReturn := Nil
    Endif

return ( xReturn )



function IsJsonValid(cJson)
return ( GetJson(cJson) != Nil .and. ;
        Len( GetJson(cJson) ) != 0 )

