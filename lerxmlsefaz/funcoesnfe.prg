//          1         2         3         4   
//          1         2         3         4   
// 12345678901234567890123456789012345678901234
// UFAAMMCNPJ          MOSERNNNNNNNNNERRRRRRRRD  
//       12345678901234     123456789 
// 35130176487032000206550200001605581155906110
//
//  codigo do estado do emitente (02 digitos)       SUBSTR(ID,1,2)
//  ano e mes da emissao da NF-e (no formato AAMM)  SUBSTR(ID,3,2) SUBSTR(ID,5,2)
//  CNPJ do emitente da NF-e (CNPJ da sua Empresa)  SUBSTR(ID,7,14)
//  modelo da NF-e (02 digito)                      SUBSTR(ID,21,2)
//  serie da NF-e (03 digito) alltrim(str(val(SUBsTR(ID,23,3))))
//  numero da NF-e (09 digito) alltrim(str(val(SUBsTR(ID,26,9))))  (27,8) caso sistema nao aceitar nove digitos
//  forma de emissao da NFe (01 digito) SUBSTR(ID,35,1)
//  codigo da NF-e (08 digito) numero gerado pelo sistema SUBSTR(ID,36,8)
//  digito verificador - DV (calculo modulo 11). (substr(44,1)


function EmissaoAno(cEMISSAO)
return substr(cemissao,1,4)

function EmissaoMes(cEMISSAO)
return substr(cemissao,6,2)                  

function EmissaoData(cEMISSAO)
return STOD(STRTRAN(cEMISSAO,"-",""))

function IdNFF(cID) //8 digitos
return alltrim(str(val(SUBsTR(cID,27,8))))   

function IdNFF9(cID) //9 digitos
return alltrim(str(val(SUBsTR(cID,26,9))))   

function IdModelo(cID)
return SUBSTR(cID,21,2)

function Idufnum(cID)
return SUBSTR(cID,1,2)


function IdufUF(cID)
return coduf(SUBSTR(cID,1,2))

function IdcnPj(cID)
return SUBSTR(cID,7,14)

function idCte(cID)
return IdModelo(cID)='57'

function idCteos(cID)
return IdModelo(cID)='67'


function idnfe(cID)
return IdModelo(cID)='55'

function IdEmissor(cID)
return SUBSTR(cID,7,14)

function idSerie(cID)
return alltrim(str(val(SUBsTR(cID,23,3))))

function idAno(cid)
return SubStr(cid,3,2)

function idmes(Cid)
return SubStr(cid,5,2)

function iddizer(cID)
return "Estado:"+Idufuf(cID)+" MES/ANO:"+idmes(Cid)+"/"+idAno(cid)+" CNPJ:"+IdcnPj(cID) +" Numero" + IdNFF9(cID) +" Modelo:" + IdModelo(cID) + " Serie:" +idSerie(cID)


function idformatada(cID)
RETURN TRANSFORM(cID,"@R 99-99/99-99.999.999/9999-99.99.999.999999999.9.99999999.9")


function idformatauf(cID)
local cUF
cUF:=IdufUF(cID)
cID:=substr(cID,3)
RETURN cUF+"-"+TRANSFORM(cID,"@R 99/99-99.999.999/9999-99.99.999.999999999.9.99999999.9")


function idModeloTipo(cID)
LOCAL cMODELO
cMODELO:=IdModelo(cID)
DO CASE
   CASE cMODELO="55"
         cMODELO="NFE"
   CASE cMODELO="57"
         cMODELO="CTE"
   CASE cMODELO="67"
         cMODELO="CTE-OS"
   CASE cMODELO="65"
         cMODELO="NFCe"
endcase
return cMODELO

function idModeloTF(cID)
LOCAL cMODELO
cMODELO:=IdModelo(cID)
DO CASE
   CASE cMODELO="55"
         cMODELO="procNFe"
   CASE cMODELO="57"
         cMODELO="procCTe"
   CASE cMODELO="67"
         cMODELO="procCTe OS"
   CASE cMODELO="65"
         cMODELO="procNFCe"
endcase
return cMODELO

function idModeloCF(cID)
LOCAL cMODELO
cMODELO:=IdModelo(cID)
DO CASE
   CASE cMODELO="55"
         cMODELO="NF-e"
   CASE cMODELO="57"
         cMODELO="CT-e"
   CASE cMODELO="67"
         cMODELO="CT-e OS"
   CASE cMODELO="65"
         cMODELO="NFC-e"
endcase
return cMODELO


function PegCamXml(cID,cCNPJEmit,cCNPJDEST,cANO,cMES)
LOCAL cARQIMP :=""
LOCAL cARQBUS :=""
LOCAL aCNPJBUS
LOCAL aCAMARQ
aCNPJBUS:=aCNPJITA //cnpj matriz filial
IF EMPTY(cCNPJEmit)
  cCNPJEmit:=IDEMISSOR(cID)
