/*
 * Harbour 3.2.0dev (r2011030937)
 * MinGW GNU C 7.3 (32-bit)
 * Generated C source from "c:\develop\harbour\objmgw\disk71.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( FORMATARG );
HB_FUNC_EXTERN( VALTYPE );
HB_FUNC_EXTERN( AT );
HB_FUNC_EXTERN( VAL );
HB_FUNC_EXTERN( ALLTRIM );
HB_FUNC_EXTERN( UPPER );
HB_FUNC_EXTERN( TIRAOUT );
HB_FUNC_EXTERN( LEN );
HB_FUNC_EXTERN( SUBSTR );
HB_FUNC_EXTERN( STR );
HB_FUNC_EXTERN( STRTRAN );
HB_FUNC_EXTERN( TRIM );
HB_FUNC_EXTERN( EMPTY );
HB_FUNC_EXTERN( LEFT );
HB_FUNC( CHECKRG );
HB_FUNC_EXTERN( LASTKEY );
HB_FUNC_EXTERN( REPLICATE );
HB_FUNC_EXTERN( CTOD );
HB_FUNC_EXTERN( MOD );
HB_FUNC_EXTERN( STRZERO );
HB_FUNC_EXTERN( FLOOR );
HB_FUNC_EXTERN( ALERTX );
HB_FUNC( PEGDDD );
HB_FUNC( FORMATATEL );
HB_FUNC( PEGTEL );
HB_FUNC( PEGPREF );
HB_FUNC( FORTEL2 );
HB_FUNC( FORMATACEP );
HB_FUNC_EXTERN( RIGHT );
HB_FUNC( CHKUFCEP );
HB_FUNC( CEP2UF );


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_DISK71 )
{ "FORMATARG", {HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL}, {HB_FUNCNAME( FORMATARG )}, NULL },
{ "VALTYPE", {HB_FS_PUBLIC}, {HB_FUNCNAME( VALTYPE )}, NULL },
{ "AT", {HB_FS_PUBLIC}, {HB_FUNCNAME( AT )}, NULL },
{ "VAL", {HB_FS_PUBLIC}, {HB_FUNCNAME( VAL )}, NULL },
{ "ALLTRIM", {HB_FS_PUBLIC}, {HB_FUNCNAME( ALLTRIM )}, NULL },
{ "UPPER", {HB_FS_PUBLIC}, {HB_FUNCNAME( UPPER )}, NULL },
{ "TIRAOUT", {HB_FS_PUBLIC}, {HB_FUNCNAME( TIRAOUT )}, NULL },
{ "LEN", {HB_FS_PUBLIC}, {HB_FUNCNAME( LEN )}, NULL },
{ "SUBSTR", {HB_FS_PUBLIC}, {HB_FUNCNAME( SUBSTR )}, NULL },
{ "STR", {HB_FS_PUBLIC}, {HB_FUNCNAME( STR )}, NULL },
{ "STRTRAN", {HB_FS_PUBLIC}, {HB_FUNCNAME( STRTRAN )}, NULL },
{ "TRIM", {HB_FS_PUBLIC}, {HB_FUNCNAME( TRIM )}, NULL },
{ "EMPTY", {HB_FS_PUBLIC}, {HB_FUNCNAME( EMPTY )}, NULL },
{ "LEFT", {HB_FS_PUBLIC}, {HB_FUNCNAME( LEFT )}, NULL },
{ "CHECKRG", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( CHECKRG )}, NULL },
{ "LASTKEY", {HB_FS_PUBLIC}, {HB_FUNCNAME( LASTKEY )}, NULL },
{ "ZDAC", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "ZNERRO", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "ZERRO", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "REPLICATE", {HB_FS_PUBLIC}, {HB_FUNCNAME( REPLICATE )}, NULL },
{ "CTOD", {HB_FS_PUBLIC}, {HB_FUNCNAME( CTOD )}, NULL },
{ "MOD", {HB_FS_PUBLIC}, {HB_FUNCNAME( MOD )}, NULL },
{ "STRZERO", {HB_FS_PUBLIC}, {HB_FUNCNAME( STRZERO )}, NULL },
{ "FLOOR", {HB_FS_PUBLIC}, {HB_FUNCNAME( FLOOR )}, NULL },
{ "ALERTX", {HB_FS_PUBLIC}, {HB_FUNCNAME( ALERTX )}, NULL },
{ "PEGDDD", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( PEGDDD )}, NULL },
{ "FORMATATEL", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( FORMATATEL )}, NULL },
{ "PEGTEL", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( PEGTEL )}, NULL },
{ "PEGPREF", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( PEGPREF )}, NULL },
{ "FORTEL2", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( FORTEL2 )}, NULL },
{ "FORMATACEP", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( FORMATACEP )}, NULL },
{ "RIGHT", {HB_FS_PUBLIC}, {HB_FUNCNAME( RIGHT )}, NULL },
{ "CHKUFCEP", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( CHKUFCEP )}, NULL },
{ "CEP2UF", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( CEP2UF )}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_DISK71, "c:\\develop\\harbour\\objmgw\\disk71.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_DISK71
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_DISK71 )
   #include "hbiniseg.h"
#endif

HB_FUNC( FORMATARG )
{
	static const HB_BYTE pcode[] =
	{
		13,3,2,36,33,0,106,1,0,80,5,36,34,0,
		176,1,0,95,2,12,1,106,2,67,0,5,28,34,
		36,35,0,95,2,106,4,82,78,69,0,5,31,13,
		95,2,106,4,82,73,67,0,5,28,9,36,36,0,
		95,1,110,7,36,39,0,95,1,106,7,73,83,69,
		78,84,79,0,5,31,36,176,2,0,106,4,82,78,
		69,0,95,1,12,2,121,15,31,19,176,2,0,106,
		4,82,73,67,0,95,1,12,2,121,15,28,9,36,
		40,0,95,1,110,7,36,42,0,176,3,0,95,1,
		12,1,121,5,28,9,36,43,0,95,1,110,7,36,
		46,0,176,4,0,95,1,12,1,80,1,36,47,0,
		176,5,0,95,1,12,1,80,1,36,48,0,176,2,
		0,106,2,45,0,95,1,12,2,80,4,36,49,0,
		95,4,121,5,28,73,36,50,0,176,6,0,95,1,
		12,1,80,1,36,51,0,176,4,0,95,1,12,1,
		80,1,36,52,0,176,7,0,95,1,12,1,92,9,
		5,28,119,36,53,0,176,8,0,95,1,92,9,122,
		12,3,80,5,36,54,0,176,8,0,95,1,122,92,
		8,12,3,80,1,25,87,36,57,0,176,8,0,95,
		1,95,4,122,72,122,12,3,80,5,36,58,0,176,
		8,0,95,1,122,95,4,122,49,12,3,80,1,36,
		59,0,95,5,106,2,120,0,5,28,11,36,60,0,
		106,2,88,0,80,5,36,62,0,95,5,106,2,88,
		0,69,28,20,36,63,0,176,9,0,176,3,0,95,
		5,12,1,122,12,2,80,5,36,66,0,176,10,0,
		95,1,106,2,120,0,106,1,0,12,3,80,1,36,
		67,0,176,10,0,95,1,106,2,88,0,106,1,0,
		12,3,80,1,36,68,0,176,6,0,95,1,12,1,
		80,1,36,69,0,176,4,0,95,1,12,1,80,1,
		36,71,0,176,7,0,95,1,12,1,92,8,5,28,
		88,36,72,0,176,4,0,176,9,0,176,3,0,176,
		8,0,95,1,122,92,8,12,3,12,1,92,8,12,
		2,12,1,80,1,36,73,0,176,11,0,176,8,0,
		95,1,122,92,2,12,3,106,2,46,0,72,176,8,
		0,95,1,92,3,92,3,12,3,72,106,2,46,0,
		72,176,8,0,95,1,92,6,12,2,72,12,1,80,
		3,25,109,36,74,0,176,7,0,95,1,12,1,92,
		7,5,28,87,36,75,0,176,4,0,176,9,0,176,
		3,0,176,8,0,95,1,122,92,8,12,3,12,1,
		92,7,12,2,12,1,80,1,36,76,0,176,11,0,
		176,8,0,95,1,122,122,12,3,106,2,46,0,72,
		176,8,0,95,1,92,2,92,3,12,3,72,106,2,
		46,0,72,176,8,0,95,1,92,5,12,2,72,12,
		1,80,3,25,9,36,78,0,95,1,80,3,36,80,
		0,176,12,0,95,5,12,1,31,17,36,81,0,95,
		3,106,2,45,0,72,95,5,72,80,3,36,83,0,
		176,13,0,95,3,122,12,2,106,2,48,0,5,28,
		16,36,84,0,176,8,0,95,3,92,2,12,2,80,
		3,36,86,0,176,13,0,95,3,122,12,2,106,2,
		46,0,5,28,16,36,87,0,176,8,0,95,3,92,
		2,12,2,80,3,36,89,0,95,3,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( CHECKRG )
{
	static const HB_BYTE pcode[] =
	{
		13,7,5,36,106,0,176,15,0,12,0,92,5,5,
		31,12,176,15,0,12,0,92,24,5,28,8,36,107,
		0,120,110,7,36,110,0,176,1,0,95,2,12,1,
		106,2,76,0,69,28,8,36,111,0,120,80,2,36,
		113,0,106,2,32,0,83,16,0,36,114,0,121,83,
		17,0,36,115,0,106,1,0,83,18,0,36,116,0,
		176,10,0,95,1,106,2,46,0,106,1,0,12,3,
		80,1,36,117,0,95,1,106,7,73,83,69,78,84,
		79,0,5,28,8,36,118,0,120,110,7,36,120,0,
		176,7,0,95,1,12,1,121,5,28,39,36,121,0,
		92,7,83,17,0,36,122,0,106,21,82,71,47,82,
		78,69,47,82,73,67,32,101,109,32,98,114,97,110,
		99,111,0,83,18,0,36,124,0,176,1,0,95,3,
		12,1,106,2,67,0,5,28,13,95,3,106,4,82,
		78,69,0,5,31,19,176,2,0,106,4,82,78,69,
		0,95,1,12,2,121,15,28,8,36,125,0,120,110,
		7,36,127,0,176,2,0,106,4,82,73,67,0,95,
		1,12,2,121,15,28,34,36,128,0,106,4,82,73,
		67,0,80,3,36,129,0,176,10,0,95,1,106,4,
		82,73,67,0,106,1,0,12,3,80,1,36,134,0,
		176,1,0,95,3,12,1,106,2,67,0,69,28,12,
		36,135,0,106,3,82,71,0,80,3,36,137,0,121,
		165,80,10,25,107,36,138,0,176,6,0,95,1,12,
		1,80,11,36,139,0,95,11,176,19,0,176,9,0,
		95,10,122,12,2,92,11,12,2,5,28,66,36,140,
		0,92,6,83,17,0,36,141,0,106,39,82,71,32,
		73,110,118,97,108,105,100,111,32,45,32,83,101,113,
		117,101,110,99,105,97,32,82,101,112,101,116,105,116,
		105,118,97,32,100,101,32,0,176,9,0,95,10,122,
		12,2,72,83,18,0,36,137,0,175,10,0,92,9,
		15,28,148,36,144,0,176,2,0,106,2,45,0,95,
		1,12,2,80,8,36,145,0,95,8,121,5,28,13,
		36,146,0,106,2,32,0,80,9,25,36,36,148,0,
		176,8,0,95,1,95,8,122,72,122,12,3,80,9,
		36,149,0,176,8,0,95,1,122,95,8,122,49,12,
		3,80,1,36,151,0,176,9,0,176,3,0,95,1,
		12,1,12,1,80,1,36,152,0,176,7,0,176,4,
		0,95,1,12,1,12,1,92,7,34,28,113,95,3,
		106,3,82,71,0,5,28,103,176,12,0,95,5,12,
		1,31,12,95,5,106,3,83,80,0,5,28,84,36,
		153,0,176,1,0,95,4,12,1,106,2,68,0,69,
		31,25,95,4,176,20,0,106,11,51,49,47,49,50,
		47,49,57,57,48,0,12,1,15,28,44,36,154,0,
		106,26,82,71,32,99,111,109,32,77,101,110,111,115,
		32,100,101,32,55,32,68,105,103,105,116,111,115,0,
		83,18,0,36,155,0,92,3,83,17,0,36,158,0,
		176,7,0,176,4,0,95,1,12,1,12,1,92,9,
		15,28,81,95,3,106,3,82,71,0,5,31,11,176,
		12,0,95,3,12,1,28,62,176,12,0,95,5,12,
		1,31,12,95,5,106,3,83,80,0,5,28,43,36,
		159,0,106,25,82,71,32,99,111,109,32,77,97,105,
		115,32,100,101,32,57,32,68,105,103,105,116,111,115,
		0,83,18,0,36,160,0,92,8,83,17,0,36,162,
		0,95,3,106,4,82,73,67,0,5,29,41,1,36,
		163,0,176,7,0,176,4,0,95,1,12,1,12,1,
		92,11,69,28,44,36,164,0,106,23,82,73,67,32,
		110,97,111,32,116,101,109,32,49,49,32,68,105,103,
		105,116,111,115,0,83,18,0,36,165,0,92,9,83,
		17,0,26,235,0,36,167,0,92,8,92,9,92,2,
		92,3,92,4,92,5,92,6,92,7,92,8,92,9,
		4,10,0,80,12,36,168,0,121,80,7,36,169,0,
		122,165,80,10,25,36,36,170,0,96,7,0,176,3,
		0,176,8,0,95,1,95,10,122,12,3,12,1,95,
		12,95,10,1,65,135,36,169,0,175,10,0,92,10,
		15,28,219,36,172,0,176,21,0,95,7,92,11,12,
		2,80,6,36,173,0,95,6,92,10,5,28,8,36,
		174,0,121,80,6,36,176,0,95,6,176,3,0,176,
		8,0,95,1,92,11,122,12,3,12,1,69,28,99,
		36,177,0,176,22,0,95,6,122,121,12,3,83,16,
		0,36,178,0,106,24,68,105,103,105,116,111,32,100,
		101,32,67,111,110,116,114,111,108,101,32,82,73,67,
		32,0,176,8,0,95,1,92,11,122,12,3,72,106,
		24,32,78,97,111,32,67,111,110,102,101,114,101,32,
		115,117,103,101,114,105,100,111,58,32,0,72,109,16,
		0,72,83,18,0,36,179,0,92,10,83,17,0,36,
		183,0,109,17,0,121,5,29,68,2,95,3,106,3,
		82,71,0,5,29,57,2,176,7,0,95,1,12,1,
		92,8,5,29,44,2,36,184,0,176,22,0,176,3,
		0,95,1,12,1,92,8,12,2,80,1,36,185,0,
		176,3,0,176,8,0,95,1,122,122,12,3,12,1,
		92,9,65,80,7,36,186,0,96,7,0,176,3,0,
		176,8,0,95,1,92,2,122,12,3,12,1,92,8,
		65,135,36,187,0,96,7,0,176,3,0,176,8,0,
		95,1,92,3,122,12,3,12,1,92,7,65,135,36,
		188,0,96,7,0,176,3,0,176,8,0,95,1,92,
		4,122,12,3,12,1,92,6,65,135,36,189,0,96,
		7,0,176,3,0,176,8,0,95,1,92,5,122,12,
		3,12,1,92,5,65,135,36,190,0,96,7,0,176,
		3,0,176,8,0,95,1,92,6,122,12,3,12,1,
		92,4,65,135,36,191,0,96,7,0,176,3,0,176,
		8,0,95,1,92,7,122,12,3,12,1,92,3,65,
		135,36,192,0,96,7,0,176,3,0,176,8,0,95,
		1,92,8,122,12,3,12,1,92,2,65,135,36,193,
		0,95,7,176,23,0,95,7,92,11,18,12,1,92,
		11,65,49,80,6,36,194,0,95,9,106,2,88,0,
		5,31,20,95,9,106,2,120,0,5,31,11,95,9,
		106,2,32,0,5,28,109,36,195,0,95,6,92,10,
		5,28,8,36,196,0,120,110,7,36,198,0,176,22,
		0,95,6,122,121,12,3,83,16,0,36,199,0,92,
		5,83,17,0,36,200,0,106,23,68,105,103,105,116,
		111,32,100,101,32,67,111,110,116,114,111,108,101,32,
		82,71,32,0,95,9,72,106,24,32,78,97,111,32,
		67,111,110,102,101,114,101,32,115,117,103,101,114,105,
		100,111,58,32,0,72,109,16,0,72,83,18,0,26,
		182,0,36,203,0,95,6,176,3,0,95,9,12,1,
		5,32,166,0,95,6,121,5,32,159,0,36,205,0,
		95,6,92,10,5,28,68,36,206,0,106,2,88,0,
		83,16,0,36,207,0,106,46,68,105,103,105,116,111,
		32,100,101,32,67,111,110,116,114,111,108,101,32,82,
		71,32,78,97,111,32,67,111,110,102,101,114,101,32,
		115,117,103,101,114,105,100,111,58,32,88,0,83,18,
		0,25,74,36,209,0,176,22,0,95,6,122,121,12,
		3,83,16,0,36,210,0,106,45,68,105,103,105,116,
		111,32,100,101,32,67,111,110,116,114,111,108,101,32,
		82,71,32,78,97,111,32,67,111,110,102,101,114,101,
		32,115,117,103,101,114,105,100,111,58,32,0,109,16,
		0,72,83,18,0,36,212,0,92,4,83,17,0,36,
		216,0,109,17,0,121,15,28,26,36,217,0,95,2,
		28,13,36,218,0,176,24,0,109,18,0,20,1,36,
		220,0,9,110,7,36,222,0,120,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( PEGDDD )
{
	static const HB_BYTE pcode[] =
	{
		13,1,1,36,235,0,176,26,0,95,1,12,1,80,
		1,36,236,0,106,1,0,80,2,36,237,0,176,2,
		0,106,2,40,0,95,1,12,2,121,15,28,18,36,
		238,0,176,8,0,95,1,92,2,92,2,12,3,80,
		2,36,240,0,95,2,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( PEGTEL )
{
	static const HB_BYTE pcode[] =
	{
		13,1,1,36,251,0,176,26,0,95,1,12,1,80,
		1,36,252,0,95,1,80,2,36,253,0,176,2,0,
		106,2,40,0,95,1,12,2,121,15,28,16,36,254,
		0,176,8,0,95,1,92,5,12,2,80,2,36,0,
		1,95,2,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( PEGPREF )
{
	static const HB_BYTE pcode[] =
	{
		13,1,2,36,10,1,176,1,0,95,2,12,1,106,
		2,76,0,69,28,8,36,11,1,120,80,2,36,14,
		1,106,1,0,80,3,36,15,1,176,2,0,106,2,
		45,0,95,1,12,2,121,15,28,79,36,16,1,176,
		8,0,95,1,122,176,2,0,106,2,45,0,95,1,
		12,2,122,49,12,3,80,3,36,17,1,95,2,28,
		46,36,18,1,176,7,0,95,3,12,1,92,5,5,
		28,31,176,13,0,95,3,122,12,2,106,2,57,0,
		5,28,16,36,19,1,176,8,0,95,3,92,2,12,
		2,80,3,36,23,1,95,3,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( FORMATATEL )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,49,1,176,4,0,95,1,12,1,80,
		1,36,50,1,176,10,0,95,1,106,2,32,0,106,
		1,0,12,3,80,1,36,52,1,176,8,0,95,1,
		122,92,4,12,3,106,5,48,51,48,48,0,5,31,
		56,176,8,0,95,1,122,92,4,12,3,106,5,48,
		56,48,48,0,5,31,36,176,8,0,95,1,122,92,
		2,12,3,106,3,53,53,0,5,31,18,176,8,0,
		95,1,122,122,12,3,106,2,43,0,5,28,9,36,
		54,1,95,1,110,7,36,56,1,176,8,0,95,1,
		122,122,12,3,106,2,40,0,5,28,49,176,8,0,
		95,1,92,4,122,12,3,106,2,41,0,5,28,32,
		36,57,1,176,8,0,95,1,122,92,4,12,3,176,
		29,0,176,8,0,95,1,92,5,12,2,12,1,72,
		80,1,36,59,1,176,8,0,95,1,92,3,122,12,
		3,106,2,45,0,5,28,42,36,60,1,106,2,40,
		0,176,8,0,95,1,122,92,2,12,3,72,106,2,
		41,0,72,176,29,0,176,8,0,95,1,92,4,12,
		2,12,1,72,80,1,36,62,1,176,8,0,95,1,
		92,3,122,12,3,106,2,44,0,5,28,42,36,63,
		1,106,2,40,0,176,8,0,95,1,122,92,2,12,
		3,72,106,2,41,0,72,176,29,0,176,8,0,95,
		1,92,4,12,2,12,1,72,80,1,36,65,1,176,
		8,0,95,1,92,3,122,12,3,106,2,32,0,5,
		28,42,36,66,1,106,2,40,0,176,8,0,95,1,
		122,92,2,12,3,72,106,2,41,0,72,176,29,0,
		176,8,0,95,1,92,4,12,2,12,1,72,80,1,
		36,68,1,176,8,0,95,1,92,4,122,12,3,106,
		2,45,0,5,28,59,176,8,0,95,1,122,122,12,
		3,106,2,48,0,5,28,43,36,69,1,106,2,40,
		0,176,8,0,95,1,92,2,92,2,12,3,72,106,
		2,41,0,72,176,29,0,176,8,0,95,1,92,5,
		12,2,12,1,72,80,1,36,71,1,176,8,0,95,
		1,92,4,122,12,3,106,2,32,0,5,28,59,176,
		8,0,95,1,122,122,12,3,106,2,48,0,5,28,
		43,36,72,1,106,2,40,0,176,8,0,95,1,92,
		2,92,2,12,3,72,106,2,41,0,72,176,29,0,
		176,8,0,95,1,92,5,12,2,12,1,72,80,1,
		36,74,1,176,8,0,95,1,92,4,122,12,3,106,
		2,45,0,5,28,59,176,8,0,95,1,122,122,12,
		3,106,2,48,0,5,28,43,36,75,1,106,2,40,
		0,176,8,0,95,1,92,2,92,2,12,3,72,106,
		2,41,0,72,176,29,0,176,8,0,95,1,92,5,
		12,2,12,1,72,80,1,36,77,1,176,8,0,95,
		1,122,122,12,3,106,2,40,0,5,28,77,176,8,
		0,95,1,92,2,122,12,3,106,2,48,0,5,28,
		60,176,8,0,95,1,92,5,122,12,3,106,2,41,
		0,5,28,43,36,78,1,106,2,40,0,176,8,0,
		95,1,92,3,92,2,12,3,72,106,2,41,0,72,
		176,29,0,176,8,0,95,1,92,6,12,2,12,1,
		72,80,1,36,80,1,176,2,0,106,2,40,0,95,
		1,12,2,121,5,29,206,0,176,2,0,106,2,45,
		0,95,1,12,2,121,5,29,190,0,36,82,1,176,
		7,0,95,1,12,1,92,10,5,28,55,36,83,1,
		106,2,40,0,176,13,0,95,1,92,2,12,2,72,
		106,2,41,0,72,176,8,0,95,1,92,3,92,4,
		12,3,72,106,2,45,0,72,176,8,0,95,1,92,
		7,12,2,72,80,1,25,121,36,84,1,176,7,0,
		95,1,12,1,92,11,5,28,55,36,85,1,106,2,
		40,0,176,13,0,95,1,92,2,12,2,72,106,2,
		41,0,72,176,8,0,95,1,92,3,92,5,12,3,
		72,106,2,45,0,72,176,8,0,95,1,92,8,12,
		2,72,80,1,25,53,36,86,1,176,7,0,95,1,
		12,1,92,9,5,31,26,176,7,0,95,1,12,1,
		92,8,5,31,14,176,7,0,95,1,12,1,92,7,
		5,28,14,36,87,1,176,29,0,95,1,12,1,80,
		1,36,90,1,95,1,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( FORTEL2 )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,99,1,176,4,0,176,6,0,95,1,
		12,1,12,1,80,1,36,100,1,176,7,0,95,1,
		12,1,92,9,5,28,32,36,101,1,176,8,0,95,
		1,122,92,5,12,3,106,2,45,0,72,176,8,0,
		95,1,92,6,12,2,72,80,1,36,103,1,176,7,
		0,95,1,12,1,92,8,5,28,32,36,104,1,176,
		8,0,95,1,122,92,4,12,3,106,2,45,0,72,
		176,8,0,95,1,92,5,12,2,72,80,1,36,106,
		1,176,7,0,95,1,12,1,92,7,5,28,32,36,
		107,1,176,8,0,95,1,122,92,3,12,3,106,2,
		45,0,72,176,8,0,95,1,92,4,12,2,72,80,
		1,36,109,1,95,1,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( FORMATACEP )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,118,1,176,1,0,95,1,12,1,106,
		2,78,0,5,28,16,36,119,1,176,22,0,95,1,
		92,8,12,2,80,1,36,121,1,176,4,0,95,1,
		12,1,80,1,36,122,1,176,2,0,106,2,45,0,
		95,1,12,2,121,5,28,43,176,7,0,95,1,12,
		1,92,8,5,28,31,36,123,1,176,13,0,95,1,
		92,5,12,2,106,2,45,0,72,176,31,0,95,1,
		92,3,12,2,72,80,1,36,125,1,95,1,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( CHKUFCEP )
{
	static const HB_BYTE pcode[] =
	{
		13,0,3,36,136,1,176,15,0,12,0,92,5,5,
		31,12,176,15,0,12,0,92,24,5,28,8,36,137,
		1,120,110,7,36,139,1,176,1,0,95,3,12,1,
		106,2,76,0,69,28,8,36,140,1,120,80,3,36,
		142,1,176,33,0,95,1,12,1,95,2,69,28,53,
		36,143,1,95,3,28,40,36,144,1,176,24,0,106,
		5,67,69,80,58,0,95,1,72,106,14,32,110,97,
		111,32,101,32,100,97,32,85,70,58,0,72,95,2,
		72,20,1,36,146,1,9,110,7,36,148,1,120,110,
		7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( CEP2UF )
{
	static const HB_BYTE pcode[] =
	{
		13,1,1,36,158,1,176,6,0,95,1,12,1,80,
		1,36,159,1,176,3,0,95,1,12,1,80,1,36,
		160,1,106,3,69,88,0,80,2,36,162,1,95,1,
		97,64,66,15,0,16,28,25,95,1,97,255,44,49,
		1,34,28,15,36,163,1,106,3,83,80,0,80,2,
		26,29,4,36,164,1,95,1,97,0,45,49,1,16,
		28,25,95,1,97,63,129,186,1,34,28,15,36,165,
		1,106,3,82,74,0,80,2,26,249,3,36,166,1,
		95,1,97,64,129,186,1,16,28,25,95,1,97,127,
		195,201,1,34,28,15,36,167,1,106,3,69,83,0,
		80,2,26,213,3,36,168,1,95,1,97,128,195,201,
		1,16,28,25,95,1,97,255,89,98,2,34,28,15,
		36,169,1,106,3,77,71,0,80,2,26,177,3,36,
		170,1,95,1,97,0,90,98,2,16,28,25,95,1,
		97,63,174,235,2,34,28,15,36,171,1,106,3,66,
		65,0,80,2,26,141,3,36,172,1,95,1,97,64,
		174,235,2,16,28,25,95,1,97,127,240,250,2,34,
		28,15,36,173,1,106,3,83,69,0,80,2,26,105,
		3,36,174,1,95,1,97,128,240,250,2,16,28,25,
		95,1,97,63,192,101,3,34,28,15,36,175,1,106,
		3,80,69,0,80,2,26,69,3,36,176,1,95,1,
		97,64,192,101,3,16,28,25,95,1,97,127,2,117,
		3,34,28,15,36,177,1,106,3,65,76,0,80,2,
		26,33,3,36,178,1,95,1,97,128,2,117,3,16,
		28,25,95,1,97,191,68,132,3,34,28,15,36,179,
		1,106,3,80,66,0,80,2,26,253,2,36,180,1,
		95,1,97,192,68,132,3,16,28,25,95,1,97,255,
		134,147,3,34,28,15,36,181,1,106,3,82,78,0,
		80,2,26,217,2,36,182,1,95,1,97,0,135,147,
		3,16,28,25,95,1,97,255,143,208,3,34,28,15,
		36,183,1,106,3,67,69,0,80,2,26,181,2,36,
		184,1,95,1,97,0,144,208,3,16,28,25,95,1,
		97,63,210,223,3,34,28,15,36,185,1,106,3,80,
		73,0,80,2,26,145,2,36,186,1,95,1,97,64,
		210,223,3,16,28,25,95,1,97,127,20,239,3,34,
		28,15,36,187,1,106,3,77,65,0,80,2,26,109,
		2,36,188,1,95,1,97,128,20,239,3,16,28,25,
		95,1,97,159,84,27,4,34,28,15,36,189,1,106,
		3,80,65,0,80,2,26,73,2,36,190,1,95,1,
		97,160,84,27,4,16,28,25,95,1,97,63,219,28,
		4,34,28,15,36,191,1,106,3,65,80,0,80,2,
		26,37,2,36,192,1,95,1,97,64,219,28,4,16,
		28,25,95,1,97,31,111,33,4,34,28,15,36,193,
		1,106,3,65,77,0,80,2,26,1,2,36,194,1,
		95,1,97,32,111,33,4,16,28,25,95,1,97,191,
		245,34,4,34,28,15,36,195,1,106,3,82,82,0,
		80,2,26,221,1,36,196,1,95,1,97,192,245,34,
		4,16,28,25,95,1,97,223,150,42,4,34,28,15,
		36,197,1,106,3,65,77,0,80,2,26,185,1,36,
		198,1,95,1,97,224,150,42,4,16,28,25,95,1,
		97,127,29,44,4,34,28,15,36,199,1,106,3,65,
		67,0,80,2,26,149,1,36,200,1,95,1,97,128,
		29,44,4,16,28,25,95,1,97,255,214,86,4,34,
		28,15,36,201,1,106,3,68,70,0,80,2,26,113,
		1,36,202,1,95,1,97,0,215,86,4,16,28,25,
		95,1,97,63,228,89,4,34,28,15,36,203,1,106,
		3,71,79,0,80,2,26,77,1,36,204,1,95,1,
		97,64,228,89,4,16,28,25,95,1,97,159,146,100,
		4,34,28,15,36,205,1,106,3,68,70,0,80,2,
		26,41,1,36,206,1,95,1,97,160,146,100,4,16,
		28,25,95,1,97,255,223,147,4,34,28,15,36,207,
		1,106,3,71,79,0,80,2,26,5,1,36,208,1,
		95,1,97,64,237,150,4,16,28,25,95,1,97,127,
		47,166,4,34,28,15,36,209,1,106,3,84,79,0,
		80,2,26,225,0,36,210,1,95,1,97,128,47,166,
		4,16,28,25,95,1,97,31,235,179,4,34,28,15,
		36,211,1,106,3,77,84,0,80,2,26,189,0,36,
		212,1,95,1,97,32,235,179,4,16,28,25,95,1,
		97,191,113,181,4,34,28,15,36,213,1,106,3,82,
		79,0,80,2,26,153,0,36,214,1,95,1,97,192,
		113,181,4,16,28,24,95,1,97,255,179,196,4,34,
		28,14,36,215,1,106,3,77,83,0,80,2,25,117,
		36,216,1,95,1,97,0,180,196,4,16,28,24,95,
		1,97,255,197,62,5,34,28,14,36,217,1,106,3,
		80,82,0,80,2,25,82,36,218,1,95,1,97,0,
		198,62,5,16,28,24,95,1,97,127,74,93,5,34,
		28,14,36,219,1,106,3,83,67,0,80,2,25,47,
		36,220,1,95,1,97,128,74,93,5,16,28,24,95,
		1,97,255,224,245,5,34,28,14,36,221,1,106,3,
		82,83,0,80,2,25,12,36,223,1,106,3,69,88,
		0,80,2,36,225,1,95,2,110,7
	};

	hb_vmExecute( pcode, symbols );
}
