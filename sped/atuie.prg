*****************CORRECAO TXT LINUX

function IMPTXTSEFAZ



aUF    := { "PR","BAIXAPR", "RS", "BAIXARS", "SC", "CPFSC", "MA", "BAIXAMA", "SE", "RO","SP","BAIXASP", ;
            "MS", "ES", "CE", "PA", "MG", "TODASPB","PB", "PI", "PE","BA","CPFBA","RJ","GO","BAIXAGO","AL"}

aUF2   := { "PR","PR", "RS", "RS", "SC", "SC", "MA", "MA", "SE", "RO", "SP", "SP", ;
            "MS", "ES", "CE", "PA", "MG", "PB", "PB","PI", "PE","BA","BA","RJ","GO","GO","AL"}


//pernambuco varios arquivos renomeia sequencial 01 02
if file("contodos.txt")  //todaspb tem diferenca da contodos uma usa ; outra usa |
   frename("contodos.txt","pb01.txt")
endif
if file("connormal.txt") //.and. ! HB_FILEEXISTS('pb.txt') //todaspb tem diferenca da contodos uma usa ; outra usa |
   frename("connormal.txt","pb02.txt")
endif
if file("consimples.txt") //.and. ! HB_FILEEXISTS('pb.txt') //todaspb tem diferenca da contodos uma usa ; outra usa |
   frename("consimples.txt","pb03.txt")
endif
if file("ConSIMEI.txt") //.and. ! HB_FILEEXISTS('pb.txt') //todaspb tem diferenca da contodos uma usa ; outra usa |
   frename("ConSIMEI.TXT","pb04.txt")
endif
if file("ConProdRuralPF.txt") //.and. ! HB_FILEEXISTS('pb.txt') //todaspb tem diferenca da contodos uma usa ; outra usa |
   frename("ConProdRuralPF.TXT","pb05.txt")
endif
if file("ConSubstituicao.txt") //.and. ! HB_FILEEXISTS('pb.txt') //todaspb tem diferenca da contodos uma usa ; outra usa |
   frename("ConSubstituicao.TXT","pb06.txt")
endif
if file("ConTodosCNPJ.txt") //.and. ! HB_FILEEXISTS('pb.txt') //todaspb tem diferenca da contodos uma usa ; outra usa |
   frename("ConTodosCNPJ.TXT","pb07.txt")
endif
if file("conoutros.txt") //.and. ! HB_FILEEXISTS('pb.txt') //todaspb tem diferenca da contodos uma usa ; outra usa |
   frename("conoutros.txt","pb08.txt")
endif
if file("contrib_todas_sit.txt")  //todaspb tem diferenca da contodos uma usa ; outra usa |
   frename("contrib_todas_sit.txt","TODASPB.txt")
endif

if file("CCI_RESUMIDO.TXT")
   frename("CCI_RESUMIDO.TXT","MS.txt")
endif

if file('contrbcnpj.txt') .and. ! HB_FILEEXISTS('ba.txt')
   frename("contrbcnpj.txt","ba.txt")
endif    

if file('cpa.txt')
   frename("cpa.txt","pa.txt")
endif    

if file("cad_resumido_ativos.txt") .and.  ! HB_FILEEXISTS('ro.txt')
   frename("cad_resumido_ativos.txt","ro.txt")
endif

if file("cad_resumido_total_cnpj.txt")
   frename("cad_resumido_total_cnpj.txt","ro.txt")
endif

if file("ICS_ATIVO.TXT")
   frename("ICS_ATIVO.TXT","rs.txt")
endif

if file("ICS_BAIXADO.txt")
   frename("ICS_BAIXADO.txt","baixars.txt")
endif

if file("CadAtivo.txt")
   frename("CadAtivo.txt","sc.txt")
endif

if file("Arq_pessoa_fisica.txt")
   frename("Arq_pessoa_fisica.txt","cpfsc.txt")
endif


if file("cad_resumido_total.txt") .and. ! HB_FILEEXISTS("ro.txt")
   frename("cad_resumido_total.txt","ro.txt")
endif

if file("cad_resumido_total_cnpj.txt") .and. ! HB_FILEEXISTS("ro.txt")
   frename("cad_resumido_total_cnpj.txt","ro.txt")
endif

if file("RJCONTRIB.txt")
   frename("RJCONTRIB.txt","rj.txt")
endif

if file("CADASTRO_DE_CONTRIBUINTE_SIMPLIFICADO.txt")
   frename("CADASTRO_DE_CONTRIBUINTE_SIMPLIFICADO.TXT","pe.txt")
endif

if file("lista_cadastro1.txt")
   frename("lista_cadastro1.txt","ma.txt")
endif

if file("ativos_icms.txt")
   frename("ativos_icms.txt","ma.txt")
endif


if file("lista_cadastro_restricao1.txt")
   frename("lista_cadastro_restricao1.txt","baixama.txt")
endif


if file("contribuinte.txt")
   Frename("contribuinte.txt","ce.txt")
endif

if file("cadastro_sped.txt")
   frename("cadastro_sped.txt","mg.txt")	 
endif

if file("cadastro.txt")
    cDELIM:=FDELIM ("cadastro.txt",1024) //acha o delimitador chr(13)+chr(10) dos ou chr(10) linux usado abaixo no freadline
    nHANDLE:=FOPEN("cadastro.txt")
    cLINHA := ALLTRIM(FREADLINE( nHANDLE, 1024 ,.T. ,cDELIM ))
	fclose(Nhandle)	
    if at(";",cLINHA)>0
       frename("cadastro.txt","al.txt")
	else 
      if at("ESTADO DE SC",cLINHA)>0		     
		frename("cadastro.txt","sc.txt")	   	  
      endif
    endif
endif


if file("cadastro_cnpj.txt") .and. ! HB_FILEEXISTS("al.txt")
   frename("cadastro_cnpj.txt","al.txt")
endif

if file("sintegra.txt")
   frename("sintegra.txt","se.txt")
endif


if file("ativos.txt")
    cDELIM:=FDELIM ("ativos.txt",1024) //acha o delimitador chr(13)+chr(10) dos ou chr(10) linux usado abaixo no freadline
    nHANDLE:=FOPEN("ativos.txt")
    cLINHA := ALLTRIM(FREADLINE( nHANDLE, 1024 ,.T. ,cDELIM ))
	fclose(Nhandle)	
    if at("Inscricao_Estadual",cLINHA)>0
       frename("ativos.txt","sp.txt")
	else 
      frename("ativos.txt","pr.txt")
    endif
endif


if file("Nao_Ativos.txt")
   frename("Nao_Ativos.txt","baixasp.txt")
