*****************CORRECAO TXT LINUX

function IMPTXTSEFAZ



aUF    := { "PR","BAIXAPR", "RS", "BAIXARS", "SC", "CPFSC", "MA", "BAIXAMA", "SE", "RO", ;
            "MS", "ES", "CE", "PA", "MG", "TODASPB","PB", "PI", "PE","BA","CPFBA","RJ","GO","BAIXAGO","AL"}

aUF2   := { "PR","PR", "RS", "RS", "SC", "SC", "MA", "MA", "SE", "RO", ;
            "MS", "ES", "CE", "PA", "MG", "PB", "PB","PI", "PE","BA","BA","RJ","GO","GO","AL"}

if file("contodos.txt")  //todaspb tem diferenca da contodos uma usa ; outra usa |
   frename("contodos.txt","pb.txt")
endif

if file("connormal.txt") .and. ! HB_FILEEXISTS('pb.txt') //todaspb tem diferenca da contodos uma usa ; outra usa |
   frename("connormal.txt","pb.txt")
endif

if file("conoutros.txt") .and. ! HB_FILEEXISTS('pb.txt') //todaspb tem diferenca da contodos uma usa ; outra usa |
   frename("conoutros.txt","pb.txt")
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


if file("cadastro.txt")
    nHANDLE:=FOPEN("cadastro.txt")
    cLINHA := ALLTRIM(FREADLINE( nHANDLE ))
	fclose(Nhandle)	
    if at(";",cLINHA)>0
       frename("cadastro.txt","al.txt")
	else 
       cSITUACAO:=SUBSTR(cLINHA,92,1)		  
	   if cSITUACAO="N" .OR. cSITUACAO='H'	      
	      frename("cadastro.txt","mg.txt")	   	  
	   else 
	      if at("ESTADO DE SC",cLINHA)>0		     
		     frename("cadastro.txt","sc.txt")	   	  
		  endif
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
   frename("ativos.txt","pr.txt")
endif

if file("cancelados.txt")
   frename("cancelados.txt","baixapr.txt")
endif

if file("cadastro"+dtos(date())+".txt")
   frename("cadastro"+dtos(date())+".txt","mg.txt")
endif

//if file(".txt")
   //frename("",".txt")
//endif


//if file(".txt")
   //frename("",".txt")
//endif
        
            
IF MDG("Atualizar txts")   
   for y=1 to len(aUF)
      atualiza(aUF[y],aUF2[y])
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
           nHANDLE:=FOPEN(cTXTBA)
           LINHA := ALLTRIM(FREADLINE( nHANDLE ))
           while .T.
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
              LINHA := alltrim( FREADLINE( nHANDLE ) )
              IF LINHA = "__FINAL__"
                 exit
              endif
              zei_fort(nLASTREC,,,1)
           enddo
          dbcloseall()
          fclose(nhandle)
          ferase(cTXTBA)       
       endif
    endif
NEXT Y

/*
//trocar ie pe velho->novo
if file("peie.txt.new") //ba contribuintes
   IF  netuse("CNPJIEPE")
       dbsetorder(2)
       mds("atualizando ie Pernanbuco")
       nLASTREC:=FLINECOUNT("peie.txt.new")
       zei_fort( nLASTREC,,,0)
       nHANDLE:=FOPEN("peie.txt.new")
       LINHA := ALLTRIM(FREADLINE( nHANDLE ))
       while .T.
          MDS(linha)          
          cIE:=SUBSTR(LINHA,1,14)
          cIENEW:=SUBSTR(LINHA,16)
          dbgotop()
          IF dbseek(cIE)
             netreclock()
             field->ieold:=cIE
             field->ie   :=cIENEW    
             dbunlock()
          endif
          LINHA := alltrim( FREADLINE( nHANDLE ) )
          IF LINHA = "__FINAL__"
             exit
          endif
          zei_fort(nLASTREC,,,1)
       enddo
      dbcloseall()
      fclose(nhandle)
      ferase("peie.txt.new")
      ferase("peie.txt")
   else
     //  alert("erro abrir cnpjieba")
   endif
else
   //alert("falta ba situ")
endif
*/

