*+ЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭ
*+
*+    Source Module => FLIB04.PRG
*+
*+               Function INFOR()
*+
*+ЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭ


*+ЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭ
*+
*+    Function INFOR()
*+
*+ЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭЭ
*+
func INFOR          //INDEXAR E EXIBIR INFORMACAO ARQUIVO

para mARQUIVO, aCHAVE, aINDICE, lCHECA, aTAG, lAPA
local nERRO
local x
if valtype( lCHECA ) # "L"
   lCHECA := .F.
endif
if valtype( aTAG ) = "U"                //Nao Passada tag
   aTAG := ""
endif
if valtype( lAPA ) # "L"
   lAPA := .T.
endif
if valtype( aCHAVE ) = "C"              //Caracter Vira Array
   aCHAVE  := { aCHAVE }
   aINDICE := { aINDICE }
   aTAG    := { aTAG }
endif
for X := 1 to len( aINDICE )
   mINDICE := aINDICE[ X ]
   if lCHECA        //Se Tiver o Indice nao Indexa
      if file( mINDICE+ +ordbagext() ) .or. HB_FILEEXISTS( ZDIRE + mINDICE + ordbagext() ) 
         retu .T.
      endif
   endif
   if lAPA 
      IF file( mINDICE + ordbagext() )
         ferase( mINDICE + ordbagext() )              //Apaga o Indice
      endif   
      if file( ZDIRE + mINDICE+ ordbagext() )
         ferase( ZDIRE + mINDICE + ordbagext() )      //Apaga o Indice empresa
      endif
   endif
next X
if ! netuse(mARQUIVO,,.F.,.F.,.T.,.F.,30) 
    //netuse(cARQ,cDRIVER,lSHA,lREAD,lNEW,lINDEX,nTIME )
   retu .F.
endif
//@  6,  0, 23, 78 box "+-+Э+-+Э "
//@  7,  3 say spac( 21 ) + "Quadro Informativo do Arquivo" + spac( 26 )
//@ 08,  4 say "Nome" + spac( 12 ) + chr( 16 )
//@ 09,  4 say "Chave" + spac( 11 ) + chr( 16 )
//@ 10,  4 say "Indice" + spac( 10 ) + chr( 16 )
//@ 11,  4 say "TAG   " + spac( 10 ) + chr( 16 )
//@ 12,  4 say "Registros" + spac( 7 ) + chr( 16 )
//@ 13,  4 say "Movimenta‡„o    " + chr( 16 )
//@ 24, 00 say chr( 16 ) + "  Aguarde Reorganizando  " + chr( 17 )
//@ 08, 23 say alias()
//@ 12, 23 say str( lastrec(), 7 )
//@ 13, 23 say dtoc( lupdate() )
pack
for X := 1 to len( aINDICE )
   mCHAVE  := aCHAVE[ X ]
   mINDICE := aINDICE[ X ]
   mTAG    := aTAG[ X ]
   if empty( mTAG ) .and. upper( ordbagext() ) = ".CDX"
      mTAG := mINDICE
   endif
//   @ 09, 23 say alltrim( mCHAVE )
//   @ 10, 23 say alltrim( mINDICE )
//   @ 11, 23 say alltrim( mTAG )
   
   nLASTREC:=LASTREC()
   zei_fort( nLASTREC,,,0)
   
   if empty( mTAG )
      index on &mCHAVE to &mINDICE EVAL ZEI_FORT(nLASTREC,,,1)
   else
      index on &mCHAVE tag &mTAG. EVAL ZEI_FORT(nLASTREC,,,1)
   endif
next X
dbclosearea()
//setcolor( "W/N,N/W" )
//@ 06,00 CLEAR
retu .T.


*+ EOF: FLIB04.PRG