endif

if file("cancelados.txt")
   frename("cancelados.txt","baixapr.txt")
endif

if file("cadastro"+dtos(date())+".txt")
   frename("cadastro"+dtos(date())+".txt","mg.txt")
endif

            
IF MDG("Atualizar txts")   
   for y=1 to len(aUF)
      atualiza(aUF[y],aUF2[y])
   next y
   FOR y=1 to 99 //sp sequencia
     ATUaLIZA("SP","SP",y)
     atualiza("BAIXASP","SP",Y)
     ATUaLIZA("PB","PB",y)
   next y
ENDIF

//gravar situacao bahia
aTXTBA:={'contrbpjativo.txt',"contrbespecbaixa.TXT","contrbpfativo.TXT","contrbpfinativo.txt","contrbpfoutro.txt","contrbpjinativo.txt","contrbpjoutro.txt"}
FOR Y=1 TO 7
    cTXTBA:=aTXTBA[Y]
    lCPF:=.F.
    IF AT(UPPER(cTXTBA),"PF")>0
       lCPF:=.T.
    ENDIF
    if file(cTXTBA) //ba contribuintes
       cCAM := PROFILESTRING( "sped.ini","PATH","CNPJIEUF",HB_CWD())
       IF  netuse(cCAM+"CNPJIEBA")
           mds("atualizando situacao")
           nLASTREC:=FLINECOUNT(cTXTBA)
           zei_fort( nLASTREC,,,0)
           cDELIM:=FDELIM (cTXTBA,1024) //acha o delimitador chr(13)+chr(10) dos ou chr(10) linux usado abaixo no freadline
           nHANDLE:=FOPEN(cTXTBA)
           while .T.
              LINHA := alltrim( FREADLINE( nHANDLE, 1024 ,.T. ,cDELIM  ) )
              IF LINHA = "__FINAL__"
                 exit
              endif
              MDS(LEFT(linha,16)   )
              IF lCPF
                 cCNPJ:=SUBSTR(LINHA,1,11)
                 cSITUACAO:=SUBSTR(LINHA,13,1)  //a=ativo i=inativo
              ELSE           
                 cCNPJ:=SUBSTR(LINHA,1,14)
                 cSITUACAO:=SUBSTR(LINHA,16,1)  //a=ativo i=inativo
              ENDIF   
              dbgotop()
              IF dbseek(cCNPJ)
                 if cSITUACAO="A".OR.cSITUACAO="I"
                    netgrvcam("SITUACAO",cSITUACAO)
                 endif   
              endif
              zei_fort(nLASTREC,,,1)
           enddo
          dbcloseall()
          fclose(nhandle)
          ferase(cTXTBA)       
       endif
    endif
NEXT Y


IF file("PrestadoresNFe.txt")
   cCAM := PROFILESTRING( "sped.ini","PATH","CNPJIEUF",HB_CWD())
   IF  netuse(Ccam+"CCMSP")       
       mds("Atualizando CCMSP")
       nLASTREC:=FLINECOUNT("PrestadoresNFe.txt")
       zei_fort( nLASTREC,,,0)
       cDELIM:=FDELIM ("PrestadoresNFe.txt",1024) //acha o delimitador chr(13)+chr(10) dos ou chr(10) linux usado abaixo no freadline
       nHANDLE:=FOPEN("PrestadoresNFe.txt")
       nLINHA:=1
       while .T.
          LINHA := alltrim( FREADLINE( nHANDLE, 1024 ,.T. ,cDELIM  ) )
          IF LINHA = "__FINAL__"
             exit
          endif
          MDS(linha+STR(nLINHA)+"/"+STR(nLASTREC))          
          cCNPJ:=TIRAOUT(LINHA)
          dbgotop()
          IF ! dbseek(cCNPJ)
             netrecapp()
             CCMSP->cnpj:=cCNPJ             
             dbunlock()
          endif
          zei_fort(nLASTREC,,,1)
          nLINHA++
       enddo
      dbcloseall()
      fclose(nhandle)
      ferase("PrestadoresNFe.txt")
   endif
endif

//apagar baixados dos ativos MA/RS/GO/PR
IF MDG("Cruzar Ativos#Baixados")
    cCAM := PROFILESTRING( "sped.ini","PATH","CNPJIEUF",HB_CWD())
    for y=1 to 6
        DO CASE
           CASE y=1
               cUF="MA"
           CASE y=2
               cUF="RS"
           CASE y=3
               cUF="GO"
           CASE y=4
               cUF="PR"
          CASE y=5
               cUF="MG"
          CASE y=6
               cUF="SP"            
        ENDCASE
        if file(cCAM+"CNPJIE"+cUF+".DBF") .and. file(CCAM+"BAIXA"+cUF+".DBF")
           if NETUSE(cCAM+"CNPJIE"+cUF)
              if NETUSE(cCAM+"BAIXA"+cUF)
                 MDS("BX"+cUF)
                 dbselectar("BAIXA"+cUF)
                 nLASTREC:=LASTREC()
                 zei_fort( nLASTREC,,,0)
                 dbgotop()
                 while ! eof()
                    cCNPJ:=CNPJ
                    MDS(cCNPJ)
                    dbselectar("CNPJIE"+cUF)
                    dbgotop()
                    if dbseek(cCNPJ)
                       MDS(cCNPJ)
                       netrecdel()                       
                    endif
                    dbselectar("BAIXA"+cUF)
                    zei_fort(nLASTREC,,,1)
                    dbskip()
                 enddo
                 IF cUF="PR"
                     dbselectar("CNPJIE"+cUF)
                     nLASTREC:=LASTREC()
                     zei_fort( nLASTREC,,,0)
                     dbgotop()
                     while ! eof()
                        cIE:=IE
                        cCNPJ:=CNPJ
                        lTRANSFER=.F.
                        IF cUF="PR"
                           cSITUACAO:=LEFT(SITUACAO,1)
                           IF ! EMPTY(cSITUACAO).AND.cSITUACAO<>"1"
                              lTRANSFER=.T.
                           ENDIF
                        ENDIF
                        IF lTRANSFER
                           IF cUF="PR"
                              CDATA     :=DATA
                              CSITUACAO :=SITUACAO
                              CmUNICIPIO:=MUNICIPIO
                              CCNAE     :=CNAE
                           ENDIF
                           netrecdel()
                           dbselectar("BAIXA"+cUF)
                           dbappend()
                           field->CNPJ:=cCNPJ
                           field->ie:=cIE
                           IF cUF="PR"
                              field->DATA     :=CDATA
                              field->SITUACAO :=cSITUACAO
                              field->mUNICIPIO:=cMUNICIPIO
                              field->CNAE     :=cCNAE
                           ENDIF
                        ENDIF
                        dbselectar("CNPJIE"+cUF)
                        zei_fort(nLASTREC,,,1)
                        dbskip()
                     enddo
                  endif
              endif
              dbcloseall()
              netpack(cCAM+"CNPJIE"+cUF)
              netpack(cCAM+"BAIXA"+cUF)
           endif
        endif
    next x
