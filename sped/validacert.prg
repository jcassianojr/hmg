function validacert()
cCAMINHO   := PROFILESTRING( "sped.ini","SINTCERT.DBF","CAMINHO",HB_CWD())+"SINTCERT"
IF ! NETUSE(cCAMINHO,"DBFCDX")
   dbcloseall()
   return
endif
cCAMINHO   := PROFILESTRING( "sped.ini","CCMSP.DBF","CAMINHO",HB_CWD())+"CCMSP"
IF ! NETUSE(cCAMINHO,"DBFCDX")
   dbcloseall()
   return
endif
cCAMINHO   := PROFILESTRING( "sped.ini","MD10.DBF","CAMINHO",HB_CWD())+"MD10"
IF ! NETUSE(cCAMINHO)
   DBCLOSEALL()
   RETURN
ENDIF
cCAMINHO   := PROFILESTRING( "sped.ini","CNPJXML.DBF","CAMINHO",HB_CWD())+"CNPJXML"
IF ! NETUSE(cCAMINHO,"DBFCDX")
   dbcloseall()
   return
endif


//inicia as variaveis
ZNERRO:=0
ZERRO:=""

   /*
   --01-ie             
   --02-cnpj           
   --03-ie<>cnpj<>cnpjxml
   --04-cnpj<>ie<>cnpjxml
   --05-prefixo ie md10 3dig
   --06-habilita cnpjuf
   --07-qtde digitos ie  ja no valie
   --08-cep uf             
   --09-ddd->md10
   --10-cidades->MD10
   --11-cep faixas->md10
   --12-email            
   --13-ddd prefixo
   --14-cidade<>cnpjuf??
   --15-razaosocial<>cnpjuf?? suframa
   --16-suframa<>cnpjufsu suframa<>cnpjxml
   --17-cnae<>cnpjuf cnae<>cnpjxml
   --18-ccm<>cnpjxml   
   */
   
   
   
   lCNPJIE:=.T.
   lIECNPJ:=.T.
   lCNPJCID:=.T.
   lCNPJCNAE:=.F.
   lCNPJNOME:=.F.
   lCNPJHAB:=.T.
   lSUFRAMA :=.F.
   lCCMXML:=.T.
   lSUFXML:=.T.
   lCCM:=.T.
   lCCMCAD:=.F.
   lDDD:=.F.
   lIEB:=.F.
   lIE :=.F.
   lCNPJ:=.T.
   lCEPUF:=.F.
   lEMAIL:=.F.
   l3DIG :=.T.
   lCEPCID:=.F.
   lCID:=.T.
   lCCMIE:=.T.


