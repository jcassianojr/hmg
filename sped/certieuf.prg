FUNCTION SERTIECNPJ()

cCAMINHO   := PROFILESTRING( "sped.ini","SINTCERT.DBF","CAMINHO",HB_CWD())+"SINTCERT"
lAPAGA:=MDG("Apagar nao certificadas")
IF ! NETUSE(cCAMINHO,"DBFCDX")
   dbcloseall()
   return
endif
nHANDLE:=FCREATE("SERTIECNPJ.txt")
dbsetorder(4) //uf
dbgotop()
while ! SINTCERT->(EOF())
   cUF  :=SINTCERT->UF   
   cARQ := PROFILESTRING( "sped.ini","PATH","CNPJIEUF",HB_CWD())
   cARQ +="cnpjie"+cUF
   lOPEN:=.F.	
   IF NETUSE(CARQ)
      cALIAS:=ALIAS()
      lOPEN:=.T.	      
   eNDIF         
   dbselectar("SINTCERT")
   WHILE cUF=SINTCERT->UF.AND.! SINTCERT->(EOF())
      cCNPJ:=ALLTRIM(TIRAOUT(SINTCERT->CNPJ))
      cIE  :=ALLTRIM(TIRAOUT(SINTCERT->IE))           
      MDS(cUF+"-"+cCNPJ+"-"+STR(RECNO()))
      IF lOPEN  	      
   	   IF SINTCERT->CNPJOK="S".AND.SINTCERT->IEOK="S".AND.LEFT(cIE,5)<>"ISENT".AND.! EMPTY(cIE).AND. vALCGC( cCNPJ,  ,.F.,cUF) .and. ValIE( cIE, cUF, ,.F.,.T.)                    
            cIE:=TIRAOUT(SINTCERT->IE)
            cCNAE:=SINTCERT->CNAE
            cNOME:=SINTCERT->RAZAO
            cMUNICIPIO:=SINTCERT->CIDADE
            DBSELECTAR(cALIAS)
            DBGOTOP()   
            IF ! DBSEEK(cCNPJ)
             	NETRECAPP()
               (cALIAS)->CNPJ:=cCNPJ
               (cALIAS)->IE:=cIE
            ELSE 
               netreclocK()
               IF cIE<>alltrim((cALIAS)->IE)
                  FWRITE(nHANDLE,"SINTCERT: "+cCNPJ+" "+cUF+" "+cIE+"<>"+(cALIAS)->IE+HB_OsNewLine())
               ENDIF
            ENDIF     
            IF cUF="SC" .OR. cUF="RS" .OR. cUF="ES" .OR. cUF="MS" .OR. cUF="MT" .OR. cUF="PA"  .OR. cUF="RO"  //.OR. cUF="PE"
               IF EMPTY((cALIAS)->UF)
                  (cALIAS)->UF:=cUF
               ENDIF 
            ENDIF 
            IF cUF="ES" .OR. cUF="MS" .OR. cUF="SC" .OR. cUF="PE" .OR. cUF="PA" .OR. cUF="MT" ;
                        .OR. cUF="PR" .OR. cUF="TO" .OR. cUF="BA" .OR. cUF="SE" .OR. cUF="AL" ;
                        .Or. cUF="MG" .Or. cUF="PB" 
               IF EMPTY((cALIAS)->SITUACAO)                           
                   IF cUF="ES" .OR. cUF="MS" .OR. cUF="SC" .OR. cUF="PA"                              
                     (cALIAS)->SITUACAO:="0"
                   ENDIF   
                   IF cUF="MT" .OR. cUF="PR"
                     (cALIAS)->SITUACAO:="1"
                   ENDIF                  
                   IF cUF="TO"
                     (cALIAS)->SITUACAO:="00"
                   ENDIF   
                   IF cUF="BA" .OR. cUF="PE"  .OR. cUF="PB"
                     (cALIAS)->SITUACAO:="A"
                   ENDIF   
                   IF cUF = "AL" .Or. cUF = "MG" .OR. cUF="SE"
                     (cALIAS)->SITUACAO:="H"
                   ENDIF
               ENDIF     
                 // If cESTADO = "GO" Or cESTADO = "RS" Or cESTADO = "MA"  Or cESTADO = "PR" Then 'estes estao tem arquivo separado de baixados                 
     	      ENDIF	
            IF cUF="GO" .OR. cUF="PA" .OR. cUF="PR" .OR. cUF="RS" .OR. cUF="SC"
               IF VAL((cALIAS)->CNAE)=0.AND.VAL(cCNAE)>0
                  (cALIAS)->CNAE:=cCNAE
               ENDIF               
            ENDIF
            IF cUF="GO" .OR. cUF="MG" .OR. cUF="PB" .OR. cUF="PI" .OR. cUF="RO" .OR. cUF="PA"
               IF EMPTY((cALIAS)->NOME)
                  (cALIAS)->NOME:=cNOME
               ENDIF
            ENDIF
            IF cUF="GO"  .OR. cUF="PB"  
               IF EMPTY((cALIAS)->MUNICIPIO)
                  (cALIAS)->MUNICIPIO:=cMUNICIPIO
               ENDIF
            ENDIF          
            IF cUF="PB"  
               IF EMPTY((cALIAS)->CEP)
                  (cALIAS)->CEP:=SINTCERT->CEP
               ENDIF
            ENDIF          
            dbunlock()            
         ENDIF
   	ENDIF	  
      dbselectar("SINTCERT")
      IF lAPAGA
         IF SINTCERT->CNPJOK=" ".AND.SINTCERT->IEOK=" "
            NETRECDEL()
         ENDIF
      ENDIF      
      DBSKIP()
   ENDDO
   If lOPEN
      DBSELECTAR(cALIAS)
      dbclosearea() 
   ENDIF
   dbselectar("SINTCERT")