endif
if mdg("Checar Cadastro")
   LIMPACNPJIE()
endif
RETURN

FUNCTION LIMPACNPJIE()
cCAM := PROFILESTRING( "sped.ini","PATH","CNPJIEUF",HB_CWD())
for Y=1 to 5
    DO CASE
       CASE Y=1
            cTEXTO:="CNPJ/CPF Invalidos"
       CASE Y=2
            cTEXTO:="CNPJ/IE Invalidos"
       CASE Y=3
            cTEXTO:="CNPJ/IE em Brancos"
       CASE Y=4
            cTEXTO:="CNPJ/CPF 14/11 Digitos"
       CASE Y=5
            cTEXTO:="PACK"
    ENDCASE
    IF MDG("Apagar "+cTEXTO)
       aUF:={"baixasp","baixago","baixama","baixapr","baixars","cnpjieac","cnpjieal","cnpjieam",    ;
            "cnpjieap","cnpjieba","cnpjiece","cnpjiedf","cnpjiees",  ;
            "cnpjiego","cnpjiema","cnpjiemg","cnpjiems","cnpjiemt","cnpjiepa","cnpjiepb",  ;
            "cnpjiepe","cnpjiepi","cnpjiepr","cnpjierj","cnpjiern","cnpjiero","cnpjierr",  ;
            "cnpjiers","cnpjiesc","cnpjiese","cnpjiesp","cnpjieto" }
       aUF2:={"SP","GO","MA","PR","RS","AC","AL","AM",    ;
            "AP","BA","CE","DF","ES",  ;
            "GO","MA","MG","MS","MT","PA","PB",  ;
            "PE","PI","PR","RJ","RN","RO","RR",  ;
            "RS","SC","SE","SP","TO" }
       for z=1 to len(aUF)          
          cARQDBF:=aUF[z]
          MDS(cARQDBF)
          if file(cCAM+carqdbf+".DBF")
             IF Y<5   //5 pack
               if NETUSE(cCAM+cARQDBF)
                  MDS("Apagando "+cTEXTO+" "+cARQDBF)
                  nLASTREC:=LASTREC()
                  zei_fort( nLASTREC,,,0)
                    DO CASE
                       CASE Y=1                                                      //nao e cpnj nem cpf valido
                            DBEval( {|| NETRECDel()}, {|| ! VALCGC( CNPJ,,.F.).and. ! Valcpf( CNPJ ,.f.)},{|| zei_fort(nLASTREC,,,1)},,, .F. )
                       CASE Y=2.AND.(z<>13.AND.z<>14.AND.z<>33.AND.z<>35.AND.z<>36) //se cnpj a inscricao tem que ser valida
                            DBEval( {|| NETRECDel()}, {||  VALCGC( CNPJ,,.F.).and. ! VALIE(IE, aUF2[z], ,.F.,.T.) },{|| zei_fort(nLASTREC,,,1)},,, .F. ) 
                       CASE Y=3                                                      //cadastro em branco
                            DBEval( {|| NETRECDel()}, {|| VAL(CNPJ)=0.OR.VAL(IE)=0},{|| zei_fort(nLASTREC,,,1)},,, .F. )
                       CASE Y=4                                                     //cpnf<>14 cpf<>11
                            DBEval( {|| NETRECDel()}, {|| len(ALLTRIM(Cnpj))<>11.and.len(ALLTRIM(Cnpj))<>14},{|| zei_fort(nLASTREC,,,1)},,, .F. )
                    ENDCASE
                  dbclosearea()
               endif
             ELSE
                netpacK(cCAM+cARQDBF)
             ENDIF
          endif
       next z
    endif
next Y
return


FUNCTION ATUaLIZA(cUF,cUF2,nSEQTXT)
cARQTXT:=cUF+".txt"
cARQDBF:="CNPJIE"+cUF
cARQIR :="CNPJIR"+cUF2 //ir sempre estado nao tem baixados controlado pela situacao
IF VALTYPE(nSEQTXT)="N"
   cARQTXT:=cUF+STRZERO(nSEQTXT,2)+".txt" 
   IF ! FILE(cARQTXT)
      RETURN .F.
   ENDIF
ENDIF

DO CASE
   CASE cUF="BAIXASP"
   	  cARQDBF:="BAIXASP"
   	  cARQTXT:="BAIXASP.TXT"
      IF VALTYPE(nSEQTXT)="N"
         cARQTXT:="BAIXASP"+STRZERO(nSEQTXT,2)+".txt"
      ENDIF   
   CASE cUF="BAIXAPR"
   	  cARQDBF:="BAIXAPR"
   	  cARQTXT:="BAIXAPR.TXT"
   CASE cUF="BAIXAGO"
   	  cARQDBF:="BAIXAGO"
   	  cARQTXT:="BAIXAGO.TXT"
   CASE cUF="BAIXARS"	
       cARQDBF:="BAIXARS"
       cARQTXT:="BAIXARS.TXT"
   CASE cUF="BAIXAMA"	
      cARQDBF:="BAIXAMA"
      cARQTXT:="BAIXAMA.TXT"
   CASE cUF="CPFBA"	
      cARQDBF:="CNPJIEBA"
      cARQTXT:="CPFBA.TXT"
   CASE cUF="CPFSC"	
      cARQDBF:="CNPJIESC"
      cARQTXT:="CPFSC.TXT"
   CASE cUF="TODASPB"	
      cARQDBF:="CNPJIEPB"
      cARQTXT:="TODASPB.TXT"      
ENDCASE


if ! file(cARQTXT)   
   return .f.
endif

cCAMINHO   := PROFILESTRING( "sped.ini","MD10.DBF","CAMINHO",HB_CWD())
IF ! NETUSE(cCAMINHO+"MD10")
   DBCLOSEALL()
   RETURN .f.
ENDIF


cCAMINHO := PROFILESTRING( "sped.ini","CIDCONV.DBF","CAMINHO",HB_CWD())
IF ! NETUSE(cCAMINHO+"CIDCONV")
   DBCLOSEALL()
   RETURN .f.
ENDIF

