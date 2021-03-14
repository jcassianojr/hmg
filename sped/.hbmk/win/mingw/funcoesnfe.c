/*
 * Harbour 3.2.0dev (r2011030937)
 * MinGW GNU C 7.3 (32-bit)
 * Generated C source from "c:\develop\hmg\lerxmlsefaz\funcoesnfe.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( EMISSAOANO );
HB_FUNC_EXTERN( SUBSTR );
HB_FUNC( EMISSAOMES );
HB_FUNC( EMISSAODATA );
HB_FUNC_EXTERN( STOD );
HB_FUNC_EXTERN( STRTRAN );
HB_FUNC( IDNFF );
HB_FUNC_EXTERN( ALLTRIM );
HB_FUNC_EXTERN( STR );
HB_FUNC_EXTERN( VAL );
HB_FUNC( IDNFF9 );
HB_FUNC( IDMODELO );
HB_FUNC( IDUFNUM );
HB_FUNC( IDUFUF );
HB_FUNC_EXTERN( CODUF );
HB_FUNC( IDCNPJ );
HB_FUNC( IDCTE );
HB_FUNC( IDCTEOS );
HB_FUNC( IDNFE );
HB_FUNC( IDEMISSOR );
HB_FUNC( IDSERIE );
HB_FUNC( IDANO );
HB_FUNC( IDMES );
HB_FUNC( IDDIZER );
HB_FUNC( IDFORMATADA );
HB_FUNC_EXTERN( TRANSFORM );
HB_FUNC( IDFORMATAUF );
HB_FUNC( IDMODELOTIPO );
HB_FUNC( IDMODELOTF );
HB_FUNC( IDMODELOCF );
HB_FUNC( PEGCAMXML );
HB_FUNC_EXTERN( EMPTY );
HB_FUNC_EXTERN( ASCAN );
HB_FUNC_EXTERN( AADD );
HB_FUNC_EXTERN( STRZERO );
HB_FUNC_EXTERN( YEAR );
HB_FUNC_EXTERN( DATE );
HB_FUNC_EXTERN( MONTH );
HB_FUNC_EXTERN( FILE );
HB_FUNC_EXTERN( LEN );
HB_FUNC( PEGACADASTRO );
HB_FUNC( PEGADADOS );
HB_FUNC_EXTERN( VALTYPE );
HB_FUNC_EXTERN( UPPER );
HB_FUNC_EXTERN( AT );


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_FUNCOESNFE )
{ "EMISSAOANO", {HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL}, {HB_FUNCNAME( EMISSAOANO )}, NULL },
{ "SUBSTR", {HB_FS_PUBLIC}, {HB_FUNCNAME( SUBSTR )}, NULL },
{ "EMISSAOMES", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( EMISSAOMES )}, NULL },
{ "EMISSAODATA", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( EMISSAODATA )}, NULL },
{ "STOD", {HB_FS_PUBLIC}, {HB_FUNCNAME( STOD )}, NULL },
{ "STRTRAN", {HB_FS_PUBLIC}, {HB_FUNCNAME( STRTRAN )}, NULL },
{ "IDNFF", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( IDNFF )}, NULL },
{ "ALLTRIM", {HB_FS_PUBLIC}, {HB_FUNCNAME( ALLTRIM )}, NULL },
{ "STR", {HB_FS_PUBLIC}, {HB_FUNCNAME( STR )}, NULL },
{ "VAL", {HB_FS_PUBLIC}, {HB_FUNCNAME( VAL )}, NULL },
{ "IDNFF9", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( IDNFF9 )}, NULL },
{ "IDMODELO", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( IDMODELO )}, NULL },
{ "IDUFNUM", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( IDUFNUM )}, NULL },
{ "IDUFUF", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( IDUFUF )}, NULL },
{ "CODUF", {HB_FS_PUBLIC}, {HB_FUNCNAME( CODUF )}, NULL },
{ "IDCNPJ", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( IDCNPJ )}, NULL },
{ "IDCTE", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( IDCTE )}, NULL },
{ "IDCTEOS", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( IDCTEOS )}, NULL },
{ "IDNFE", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( IDNFE )}, NULL },
{ "IDEMISSOR", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( IDEMISSOR )}, NULL },
{ "IDSERIE", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( IDSERIE )}, NULL },
{ "IDANO", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( IDANO )}, NULL },
{ "IDMES", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( IDMES )}, NULL },
{ "IDDIZER", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( IDDIZER )}, NULL },
{ "IDFORMATADA", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( IDFORMATADA )}, NULL },
{ "TRANSFORM", {HB_FS_PUBLIC}, {HB_FUNCNAME( TRANSFORM )}, NULL },
{ "IDFORMATAUF", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( IDFORMATAUF )}, NULL },
{ "IDMODELOTIPO", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( IDMODELOTIPO )}, NULL },
{ "IDMODELOTF", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( IDMODELOTF )}, NULL },
{ "IDMODELOCF", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( IDMODELOCF )}, NULL },
{ "PEGCAMXML", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( PEGCAMXML )}, NULL },
{ "ACNPJITA", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "EMPTY", {HB_FS_PUBLIC}, {HB_FUNCNAME( EMPTY )}, NULL },
{ "ASCAN", {HB_FS_PUBLIC}, {HB_FUNCNAME( ASCAN )}, NULL },
{ "AADD", {HB_FS_PUBLIC}, {HB_FUNCNAME( AADD )}, NULL },
{ "STRZERO", {HB_FS_PUBLIC}, {HB_FUNCNAME( STRZERO )}, NULL },
{ "YEAR", {HB_FS_PUBLIC}, {HB_FUNCNAME( YEAR )}, NULL },
{ "DATE", {HB_FS_PUBLIC}, {HB_FUNCNAME( DATE )}, NULL },
{ "MONTH", {HB_FS_PUBLIC}, {HB_FUNCNAME( MONTH )}, NULL },
{ "CLOGIX", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "CLOGIX2", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "CLOGIX3", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "CLOGIX4", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "CNFECNPJ", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "CLOGIXARQ", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "CMEMORIZADOS", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "ZK", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "CFIMXML", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "ZL", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "FILE", {HB_FS_PUBLIC}, {HB_FUNCNAME( FILE )}, NULL },
{ "LEN", {HB_FS_PUBLIC}, {HB_FUNCNAME( LEN )}, NULL },
{ "PEGACADASTRO", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( PEGACADASTRO )}, NULL },
{ "PEGADADOS", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( PEGADADOS )}, NULL },
{ "XCNPJ", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "XNOME", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "XFANT", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "XLGR", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "XCPL", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "XNRO", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "XBAIRRO", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "CMUN", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "XMUN", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "XUF", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "XCEP", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "CPAIS", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "XPAIS", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "XFONE", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "XIE", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "XIEST", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "XISUF", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "XEMAIL", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "XIM", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "XCNAE", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "XCPF", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "VALTYPE", {HB_FS_PUBLIC}, {HB_FUNCNAME( VALTYPE )}, NULL },
{ "UPPER", {HB_FS_PUBLIC}, {HB_FUNCNAME( UPPER )}, NULL },
{ "AT", {HB_FS_PUBLIC}, {HB_FUNCNAME( AT )}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_FUNCOESNFE, "c:\\develop\\hmg\\lerxmlsefaz\\funcoesnfe.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_FUNCOESNFE
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_FUNCOESNFE )
   #include "hbiniseg.h"
#endif

HB_FUNC( EMISSAOANO )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,20,0,176,1,0,95,1,122,92,4,
		20,3,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( EMISSAOMES )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,23,0,176,1,0,95,1,92,6,92,
		2,20,3,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( EMISSAODATA )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,26,0,176,4,0,176,5,0,95,1,
		106,2,45,0,106,1,0,12,3,20,1,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( IDNFF )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,29,0,176,7,0,176,8,0,176,9,
		0,176,1,0,95,1,92,27,92,8,12,3,12,1,
		12,1,20,1,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( IDNFF9 )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,32,0,176,7,0,176,8,0,176,9,
		0,176,1,0,95,1,92,26,92,9,12,3,12,1,
		12,1,20,1,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( IDMODELO )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,35,0,176,1,0,95,1,92,21,92,
		2,20,3,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( IDUFNUM )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,38,0,176,1,0,95,1,122,92,2,
		20,3,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( IDUFUF )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,42,0,176,14,0,176,1,0,95,1,
		122,92,2,12,3,20,1,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( IDCNPJ )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,45,0,176,1,0,95,1,92,7,92,
		14,20,3,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( IDCTE )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,48,0,176,11,0,95,1,12,1,106,
		3,53,55,0,5,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( IDCTEOS )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,51,0,176,11,0,95,1,12,1,106,
		3,54,55,0,5,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( IDNFE )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,55,0,176,11,0,95,1,12,1,106,
		3,53,53,0,5,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( IDEMISSOR )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,58,0,176,1,0,95,1,92,7,92,
		14,20,3,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( IDSERIE )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,61,0,176,7,0,176,8,0,176,9,
		0,176,1,0,95,1,92,23,92,3,12,3,12,1,
		12,1,20,1,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( IDANO )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,64,0,176,1,0,95,1,92,3,92,
		2,20,3,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( IDMES )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,67,0,176,1,0,95,1,92,5,92,
		2,20,3,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( IDDIZER )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,70,0,106,8,69,115,116,97,100,111,
		58,0,176,13,0,95,1,12,1,72,106,10,32,77,
		69,83,47,65,78,79,58,0,72,176,22,0,95,1,
		12,1,72,106,2,47,0,72,176,21,0,95,1,12,
		1,72,106,7,32,67,78,80,74,58,0,72,176,15,
		0,95,1,12,1,72,106,8,32,78,117,109,101,114,
		111,0,72,176,10,0,95,1,12,1,72,106,9,32,
		77,111,100,101,108,111,58,0,72,176,11,0,95,1,
		12,1,72,106,8,32,83,101,114,105,101,58,0,72,
		176,20,0,95,1,12,1,72,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( IDFORMATADA )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,74,0,176,25,0,95,1,106,61,64,
		82,32,57,57,45,57,57,47,57,57,45,57,57,46,
		57,57,57,46,57,57,57,47,57,57,57,57,45,57,
		57,46,57,57,46,57,57,57,46,57,57,57,57,57,
		57,57,57,57,46,57,46,57,57,57,57,57,57,57,
		57,46,57,0,20,2,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( IDFORMATAUF )
{
	static const HB_BYTE pcode[] =
	{
		13,1,1,36,79,0,176,13,0,95,1,12,1,80,
		2,36,80,0,176,1,0,95,1,92,3,12,2,80,
		1,36,81,0,95,2,106,2,45,0,72,176,25,0,
		95,1,106,58,64,82,32,57,57,47,57,57,45,57,
		57,46,57,57,57,46,57,57,57,47,57,57,57,57,
		45,57,57,46,57,57,46,57,57,57,46,57,57,57,
		57,57,57,57,57,57,46,57,46,57,57,57,57,57,
		57,57,57,46,57,0,12,2,72,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( IDMODELOTIPO )
{
	static const HB_BYTE pcode[] =
	{
		13,1,1,36,86,0,176,11,0,95,1,12,1,80,
		2,36,88,0,95,2,106,3,53,53,0,5,28,15,
		36,89,0,106,4,78,70,69,0,80,2,25,82,36,
		90,0,95,2,106,3,53,55,0,5,28,15,36,91,
		0,106,4,67,84,69,0,80,2,25,56,36,92,0,
		95,2,106,3,54,55,0,5,28,18,36,93,0,106,
		7,67,84,69,45,79,83,0,80,2,25,27,36,94,
		0,95,2,106,3,54,53,0,5,28,14,36,95,0,
		106,5,78,70,67,101,0,80,2,36,97,0,95,2,
		110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( IDMODELOTF )
{
	static const HB_BYTE pcode[] =
	{
		13,1,1,36,101,0,176,11,0,95,1,12,1,80,
		2,36,103,0,95,2,106,3,53,53,0,5,28,19,
		36,104,0,106,8,112,114,111,99,78,70,101,0,80,
		2,25,94,36,105,0,95,2,106,3,53,55,0,5,
		28,19,36,106,0,106,8,112,114,111,99,67,84,101,
		0,80,2,25,64,36,107,0,95,2,106,3,54,55,
		0,5,28,22,36,108,0,106,11,112,114,111,99,67,
		84,101,32,79,83,0,80,2,25,31,36,109,0,95,
		2,106,3,54,53,0,5,28,18,36,110,0,106,9,
		112,114,111,99,78,70,67,101,0,80,2,36,112,0,
		95,2,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( IDMODELOCF )
{
	static const HB_BYTE pcode[] =
	{
		13,1,1,36,116,0,176,11,0,95,1,12,1,80,
		2,36,118,0,95,2,106,3,53,53,0,5,28,16,
		36,119,0,106,5,78,70,45,101,0,80,2,25,85,
		36,120,0,95,2,106,3,53,55,0,5,28,16,36,
		121,0,106,5,67,84,45,101,0,80,2,25,58,36,
		122,0,95,2,106,3,54,55,0,5,28,19,36,123,
		0,106,8,67,84,45,101,32,79,83,0,80,2,25,
		28,36,124,0,95,2,106,3,54,53,0,5,28,15,
		36,125,0,106,6,78,70,67,45,101,0,80,2,36,
		127,0,95,2,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( PEGCAMXML )
{
	static const HB_BYTE pcode[] =
	{
		13,4,5,36,131,0,106,1,0,80,6,36,132,0,
		106,1,0,80,7,36,135,0,109,31,0,80,8,36,
		136,0,176,32,0,95,2,12,1,28,14,36,137,0,
		176,19,0,95,1,12,1,80,2,36,139,0,176,32,
		0,95,2,12,1,31,28,176,33,0,109,31,0,95,
		2,12,2,121,5,28,14,36,140,0,176,34,0,95,
		8,95,2,20,2,36,142,0,176,32,0,95,3,12,
		1,31,28,176,33,0,109,31,0,95,3,12,2,121,
		5,28,14,36,143,0,176,34,0,95,8,95,3,20,
		2,36,145,0,176,34,0,95,8,106,15,57,57,57,
		57,57,57,57,57,57,57,57,57,57,57,0,20,2,
		36,146,0,176,34,0,95,8,106,25,68,101,115,116,
		105,110,97,116,97,114,105,111,68,101,115,99,111,110,
		104,101,99,105,100,111,0,20,2,36,147,0,176,32,
		0,95,4,12,1,31,33,176,32,0,95,5,12,1,
		31,24,176,9,0,95,4,12,1,121,5,31,13,176,
		9,0,95,5,12,1,121,5,28,32,36,148,0,106,
		3,50,48,0,176,21,0,95,1,12,1,72,80,4,
		36,149,0,176,22,0,95,1,12,1,80,5,36,151,
		0,176,32,0,95,4,12,1,31,33,176,32,0,95,
		5,12,1,31,24,176,9,0,95,4,12,1,121,5,
		31,13,176,9,0,95,5,12,1,121,5,28,48,36,
		152,0,176,35,0,176,36,0,176,37,0,12,0,12,
		1,92,4,121,12,3,80,4,36,153,0,176,35,0,
		176,38,0,176,37,0,12,0,12,1,92,2,121,12,
		3,80,5,36,156,0,109,39,0,109,40,0,109,41,
		0,109,42,0,109,43,0,109,44,0,4,6,0,80,
		9,36,159,0,176,34,0,95,9,109,45,0,106,31,
		69,109,105,116,105,100,111,115,80,111,114,77,105,109,
		92,54,49,51,56,49,51,50,51,48,48,48,49,54,
		55,92,0,72,20,2,36,160,0,176,34,0,95,9,
		109,45,0,106,31,69,109,105,116,105,100,111,115,80,
		111,114,77,105,109,92,54,49,51,56,49,51,50,51,
		48,48,48,50,52,56,92,0,72,20,2,36,161,0,
		176,34,0,95,9,109,45,0,106,31,69,109,105,116,
		105,100,111,115,80,111,114,77,105,109,92,54,49,51,
		56,49,51,50,51,48,48,48,51,50,57,92,0,72,
		20,2,36,162,0,176,34,0,95,9,109,45,0,106,
		31,69,109,105,116,105,100,111,115,80,111,114,77,105,
		109,92,54,49,51,56,49,51,50,51,48,48,48,52,
		48,48,92,0,72,20,2,36,163,0,176,34,0,95,
		9,109,45,0,106,31,69,109,105,116,105,100,111,115,
		80,111,114,77,105,109,92,54,49,51,56,49,51,50,
		51,48,48,48,53,57,48,92,0,72,20,2,36,165,
		0,176,34,0,95,9,109,45,0,106,33,82,101,99,
		101,98,105,100,111,115,92,88,84,73,80,79,88,92,
		54,49,51,56,49,51,50,51,48,48,48,49,54,55,
		92,0,72,20,2,36,166,0,176,34,0,95,9,109,
		45,0,106,33,82,101,99,101,98,105,100,111,115,92,
		88,84,73,80,79,88,92,54,49,51,56,49,51,50,
		51,48,48,48,50,52,56,92,0,72,20,2,36,167,
		0,176,34,0,95,9,109,45,0,106,33,82,101,99,
		101,98,105,100,111,115,92,88,84,73,80,79,88,92,
		54,49,51,56,49,51,50,51,48,48,48,51,50,57,
		92,0,72,20,2,36,168,0,176,34,0,95,9,109,
		45,0,106,33,82,101,99,101,98,105,100,111,115,92,
		88,84,73,80,79,88,92,54,49,51,56,49,51,50,
		51,48,48,48,52,48,48,92,0,72,20,2,36,169,
		0,176,34,0,95,9,109,45,0,106,33,82,101,99,
		101,98,105,100,111,115,92,88,84,73,80,79,88,92,
		54,49,51,56,49,51,50,51,48,48,48,53,57,48,
		92,0,72,20,2,36,171,0,176,34,0,95,9,109,
		45,0,106,28,99,83,76,70,80,114,111,102,105,108,
		101,92,54,49,51,56,49,51,50,51,48,48,48,49,
		54,55,92,0,72,20,2,36,172,0,176,34,0,95,
		9,109,45,0,106,28,99,83,76,70,80,114,111,102,
		105,108,101,92,54,49,51,56,49,51,50,51,48,48,
		48,50,52,56,92,0,72,20,2,36,173,0,176,34,
		0,95,9,109,45,0,106,28,99,83,76,70,80,114,
		111,102,105,108,101,92,54,49,51,56,49,51,50,51,
		48,48,48,51,50,57,92,0,72,20,2,36,174,0,
		176,34,0,95,9,109,45,0,106,28,99,83,76,70,
		80,114,111,102,105,108,101,92,54,49,51,56,49,51,
		50,51,48,48,48,52,48,48,92,0,72,20,2,36,
		175,0,176,34,0,95,9,109,45,0,106,28,99,83,
		76,70,80,114,111,102,105,108,101,92,54,49,51,56,
		49,51,50,51,48,48,48,53,57,48,92,0,72,20,
		2,36,178,0,122,165,83,46,0,26,116,2,36,179,
		0,176,32,0,95,6,12,1,29,92,2,36,181,0,
		109,46,0,122,5,31,26,109,46,0,92,2,5,31,
		18,109,46,0,92,3,5,31,10,109,46,0,92,4,
		5,28,29,36,182,0,95,1,106,13,45,110,102,101,
		95,118,105,115,46,120,109,108,0,72,83,47,0,26,
		9,1,36,183,0,109,46,0,92,5,5,31,10,109,
		46,0,92,6,5,28,29,36,184,0,176,27,0,95,
		1,12,1,95,1,72,106,5,46,120,109,108,0,72,
		83,47,0,26,219,0,36,185,0,109,46,0,92,7,
		5,31,34,109,46,0,92,8,5,31,26,109,46,0,
		92,9,5,31,18,109,46,0,92,10,5,31,10,109,
		46,0,92,11,5,28,34,36,186,0,95,1,106,2,
		45,0,72,176,28,0,95,1,12,1,72,106,5,46,
		120,109,108,0,72,83,47,0,26,144,0,36,187,0,
		109,46,0,92,12,5,31,34,109,46,0,92,13,5,
		31,26,109,46,0,92,14,5,31,18,109,46,0,92,
		15,5,31,10,109,46,0,92,16,5,28,33,36,188,
		0,95,1,106,2,45,0,72,176,28,0,95,1,12,
		1,72,106,5,46,120,109,108,0,72,83,47,0,25,
		69,36,189,0,109,46,0,92,17,5,31,34,109,46,
		0,92,18,5,31,26,109,46,0,92,19,5,31,18,
		109,46,0,92,20,5,31,10,109,46,0,92,21,5,
		28,26,36,190,0,176,27,0,95,1,12,1,95,1,
		72,106,5,46,120,109,108,0,72,83,47,0,36,192,
		0,122,165,83,48,0,26,3,1,36,193,0,176,32,
		0,95,6,12,1,29,235,0,36,195,0,109,46,0,
		122,5,31,26,109,46,0,92,2,5,31,18,109,46,
		0,92,3,5,31,10,109,46,0,92,4,5,28,20,
		36,196,0,95,9,109,46,0,1,109,47,0,72,80,
		7,26,162,0,36,197,0,109,46,0,92,12,5,31,
		34,109,46,0,92,13,5,31,26,109,46,0,92,14,
		5,31,18,109,46,0,92,15,5,31,10,109,46,0,
		92,16,5,28,75,36,198,0,95,9,109,46,0,1,
		95,8,109,48,0,1,72,106,2,92,0,72,95,4,
		72,106,2,92,0,72,95,5,72,106,2,92,0,72,
		109,47,0,72,80,7,36,199,0,176,5,0,95,7,
		106,7,88,84,73,80,79,88,0,176,29,0,95,1,
		12,1,12,3,80,7,25,45,36,201,0,95,9,109,
		46,0,1,95,8,109,48,0,1,72,106,2,92,0,
		72,95,4,72,106,2,92,0,72,95,5,72,106,2,
		92,0,72,109,47,0,72,80,7,36,203,0,176,49,
		0,95,7,12,1,28,11,36,204,0,95,7,80,6,
		25,24,36,192,0,109,48,0,23,21,83,48,0,176,
		50,0,95,8,12,1,15,29,248,254,36,178,0,109,
		46,0,23,21,83,46,0,176,50,0,95,9,12,1,
		15,29,135,253,36,211,0,95,6,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( PEGACADASTRO )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,214,0,176,52,0,106,5,67,78,80,
		74,0,176,7,0,95,1,12,1,12,2,83,53,0,
		36,215,0,176,52,0,106,6,120,78,111,109,101,0,
		176,7,0,95,1,12,1,12,2,83,54,0,36,216,
		0,176,52,0,106,6,120,70,65,78,84,0,176,7,
		0,95,1,12,1,12,2,83,55,0,36,217,0,176,
		52,0,106,5,120,76,103,114,0,176,7,0,95,1,
		12,1,12,2,83,56,0,36,218,0,176,52,0,106,
		5,120,99,112,108,0,176,7,0,95,1,12,1,12,
		2,83,57,0,36,219,0,176,52,0,106,4,110,114,
		111,0,176,7,0,95,1,12,1,12,2,83,58,0,
		36,220,0,176,52,0,106,8,120,66,97,105,114,114,
		111,0,176,7,0,95,1,12,1,12,2,83,59,0,
		36,221,0,176,52,0,106,5,99,77,117,110,0,176,
		7,0,95,1,12,1,12,2,83,60,0,36,222,0,
		176,52,0,106,5,120,77,117,110,0,176,7,0,95,
		1,12,1,12,2,83,61,0,36,223,0,176,52,0,
		106,3,85,70,0,176,7,0,95,1,12,1,12,2,
		83,62,0,36,224,0,176,52,0,106,4,67,69,80,
		0,176,7,0,95,1,12,1,12,2,83,63,0,36,
		225,0,176,52,0,106,6,99,80,97,105,115,0,176,
		7,0,95,1,12,1,12,2,83,64,0,36,226,0,
		176,52,0,106,6,120,80,97,105,115,0,176,7,0,
		95,1,12,1,12,2,83,65,0,36,227,0,176,52,
		0,106,5,102,111,110,101,0,176,7,0,95,1,12,
		1,12,2,83,66,0,36,228,0,176,52,0,106,3,
		73,69,0,176,7,0,95,1,12,1,12,2,83,67,
		0,36,229,0,176,52,0,106,5,73,69,83,84,0,
		176,7,0,95,1,12,1,12,2,83,68,0,36,230,
		0,176,52,0,106,5,73,83,85,70,0,176,7,0,
		95,1,12,1,12,2,83,69,0,36,231,0,176,52,
		0,106,6,101,109,97,105,108,0,176,7,0,95,1,
		12,1,12,2,83,70,0,36,232,0,176,52,0,106,
		3,73,77,0,176,7,0,95,1,12,1,12,2,83,
		71,0,36,233,0,176,52,0,106,5,99,110,97,101,
		0,176,7,0,95,1,12,1,12,2,83,72,0,36,
		234,0,176,52,0,106,4,67,80,70,0,176,7,0,
		95,1,12,1,12,2,83,73,0,36,236,0,109,53,
		0,106,15,48,48,48,48,48,48,48,48,48,48,48,
		48,48,48,0,5,28,12,36,237,0,106,2,48,0,
		83,53,0,36,240,0,109,53,0,106,2,48,0,5,
		31,12,176,32,0,109,53,0,12,1,28,53,176,50,
		0,176,7,0,109,53,0,12,1,12,1,122,34,28,
		36,109,62,0,106,3,69,88,0,5,28,25,36,241,
		0,106,15,57,57,57,57,57,57,57,57,57,57,57,
		57,57,57,0,83,53,0,36,243,0,109,53,0,106,
		2,48,0,5,31,12,176,32,0,109,53,0,12,1,
		28,45,176,50,0,176,7,0,109,53,0,12,1,12,
		1,122,34,28,28,176,50,0,176,7,0,109,73,0,
		12,1,12,1,122,15,28,11,36,244,0,109,73,0,
		83,53,0,36,246,0,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( PEGADADOS )
{
	static const HB_BYTE pcode[] =
	{
		13,8,4,36,253,0,106,2,48,0,80,9,36,2,
		1,176,74,0,95,3,12,1,106,2,85,0,69,28,
		9,36,3,1,95,3,80,9,36,6,1,176,75,0,
		95,1,12,1,80,1,36,7,1,176,75,0,95,2,
		12,1,80,2,36,8,1,95,4,100,8,31,14,36,
		10,1,176,75,0,95,4,12,1,80,4,36,13,1,
		95,4,100,8,28,16,106,2,60,0,95,1,72,106,
		2,62,0,72,25,9,106,2,60,0,95,1,72,80,
		5,36,14,1,95,4,100,8,28,17,106,3,60,47,
		0,95,1,72,106,2,62,0,72,25,15,106,3,60,
		47,0,95,4,72,106,2,62,0,72,80,6,36,15,
		1,176,76,0,95,5,95,2,12,2,80,7,36,16,
		1,176,76,0,95,6,95,2,12,2,80,8,36,18,
		1,95,7,121,8,31,8,95,8,121,8,28,91,36,
		19,1,95,4,100,8,28,11,106,2,60,0,95,1,
		72,25,9,106,2,60,0,95,1,72,80,5,36,20,
		1,95,4,100,8,28,12,106,3,60,47,0,95,1,
		72,25,15,106,3,60,47,0,95,4,72,106,2,62,
		0,72,80,6,36,21,1,176,76,0,95,5,95,2,
		12,2,80,7,36,22,1,176,76,0,95,6,95,2,
		12,2,80,8,36,26,1,95,7,121,8,31,8,95,
		8,121,8,28,9,36,27,1,95,9,110,7,36,29,
		1,176,1,0,95,2,95,7,176,50,0,95,5,12,
		1,72,95,8,95,7,49,176,50,0,95,6,12,1,
		49,122,72,12,3,80,9,36,30,1,176,5,0,95,
		9,106,2,13,0,106,1,0,12,3,80,9,36,31,
		1,176,5,0,95,9,106,2,10,0,106,1,0,12,
		3,80,9,36,32,1,106,2,38,0,106,2,34,0,
		106,2,39,0,106,2,60,0,106,2,62,0,106,2,
		186,0,106,2,170,0,4,7,0,80,11,36,33,1,
		106,6,38,97,109,112,59,0,47,106,7,38,113,117,
		111,116,59,0,47,106,6,38,35,51,57,59,0,106,
		5,38,108,116,59,0,47,106,5,38,103,116,59,0,
		47,106,7,38,35,49,55,54,59,0,106,7,38,35,
		49,55,48,59,0,4,7,0,80,10,36,34,1,122,
		165,80,12,25,30,36,35,1,176,5,0,95,9,95,
		10,95,12,1,95,11,95,12,1,12,3,80,9,36,
		34,1,175,12,0,176,50,0,95,10,12,1,15,28,
		220,36,38,1,95,9,110,7
	};

	hb_vmExecute( pcode, symbols );
}