enddo
DBCLOSEALL()

cCAMINHO   := PROFILESTRING( "sped.ini","CNPJXML.DBF","CAMINHO",HB_CWD())+"CNPJXML"
IF ! NETUSE(cCAMINHO,"DBFCDX")
   dbcloseall()
   return
endif
dbsetorder(4) //uf+CIDADE
dbgotop()
while ! eof()
   cUF:=CNPJXML->UF   
   cARQ   := PROFILESTRING( "sped.ini","PATH","CNPJIEUF",HB_CWD())
   cARQ+="cnpjie"+cUF
   lOPEN:=.F.	
   IF NETUSE(CARQ)
      cALIAS:=ALIAS()
      lOPEN:=.T.	      
   eNDIF         
   dbselectar("CNPJXML")
   WHILE cUF=CNPJXML->UF.AND.! CNPJXML->(EOF())
      cCNPJ:=alltrim(TIRAOUT(CNPJXML->CNPJ))
      cIE:=alltrim(TIRAOUT(CNPJXML->IE))      
      MDS(cUF+"-"+cCNPJ)
      IF lOPEN 
         if ! empty(cIE).AND.lEFT(cIE,5)<>"ISENT" .AND. vALCGC( cCNPJ,  ,.F.,cUF) .and. ValIE( cIE, cUF, ,.F.,.T.)                    
            cCNAE:=CNPJXML->CNAE
            cNOME:=CNPJXML->NOME
            cCODIBGE:=CNPJXML->CODIBGE
            cMUNICIPIO=CNPJXML->CIDADE
            DBSELECTAR(cALIAS)
            DBGOTOP()   
            IF ! DBSEEK(cCNPJ)
               NETRECAPP()
               (cALIAS)->CNPJ:=cCNPJ
               (cALIAS)->IE:=cIE
            ELSE 
               netreclocK()
               IF cIE<>(cALIAS)->IE            
                  FWRITE(nHANDLE,"CNPJXML: "+cCNPJ+" "+cUF+" "+cIE+"<>"+(cALIAS)->IE+HB_OsNewLine())
               ENDIF
            ENDIF     
            IF cUF="GO" .OR. cUF="PA" .OR. cUF="PR" .OR. cUF="RS" .OR. cUF="SC"
               IF VAL((cALIAS)->CNAE)=0.AND.VAL(cCNAE)>0
                  (cALIAS)->CNAE:=cCNAE
               ENDIF               
            ENDIF
            IF cUF="GO" .OR. cUF="MG" .OR. cUF="PB" .OR. cUF="PI" .OR. cUF="RO" .OR. cUF="PA"
               IF EMPTY((cALIAS)->NOME)
                  (cALIAS)->NOME:=cNOME
               ENDIF
            ENDIF
            IF cUF="GO"  .OR. cUF="PB" 
               IF EMPTY((cALIAS)->MUNICIPIO)
                  (cALIAS)->MUNICIPIO:=cMUNICIPIO
               ENDIF
            ENDIF             
            IF cUF="GO"  .OR. cUF="PB"  .OR. cUF="SC" .or. cUF="PR"
               IF val((cALIAS)->ibge)=0
                  (cALIAS)->ibge:=cCODIBGE
               ENDIF               
            ENDIF 
            IF cUF="PB"            
                IF EMPTY((cALIAS)->ENDERECO)
                  (cALIAS)->ENDERECO:=CNPJXML->ENDERECO
                ENDIF
                IF EMPTY((cALIAS)->NUMEND)
                  (cALIAS)->NUMEND:=CNPJXML->NUMEND
                ENDIF
                IF EMPTY((cALIAS)->COMPLEM)
                  (cALIAS)->COMPLEM:=CNPJXML->COMPLEM
                ENDIF
                IF EMPTY((cALIAS)->BAIRRO)
                  (cALIAS)->BAIRRO:=CNPJXML->BAIRRO
                ENDIF
                IF EMPTY((cALIAS)->CEP)
                  (cALIAS)->CEP:=CNPJXML->CEP
                ENDIF
            ENDIF
            dbunlock()            
         ENDIF
   	ENDIF	  
      dbselectar("CNPJXML")
      DBSKIP()
   ENDDO
   If lOPEN
      DBSELECTAR(cALIAS)
      dbclosearea() 
   ENDIF
   dbselectar("CNPJXML")
enddo
dbcloseall()
      


FCLOSE(nHANDLE)
if Lapaga
   cCAMINHO   := PROFILESTRING( "sped.ini","SINTCERT.DBF","CAMINHO",HB_CWD())+"SINTCERT"
   netpack(cCAMINHO)
endif
IF MDG("Limpar com Erros")
   LIMPACNPJIE()
ENDIF

MDS("...")
      
