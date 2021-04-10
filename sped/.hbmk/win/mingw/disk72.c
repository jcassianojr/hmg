/*
 * Harbour 3.2.0dev (r2011030937)
 * MinGW GNU C 7.3 (32-bit)
 * Generated C source from "c:\develop\harbour\objmgw\disk72.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( FILENAMES );
HB_FUNC_EXTERN( VALTYPE );
HB_FUNC_EXTERN( ARRAY );
HB_FUNC_EXTERN( LEN );
HB_FUNC_EXTERN( DIRECTORY );
HB_FUNC_EXTERN( UPPER );
HB_FUNC_EXTERN( LOWER );
HB_FUNC( TIRAEXT );
HB_FUNC_EXTERN( HB_FNAMESPLIT );
HB_FUNC( TROCAEXT );
HB_FUNC( DELETAARQ );
HB_FUNC_EXTERN( FERASE );


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_DISK72 )
{ "FILENAMES", {HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL}, {HB_FUNCNAME( FILENAMES )}, NULL },
{ "VALTYPE", {HB_FS_PUBLIC}, {HB_FUNCNAME( VALTYPE )}, NULL },
{ "ARRAY", {HB_FS_PUBLIC}, {HB_FUNCNAME( ARRAY )}, NULL },
{ "LEN", {HB_FS_PUBLIC}, {HB_FUNCNAME( LEN )}, NULL },
{ "DIRECTORY", {HB_FS_PUBLIC}, {HB_FUNCNAME( DIRECTORY )}, NULL },
{ "UPPER", {HB_FS_PUBLIC}, {HB_FUNCNAME( UPPER )}, NULL },
{ "LOWER", {HB_FS_PUBLIC}, {HB_FUNCNAME( LOWER )}, NULL },
{ "TIRAEXT", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( TIRAEXT )}, NULL },
{ "HB_FNAMESPLIT", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_FNAMESPLIT )}, NULL },
{ "TROCAEXT", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( TROCAEXT )}, NULL },
{ "DELETAARQ", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( DELETAARQ )}, NULL },
{ "FERASE", {HB_FS_PUBLIC}, {HB_FUNCNAME( FERASE )}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_DISK72, "c:\\develop\\harbour\\objmgw\\disk72.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_DISK72
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_DISK72 )
   #include "hbiniseg.h"
#endif

HB_FUNC( FILENAMES )
{
	static const HB_BYTE pcode[] =
	{
		13,3,2,36,24,0,176,1,0,95,2,12,1,106,
		2,67,0,69,28,10,36,25,0,106,1,0,80,2,
		36,27,0,176,2,0,176,3,0,176,4,0,95,1,
		12,1,165,80,3,12,1,12,1,80,4,36,28,0,
		122,165,80,5,25,102,36,30,0,95,2,106,2,85,
		0,5,28,24,36,31,0,176,5,0,95,3,95,5,
		1,122,1,12,1,95,4,95,5,2,25,62,36,32,
		0,95,2,106,2,76,0,5,28,24,36,33,0,176,
		6,0,95,3,95,5,1,122,1,12,1,95,4,95,
		5,2,25,28,36,34,0,95,2,106,1,0,5,28,
		17,36,35,0,95,3,95,5,1,122,1,95,4,95,
		5,2,36,28,0,175,5,0,176,3,0,95,3,12,
		1,15,28,148,36,38,0,95,4,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( TIRAEXT )
{
	static const HB_BYTE pcode[] =
	{
		13,1,2,36,48,0,176,8,0,95,1,100,96,3,
		0,20,3,36,49,0,176,1,0,95,2,12,1,106,
		2,67,0,5,28,16,36,50,0,96,3,0,106,2,
		46,0,95,2,72,135,36,52,0,95,3,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( TROCAEXT )
{
	static const HB_BYTE pcode[] =
	{
		13,0,2,36,61,0,176,7,0,95,1,95,2,20,
		2,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( DELETAARQ )
{
	static const HB_BYTE pcode[] =
	{
		13,2,1,36,74,0,176,1,0,95,1,12,1,106,
		2,67,0,69,28,17,36,75,0,106,8,84,69,77,
		80,42,46,42,0,80,1,36,77,0,176,0,0,95,
		1,12,1,80,2,36,78,0,122,165,80,3,25,21,
		36,79,0,176,11,0,95,2,95,3,1,20,1,36,
		78,0,175,3,0,176,3,0,95,2,12,1,15,28,
		229,36,80,0,7
	};

	hb_vmExecute( pcode, symbols );
}