//parana tem codigos cidades espefico
IF cUF="PR".OR.cUF="BAIXAPR"
   cCAMINHO   := PROFILESTRING( "sped.ini","PRCID.DBF","CAMINHO",HB_CWD())
   IF ! NETUSE(cCAMINHO+"prcid")
      DBCLOSEALL()
      RETURN .f.
   ENDIF
ENDIF

cCAM := PROFILESTRING( "sped.ini","PATH","CNPJIEUF",HB_CWD())

IF ! netuse(Ccam+Carqir)
	dbcloseall()
	return .f.
endif

IF ! netuse(Ccam+cARQDBF)
   dbcloseall()
   return .f.
endif
IF cUF="MG"
	IF ! netuse(Ccam+"BAIXAMG")
	   dbcloseall()
	   return .f.
	endif
ENDIF


mds("contando as linhas: "+cARQTXT)
IF cUF="SP" .OR. cUF="BAIXASP" //Muitos linhas trava contagem
  nLASTREC:=1
ELSE
  nLASTREC:=FLINECOUNT(cARQtxt)
ENDIF  


nLINHA:=1
zei_fort( nLASTREC,,,0)
MDS(PADR(cARQTXT+"->"+cARQDBF,40))
cDELIM:=FDELIM (cARQTXT,1024)
nHANDLE:=FOPEN(cARQTXT)
while .T.

   LINHA := alltrim( FREADLINE( nHANDLE, 1024 ,.T. ,cDELIM ) )
   IF LINHA = "__FINAL__"
      exit
   endif


   MDS(cUF+" "+transform(STR(nLINHA),"@R 999.999.999")+"/"+TRANSFORM(STR(nLASTREC),"@R 999.999.999")+" -> "+LEFT(linha,50))             
   cIE      :=  ""
   cNOME    := ""
   cCNPJ    := ""
   cDATA    := ""
   dDATA    :=CTOD(SPACE(8))
   cSITUACAO:= ""
   cCIDADE  := ""
   cCNAE    :=  ""
   cIBGE    :=""
   cBAIRRO  :=""
   cENDERECO:=""
   cCEP     := ""
   cREGIME  :=""
   cESTADO  :="" //difere de cUF(Passado funcao) para evitar erros pode ser ST subistituto tributario
   cNUMEND  :=""
   cENDTIP  :=""
   cCOMPLEM :=""
   
   

   do case

    Case cUF="AC"

    Case cUF="AM"

    Case cUF="AP"

    Case cUF="DF"

    Case cUF="MA".or.cUF="BAIXAMA"
         cCNPJ:=SUBSTR(LINHA,01,14)
         cIE  :=SUBSTR(LINHA,15,9)
         cCNAE:=SUBSTR(LINHA,24,7)         
         cNOME:=SUBSTR(LINHA,31,200)

    Case cUF="MG"
        IF AT("/",LINHA)=0 .OR. AT("-",LINHA)=0 //as informacoes vem em duas linhas
        
           LINHA2 := alltrim( FREADLINE( nHANDLE, 1024 ,.T. ,cDELIM ) ) //Como sao duas linhas precisa checar se e fim de arquivo novamente
           IF LINHA2 = "__FINAL__"
              exit
           endif
           LINHA:=LINHA+LINHA2
        
        ENDIF  
       
       
        cIE:=SUBSTR(LINHA,1,13)
        cCNPJ:=SUBSTR(LINHA,15,14)
        cSUBLINHA:=SUBSTR(LINHA,30)
        cNOME:=SUBSTR(cSUBLINHA,1,LEN(cSUBLINHA)-11)
        cSUBLINHA:=SUBSTR(cSUBLINHA,LEN(cSUBLINHA)-10)
        IF AT("/",cSUBLINHA)>0 .AND. AT("-",cSUBLINHA)>0 //checa sublinha pois alguma nao trazem o cnae e situacao
           cSITUACAO:=LEFT(cSUBLINHA,1)
           cCNAE    :=TIRAOUT(SUBSTR(cSUBLINHA,3))
        ENDIF
       

    Case cUF="MT"

    Case cUF="PA"
/*
07209612010109150508662PA104755501119920203LUNDGREN IRMAOS TECIDOS SA CASAS PE    
*/
         cCNPJ:=SUBSTR(LINHA,1,14)
         cIE:=SUBSTR(LINHA,15,9)
         cESTADO:=SUBSTR(LINHA,24,2)
         cREGIME:=SUBSTR(LINHA,26,1)
         cCNAE:=SUBSTR(LINHA,27,8)
         cSITUACAO:=SUBSTR(LINHA,35,1)  //0 = Habilitado1 = NÆo Habilitado
         cDATA:=SUBSTR(LINHA,36,8) //yyyymmdd
         cNOME:=SUBSTR(LINHA,44,35)
         dDATA:=str2data(cDATA,"YMD","",4)

          
    CASE cUF="TODASPB"      
