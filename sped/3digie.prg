FUNCTION gera3digie()
ALERTX("As IE podem possuem agora 3dig diferentes na mesma cidade")


/*
cCAMINHO   := PROFILESTRING( "sped.ini","SINTCERT.DBF","CAMINHO",HB_CWD())+"SINTCERT"
IF ! NETUSE(cCAMINHO)
   RETURN
ENDIF

cCAMINHO   := PROFILESTRING( "sped.ini","MD10.DBF","CAMINHO",HB_CWD())+"MD10"
IF ! NETUSE(cCAMINHO)
   DBCLOSEALL()
   RETURN
ENDIF


nHANDLE:=FCREATE("3digie.txt")

a2CNPJ:={}
dbselectar("sintcert")
dbsetorder(4)

dbselectar("MD10")
dbgotop()
while ! eof()
    mNOME:=ALLTRIM(NOME)    
    mUF:=UF
    mds(mUF+" "+mNOME)
    mINIIE:=INIIE
    IF (mUF="MG".OR.mUF="PE".OR.mUF="RS".OR.mUF="SP").and.empty(iniie).AND.mNOME<>"SAO PAULO"
       dbselectar("sintcert")
       dbgotop()
       dbseek(mUF+mNOME)
       while UF=mUF.AND.mNOME=ALLTRIM(CIDADE).AND. ! EOF()
           IF IE<>"ISENTO".AND.! EMPTY(IE)
              fwrite(nhandle,MuF+mnome+" "+LEFT(ie,3)+HB_OsNewLine())
           ENDIF  
           mINIIE:=LEFT(IE,3)
           dbskip()
       enddo
    endif

    dbselectar("MD10")
    dbskip()
enddo
dbselectar("sintcert")
dbgotop()
while ! eof()
    cBUSCA:=LEFT(CNPJ,2)+UF
    IF ASCAN(a2CNPJ,cBUSCA)=0
       AADD(a2CNPJ,cBUSCA)
    ENDIF
    dbskip()
enddo
dbcloseall()
a2CNPJ:=aSORT(a2CNPJ)
FWRITE("2 Digitos cnpj")
for x=1 to len(a2CNPJ)
    fwrite(nHANDLE,SUBSTR(a2CNPJ[X],1,2)+"|"+SUBSTR(a2CNPJ[X],3)+HB_OSNEWLINE())
NEXT X
fclose(nHANDLE)

msginfo("Concluido")
*/

/*
dbselectar("sintcert")
dbgotop()
while ! eof()
    mNOME:=ALLTRIM(CIDADE)    
    mUF:=UF
    mIE:=IE
    dbselectar("MD10")
    dbgotop()
    if ! dbseek(mUF+mNOME)   
       fwrite(nhandle,MuF+mnome+" sem "+Mie+HB_OsNewLine())
    endif   
    dbselectar("sintcert")
    dbskip()
enddo
dbcloseall()
fclose(nhandle)
*/