ENDIF
IF ! EMPTY(cCNPJEmit) .AND. ASCAN(aCNPJITA,cCNPJEmit)=0
   AADD(aCNPJBUS,cCNPJEmit)
ENDIF
IF ! EMPTY(cCNPJDEST) .AND. ASCAN(aCNPJITA,cCNPJDesT)=0
   AADD(aCNPJBUS,cCNPJDEST)
ENDIF
AADD(aCNPJBUS,"99999999999999") //importacao exportacao
AADD(aCNPJBUS,"DestinatarioDesconhecido")  //importacao exportacao danfeview
IF EMPTY(cANO) .OR. EMPTY(CMES) .OR. val(cANO)=0 .OR. val(cMES)=0
   cANO  := "20"+idano(cID)
   cMES  := idmes(cID)
ENDIF
IF EMPTY(cANO) .OR. EMPTY(CMES) .OR. val(cANO)=0 .OR. val(cMES)=0
   cANO  := strzero(year(date()),4,0)
   cMES  := strzero(month(date()),2,0)
ENDIF

aCAMARQ:= {cLOGIX,cLOGIX2,cLOGIX3,cLOGIX4,cNFECNPJ, cLOGIXARQ}
//            1       2         3     4        5          6
			
aadd(aCAMARQ,cmemorizados+'EmitidosPorMim\61381323000167\')		// 7
aadd(aCAMARQ,cmemorizados+'EmitidosPorMim\61381323000248\')		// 8
aadd(aCAMARQ,cmemorizados+'EmitidosPorMim\61381323000329\')		// 9
aadd(aCAMARQ,cmemorizados+'EmitidosPorMim\61381323000400\')		// 10
aadd(aCAMARQ,cmemorizados+'EmitidosPorMim\61381323000590\')		// 11

aadd(aCAMARQ,cmemorizados+'Recebidos\XTIPOX\61381323000167\')	// 12 
aadd(aCAMARQ,cmemorizados+'Recebidos\XTIPOX\61381323000248\')	// 13
aadd(aCAMARQ,cmemorizados+'Recebidos\XTIPOX\61381323000329\')	// 14
aadd(aCAMARQ,cmemorizados+'Recebidos\XTIPOX\61381323000400\')	// 15
aadd(aCAMARQ,cmemorizados+'Recebidos\XTIPOX\61381323000590\')	// 16

aadd(aCAMARQ,cmemorizados+'cSLFProfile\61381323000167\')			// 17
aadd(aCAMARQ,cmemorizados+'cSLFProfile\61381323000248\')			// 18
aadd(aCAMARQ,cmemorizados+'cSLFProfile\61381323000329\')			// 19
aadd(aCAMARQ,cmemorizados+'cSLFProfile\61381323000400\')			// 20
aadd(aCAMARQ,cmemorizados+'cSLFProfile\61381323000590\')			// 21


FOR ZK=1 TO LEN(aCAMARQ)      
    IF EMPTY(cARQIMP)
	    DO CASE
       	   case	ZK=1 .OR. ZK=2 .OR. ZK=3 .OR. ZK=4  
	            cFIMXML:=cid+"-nfe_vis.xml"		   
		   case	ZK=5 .or. ZK=6
		        cFIMXML:=idModeloTipo(cID)+cid+".xml"
           case	ZK=7 .OR. ZK=8 .OR. ZK=9 .OR. ZK=10 .OR. ZK=11
				cFIMXML:=cid+"-"+idModeloTF(cID)+".xml"
           case	ZK=12 .OR. ZK=13 .OR. ZK=14 .OR. ZK=15 .OR. ZK=16
				cFIMXML:=cid+"-"+idModeloTF(cID)+".xml"
		   case	ZK=17 .or. ZK=18 .or. ZK=19 .or. ZK=20  .or. ZK=21
		        cFIMXML:=idModeloTipo(cID)+cid+".xml"
        ENDCASE 	   	
       FOR ZL=1 TO LEN(aCNPJBUS) 
           IF EMPTY(cARQIMP)
		      do case
  			     case ZK=1 .OR. ZK=2 .OR. ZK=3 .OR. ZK=4 
			         cARQBUS:=aCAMARQ[ZK]+cFIMXML
				 case ZK=12 .OR. ZK=13 .OR. ZK=14 .OR. ZK=15 .OR. ZK=16	 
				      cARQBUS:=aCAMARQ[ZK]+aCNPJBUS[ZL]+"\"+cANO+"\"+cMES+"\"+cFIMXML
					  cARQBUS:=STRTRAN(cARQBUS,'XTIPOX',idModeloCF(cID))
			     otherwise
                     cARQBUS:=aCAMARQ[ZK]+aCNPJBUS[ZL]+"\"+cANO+"\"+cMES+"\"+cFIMXML
			  endcase		  
              if file(cARQBUS)  
                 cARQIMP:=cARQBUS              
                 exit
              endif
           ENDIF     
       NEXT ZL
    ENDIF    
NEXT ZK   
return cARQIMP

Function Pegacadastro(cTextoCad)
   XCNPJ    := PegaDados( 'CNPJ'  ,Alltrim(cTextoCad))
   xNome    := PegaDados( 'xNome' ,Alltrim(cTextoCad) )
   xFant    := PegaDados( 'xFANT' ,Alltrim(cTextoCad) )
   xLgr     := PegaDados( 'xLgr'  ,Alltrim(cTextoCad) )
   xCpl     := PegaDados( 'xcpl'  ,Alltrim(cTextoCad) )
   Xnro     := PegaDados( 'nro'  ,Alltrim(cTextoCad) )
   xBairro  := PegaDados( 'xBairro' ,Alltrim(cTextoCad))
   CMun     := PegaDados( 'cMun'  ,Alltrim(cTextoCad) )
   xMun     := PegaDados( 'xMun'  ,Alltrim(cTextoCad))
   XUF      := PegaDados( 'UF'   ,Alltrim(cTextoCad))
   XCEP     := PegaDados( 'CEP'  ,Alltrim(cTextoCad))
   CPais    := PegaDados( 'cPais' ,Alltrim(cTextoCad))
   xPais    := PegaDados( 'xPais' ,Alltrim(cTextoCad))
   Xfone    := PegaDados( 'fone'  ,Alltrim(cTextoCad))
   XIE      := PegaDados( 'IE'   ,Alltrim(cTextoCad) )
   XIEST    := PegaDados( 'IEST'   ,Alltrim(cTextoCad) )
   XISUF    := PegaDados( 'ISUF'   ,Alltrim(cTextoCad) )
   Xemail   := PegaDados( 'email'   ,Alltrim(cTextoCad) )
   XIm     := PegaDados( 'IM'   ,Alltrim(cTextoCad) )
   XCNAE   := PegaDados( 'cnae'   ,Alltrim(cTextoCad) )
   XCPF    := PegaDados( 'CPF'  ,Alltrim(cTextoCad) )      
   
   if xcnpj="00000000000000" //algumas exportacao estao trazendo 00000000000000
      XCNPJ="0"
   endif
   
   IF (XCNPJ="0" .or. empty(XCNPJ)) .and. len(ALLTRIM(XCNPJ))<=1 .AND. XUF="EX"      
      XCNPJ    := "99999999999999"
   ENDIF   
   IF (XCNPJ="0" .or. empty(XCNPJ)) .and. len(ALLTRIM(XCNPJ))<=1 .AND. len(ALLTRIM(XCPF))>1            
      XCNPJ    := XCPF
   ENDIF   
return 

Function PegaDados(cProc, cLinha, cPADRAO, cTexto2)
 Local InicioDoDado 
 Local FinalDoDado 
 Local nPosIni   
 Local nPosFim
 Local cRet    := '0' //'0'
 LOCAL aFrom
 LOCAL aTo
 LOCAL nI

 IF VALTYPE(cPADRAO)<>'U'
    cRET:=cPADRAO
 ENDIF
 
 cPROC:=UPPER(cPROC)
 cLINHA:=UPPER(cLINHA)
 IF cTEXTO2==nil
 ELSE
    cTEXTO2=UPPER(cTEXTO2)
 ENDIF   
 
 InicioDoDado := Iif(cTexto2==Nil,"<"+cProc+">" , "<"+cProc )
 FinalDoDado := Iif(cTexto2==Nil,"</"+cProc+">",'</'+cTexto2+'>')
 nPosIni   := At(InicioDoDado,cLinha)
 nPosFim   := At(FinalDoDado,cLinha)
 
 If nPosIni==0 .or. nPosFim==0  //tenta sem a chave final
	InicioDoDado := Iif(cTexto2==Nil,"<"+cProc , "<"+cProc )
	FinalDoDado := Iif(cTexto2==Nil,"</"+cProc,'</'+cTexto2+'>')
	nPosIni   := At(InicioDoDado,cLinha)
	nPosFim   := At(FinalDoDado,cLinha) 
 ENDIF
 

 If nPosIni==0 .or. nPosFim==0
   Return cRet
 Endif
 cRet := Substr(cLinha,nPosIni+Len(IniciodoDado),nPosFim-nPosIni-Len(FinalDoDado)+1)
 cRET:=STRTRAN(cRET,CHR(13),"")
 cRET:=STRTRAN(cRET,CHR(10),"") 
 aTo := { '&', '"', "'", '<', '>', 'º', 'ª' }
 aFrom := { '&amp;', '&quot;', '&#39;', '&lt;', '&gt;', '&#176;', '&#170;' }
 FOR nI=1 TO LEN(aFrom)
    cRet := STRTRAN( cRET, aFrom[nI], aTo[nI] )
 NEXT
 
Return ( cRet)