//IE|NOME|CNPJ|SITUACAO|REGIME|CNAE|AtivEcon|TipoLogr|NomeLogre|NUm|Compl|Bairro|CIDADE|UF|CEP|ENDERECONCe|NUm|Compl|Bairro|CIDADE|UF|CEP|ENDERECONC    
//1  2    3    4        5      6    7        8        9        10  11    12     13     14 15  16
          aCAMPOS:=HB_ATokens(LINHA,"|")          
          if len(aCAMPOS)>=15  //O Txt as vezes tem linhas em branco
             CIE:=        Acampos[1]
             CNOME:=      Acampos[2]
             cCNPJ:=      Acampos[3]
             cSITUACAO:=  Acampos[4]  
             cREGIME:=   Acampos[5]
             cCNAE:=   Acampos[6]
             //c:=   Acampos[7] descritivo atividade nao usado
             cENDTIP:=  Acampos[8]
             cENDERECO:= ALLTRIM(Acampos[9])
             cNUMEND  :=   Acampos[10]
             cCOMPLEM:=   Acampos[11]
             cBAIRRO:=   Acampos[12]
             cCIDADE:=   Acampos[13]
             cESTADO:=   Acampos[14]
             cCEP:=   Acampos[15]
             //c:=   Acampos[16] endereco conc nao usado
          ENDIF
          
          

    Case cUF="PB"
          aCAMPOS:=HB_ATokens(LINHA,";")
          if len(aCAMPOS)>=5  //O Txt as vezes tem linhas em branco
             CIE       :=  Acampos[1]
             cCNPJ     :=  Acampos[2]
             CNOME     :=  Acampos[3]
             cREGIME   := Acampos[4]
             CCIDADE   := Acampos[5]
          ENDIF

          
    Case cUF="PE"
	
	     //10826063000155000000272BAIXADO   2011-01-141
         //12345678901234567890123456789012345678901235
         //         1         2         3         4
         //              5        4         4         4

	
         cCNPJ:=SUBSTR(LINHA,1,14)
         cIE:=SUBSTR(LINHA,15,9)
         cSITUACAO:=SUBSTR(LINHA,24,1)  //0 = Habilitado1 = NÆo Habilitado
         cDATA:=SUBSTR(LINHA,34,10) //
         cDATA:=STRTRAN(cDATA,"-","")
         cESTADO:="PE"
         cREGIME:=SUBSTR(LINHA,44,1)
         IF cSITUACAO="0"
            cSITUACAO="A"
         ENDIF
         IF cSITUACAO="1"
            cSITUACAO="B"
         ENDIF

    Case cUF="PI"
         aCAMPOS:=HB_ATokens(LINHA,";")
         if len(aCAMPOS)>=3  //O Txt as vezes tem linhas em branco
           CIE:=        Acampos[1]
           cCNPJ:=      Acampos[2]
           CNOME:=      Acampos[3]
         endif

    Case cUF="RN"

    Case cUF="RO"
        aStruct:= {{"CNPJ","C",14,0},;
                  {"IE","C",14,0},;
                  {"NOME","C",70,0},;
                  {"UF","C",2,0}}

        cCNPJ:=SubStr(LINHA,1,14)
     	  CIE:=SubStr(LINHA,15,14)
     	  cNOME=SubStr(LINHA,29,70)
     	  CESTADO:=SubStr(LINHA,99,2)

    Case cUF="RR"

    Case cUF="SC"        //Apagar inicio e fim
       aCAMPOS:=HB_ATokens(LINHA,",")
       if len(aCAMPOS)>=9  //O Txt as vezes tem linhas em branco
         cCNPJ:=    Acampos[1]
         cIE:=      Acampos[2]
         cESTADO:=  Acampos[3]
         cCIDADE:=  Acampos[4]
         cDATA  :=  Acampos[5]
         cDATA2:=   Acampos[6]
         cCNAE:=    Acampos[7]
         cSITUACAO:=Acampos[8]      //0 ATIVO 1 CANCELADO 2 BAIXA DEFERIDA
         cSITDESC:= Acampos[9]      //discritivo situacao
         dDATA     :=CTOD(cDATA)
       ENDIF
    Case cUF="CPFSC"
       aCAMPOS:=HB_ATokens(LINHA,";")
       if len(aCAMPOS)>=4  //O Txt as vezes tem linhas em branco
          cIE:=      Acampos[1]
          cCNPJ:=    Acampos[2]
          cSITUACAO:=Acampos[3]   //1;ATIVO  9;BAIXA DEFERIDA
          cSITDESC:= Acampos[4]
       endif
       if cSITUACAO="1"
          cSITUACAO:="0"         //muda para zero para ficar igual cnpj
       endif
       if cSITUACAO="9"
          cSITUACAO:="2"         //muda para 2 para ficar igual cnpj
       endif

 


  //  ALTD()
    Case cUF="SP" .OR. cUF="BAIXASP"
    
    /*
       1       nscri‡Æo Estadual
       2   CNPJ
       3   Nome Empresarial
       4   Nome Fantasia
       5   Natureza Jur¡dica
       6   Tipo Logradouro
       7   Nome Logradouro
       8   Numero Logradouro
       9   Complemento Logradouro
       10   CEP
       11   Bairro
       12   Munic¡pio
       13   UF
       14   Situa‡Æo Cadastral
       15   Data da Situa‡Æo Cadastral
       16    Ocorrˆncia Fiscal
       17   Regime de Apura‡Æo
       18   Atividade Econ“mica
    */
    
        aCAMPOS:=HB_ATokens(LINHA,";") 
         if len(aCAMPOS)>=18  //O Txt as vezes tem linhas em branco
           CIE:=        Acampos[1]   //
           cCNPJ:=      Acampos[2]   //
           CNOME:=      Acampos[3]   //
           cDATA    := Acampos[15]  //
           dDATA    := str2data(cDATA,"YMD","-",4)//
           cSITUACAO:= Acampos[14]     //
           cCIDADE  := Acampos[12]  // Grava ibge
           cCNAE    :=  Acampos[18]  //

        //   cIBGE    :=Acampos[]   //
           cBAIRRO  :=Acampos[11]   //grava cep
           cENDERECO:=Acampos[7]    //grava cep
           cCEP     := Acampos[10]
           cREGIME  :=Acampos[17]
           cESTADO  :=Acampos[13] //difere de cUF(Passado funcao) para evitar erros pode ser ST subistituto tributario  //grava cep
           cNUMEND  :=Acampos[8]
           cENDTIP  :=Acampos[6]   //grava cep
        //   cCOMPLEM :=Acampos[]
        
    
           
         endif

    Case cUF="TO"

    Case cUF="AL"
         aCAMPOS:=HB_ATokens(LINHA,";")
         if len(aCAMPOS)>=3  //O Txt as vezes tem linhas em branco
            CIE:=        Acampos[1]
            cCNPJ:=      Acampos[2]
            CSITUACAO:=   Acampos[3]  //H = Habilitado  N= NÆo Habilitado
         endif


    CASE cUF=="BA"	

//Sequencial - 6 posições numérica
//Tipo do registro (fixo 2) - 1 posição numérica
//Inscrição Estadual - 11 posições (as nove primeiras numéricas e as duas últimas alfabeticas indicando código da condição)
//CNPJ - 14 posições numéricas
//SSSSSSTIIIIIIIIITTCCCCCCCCCCCCCC        
//0000102000013321ME15111123000177
//       000013321 
//12345678901234567890123456789012


         CIE       :=SUBSTR(LINHA,8,9)
         cCATEGORIA:=SUBSTR(LINHA,17,2)
         cCNPJ     :=SUBSTR(LINHA,19,14)
        


   CASE cUF="CPFBA"	
        aStruct:= {{"SEQ","C",6,0},;
                  {"TIPOREG","C",2,0},;
                  {"IE","C",8,0},;
                  {"CATEGORIA","C",2,0},;
                  {"SEP01","C",3,0},;
                  {"CNPJ","C",11,0}}

         //12345612123456781212312345678901
         //SSSSSSTTIIIIIIIITT000CCCCCCCCCCC
         //12345678901234567890123456789012


         CIE       :=SUBSTR(LINHA,9,8)
         cCATEGORIA:=SUBSTR(LINHA,17,2)
         cCNPJ     :=SUBSTR(LINHA,22,11)



    Case cUF="CE"
        aStruct:= {{"CNPJ","C",14,0},;
                  {"SEP01","C",2,0},;
                  {"IE","C",9,0},;
                  {"SEP02","C",2,0},;
                  {"UF","C",2,0}}
       aCAMPOS:=HB_ATokens(LINHA,",")
       if len(aCAMPOS)>=3  //O Txt as vezes tem linhas em branco
          cCNPJ:=Acampos[1]
          cIE:=  ALLTRIM(Acampos[2])
          cESTADO:=  ALLTRIM(Acampos[3])
       endif


    Case cUF="ES"
         aStruct:= {{"CNPJ","C",14,0},;
                  {"IE","C",9,0},;
                  {"SITUACAO","C",1,0},;
                  {"DATA","C",8,0},;
                  {"UF","C",2,0}}
         cCNPJ:=SUBSTR(LINHA,1,14)
         CIE:=  SUBSTR(LINHA,15,9)
         cSITUACAO:=SUBSTR(LINHA,24,1)
         cDATA:= SUBSTR(LINHA,25,8) //yyyymmdd
         CESTADO:= SUBSTR(LINHA,33,2)

    Case cUF="GO" .OR. cUF="BAIXAGO"