nHANDLE:=FCREATE("validacert.txt")
dbselectarea("SINTCERT")
set filter to .not. empty(UF)
dbgotop()
while ! eof()
   cCIDADE := SINTCERT->CIDADE
   cUF     := SINTCERT->UF
   cIE     := SINTCERT->IE
   cIET    := ALLTRIM(TIRAOUT(SINTCERT->IE))
   cCCM    := SINTCERT->CCM
   cCCMT   := ALLTRIM(TIRAOUT(SINTCERT->CCM))
   cCNPJ   := SINTCERT->CNPJ
   cCNPJT  := ALLTRIM(TIRAOUT(SINTCERT->CNPJ))
   cCEP    := SINTCERT->CEP
   cEMAIL  := sintcert->email
   cDDD    := SINTCERT->DDD
   cNOME   := ALLTRIM(TIRAOUT(SINTCERT->RAZAO))
   cCNAE   := ALLTRIM(TIRAOUT(SINTCERT->CNAE))
   cSUFRAMA:= ALLTRIM(TIRAOUT(SINTCERT->SUFRAMA))   
   
   
   
   
   lLIMPAIE :=.f.
   lLIMPACCM:=.f.
   lLIMPACEP:=.F.
   lLIMPACID:=.F.
   lLIMPAEMAIL:=.F.
  
   mds(cCNPJ)
   
   
   IF lCCMIE
      IF cCCMT=cIET.AND.! EMPTY(cCCMT).AND.! EMPTY(cIET)
         fwrite(nhandle,cCNPJT+" "+cIET+" Inscricao Estadual=Municipal"+HB_OsNewLine())   
         lLIMPAIE:=.t.
         lLIMPACCM:=.t.         
      ENDIF
   ENDIF
   IF lCCM
      nLENCCM:=LEN(cCCMT)
      IF lCCMCAD
         IF cUF="SP".AND.cCIDADE="SAO PAULO".AND.(EMPTY(cCCM).OR.left(cCCM,5)="ISENT")
            dbselectarea("CCMSP")
            dbgotop()
            if dbseek(cCNPJT)                     
               fwrite(nhandle,cCNPJT+" Inscricao Municipal Sao Paulo Nao Preenchida"+HB_OsNewLine())            
            ENDIF   
         endif 
      endif
      IF ! EMPTY(cCCM) .AND. LEFT(cCCM,5)<>"ISENT"         
         nTAMCCM:=TamanhoCCM(cCIDADE,cUF)
         IF nTAMCCM>0.AND.nTAMCCM<>nLENCCM
            fwrite(nhandle,cCNPJT+"/"+cCCM+" Inscricao Municipal "+cUF+"-"+cCIDADE+" <>"+STR(nTAMCCM,2)+" Digitos"+HB_OsNewLine())
            lLIMPACCM:=.t.         
         ENDIF   
      ENDIF       
   ENDIF
   IF lCNPJ
      if ! vALCGC( cCNPJT,  ,.F.,cUF)
          fwrite(nhandle,cCNPJT+" "+ZERRO+HB_OsNewLine())
      endif       
   ENDIF   
   IF lIE   
      IF EMPTY(cIE).AND.! lIEB   
      ELSE         
         if ! ValIE( cIE, cUF, ,.F.,.T.)  
             fwrite(nhandle,cCNPJT+" "+cIE+" "+cUF+" "+ZERRO+HB_OsNewLine())
             lLIMPAIE:=.t.
         endif   
      endif   
   ENDIF   
   IF lCEPUF
      IF ! chkufcep(cCEP,cUF,.F.)
         fwrite(nhandle,cCNPJT+" "+cUF+" "+cCIDADE+" "+cCEP+" Cep nao e do estado"+HB_OsNewLine())
         lLIMPACEP:=.T.
      endif    
   ENDIF   
   IF lEMAIL
      IF ! EMPTY(Cemail)   
         if ! CheckEmail( Cemail)
             fwrite(nhandle,cCNPJT+" "+cEMAIL+" Email invalido"+HB_OsNewLine())
             lLIMPAEMAIL:=.T.
         endif
      endif
   ENDIF
   dbselectar("MD10")
   dbgotop()
   if dbseek(cUF+cCIDADE)
      IF lDDD
         if md10->ddd<>cDDD         
            fwrite(nhandle,cCNPJT+" "+cUF+" "+cCIDADE+" "+cDDD+" DDD nao e da cidade:"+md10->ddd+HB_OsNewLine())
         ENDIF   
      endif
      IF l3DIG
         IF (cUF="MG".OR.cUF="PE".OR.cUF="RS".OR.cUF="SP").and.empty(md10->iniie).AND.cCIDADE<>"SAO PAULO".AND.LEFT(cIE,5)<>"ISENT".AND. ! EMPTY(cIE)
            IF LEFT(cie,3)<>md10->iniie.AND. ! EMPTY(md10->iniie)
               fwrite(nhandle,cCNPJT+" "+cUF+" "+cCIDADE+" "+left(cIE,3)+" prefixo Incricao Estadual nao e da cidade: "+md10->INIIE+HB_OsNewLine())
               lLIMPAIE:=.t.
            endif
         endif
      ENDIF   
      IF lCEPCID
         if cCEP >= MD10->INICEP .and. cCEP <= MD10->FIMCEP
         ELSE
            if VAL(MD10->INICEP2)>0.AND.cCEP >= MD10->INICEP2 .and. cCEP <= MD10->FIMCEP2
            ELSE      
               fwrite(nhandle,cCNPJT+" "+cUF+" "+cCIDADE+" "+cCEP+" cep fora da faixa da cidade "+HB_OsNewLine())
               lLIMPACEP:=.T.
            ENDIF         
         ENDIF
      ENDIF  
   ELSE
      IF lCID
         fwrite(nhandle,cCNPJT+" "+cUF+" "+cCIDADE+" cidade nao cadastrada"+HB_OsNewLine())
         lLIMPACID:=.T.
      ENDIF
   endif
   
   FOR Z=1 TO IF(lSUFRAMA,3,2)
         DO CASE
            CASE Z=1
                 cARQ   := PROFILESTRING( "sped.ini","PATH","CNPJIEUF",HB_CWD())
                 cARQ+="cnpjie"+cUF
                 cSUB:="CNPJ da uf"
                 NETUSE(CARQ)
            CASE Z=2
                 DBSELECTAR("CNPJXML")         
                 cSUB:="NFE"
            CASE Z=3     
                 cARQ   := PROFILESTRING( "sped.ini","PATH","CNPJIEUF",HB_CWD())
                 cARQ+="cnpjiesu"
                 NETUSE(CARQ)              
                 cSUB:="SUFRAMA"
         ENDCASE         
         cALIAS:=ALIAS()
         dbgotop()
         if dbseek(cCNPJT)
            IF lCNPJIE
               IF Z<>3
                  if alltrim(TIRAOUT((cALIAS)->ie))<>cieT
                     fwrite(nhandle,ccnpjt+" "+cUF+": "+cIE+"<>"+IE+" IE<>IE "+cSUB+HB_OsNewLine())
                     lLIMPAIE:=.T.
                  ENDIF
               ENDIF               
               IF Z=3
                  if alltrim(TIRAOUT((cALIAS)->ie))<>cSUFRAMA
                     fwrite(nhandle,ccnpjt+" "+cUF+": "+cSUFRAMA+"<>"+IE+" SUFRAMA<>cSUFRAMA"+HB_OsNewLine())
                  ENDIF               
               ENDIF               
            ENDIF  
            IF Z=2
               IF lSUFXML
                  if alltrim(TIRAOUT((cALIAS)->SUFRAMA))<>cSUFRAMA
                     fwrite(nhandle,ccnpjt+" "+cUF+": "+cSUFRAMA+"<>"+SUFRAMA+" SUFRAMA<>cSUFRAMA NFE"+HB_OsNewLine())
                  ENDIF       
               ENDIF   
               IF lCCMXML
                  if alltrim(TIRAOUT((cALIAS)->IMUNICIPAL))<>cCCMT
                     fwrite(nhandle,ccnpjt+" "+cUF+": "+cCCM+"<>"+IMUNICIPAL+" CCM<>cCCM NFE"+HB_OsNewLine())
                     lLIMPACCM:=.T.
                  ENDIF       
              ENDIF    
           ENDIF
            IF lCNPJCID .AND. (cUF="GO"  .OR. cUF="PB"  )               
               IF Z=1
                  cMUNICIPIO:=alltrim((cALIAS)->MUNICIPIO)
               ELSE
                  cMUNICIPIO:=alltrim((cALIAS)->CIDADE)
               ENDIF
               if cMUNICIPIO<>ALLTRIM(cCIDADE)
                  fwrite(nhandle,ccnpjt+" "+cUF+": "+cCIDADE+"<>"+cMUNICIPIO+" Cidade<>"+cSUB+HB_OsNewLine())
                  lLIMPACID:=.T.
               ENDIF   
            ENDIF
            IF lCNPJNOME .AND. ( cUF="GO" .OR. cUF="MG" .OR. cUF="PB" .OR. cUF="PI" .OR. cUF="RO" .OR. cUF="PA")
               if alltrim(TIRAOUT((cALIAS)->NOME))<>cNOME
                  fwrite(nhandle,ccnpjt+": "+cNOME+"<>"+NOME+" Razao<>"+cSUB+HB_OsNewLine())
               endif   
            ENDIF            
            IF lCNPJCNAE .AND. Z<>3  .AND. ( cUF="GO" .OR. cUF="PA" .OR. cUF="PR" .OR. cUF="RS" .OR. cUF="SC")
               if alltrim(TIRAOUT((cALIAS)->CNAE))<>cCNAE
                  fwrite(nhandle,ccnpjt+": "+cCNAE+"<>"+CNAE+" CNAE<>"+cSUB+HB_OsNewLine())
               endif   
            ENDIF 
            IF lCNPJHAB .AND. Z=1
               lHAB:=.F.
               IF cUF="ES" .OR. cUF="MS" .OR. cUF="SC" .OR. cUF="PE" .OR. cUF="PA" ;
                           .OR. cUF="MT" .OR. cUF="PR" .OR. cUF="TO" .OR. cUF="BA" ;
                           .OR. cUF="SE" .OR. cUF="AL" .Or. cUF="MG" .Or. cUF="PB" 
                  If cUF="GO" .Or. cUF = "RS" .Or. cUF = "MA"  .Or. cUF = "PR" //contrala baixaUF
                     lHAB:=.T. 
                     cARQ   := PROFILESTRING( "sped.ini","PATH","CNPJIEUF",HB_CWD())
                     cARQ+="baixa"+cUF                 
                     if NETUSE(CARQ)
                        dbgotop()         
                        if dbseek(cCNPJT)
                           lHAB:=.F. 
                        endif
                     endif       
                     dbclosearea()
                     dbselectar(cALIAS)                     
                  ELSE
                     cSITUACAO:=LEFT((cALIAS)->SITUACAO ,1)
                     IF (cUF="ES" .OR. cUF="MS" .OR. cUF="SC" .OR. cUF="PE" .OR. cUF="PA").AND.cSITUACAO="0"
                        lHAB:=.T.                                                     
                     ENDIF   
                     //antigamenente pe=0 agora pe=a=ativo manter dois casos ate normalizar base
                     IF (cUF="MT" .OR. cUF="PR").AND.cSITUACAO="1"
                        lHAB:=.T.
                     ENDIF                  
                     IF cUF="TO".AND.cSITUACAO="0"
                        lHAB:=.T.
                     ENDIF   
                     IF (cUF="BA" .or. cUF="PE" .or. cUF="PB" ).AND.cSITUACAO="A"
                        lHAB:=.T.
                     ENDIF   
                     IF (cUF ="AL" .Or. cUF="MG" .OR. cUF="SE").AND.cSITUACAO="H"
                        lHAB:=.T.
                     ENDIF
                  ENDIF                  
               ELSE
                  lHAB:=.T. //demais estados nao disponiibilizam status
               ENDIF	
            
            
            ENDIF            
         endif
         IF lIECNPJ.AND.Z<>3
            if LEFT(cIE,5)<>"ISENT".AND.! EMPTY(cIE).AND.ValIE( cIE, cUF, ,.F.,.T.)  
               dbsetorder(2)
               dbgotop()
               if dbseek(CieT)            
                  if alltrim((cALIAS)->CNPJ)<>cCNPJT            
                     fwrite(nhandle,Cie+" "+cUF+": "+cCNPJT+"<>"+CNPJ+" CNPJ<>"+cSUB+HB_OsNewLine())
                     lLIMPAIE:=.T.
                  ENDIF
               endif   
            endif
         endif   
         IF Z=1 .or. z=3
            dbclosearea()      
         ENDIF         
    NEXT Z 
   
   dbselectarea("SINTCERT")
   if lLIMPAIE.OR.lLIMPACCM.OR.lLIMPACEP.OR.lLIMPACID.OR.lLIMPAEMAIL
      netreclock()    
      if lLIMPAIE
         SINTCERT->IE:=""
      ENDIF
      if Llimpaccm
         SINTCERT->ccm:=""
      endif
      IF lLIMPACEP
         SINTCERT->CEP:=""
      ENDIF
      IF lLIMPACID
         SINTCERT->CIDADE:=""
      ENDIF
      IF LEFT(XREGAPUR,3)='256' .OR. LEFT(XREGAPUR,3)='259' //com erro evita pesquisar novamente
      ELSE  
         sintcert->XREGAPUR:=""
      ENDIF            
      dbunlock()
   endif
   
   IF len(cCNPJ)=11.AND.Valcpf( cCNPJ ,.F.) .and. empty(sintcert->XREGAPUR)
       netreclock()          
       sintcert->XREGAPUR:="CPF" 
       IF EMPTY(CNPJXML->IE)
          sintcert->IE:="ISENTO"
       ENDIF    
       dbunlock()            	
    ENDIF
    IF cUF="EX" .and. empty(sintcert->XREGAPUR)    
       netreclock()   
       sintcert->XREGAPUR:="EX"   
       dbunlock()    
    ENDIF
    IF cUF="??"
       netreclock()
       sintcert->UF:=""
       dbunlock()
    ENDIF   

    
   dbskip()
