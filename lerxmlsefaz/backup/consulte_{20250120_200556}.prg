#include <hmg.ch>
#include "try.ch"

function consultex(nTIPO,cID)
   System.Clipboard := cID
   
if nTIPO=2 .AND. Idufnum(cID)<>'35'   
   msginfo("NF nao e de Sao Paulo Usando Portal Nacional")
   nTIPO=1
endif

   
   SWITCH nTIPO
      CASE 1 //Nacional
        if idcte(cID)
           abrirpagina("https://www.cte.fazenda.gov.br/portal/consulta.aspx?tipoConsulta=completa&tipoConteudo=mCK/KoCqru0=")
		   
        ELSE
           abrirpagina("http://www.nfe.fazenda.gov.br/portal/consultaRecaptcha.aspx?tipoConsulta=completa&tipoConteudo=XbSeqxE8pl8=",'NA',cID)
        ENDIF        
        EXIT 
      CASE 2 //SP
        if idcte(cID)
           abrirpagina("https://nfe.fazenda.sp.gov.br/cteConsulta/consulta/publica/ConsultarCTe.aspx")
        ELSE
           abrirpagina("https://nfe.fazenda.sp.gov.br/ConsultaNFe/consulta/publica/ConsultarNFe.aspx","SP",cID)
        ENDIF       
        EXIT 
      CASE 3 //rs scan
        if idcte(cID)
           abrirpagina("https://www.sefaz.rs.gov.br/CTE/CTE-COM.aspx")
        ELSE
           abrirpagina("http://www.sefaz.rs.gov.br/ASP/AAE_ROOT/NFE/SAT-WEB-NFE-COM_1.asp?")
        ENDIF        
        EXIT 
     case 4
         checasituacao()     
        EXIT  
   ENDSWITCH
return .t.