/*    
110000030ABELIO JOAQUIM GOMES                              00001559605120110519900151202ANICUNS - GO                                                                                       
*/   
         aStruct:= {{"IE","C",9,0},;
                   {"NOME","C",50,0},;
     	              {"CNPJ","C",14,0},;
                    {"DATA","D",8,0},;
                    {"CNAE","C",7,0},;
                    {"CIDADE","C",45,0}}

         CIE:=  SUBSTR(LINHA,1,9)
         cNOME=SubStr(LINHA,10,50)
         cCNPJ:=SUBSTR(LINHA,60,14)
         cDATA:= SUBSTR(LINHA,74,8)
         IF cUF<>"BAIXAGO"
            cCNAE:= SUBSTR(LINHA,82,7)
            cCIDADE:= SUBSTR(LINHA,89,45)
            cCIDADE:= STRTRAN(cCIDADE,"- GO","")
         ENDIF
         dDATA:=str2data(cDATA,"DMY","",4)


    Case cUF="MS"
        aStruct:= {{"CNPJ","C",14,0},;
                  {"IE","C",9,0},;
                  {"SEP02","C",5,0},;
                  {"SITUACAO","C",1,0},;
                  {"DATA","C",8,0},;
                  {"UF","C",2,0}}
         cCNPJ:=SUBSTR(LINHA,1,14)
         CIE:=  SUBSTR(LINHA,15,9)
         cSITUACAO:=SUBSTR(LINHA,29,1)
         cDATA:= SUBSTR(LINHA,30,8) //yyyymmdd
         CESTADO:= SUBSTR(LINHA,38,2)

    Case cUF="PR".OR.cUF="BAIXAPR"
         //Inscri‡Æo Estadual (10 posi‡äes num‚ricas)                  ; (delimitador)
         // CNPJ (14 posi‡äes num‚ricas)                 ; (delimitador)
         // Data de habilita‡Æo: AAAAMM (6 posi‡äes num‚ricas)              ; (delimitador)
         // Situa‡Æo Atual: (8 posi‡äes num‚ricas)                 ; (delimitador)
         //   Munic¡pio: (5 posi‡äes num‚ricas)                 ; (delimitador)
         // CNAE: (7 posi‡äes num‚ricas - convertido em 12/02/2007)        Ex.: 1012345678;12345670000123;200101;12345678;12345;1234567
        aStruct:= {{"IE","C",10,0},;
                  {"SEP01","C",1,0},;
                  {"CNPJ","C",14,0},;
                  {"SEP02","C",1,0},;
                  {"DATA","C",6,0},;
                  {"SEP03","C",1,0},;
                  {"SITUACAO","C",8,0},;
                  {"SEP04","C",1,0},;
                  {"CIDADE","C",5,0},;
                  {"SEP05","C",1,0},;
                  {"CNAE","C",7,0}}
				  
		//0990002363;44367522000525;200708;98260109;61794;4635402		  
       aCAMPOS:=HB_ATokens(LINHA,";")
       if len(aCAMPOS)>=6  //O Txt as vezes tem linhas em branco
           cIE:=  Acampos[1]
           cCNPJ:=Acampos[2]
           cDATA:= Acampos[3]
           cSITUACAO:=  Acampos[4]
           cCIDADE:=  ALLTRIM(Acampos[5])
           cCNAE:=  Acampos[6]
       endif



    Case cUF="RJ"
       aStruct:= {{"CNPJ","C",14,0},;
                  {"IE","C",14,0}}
         cCNPJ:=SUBSTR(LINHA, 1,14)
         cIE  :=SUBSTR(LINHA,15,14)



    Case cUF="RS"
       // Inscri‡Æo Estadual (10 posi‡äes num‚ricas), onde as 3 primeiras posi‡äes representam o Munic¡pio de localiza‡Æo do Estabelecimento.
       // CNPJ (14 posi‡äes num‚ricas)
       // Categoria da Empresa (5 posi‡äes alfab‚ticas) - com a classifica‡Æo "GERAL", "EPP", "MICRO", "S NAC".
       // Data Abertura do Estabelecimento (10 posi‡äes)
       // C¢digo Nacional de Atividade Econ“mica Principal - CNAE Fiscal (7 posi‡äes num‚ricas).
       // UF (2 posi‡äes alfab‚ticas) - com a UF do Contribuinte Substituto Tribut rio, se for o caso.
       // C¢digo da Atividade Econ“mica Principal - CAE (9 posi‡äes num‚ricas).
       //0010000194;87067187000129;GERAL;01/01/1960;1061901;RS;410060000

         aStruct:= {{"IE","C",10,0},;
                  {"SEP01","C",1,0},;
                  {"CNPJ","C",14,0},;
                  {"SEP02","C",1,0},;
                  {"CATEGORIA","C",5,0},;
                  {"SEP03","C",1,0},;
                  {"DATA","C",10,0},;
                  {"SEP04","C",1,0},;
                  {"CNAE","C",7,0},;
                  {"SEP05","C",1,0},;
                  {"UF","C",2,0}}

       aCAMPOS:=HB_ATokens(LINHA,";")
       if len(aCAMPOS)>=7  //O Txt as vezes tem linhas em branco
           cIE:=  Acampos[1]
           cCNPJ:=Acampos[2]
           cCATEGORIA:= Acampos[3]
           cDATA:=aCampos[4]
           cCNAE:=  Acampos[5]
           cESTADO:=  Acampos[6]
           cCNAP:=  Acampos[7]
       endif
	   IF LEN(ALLTRIM(Acampos[1]))=9 //inscricao de 9 digitos antigas se acresenta 0 para ficar com 10
	      Acampos[1]='0'+Acampos[1]
	   ENDIF

   Case cUF="BAIXARS"

      * Inscri‡Æo Estadual (10 posi‡äes num‚ricas), onde as 3 primeiras posi‡äes representam o Munic¡pio de localiza‡Æo do Estabelecimento.
       * CNPJ (14 posi‡äes num‚ricas)
       * Data da Baixa (10 posi‡äes)
       * C¢digo da Atividade Econ“mica Principal - CAE (9 posi‡äes num‚ricas).
       //0010000062;87067336000150;31/07/1995;319050000

        aStruct:= {{"IE","C",10,0},;
                  {"SEP01","C",1,0},;
                  {"CNPJ","C",14,0},;
                  {"SEP02","C",1,0},;
                  {"DATA","C",10,0}}

       aCAMPOS:=HB_ATokens(LINHA,";")
       if len(aCAMPOS)>=4  //O Txt as vezes tem linhas em branco
         cIE:=  Acampos[1]
         cCNPJ:=Acampos[2]
         cDATA:=aCampos[3]
         cCNAP:=  Acampos[4]
       endif
	   IF LEN(ALLTRIM(Acampos[1]))=9 //inscricao de 9 digitos antigas se acresenta 0 para ficar com 10
	      Acampos[1]='0'+Acampos[1]
	   ENDIF



    Case cUF="SE"
        cIE:=SubStr(LINHA,1,9)
     	CCNPJ:=SubStr(LINHA,11,14)
     	cSITUACAO:=SubStr(LINHA,26,1)
     	CDATA:=SubStr(LINHA,52,8)
     	cCATEGORIA:=ALLTRIM(UPPER(SubStr(LINHA,61)))
        
        /*
        NOR;NORMAL
        SER;PRESTADOR DE SERVICO
        COM;SIMFAZ COMERCIO
        SIM;SIMPLES NACIONAL
        MEI;SIMEI
        IND;SIMFAZ INDUSTRIA
        SUB;SUBSTITUTO
        */
        
        //Grava sigla para a base nao ficar muito grande melhoria perfomace leitura gravacao
        DO CASE
           CASE cCATEGORIA="NORMAL"
                cCATEGORIA:="NOR"
           CASE cCATEGORIA="PRESTADOR DE SERVICO"
                cCATEGORIA:="SER"
           CASE cCATEGORIA="SIMFAZ COMERCIO"
                cCATEGORIA:="COM"                            
           CASE cCATEGORIA="SIMEI"
                cCATEGORIA:="MEI"
           CASE cCATEGORIA="SIMPLES NACIONAL"
                cCATEGORIA:="SIM"
           CASE cCATEGORIA="SIMFAZ INDUSTRIA"
                cCATEGORIA:="IND"
           CASE cCATEGORIA="SUBSTITUTO"
                cCATEGORIA:="SUB"                                                   
        ENDCASE



   endcase

   cNOME:=STRTRAN(cNOME,"  ","") //tirar duplo espaco
   
   if  ! empty(cCNPJ) .AND. ! EMPTY(cIE) .AND. ((VALCGC( cCNPJ,,.F.) .and. ValIE( cIE, cUF2 , , .f. , .f. ) ) .or. Valcpf( cCNPJ ,.f.))         //VALIEOLD(cIE, cUF2,.F.))
	  
       dbselectar(cARQDBF)
       //MG ativos e baixos mesmo arquivo controlado pela Situacao
    	IF cUF="MG" 
           IF cSITUACAO="H"	
              DBSELECTAR("CNPJIEMG")		   
		   ELSE
		      DBSELECTAR("BAIXAMG")
		   ENDIF
	   ENDIF
       
	   dbgotop()
        IF ! dbseek(cCNPJ)
          netrecapp()
          FIELD->CNPJ:=cCNPJ
        ELSE
          netreclock()
        endif
        IF cUF="PE" //inscricao nova nao sobrepor com a antiga que vem no txt
           IF EMPTY(IE)
              field->ie:=Cie
           ENDIF
        ELSE
           field->ie:=Cie
        ENDIF   
          IF cUF="AL" .OR. cUF="ES" .OR. cUF="MS" .OR. cUF="PR" .OR. cUF="PE" .OR. cUF="SC" .OR. cUF="TODASPB" ;
          	         .OR. cUF="SE" .OR. cUF="CPFSC" .OR. cUF="PA" .OR. cUF="MG" .OR. cUF="BAIXAPR" .OR. cUF="SP" .OR. cUF="BAIXASP"
             field->SITUACAO:=cSITUACAO
          ENDIF	
          IF cUF="TO" .OR. cUF="PE" .OR. cUF="MS" .OR. cUF="ES" ;
             .OR. cUF="BAIXATO" .OR. cUF="BAIXAPE" .OR. cUF="BAIXAMS" .OR. cUF="BAIXAES"
            cDATA:=dtoc(stod(Cdata))
          ENDIF
          IF cUF="SE" .OR. cUF="BAIXASE"
            cDATA:=dtoc(str2data(cDATA))
          ENDIF
          IF cUF="ES" .OR. cUF="MS" .OR. cUF="PE" .OR. cUF="PR" .OR. cUF="RS" ;
                  .OR. cUF="BAIXARS" .OR. cUF="SE" .OR. cUF="BAIXAPR"
             field->DATA:=cDATA
          ENDIF	 //campos data tipo date abaixo
		  //grava so ibge para diminuir tamanho dos arquivos
          //IF cUF="RO" .OR. cUF="ES" .OR. cUF="MS" .OR. cUF="RS" .OR. cUF="SC" .OR. cUF="PA" .OR. cUF="TODASPB" //.OR.cUF="PE"
          //   field->UF:=cESTADO
          //ENDIF
          //27/12/2O22 Incluido MG	
          IF cUF="MA" .OR. cUF="PR" .OR. cUF="RS" .OR. cUF="GO" .OR. cUF="SC" .OR. cUF="PA" .OR. cUF="BAIXAPR"  .OR. cUF="TODASPB" .OR. cUF="MG" ;
             .OR. cUF="SP" .OR. cUF="BAIXASP"
            FIELD->CNAE:=cCNAE
            IF VAL(FIELD->CNAE)=0
               FIELD->CNAE:=""
            ENDIF
          ENDIF
		  //grava so ibge diminuir tamanho arquivos
          cIBGE:=""
          IF cUF="PR" .OR. cUF="BAIXAPR" //no parana nao usa nem ibge nem irrf e sim codificacao propria da tabela prcid 
             dbselectar('prcid')
             dbgotop()
             if dbseek(cCIDADE)
                cCIDADE:=PRCID->MUNICIPIO
                cIBGE:=BUSCAIBGE('PR',cCIDADE)
			 ELSE
                cCIDADE:="" //zera a cidade para evitar erros			 
             endif
             dbselectar(carqdbf)
          ENDIF	          
          IF cUF="SC"
             //em sc   ccidade esta com o codigo do irrf da cidade                             
             cIBGE:=IRRFIBGE(cCIDADE) //retorna o ibge passando ccidade=codigoirrf
          ENDIF	
          
          IF cUF="TODASPB"    //Pode ser substitutivo por isso usa estado aqui                       
             cIBGE:=BUSCAIBGE(cESTADO,cCIDADE)                  
          ENDIF	 
		  
		  IF Empty(cIBGE) .AND. ! Empty(cCIDADE) 
		     cIBGE:=BUSCAIBGE(cUF,cCIDADE)
		  ENDIF	

		 IF .NOT. EMPTY(cIBGE)     
			//SU SUFRAMA   YY ajustes
			 IF cUF="GO" .OR. cUF="PB" .OR. cUF="TODASPB" .OR. cUF="PB" .OR. cUF="SC" .OR. cUF="SU" .OR. cUF="DF" .OR. cUF="PR" ;
                .OR. cUF="SP" .OR. cUF="BAIXASP".OR. cUF="BAIXAPR" .OR. cUF="YY"
				FIELD->IBGE:=cIBGE
                //Corrige caso venha fora do padrao em algum txt
                IF VAL(FIELD->IBGE)=0  .or. len(alltrim(FIELD->IBGE))<7
                   FIELD->IBGE:=""
                ENDIF
			 ENDIF	
		  ENDIF	
		  IF ! EMPtY(cNOME) 
             cNOME:=TiRACE(cNOME)
             IF cUF="MA" .OR. cUF="RO" .OR. cUF="GO" .OR. cUF="BAIXAGO" .OR. cUF="PB" .OR. cUF="PA" .OR. cUF="MG" .OR. cUF="PI" ;
                .OR. cUF="SP" .OR. cUF="BAIXASP".OR. cUF="TODASPB" 
               FIELD->NOME:=cNOME
             ENDIF
          ENDIF
           IF cUF=="RS" .OR. cUF=="BA" .OR. cUF=="CPFBA" .OR. cUF=="SE" 
             FIELD->CATEGORIA:=cCATEGORIA
          ENDIF
          IF cUF="PA" .OR. cUF="GO" .OR. cUF="BAIXAGO" .OR. cUF="SC"  .OR. cUF="SP" .OR. cUF="BAIXASP"
             field->DATA:=dDATA
          ENDIF	
          IF cUF="TODASPB"   .OR. cUF="PB"  .OR. cUF="SP" .OR. cUF="BAIXASP"
          
            /*
            NOR;NORMAL
            SIM;SIMPLES NACIONAL
            OUT;OUTROS
            FON;FONTE
            RUR;PRODUTOR RURAL PESSO
            SUB;SUBST TRIBUT.
            ESP;ESPECIAL
            */
            
            //Grava sigla para a base nao ficar muito grande melhoria perfomace leitura gravacao
            DO CASE
               CASE cREGIME="NORMAL"
                    cREGIME:="NOR"
               CASE AT("PRODUTOR RURAL",cREGIME)>0
                    cREGIME:="RUR"
               CASE cREGIME="FONTE"
                    cREGIME:="FON"   
               CASE cREGIME="ESPECIAL"
                    cREGIME:="ESP"
               CASE cREGIME="SIMPLES NACIONAL"
                    cREGIME:="SIM"
               CASE cREGIME="OUTROS"
                    cREGIME:="OUT"
               CASE AT("SUBST TRIBUT",cREGIME)>0
                    cREGIME:="SUB"                                                   
            ENDCASE
      
             
          ENDIF
          IF cUF="PA" .OR. cUF="TODASPB"   .OR. cUF="PB"    .OR. cUF="SP" .OR. cUF="BAIXASP"                   
             field->REGIME:=cREGIME
          ENDIF
          IF cUF="SP" .OR. cUF="BAIXASP"  .OR. cUF="TODASPB"    //grava so cep e o numero pelo cep traz bairro logradouro tipo logradouro
