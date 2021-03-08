*+　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　
*+
*+    Function IMPHP()
*+
*+　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　　
*+
*
#include "hmg.ch"


function imphp()
DEFINE WINDOW imphp AT 132 , 235 WIDTH 403 HEIGHT 323 VIRTUAL WIDTH Nil VIRTUAL HEIGHT Nil TITLE "Escolher Tipo Impressora" ICON NIL MODAL CURSOR NIL ON INIT Nil ON RELEASE Nil ON INTERACTIVECLOSE Nil ON MOUSECLICK Nil ON MOUSEDRAG Nil ON MOUSEMOVE Nil ON SIZE Nil ON PAINT Nil BACKCOLOR Nil ON GOTFOCUS Nil ON LOSTFOCUS Nil ON SCROLLUP Nil ON SCROLLDOWN Nil ON SCROLLLEFT Nil ON SCROLLRIGHT Nil ON HSCROLLBOX Nil ON VSCROLLBOX Nil

    DEFINE RADIOGROUP opcaohp
        ROW    40
        COL    50
        WIDTH  130
        HEIGHT 200
        OPTIONS { 'Matricial','HP',"Laser","Lexmark","Lista-1","Lista-2","Lista-3","Sem Codigo"}
        VALUE 3
        FONTNAME "Arial"
        FONTSIZE 9
        TOOLTIP ""
        ONCHANGE Nil
        FONTBOLD .F.
        FONTITALIC .F.
        FONTUNDERLINE .F.
        FONTSTRIKEOUT .F.
        HELPID Nil
        TABSTOP .T.
        VISIBLE .T.
        TRANSPARENT .F.
        SPACING 25
        BACKCOLOR NIL
        FONTCOLOR NIL
        READONLY Nil
        HORIZONTAL .F. 
    END RADIOGROUP

    DEFINE BUTTON txtgravar
        ROW    50
        COL    230
        WIDTH  100
        HEIGHT 28
        ACTION imphpgrv()
        CAPTION "Gravar"
        FONTNAME "Arial"
        FONTSIZE 9
        TOOLTIP ""
        FONTBOLD .F.
        FONTITALIC .F.
        FONTUNDERLINE .F.
        FONTSTRIKEOUT .F.
        ONGOTFOCUS Nil
        ONLOSTFOCUS Nil
        HELPID Nil
        FLAT .F.
        TABSTOP .T.
        VISIBLE .T.
        TRANSPARENT .F.
        MULTILINE .F.
        PICTURE Nil
        PICTALIGNMENT TOP
    END BUTTON

END WINDOW
imphp.Center
imphp.Activate
return  .t.




function imphpgrv()
nHP:=imphp.opcaohp.value
imphptipo(nHP)
imphp.release
return .t.

function imphptipo(nHP)
aRETU := { chr( 15 ), chr( 18 ), chr( 14 ),CHR(27)+CHR(69),CHR(27)+CHR(70) }
        //1-normal 2-comprimido 3-expandido 4-negrito 5-sem negrito
if nHP = 2
   aRETU := { chr(27)+chr(40)+chr(115)+"16"+chr(72), ;
              chr(27)+chr(40)+chr(115)+"12"+chr(72), ;
              chr(27)+chr(40)+chr(115)+"23"+chr(72), ;
              chr(27)+chr(40)+chr(115)+CHR(51)+chr(66), ;
              chr(27)+chr(40)+chr(115)+CHR(45)+CHR(51)+chr(66)}                 
endif
if nHP = 3
   aRETU := { chr( 27 ) + chr( 38 ) + chr( 107 ) + chr( 50 ) + chr( 83 ), ;
              chr( 27 ) + chr( 38 ) + chr( 107 ) + chr( 48 ) + chr( 83 ), "" , ; 
              chr( 27 ) + chr( 40 ) + chr( 115 ) + CHR(51) + chr( 66 ), ;
              chr( 27 ) + chr( 40 ) + chr( 115 ) + CHR(48) + chr( 66 ) }
endif
if nHP = 4
   aRETU := { chr( 27 ) + chr( 38 ) + chr( 107 ) + chr( 50 ) + chr( 83 ) + chr( 27 ) + chr( 38 ) + ;
              chr( 108 ) + "8" + chr( 68 ) + chr( 27 ) + chr( 38 ) + chr( 108 ) + "90" + chr( 80 ), ;
              chr( 27 ) + chr( 38 ) + chr( 107 ) + chr( 52 ) + chr( 83 ) + chr( 27 ) + chr( 38 ) + ;
              chr( 108 ) + "5" + chr( 68 ) + chr( 27 ) + chr( 38 ) + chr( 108 ) + "66" + chr( 80 ), ;
              chr( 27 ) + chr( 40 ) + chr( 115 ) + "23" + chr( 72 ) + chr( 27 ) + chr( 38 ) + chr( 108 ) + ;
              "10" + chr( 68 ) + chr( 27 ) + chr( 38 ) + chr( 108 ) + "90" + chr( 80 ) }
endif
IF nHP = 5
endif
IF nHP = 6
endif
IF nHP = 7
ENDIF
if nHP = 8
   aRETU := { "", "", "" ,"",""}
endif
//Variaveis Publicas de Impressao
cIMPCOM := aRETU[ 1 ]
cIMPEXP := aRETU[ 2 ]
cIMPTIT := aRETU[ 3 ]
IF LEN(aRETU)>3 //temporariamente ate pegar codigos posicoes 4,5 impressoras
   cIMPNEG := aRETU[ 4 ]
   ciMPNER := aRETU[ 5 ]
ELSE
   cIMPNEG := ""
   ciMPNER := ""
ENDIF 
retu aRETU