IF file("PrestadoresNFe.txt")
   cCAM := PROFILESTRING( "sped.ini","PATH","CNPJIEUF",HB_CWD())
   IF  netuse(Ccam+"CCMSP")       
       mds("Atualizando CCMSP")
       nLASTREC:=FLINECOUNT("PrestadoresNFe.txt")
       zei_fort( nLASTREC,,,0)
       nHANDLE:=FOPEN("PrestadoresNFe.txt")
       LINHA := ALLTRIM(FREADLINE( nHANDLE ))
       nLINHA:=1
       while .T.
          MDS(linha+STR(nLINHA)+"/"+STR(nLASTREC))          
          cCNPJ:=TIRAOUT(LINHA)
          dbgotop()
          IF ! dbseek(cCNPJ)
             netrecapp()
             CCMSP->cnpj:=cCNPJ             
             dbunlock()
          endif
          LINHA := alltrim( FREADLINE( nHANDLE ) )
          IF LINHA = "__FINAL__"
             exit
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
    for y=1 to 4
        DO CASE
           CASE y=1
               cUF="MA"
           CASE y=2
               cUF="RS"
           CASE y=3
               cUF="GO"
           CASE y=4
               cUF="PR"
        ENDCASE
        if file(cCAM+"CNPJIE"+cUF+".DBF").and.file(CCAM+"BAIXA"+cUF+".DBF")
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
       aUF:={"baixago","baixama","baixapr","baixars","cnpjieac","cnpjieal","cnpjieam",    ;
            "cnpjieap","cnpjieba","cnpjiece","cnpjiedf","cnpjiees",  ;
            "cnpjiego","cnpjiema","cnpjiemg","cnpjiems","cnpjiemt","cnpjiepa","cnpjiepb",  ;
            "cnpjiepe","cnpjiepi","cnpjiepr","cnpjierj","cnpjiern","cnpjiero","cnpjierr",  ;
            "cnpjiers","cnpjiesc","cnpjiese","cnpjiesp","cnpjieto" }
       aUF2:={"GO","MA","PR","RS","AC","AL","AM",    ;
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


FUNCTION ATUaLIZA(cUF,cUF2)
cARQTXT:=cUF+".txt"
cARQDBF:="CNPJIE"+cUF
DO CASE
   CASE cUF="BAIXAPR"
   	  cARQDBF:="BAIXAPR"
   	  cARQTXT:="BAIXAPR.TXT"
   CASE cUF="BAIXAGO"
   	  cARQDBF:="BAIXAGO"
   	  cARQTXT:="BAIXAGO.TXT"
   //CASE cUF="RS" //.AND.FILE("ICS_ATIVO.TXT")	       
        //cARQTXT:="ICS_ATIVO.TXT"        
   CASE cUF="BAIXARS"	
       cARQDBF:="BAIXARS"
       cARQTXT:="BAIXARS.TXT"
       //IF FILE("ICS_BAIXADO.TXT") //rename acima
       //   cARQTXT:="ICS_BAIXADO.TXT"
       //ELSE
       //   cARQTXT:="BAIXARS.TXT"
       //ENDIF  
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
   retu .f.
endif

cCAMINHO   := PROFILESTRING( "sped.ini","MD10.DBF","CAMINHO",HB_CWD())+"MD10"
IF ! NETUSE(cCAMINHO)
   DBCLOSEALL()
   RETURN .f.
ENDIF

IF cUF="PR".OR.cUF="BAIXAPR"
   cCAMINHO   := PROFILESTRING( "sped.ini","PRCID.DBF","CAMINHO",HB_CWD())+"PRCID"
   IF ! NETUSE(cCAMINHO)
      DBCLOSEALL()
      RETURN .f.
   ENDIF
ENDIF

cCAM := PROFILESTRING( "sped.ini","PATH","CNPJIEUF",HB_CWD())
IF ! netuse(Ccam+cARQDBF)
   dbcloseall()
   return .f.
endif



mds("contando as linhas: "+cARQTXT)
nLASTREC:=FLINECOUNT(cARQtxt)
nLINHA:=1
zei_fort( nLASTREC,,,0)
MDS(PADR(cARQTXT+"->"+cARQDBF,40))
//nHANDLE:=FOPEN(cARQTXT)
//LINHA := ALLTRIM(FREADLINE( nHANDLE ))
nFile := HB_FUse(cARQTXT)
LINHA:=HB_FREADLN()  
WHILE .NOT. HB_FEof()   
//while .T.
   MDS(cUF+" "+STR(nLINHA)+"/"+STR(nLASTREC)+" -> "+LEFT(linha,50))             
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
   cCEP     := ""
   cREGIME  :=""
   cESTADO  :="" //difere de cUF(Passado funcao) para evitar erros pode ser ST subistituto tributario
   cNUMEND  :=""
   cENDTIP  :=""
   cCOMPLEM :=""
   cREGIME  :=""
   
   

   do case

    Case cUF="AC"

    Case cUF="AM"

    Case cUF="AP"

    Case cUF="DF"

    Case cUF="MA".or.cUF="BAIXAMA"
       //Mudado strutura
        //aStruct:= {{"IE","C",9,0},;
        //          {"SEP01","C",2,0},;
        //          {"CNPJ","C",14,0},;
        //          {"SEP02","C",55,0}}
       //cIE:=    SUBSTR(LINHA,1,9)
       //cCNPJ:=     alltrim(SUBSTR(LINHA,12,14))
       //120000520        //1o. linha ie
       //06265946000166   //2o.linha cnpj
       //                 //3 Linha em branco
       // cIE:=LINHA
      //  LINHA := alltrim( FREADLINE( nHANDLE ) ) //linha cnpj
      //  cCNPJ:=LINHA
      //  LINHA := alltrim( FREADLINE( nHANDLE ) ) // Linha em branco apenas saltar

         
         cCNPJ:=SUBSTR(LINHA,01,14)
         cIE  :=SUBSTR(LINHA,15,9)
         cCNAE:=SUBSTR(LINHA,24,7)         
         cNOME:=SUBSTR(LINHA,31,200)
         


    Case cUF="MG" //LIMITADOR LINUX
         cIE:=SUBSTR(LINHA,1,13)
         cCNPJ:=SUBSTR(LINHA,15,14)
         cNOME:=SUBSTR(LINHA,31,60)
         cSITUACAO:=SUBSTR(LINHA,92,1)  //H = Habilitado  N= NÆo Habilitado

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
//IE|NOME|CNPJ|SITUACAO|REGIME|CNAE|AtivEcon|TipoLogr|NomeLogr|NUm|Compl|Bairro|CIDADE|UF|CEP|ENDERECONC    
//1  2    3    4        5      6    7        8        9        10  11    12     13     14 15  16
          aCAMPOS:=HB_ATokens(LINHA,"|")          
          if len(aCAMPOS)>=0  //O Txt as vezes tem linhas em branco
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
    Case cUF="SP"

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
     	  cCATEGORIA:=SubStr(LINHA,61)



   endcase

   cNOME:=STRTRAN(cNOME,"  ","") //tirar duplo espaco
   
   if  ! empty(cCNPJ) .AND. ! EMPTY(cIE) .AND. ((VALCGC( cCNPJ,,.F.) .and. ValIE( cIE, cUF2 , , .f. , .f. ) ) .or. Valcpf( cCNPJ ,.f.))         //VALIEOLD(cIE, cUF2,.F.))
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
          	         .OR. cUF="SE" .OR. cUF="CPFSC" .OR. cUF="PA" .OR. cUF="MG" .OR. cUF="BAIXAPR"
             field->SITUACAO:=cSITUACAO
          ENDIF	
          IF cUF="ES" .OR. cUF="MS" .OR. cUF="PE" .OR. cUF="PR" .OR. cUF="RS" ;
                  .OR. cUF="BAIXARS" .OR. cUF="SE" .OR. cUF="BAIXAPR"
             field->DATA:=cDATA
          ENDIF	 //campos data tipo date abaixo
          IF cUF="RO" .OR. cUF="ES" .OR. cUF="MS" .OR. cUF="RS" .OR. cUF="SC" .OR. cUF="PA" .OR. cUF="TODASPB" //.OR.cUF="PE"
             field->UF:=cESTADO
          ENDIF	
          IF cUF="MA" .OR. cUF="PR" .OR. cUF="RS" .OR. cUF="GO" .OR. cUF="SC" .OR. cUF="PA" .OR. cUF="BAIXAPR"  .OR. cUF="TODASPB" 
            FIELD->CNAE:=cCNAE
            IF VAL(FIELD->CNAE)=0
               FIELD->CNAE:=""
            ENDIF
          ENDIF
          cIBGE:=""
          IF cUF="GO".OR.cUF="PB".OR.cUF="SC" .OR. cUF="TODASPB" 
             FIELD->MUNICIPIO:=cCIDADE                                        
          ENDIF	
          IF cUF="PR".OR.cUF="BAIXAPR"             
             FIELD->MUNICIPIO:=cCIDADE 
             dbselectar('prcid')
             dbgotop()
             if dbseek(cCIDADE)
                cCIDADE:=MUNICIPIO
                cIBGE:=BUSCAIBGE('PR'+cCIDADE)
                dbselectar(carqdbf)
                if ! empty(cIBGE)
                    FIELD->IBGE:=cIBGE                      
                ENDIF    
             endif
             dbselectar(carqdbf)
          ENDIF	          
          IF cUF="SC"
             FIELD->IRRF:=cCIDADE                                        
             cIBGE:=IRRFIBGE(cCIDADE)
             FIELD->IBGE:=cIBGE                      
          ENDIF	
          IF cUF="GO" .OR. cUF="PB"  .OR. cUF="TODASPB" 
             IF  cUF="TODASPB"                           
                 cIBGE:=BUSCAIBGE(cESTADO+cCIDADE)
             ELSE
                 cIBGE:=BUSCAIBGE(cUF+cCIDADE)
             ENDIF             
             FIELD->IBGE:=cIBGE                      
          ENDIF	          
          IF cUF="MA" .OR. cUF="RO" .OR. cUF="GO" .OR. cUF="BAIXAGO" .OR. cUF="PB" .OR. cUF="PA" .OR. cUF="MG" .OR. cUF="PI" .OR. cUF="TODASPB" 
             FIELD->NOME:=cNOME
          ENDIF	
          IF cUF=="RS" .OR. cUF=="BA" .OR. cUF=="CPFBA" .OR. cUF=="SE" 
             FIELD->CATEGORIA:=cCATEGORIA
          ENDIF
          IF cUF="PA" .OR. cUF="GO" .OR. cUF="BAIXAGO" .OR. cUF="SC"
             field->DATA:=dDATA
          ENDIF	
          IF cUF="PA" .OR. cUF="TODASPB"   .OR. cUF="PB"                      
             field->REGIME:=cREGIME
          ENDIF
          IF cUF="TODASPB"      
             field->ENDTIP  :=cENDTIP          
             field->ENDERECO:=cENDERECO
             field->NUMEND:=cNUMEND  
             field->COMPLEM:=cCOMPLEM
             field->BAIRRO:=cBAIRRO
             field->CEP:=cCEP   
          ENDIF
          dbunlock()   	
   endif

//   LINHA := alltrim( FREADLINE( nHANDLE ) )
//   IF LINHA = "__FINAL__"
//      exit
///   endif
   
   HB_FSkip(1)
   LINHA:=HB_FREADLN()  
   //LINHA:=HB_FREADLN()  
   zei_fort(nLASTREC,,,1)
   nLINHA++   
enddo
HB_FUse()
//FCLOSE(nHANDLE)

IF cUF="PE"
   nHANDLE:=FCREATE("PEIE.TXT")
   dbgotop()
   while ! eof()
      fwrite(nHANDLE,IE+HB_OsNewLine()) 
      dbskip()
   enddo
   FCLOSE(nHANDLE)
ENDIF
dbselectar(carqdbf)
IF cUF="GO" .OR. cUF="PB" .OR. cUF="SC" .OR. cUF="PR" .OR. cUF="BAIXAPR"             
   dbgotop()
   while ! eof()
      MDS(FIELD->CNPJ)
      if VAL(FIELD->IBGE)=0 
         NETRECLOCK()
          IF cUF="SC" .AND. ! EMPTY(FIELD->IRRF)            
             cIBGE:=IRRFIBGE(FIELD->IRRF)
             FIELD->IBGE:=cIBGE                      
          ENDIF	
          IF cUF="GO" .OR. cUF="PB"              
            cIBGE:=BUSCAIBGE(cUF+FIELD->MUNICIPIO)
            FIELD->IBGE:=cIBGE        
         ENDIF            
         IF cUF="GO" .OR. cUF="SC" 
            IF VAL(FIELD->CNAE)=0
                FIELD->CNAE:=""
            ENDIF
         ENDIF
         IF cUF="PR" .OR. cUF="BAIXAPR" 
             cCIDADE:=ALLTRIM(FIELD->MUNICIPIO)         
             dbselectar('prcid')
             dbgotop()
             if dbseek(cCIDADE)
                cCIDADE:=ALLTRIM(PRCID->MUNICIPIO)
                cIBGE:=BUSCAIBGE('PR'+cCIDADE)
                dbselectar(carqdbf)
                if ! empty(cIBGE)
                    FIELD->IBGE:=cIBGE                      
                ENDIF    
             endif
             dbselectar(carqdbf)
          ENDIF	    
         DBUNLOCK()
      endif   
      dbskip()
   enddo
endif
dbcloseall()
MDS("...")
ferase(cARQTXT)
RETURN .T.



FUNCTION BUSCAIBGE(cBUSCA)
cIBGE:=""
cALIAS:=ALIAS()
cBUSCA := strtran( alltrim( cBUSCA ), "'", " " )    //tirar como d'agua d'olho
dbselectar("MD10")
dbsetorder(1)
dbgotop()
if dbseek(cbUSCA)
  cIBGE:=MD10->CODIBGE
endif
dbselectar(cALIAS)
return cIBGE

FUNCTION IRRFIBGE(cBUSCA)
cIBGE:=""
cALIAS:=ALIAS()
dbselectar("MD10")
dbsetorder(5)
dbgotop()
if dbseek(cbUSCA)
  cIBGE:=MD10->CODIBGE
endif
dbselectar(cALIAS)
return cIBGE