enddo
dbcloseall()
fclose(nHANDLE)
mds("...")


FUNCTION TamanhoCCM(cCidade,cUF)
nTAMCCM:=0
do case
   case (cUF="SP".AND.cCIDADE="SAO PAULO").or.cCIDADE="3550308" // SP000
      nTAMCCM:=8
   case (cUF="PI".AND.cCIDADE="TERESINA").or.cCIDADE="2211001"  // PI000 
      nTAMCCM:=7          
   case (cUF="PA".AND.cCIDADE="BELEM").or.cCIDADE="1501402"  // PA000
      nTAMCCM:=7
   case (cUF="MS".AND.cCIDADE="CAMPO GRANDE").or.cCIDADE="5002704"   // MS000 
      nTAMCCM:=11            
   case (cUF="MA".AND.cCIDADE="SAO LUIZ").OR.(cUF="MA".AND.cCIDADE="SAO LUIS").or.cCIDADE="2111300"  // MA000
      nTAMCCM:=11            
   case (cUF="MG".AND.cCIDADE="UBERLANDIA").or.cCIDADE="3170206"  // MGD92
      nTAMCCM:=8
   case (cUF="RJ".AND.cCIDADE="NOVA IGUACU").or.cCIDADE="3303500" // RJ155 
      nTAMCCM:=6
   case (cUF="SP".AND.cCIDADE="CAMPINAS").or.cCIDADE="3509502" // SP171
       nTAMCCM:=9                        
   case (cUF="SP".AND.cCIDADE="SOROCABA").or.cCIDADE="3552205" // SP838 
       nTAMCCM:=9                        
//            case cUF="".AND.cCIDADE="" //
//                nTAMCCM:=0                                        
endcase
return  nTAMCCM        


FUNCTION formatacCM(xCCM)
xCCM:=StrZero(Val(AllTrim(TIRAOUT(xCCM))),8)
RETURN Transform(xCCM,"@R 9.999.999-9")
