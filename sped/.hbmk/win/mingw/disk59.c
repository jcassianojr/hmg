/*
 * Harbour 3.2.0dev (r2011030937)
 * MinGW GNU C 7.3 (32-bit)
 * Generated C source from "c:\develop\harbour\objmgw\disk59.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( VALCGC );
HB_FUNC_EXTERN( LASTKEY );
HB_FUNC_EXTERN( VALTYPE );
HB_FUNC_EXTERN( ALLTRIM );
HB_FUNC_EXTERN( STR );
HB_FUNC_EXTERN( TIRAOUT );
HB_FUNC_EXTERN( VAL );
HB_FUNC_EXTERN( LEN );
HB_FUNC_EXTERN( REPLICATE );
HB_FUNC_EXTERN( LEFT );
HB_FUNC_EXTERN( SUBSTR );
HB_FUNC_EXTERN( ASCAN );
HB_FUNC( MOD11 );
HB_FUNC_EXTERN( ALERTX );
HB_FUNC( VALCPF );
HB_FUNC_EXTERN( MOD );
HB_FUNC( FORMATACPF );
HB_FUNC_EXTERN( STRZERO );
HB_FUNC_EXTERN( TRANSFORM );
HB_FUNC( FORMATACNPJ );
HB_FUNC( CNPJCPFPICT );
HB_FUNC_EXTERN( DEVPOS );
HB_FUNC_EXTERN( DEVOUT );
HB_FUNC_EXTERN( SPACE );
HB_FUNC( CNPJCPFVAL );
HB_FUNC( VALCEI );
HB_FUNC_EXTERN( __MVPRIVATE );
HB_FUNC_EXTERN( RIGHT );
HB_FUNC( CODUF );
HB_FUNC_EXTERN( EMPTY );


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_DISK59 )
{ "VALCGC", {HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL}, {HB_FUNCNAME( VALCGC )}, NULL },
{ "ZNERRO", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "ZERRO", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "LASTKEY", {HB_FS_PUBLIC}, {HB_FUNCNAME( LASTKEY )}, NULL },
{ "VALTYPE", {HB_FS_PUBLIC}, {HB_FUNCNAME( VALTYPE )}, NULL },
{ "ALLTRIM", {HB_FS_PUBLIC}, {HB_FUNCNAME( ALLTRIM )}, NULL },
{ "STR", {HB_FS_PUBLIC}, {HB_FUNCNAME( STR )}, NULL },
{ "TIRAOUT", {HB_FS_PUBLIC}, {HB_FUNCNAME( TIRAOUT )}, NULL },
{ "P1", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "VAL", {HB_FS_PUBLIC}, {HB_FUNCNAME( VAL )}, NULL },
{ "LEN", {HB_FS_PUBLIC}, {HB_FUNCNAME( LEN )}, NULL },
{ "REPLICATE", {HB_FS_PUBLIC}, {HB_FUNCNAME( REPLICATE )}, NULL },
{ "LEFT", {HB_FS_PUBLIC}, {HB_FUNCNAME( LEFT )}, NULL },
{ "SUBSTR", {HB_FS_PUBLIC}, {HB_FUNCNAME( SUBSTR )}, NULL },
{ "AUF", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "ASCAN", {HB_FS_PUBLIC}, {HB_FUNCNAME( ASCAN )}, NULL },
{ "MOD11", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( MOD11 )}, NULL },
{ "ALERTX", {HB_FS_PUBLIC}, {HB_FUNCNAME( ALERTX )}, NULL },
{ "VALCPF", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( VALCPF )}, NULL },
{ "DV", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "PESO", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "IMOD", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "MOD", {HB_FS_PUBLIC}, {HB_FUNCNAME( MOD )}, NULL },
{ "REST", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "FORMATACPF", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( FORMATACPF )}, NULL },
{ "STRZERO", {HB_FS_PUBLIC}, {HB_FUNCNAME( STRZERO )}, NULL },
{ "TRANSFORM", {HB_FS_PUBLIC}, {HB_FUNCNAME( TRANSFORM )}, NULL },
{ "FORMATACNPJ", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( FORMATACNPJ )}, NULL },
{ "CNPJCPFPICT", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( CNPJCPFPICT )}, NULL },
{ "DEVPOS", {HB_FS_PUBLIC}, {HB_FUNCNAME( DEVPOS )}, NULL },
{ "DEVOUT", {HB_FS_PUBLIC}, {HB_FUNCNAME( DEVOUT )}, NULL },
{ "SPACE", {HB_FS_PUBLIC}, {HB_FUNCNAME( SPACE )}, NULL },
{ "_PICTURE", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "CNPJCPFVAL", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( CNPJCPFVAL )}, NULL },
{ "LRETU", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "VALCEI", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( VALCEI )}, NULL },
{ "NTOT", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "CAUX", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "I", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "__MVPRIVATE", {HB_FS_PUBLIC}, {HB_FUNCNAME( __MVPRIVATE )}, NULL },
{ "PNU_CEI", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "RIGHT", {HB_FS_PUBLIC}, {HB_FUNCNAME( RIGHT )}, NULL },
{ "CODUF", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( CODUF )}, NULL },
{ "EMPTY", {HB_FS_PUBLIC}, {HB_FUNCNAME( EMPTY )}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_DISK59, "c:\\develop\\harbour\\objmgw\\disk59.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_DISK59
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_DISK59 )
   #include "hbiniseg.h"
#endif

HB_FUNC( VALCGC )
{
	static const HB_BYTE pcode[] =
	{
		13,1,4,36,27,0,121,83,1,0,36,28,0,106,
		1,0,83,2,0,36,30,0,176,3,0,12,0,92,
		5,5,31,12,176,3,0,12,0,92,24,5,28,8,
		36,31,0,120,110,7,36,33,0,176,4,0,95,3,
		12,1,106,2,76,0,69,28,8,36,34,0,120,80,
		3,36,36,0,176,4,0,95,2,12,1,106,2,67,
		0,69,28,11,36,37,0,106,2,88,0,80,2,36,
		39,0,176,4,0,95,1,12,1,106,2,78,0,5,
		28,19,36,40,0,176,5,0,176,6,0,95,1,12,
		1,12,1,80,1,36,42,0,176,5,0,176,7,0,
		95,1,12,1,12,1,83,8,0,36,44,0,176,9,
		0,109,8,0,12,1,121,5,28,49,36,45,0,122,
		83,1,0,36,46,0,106,26,67,78,80,74,32,73,
		110,118,97,108,105,100,111,32,45,32,69,109,32,66,
		114,97,110,99,111,0,83,2,0,36,47,0,9,110,
		7,36,49,0,176,10,0,109,8,0,12,1,92,14,
		69,28,53,36,50,0,92,2,83,1,0,36,51,0,
		106,35,67,78,80,74,32,73,110,118,97,108,105,100,
		111,32,45,32,110,97,111,32,116,101,109,32,49,52,
		32,68,105,103,105,116,111,115,0,83,2,0,36,53,
		0,121,165,80,5,25,98,36,54,0,109,8,0,176,
		11,0,176,6,0,95,5,122,12,2,92,14,12,2,
		5,28,68,36,55,0,92,3,83,1,0,36,56,0,
		106,41,67,78,80,74,32,73,110,118,97,108,105,100,
		111,32,45,32,83,101,113,117,101,110,99,105,97,32,
		82,101,112,101,116,105,116,105,118,97,32,100,101,32,
		0,176,6,0,95,5,122,12,2,72,83,2,0,36,
		53,0,175,5,0,92,9,15,28,157,36,65,0,176,
		12,0,109,8,0,92,7,12,2,106,8,57,57,57,
		57,57,57,57,0,5,28,40,36,66,0,92,5,83,
		1,0,36,67,0,106,22,67,78,80,74,32,71,101,
		110,101,114,105,99,111,32,57,57,57,57,57,57,57,
		0,83,2,0,36,69,0,176,13,0,109,8,0,92,
		9,92,4,12,3,106,5,57,57,57,57,0,5,28,
		39,36,70,0,92,6,83,1,0,36,71,0,106,21,
		67,78,80,74,32,71,101,110,101,114,105,99,111,32,
		47,57,57,57,57,45,0,83,2,0,36,73,0,176,
		4,0,95,4,12,1,106,2,67,0,5,29,211,0,
		36,76,0,106,3,65,67,0,106,3,65,76,0,106,
		3,65,77,0,106,3,65,80,0,106,3,66,65,0,
		106,3,67,69,0,106,3,68,70,0,106,3,69,83,
		0,106,3,71,79,0,106,3,77,65,0,106,3,77,
		71,0,106,3,77,83,0,106,3,77,84,0,106,3,
		80,65,0,106,3,80,66,0,106,3,80,69,0,106,
		3,80,73,0,106,3,80,82,0,106,3,82,74,0,
		106,3,82,78,0,106,3,82,79,0,106,3,82,82,
		0,106,3,82,83,0,106,3,83,67,0,106,3,83,
		69,0,106,3,83,80,0,106,3,84,79,0,106,3,
		69,88,0,106,3,88,88,0,4,29,0,83,14,0,
		36,77,0,176,15,0,109,14,0,95,4,12,2,121,
		5,28,39,36,78,0,92,7,83,1,0,36,79,0,
		106,18,69,115,116,97,100,111,32,105,110,118,97,108,
		105,100,111,58,32,0,95,4,72,83,2,0,36,83,
		0,109,1,0,121,5,29,147,0,36,84,0,176,16,
		0,109,8,0,92,13,92,9,12,3,28,78,36,85,
		0,176,16,0,109,8,0,92,14,92,9,12,3,28,
		8,36,86,0,120,110,7,36,88,0,92,8,83,1,
		0,36,89,0,106,35,67,104,101,113,117,101,32,49,
		52,111,46,32,68,105,103,105,116,111,32,45,32,50,
		32,86,101,114,105,102,105,99,97,100,111,114,0,83,
		2,0,25,53,36,92,0,92,9,83,1,0,36,93,
		0,106,35,67,104,101,113,117,101,32,49,51,111,46,
		32,68,105,103,105,116,111,32,45,32,49,32,86,101,
		114,105,102,105,99,97,100,111,114,0,83,2,0,36,
		96,0,109,1,0,121,15,28,26,36,97,0,95,3,
		28,13,36,98,0,176,17,0,109,2,0,20,1,36,
		100,0,9,110,7,36,102,0,120,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( VALCPF )
{
	static const HB_BYTE pcode[] =
	{
		13,2,2,36,123,0,121,83,1,0,36,124,0,106,
		1,0,83,2,0,36,126,0,176,3,0,12,0,92,
		5,5,31,12,176,3,0,12,0,92,24,5,28,8,
		36,127,0,120,110,7,36,129,0,176,4,0,95,2,
		12,1,106,2,76,0,69,28,8,36,130,0,120,80,
		2,36,133,0,176,5,0,176,7,0,95,1,12,1,
		12,1,83,8,0,36,136,0,176,10,0,109,8,0,
		12,1,92,14,5,28,38,176,13,0,109,8,0,122,
		92,3,12,3,106,4,48,48,48,0,5,28,18,36,
		137,0,176,13,0,109,8,0,92,4,12,2,83,8,
		0,36,141,0,176,9,0,109,8,0,12,1,121,5,
		28,31,36,142,0,122,83,1,0,36,143,0,106,14,
		67,80,70,32,69,109,32,66,114,97,110,99,111,0,
		83,2,0,36,146,0,176,10,0,109,8,0,12,1,
		92,11,69,28,41,36,147,0,92,2,83,1,0,36,
		148,0,106,23,67,112,102,32,110,97,111,32,116,101,
		109,32,49,49,32,100,105,103,105,116,111,115,0,83,
		2,0,36,151,0,121,165,80,3,25,97,36,152,0,
		109,8,0,176,11,0,176,6,0,95,3,122,12,2,
		92,11,12,2,5,28,67,36,153,0,92,3,83,1,
		0,36,154,0,106,40,67,80,70,32,73,110,118,97,
		108,105,100,111,32,45,32,83,101,113,117,101,110,99,
		105,97,32,82,101,112,101,116,105,116,105,118,97,32,
		100,101,32,0,176,6,0,95,3,122,12,2,72,83,
		2,0,36,151,0,175,3,0,92,9,15,28,158,36,
		158,0,109,1,0,121,5,29,177,0,36,159,0,176,
		16,0,109,8,0,92,10,92,10,12,3,28,93,36,
		160,0,176,16,0,109,8,0,92,11,92,11,12,3,
		28,8,36,161,0,120,110,7,36,163,0,92,4,83,
		1,0,36,164,0,106,50,67,80,70,32,45,32,73,
		110,118,97,108,105,100,111,32,67,104,101,113,117,101,
		32,49,49,111,46,32,68,105,103,105,116,111,32,45,
		32,50,32,86,101,114,105,102,105,99,97,100,111,114,
		0,83,2,0,25,68,36,167,0,92,5,83,1,0,
		36,168,0,106,50,67,80,70,32,45,32,73,110,118,
		97,108,105,100,111,32,67,104,101,113,117,101,32,49,
		48,111,46,32,68,105,103,105,116,111,32,45,32,49,
		32,86,101,114,105,102,105,99,97,100,111,114,0,83,
		2,0,36,172,0,176,13,0,109,8,0,92,9,122,
		12,3,80,4,36,174,0,95,4,106,2,49,0,5,
		28,27,36,175,0,106,15,71,79,47,77,84,47,77,
		83,47,68,70,47,84,79,0,80,4,26,3,1,36,
		176,0,95,4,106,2,50,0,5,28,30,36,177,0,
		106,18,65,77,47,65,67,47,80,65,47,82,82,47,
		82,79,47,65,80,0,80,4,26,219,0,36,178,0,
		95,4,106,2,51,0,5,28,21,36,179,0,106,9,
		77,65,47,67,69,47,80,73,0,80,4,26,188,0,
		36,180,0,95,4,106,2,52,0,5,28,24,36,181,
		0,106,12,82,78,47,80,66,47,80,69,47,65,76,
		0,80,4,26,154,0,36,182,0,95,4,106,2,53,
		0,5,28,17,36,183,0,106,6,83,69,47,66,65,
		0,80,4,25,126,36,184,0,95,4,106,2,54,0,
		5,28,14,36,185,0,106,3,77,71,0,80,4,25,
		102,36,186,0,95,4,106,2,55,0,5,28,17,36,
		187,0,106,6,82,74,47,69,83,0,80,4,25,75,
		36,188,0,95,4,106,2,56,0,5,28,14,36,189,
		0,106,3,83,80,0,80,4,25,51,36,190,0,95,
		4,106,2,57,0,5,28,17,36,191,0,106,6,80,
		82,47,83,67,0,80,4,25,24,36,192,0,95,4,
		106,2,48,0,5,28,12,36,193,0,106,3,82,83,
		0,80,4,36,195,0,109,1,0,121,15,28,26,36,
		196,0,95,2,28,13,36,197,0,176,17,0,109,2,
		0,20,1,36,199,0,9,110,7,36,202,0,120,110,
		7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( MOD11 )
{
	static const HB_BYTE pcode[] =
	{
		13,0,3,36,212,0,121,83,19,0,36,213,0,122,
		83,20,0,36,214,0,95,2,165,83,21,0,25,74,
		36,215,0,109,19,0,109,20,0,176,9,0,176,13,
		0,95,1,109,21,0,122,12,3,12,1,65,72,83,
		19,0,36,216,0,109,20,0,23,83,20,0,36,217,
		0,109,20,0,95,3,15,28,10,36,218,0,92,2,
		83,20,0,36,214,0,109,21,0,92,255,72,21,83,
		21,0,122,35,28,182,36,221,0,176,22,0,109,19,
		0,92,11,12,2,83,23,0,36,222,0,109,23,0,
		121,5,28,8,36,223,0,120,110,7,36,225,0,109,
		23,0,122,5,28,27,176,9,0,176,13,0,95,1,
		95,2,122,12,3,12,1,121,5,28,8,36,226,0,
		120,110,7,36,228,0,9,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( FORMATACPF )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,240,0,176,4,0,95,1,12,1,106,
		2,78,0,5,28,19,36,241,0,176,5,0,176,6,
		0,95,1,12,1,12,1,80,1,36,243,0,176,5,
		0,176,7,0,95,1,12,1,12,1,80,1,36,244,
		0,176,9,0,95,1,12,1,121,5,31,14,176,10,
		0,95,1,12,1,92,11,69,28,9,36,245,0,95,
		1,110,7,36,247,0,176,25,0,176,9,0,95,1,
		12,1,92,11,12,2,80,1,36,248,0,176,26,0,
		95,1,106,18,64,82,32,57,57,57,46,57,57,57,
		46,57,57,57,45,57,57,0,20,2,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( FORMATACNPJ )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,1,1,176,4,0,95,1,12,1,106,
		2,78,0,5,28,19,36,2,1,176,5,0,176,6,
		0,95,1,12,1,12,1,80,1,36,4,1,176,5,
		0,176,7,0,95,1,12,1,12,1,80,1,36,5,
		1,176,9,0,95,1,12,1,121,5,31,14,176,10,
		0,95,1,12,1,92,14,69,28,9,36,6,1,95,
		1,110,7,36,8,1,176,25,0,176,9,0,95,1,
		12,1,92,14,12,2,80,1,36,9,1,176,26,0,
		95,1,106,22,64,82,32,57,57,46,57,57,57,46,
		57,57,57,47,57,57,57,57,45,57,57,0,20,2,
		7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( CNPJCPFPICT )
{
	static const HB_BYTE pcode[] =
	{
		13,0,4,36,18,1,176,29,0,95,3,95,4,20,
		2,176,30,0,176,31,0,92,18,12,1,20,1,36,
		20,1,95,2,106,2,74,0,5,28,36,36,21,1,
		48,32,0,95,1,106,19,57,57,46,57,57,57,46,
		57,57,57,47,57,57,57,57,45,57,57,0,112,1,
		73,25,62,36,22,1,95,2,106,2,70,0,5,28,
		32,36,23,1,48,32,0,95,1,106,15,57,57,57,
		46,57,57,57,46,57,57,57,45,57,57,0,112,1,
		73,25,20,36,25,1,48,32,0,95,1,106,5,64,
		83,49,56,0,112,1,73,36,29,1,120,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( CNPJCPFVAL )
{
	static const HB_BYTE pcode[] =
	{
		13,0,3,36,38,1,120,83,34,0,36,40,1,95,
		2,106,2,74,0,5,28,21,36,41,1,176,0,0,
		95,1,100,100,95,3,12,4,83,34,0,25,54,36,
		42,1,95,2,106,2,70,0,5,28,17,36,43,1,
		176,18,0,95,1,12,1,83,34,0,25,27,36,44,
		1,95,2,106,2,67,0,5,28,15,36,45,1,176,
		35,0,95,1,12,1,83,34,0,36,47,1,109,34,
		0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( VALCEI )
{
	static const HB_BYTE pcode[] =
	{
		13,0,2,36,58,1,176,39,0,108,36,108,37,108,
		38,20,3,36,59,1,176,3,0,12,0,92,5,5,
		31,12,176,3,0,12,0,92,24,5,28,8,36,60,
		1,120,110,7,36,62,1,176,4,0,95,2,12,1,
		106,2,76,0,69,28,8,36,63,1,120,80,2,36,
		65,1,121,83,1,0,36,66,1,106,1,0,83,2,
		0,36,67,1,121,83,36,0,36,68,1,106,1,0,
		83,37,0,36,69,1,121,83,38,0,36,70,1,106,
		1,0,83,40,0,36,71,1,176,7,0,95,1,12,
		1,83,40,0,36,72,1,176,9,0,109,40,0,12,
		1,121,5,28,61,36,73,1,122,83,1,0,36,74,
		1,106,44,67,69,73,32,105,110,118,97,108,105,100,
		111,115,32,45,32,32,98,114,97,110,99,111,32,111,
		117,32,122,101,114,111,32,44,32,114,101,100,105,103,
		105,116,101,32,0,83,2,0,36,76,1,176,9,0,
		176,13,0,109,40,0,122,92,2,12,3,12,1,92,
		2,35,31,23,176,9,0,176,13,0,109,40,0,122,
		92,2,12,3,12,1,92,29,15,28,59,36,77,1,
		92,2,83,1,0,36,78,1,106,41,80,111,115,105,
		99,97,111,32,49,44,50,32,110,97,111,32,101,32,
		48,48,44,48,49,32,111,117,32,109,97,105,111,114,
		32,113,117,101,32,50,57,32,0,83,2,0,36,82,
		1,176,13,0,109,40,0,92,11,122,12,3,106,5,
		48,54,55,56,0,24,29,37,1,176,9,0,176,12,
		0,109,40,0,92,2,12,2,12,1,121,15,29,17,
		1,176,9,0,176,13,0,109,40,0,92,3,92,3,
		12,3,12,1,121,15,29,251,0,176,9,0,176,13,
		0,109,40,0,92,6,92,5,12,3,12,1,121,15,
		29,229,0,36,83,1,122,165,83,38,0,25,69,36,
		84,1,109,36,0,176,9,0,176,13,0,109,40,0,
		109,38,0,122,12,3,12,1,176,9,0,176,13,0,
		106,12,55,52,49,56,53,50,49,54,51,55,52,0,
		109,38,0,122,12,3,12,1,65,72,83,36,0,36,
		83,1,109,38,0,23,21,83,38,0,92,11,15,28,
		186,36,86,1,176,41,0,176,6,0,109,36,0,92,
		3,12,2,92,2,12,2,83,37,0,36,87,1,176,
		9,0,176,12,0,109,37,0,122,12,2,12,1,176,
		9,0,176,41,0,109,37,0,122,12,2,12,1,72,
		83,36,0,36,88,1,109,36,0,92,9,15,28,5,
		121,25,8,92,10,109,36,0,49,83,36,0,36,89,
		1,176,9,0,176,41,0,109,40,0,122,12,2,12,
		1,109,36,0,5,28,8,36,90,1,120,110,7,36,
		92,1,92,3,83,1,0,36,93,1,106,16,68,105,
		103,105,116,111,32,105,110,118,97,108,105,100,111,0,
		83,2,0,25,76,36,96,1,92,4,83,1,0,36,
		97,1,106,58,80,111,115,105,99,97,111,32,49,49,
		32,110,97,111,32,101,32,48,44,54,44,55,44,56,
		32,111,117,32,112,111,115,105,99,111,101,115,32,50,
		32,51,52,53,32,54,55,56,57,49,48,32,122,101,
		114,97,100,97,115,0,83,2,0,36,99,1,109,1,
		0,121,15,28,26,36,100,1,95,2,28,13,36,101,
		1,176,17,0,109,2,0,20,1,36,103,1,9,110,
		7,36,105,1,120,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( CODUF )
{
	static const HB_BYTE pcode[] =
	{
		13,4,2,36,115,1,121,80,3,36,116,1,106,3,
		32,32,0,80,4,36,121,1,106,3,65,67,0,106,
		3,65,76,0,106,3,65,77,0,106,3,65,80,0,
		106,3,66,65,0,106,3,67,69,0,106,3,68,70,
		0,106,3,69,83,0,106,3,71,79,0,106,3,77,
		65,0,106,3,77,71,0,106,3,77,83,0,106,3,
		77,84,0,106,3,80,65,0,106,3,80,66,0,106,
		3,80,69,0,106,3,80,73,0,106,3,80,82,0,
		106,3,82,74,0,106,3,82,78,0,106,3,82,79,
		0,106,3,82,82,0,106,3,82,83,0,106,3,83,
		67,0,106,3,83,69,0,106,3,83,80,0,106,3,
		84,79,0,106,3,69,88,0,106,3,88,88,0,4,
		29,0,80,5,36,125,1,106,3,49,50,0,106,3,
		50,55,0,106,3,49,51,0,106,3,49,54,0,106,
		3,50,57,0,106,3,50,51,0,106,3,53,51,0,
		106,3,51,50,0,106,3,53,50,0,106,3,50,49,
		0,106,3,51,49,0,106,3,53,48,0,106,3,53,
		49,0,106,3,49,53,0,106,3,50,53,0,106,3,
		50,54,0,106,3,50,50,0,106,3,52,49,0,106,
		3,51,51,0,106,3,50,52,0,106,3,49,49,0,
		106,3,49,52,0,106,3,52,51,0,106,3,52,50,
		0,106,3,50,56,0,106,3,51,53,0,106,3,49,
		55,0,106,3,53,52,0,106,3,53,52,0,4,29,
		0,80,6,36,133,1,176,43,0,95,1,12,1,28,
		9,36,134,1,95,4,110,7,36,136,1,176,4,0,
		95,2,12,1,106,2,67,0,69,28,12,36,137,1,
		106,3,85,70,0,80,2,36,141,1,95,2,106,3,
		85,70,0,5,28,67,36,142,1,176,10,0,95,1,
		12,1,92,2,15,28,17,36,143,1,176,13,0,95,
		1,122,92,2,12,3,80,1,36,145,1,176,15,0,
		95,6,95,1,12,2,80,3,36,146,1,95,3,121,
		15,28,47,36,147,1,95,5,95,3,1,80,4,25,
		35,36,150,1,176,15,0,95,5,95,1,12,2,80,
		3,36,151,1,95,3,121,15,28,12,36,152,1,95,
		6,95,3,1,80,4,36,155,1,95,4,110,7
	};

	hb_vmExecute( pcode, symbols );
}