//             field->ENDTIP  :=cENDTIP          
//             field->ENDERECO:=cENDERECO
             field->NUMEND:=cNUMEND  
//             field->COMPLEM:=cCOMPLEM
//             field->BAIRRO:=cBAIRRO
             field->CEP:=cCEP   
          ENDIF
          dbunlock()   
          
          dbselectar(cARQIR) 
          dbgotop()
          if ! dbseek(cCNPJ)
             netrecapp()
             field->cnpj:=cCNPJ
          else
             netreclock()
          endif
          IF cUF="PR" .OR. cUF="SP".OR. cUF="TODASPB"   .OR. cUF="PB"
             if ! empty(cCNAE) .AND. EMPTY(FIELD->cnae)
                field->cnae:=cCNAE
             endif
          endif
          IF cUF="PR" .OR. cUF="SP" .OR. cUF="TODASPB"   .OR. cUF="PB"
             if ! empty(cIBGE) .AND. EMPTY(FIELD->IBGE)
                field->IBGE:=cIBGE
             endif
          endif   
          IF cUF="SP" .OR. cUF="TODASPB" .OR. cUF="PB"
             if ! empty(cNOME) .AND. EMPTY(FIELD->NOME)
                field->NOME:=cNOME
             endif
          endif 
          IF cUF="SP" .OR. cUF="TODASPB" .OR. cUF="PB"
             if ! empty(cNUMEND) .AND. EMPTY(FIELD->NUMEND)
                field->NUMEND:=cNUMEND
             endif
          endif  
          IF cUF="SP" .OR. cUF="TODASPB" .OR. cUF="PB"
             if ! empty(cCEP) .AND. EMPTY(FIELD->cEP)
                field->cEP:=cCEP
             endif
          endif 
          dbunlock()
        
          //retorna are CNPJIE
          dbselectar(cARQDBF)  
   endif


   zei_fort(nLASTREC,,,1)
   nLINHA++   
enddo
FCLOSE(nHANDLE)


dbcloseall()

MDS("...")
ferase(cARQTXT)
RETURN .T.


