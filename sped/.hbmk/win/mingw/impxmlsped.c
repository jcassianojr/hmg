/*
 * Harbour 3.2.0dev (r2011030937)
 * MinGW GNU C 7.3 (32-bit)
 * Generated C source from "C:\develop\hmg\sped\impxmlsped.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( IMPXMLSPED );
HB_FUNC_EXTERN( GETFOLDER );
HB_FUNC_EXTERN( DIRECTORY );
HB_FUNC_EXTERN( ARQLOGDATAHORA );
HB_FUNC_EXTERN( FCREATE );
HB_FUNC_EXTERN( LEN );
HB_FUNC_EXTERN( UPPER );
HB_FUNC_EXTERN( MDS );
HB_FUNC_EXTERN( STR );
HB_FUNC_EXTERN( HB_MEMOREAD );
HB_FUNC_EXTERN( AT );
HB_FUNC_EXTERN( PEGADADOS );
HB_FUNC_EXTERN( ALLTRIM );
HB_FUNC_EXTERN( ASCAN );
HB_FUNC_EXTERN( VALCGC );
HB_FUNC_EXTERN( VALCPF );
HB_FUNC_EXTERN( AADD );
HB_FUNC_EXTERN( ARRAY );
HB_FUNC_EXTERN( GERARR );
HB_FUNC_EXTERN( SUBSTR );
HB_FUNC_EXTERN( VAL );
HB_FUNC_EXTERN( DTOC );
HB_FUNC_EXTERN( STOD );
HB_FUNC_EXTERN( STRTRAN );
HB_FUNC_EXTERN( STRZERO );
HB_FUNC_EXTERN( FCLOSE );


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_IMPXMLSPED )
{ "IMPXMLSPED", {HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL}, {HB_FUNCNAME( IMPXMLSPED )}, NULL },
{ "GETFOLDER", {HB_FS_PUBLIC}, {HB_FUNCNAME( GETFOLDER )}, NULL },
{ "CFOLDER", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "DIRECTORY", {HB_FS_PUBLIC}, {HB_FUNCNAME( DIRECTORY )}, NULL },
{ "MLISTAARQ", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "ARQLOGDATAHORA", {HB_FS_PUBLIC}, {HB_FUNCNAME( ARQLOGDATAHORA )}, NULL },
{ "CARQSPED", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "FCREATE", {HB_FS_PUBLIC}, {HB_FUNCNAME( FCREATE )}, NULL },
{ "NSPED", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "CARQSPED2", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "NSPEDXML", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "LEN", {HB_FS_PUBLIC}, {HB_FUNCNAME( LEN )}, NULL },
{ "NLENX", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "ACNPJ", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "I", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "UPPER", {HB_FS_PUBLIC}, {HB_FUNCNAME( UPPER )}, NULL },
{ "CARQUIVO", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "MDS", {HB_FS_PUBLIC}, {HB_FUNCNAME( MDS )}, NULL },
{ "STR", {HB_FS_PUBLIC}, {HB_FUNCNAME( STR )}, NULL },
{ "HB_MEMOREAD", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_MEMOREAD )}, NULL },
{ "CLINHATXT", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "LCTE", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "NFIMZ", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "AT", {HB_FS_PUBLIC}, {HB_FUNCNAME( AT )}, NULL },
{ "NPOS1", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "Z", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "PEGADADOS", {HB_FS_PUBLIC}, {HB_FUNCNAME( PEGADADOS )}, NULL },
{ "ALLTRIM", {HB_FS_PUBLIC}, {HB_FUNCNAME( ALLTRIM )}, NULL },
{ "CLIDOS2", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "LINHA2", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "XCNPJ", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "ASCAN", {HB_FS_PUBLIC}, {HB_FUNCNAME( ASCAN )}, NULL },
{ "VALCGC", {HB_FS_PUBLIC}, {HB_FUNCNAME( VALCGC )}, NULL },
{ "VALCPF", {HB_FS_PUBLIC}, {HB_FUNCNAME( VALCPF )}, NULL },
{ "AADD", {HB_FS_PUBLIC}, {HB_FUNCNAME( AADD )}, NULL },
{ "ARRAY", {HB_FS_PUBLIC}, {HB_FUNCNAME( ARRAY )}, NULL },
{ "ASPED", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "GERARR", {HB_FS_PUBLIC}, {HB_FUNCNAME( GERARR )}, NULL },
{ "SUBSTR", {HB_FS_PUBLIC}, {HB_FUNCNAME( SUBSTR )}, NULL },
{ "CID", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "CCNPJ", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "CUFCOD", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "CANO", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "CMES", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "VAL", {HB_FS_PUBLIC}, {HB_FUNCNAME( VAL )}, NULL },
{ "CNNF", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "CSERIE", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "CMODELO", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "ATAGS", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "APOS", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "K", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "DTOC", {HB_FS_PUBLIC}, {HB_FUNCNAME( DTOC )}, NULL },
{ "STOD", {HB_FS_PUBLIC}, {HB_FUNCNAME( STOD )}, NULL },
{ "STRTRAN", {HB_FS_PUBLIC}, {HB_FUNCNAME( STRTRAN )}, NULL },
{ "CDATA", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "NCONTA", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "STRZERO", {HB_FS_PUBLIC}, {HB_FUNCNAME( STRZERO )}, NULL },
{ "CCHAVE", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "NPOSINI", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "LINHA3", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "CVTPREST", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "CVBC", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "CVICMS", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "CCST", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "FCLOSE", {HB_FS_PUBLIC}, {HB_FUNCNAME( FCLOSE )}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_IMPXMLSPED, "C:\\develop\\hmg\\sped\\impxmlsped.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_IMPXMLSPED
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_IMPXMLSPED )
   #include "hbiniseg.h"
#endif

HB_FUNC( IMPXMLSPED )
{
	static const HB_BYTE pcode[] =
	{
		36,1,0,176,1,0,106,19,80,97,115,116,97,32,
		65,114,113,117,105,118,111,115,32,88,77,76,0,12,
		1,83,2,0,36,2,0,109,2,0,106,2,92,0,
		72,83,2,0,36,3,0,176,3,0,109,2,0,106,
		6,42,46,120,109,108,0,72,106,2,68,0,12,2,
		83,4,0,36,5,0,109,2,0,106,6,83,80,69,
		68,95,0,72,176,5,0,106,4,116,120,116,0,12,
		1,72,83,6,0,36,6,0,176,7,0,109,6,0,
		12,1,83,8,0,36,7,0,109,2,0,106,9,83,
		80,69,68,88,77,76,95,0,72,176,5,0,106,4,
		116,120,116,0,12,1,72,83,9,0,36,8,0,176,
		7,0,109,9,0,12,1,83,10,0,36,11,0,176,
		11,0,109,4,0,12,1,83,12,0,36,12,0,4,
		0,0,83,13,0,36,13,0,122,165,83,14,0,26,
		136,4,36,14,0,176,15,0,98,4,0,109,14,0,
		1,122,1,12,1,83,16,0,36,15,0,176,17,0,
		106,9,114,101,103,48,49,53,48,32,0,109,16,0,
		72,176,18,0,109,14,0,12,1,72,106,2,47,0,
		72,176,18,0,109,12,0,12,1,72,20,1,36,16,
		0,176,19,0,109,2,0,109,16,0,72,12,1,83,
		20,0,36,17,0,9,83,21,0,36,18,0,92,2,
		83,22,0,36,19,0,176,23,0,106,8,99,116,101,
		80,114,111,99,0,109,20,0,12,2,83,24,0,36,
		20,0,109,24,0,121,15,28,17,36,21,0,120,83,
		21,0,36,22,0,92,4,83,22,0,36,25,0,122,
		165,83,25,0,26,215,3,36,27,0,109,25,0,122,
		5,28,39,36,28,0,176,26,0,106,5,101,109,105,
		116,0,176,27,0,109,20,0,12,1,100,106,5,101,
		109,105,116,0,12,4,83,28,0,26,142,0,36,29,
		0,109,25,0,92,2,5,28,38,36,30,0,176,26,
		0,106,5,100,101,115,116,0,176,27,0,109,20,0,
		12,1,100,106,5,100,101,115,116,0,12,4,83,28,
		0,25,94,36,31,0,109,25,0,92,3,5,28,37,
		36,32,0,176,26,0,106,5,100,101,115,116,0,176,
		27,0,109,20,0,12,1,100,106,4,114,101,109,0,
		12,4,83,28,0,25,48,36,33,0,109,25,0,92,
		4,5,28,37,36,34,0,176,26,0,106,5,100,101,
		115,116,0,176,27,0,109,20,0,12,1,100,106,6,
		101,120,112,101,100,0,12,4,83,28,0,36,36,0,
		109,28,0,83,29,0,36,37,0,176,26,0,106,5,
		67,78,80,74,0,176,27,0,109,29,0,12,1,12,
		2,83,30,0,36,38,0,176,31,0,109,13,0,109,
		30,0,12,2,121,5,29,220,2,176,32,0,109,30,
		0,100,9,12,3,31,14,176,33,0,109,30,0,9,
		12,2,29,196,2,36,39,0,176,34,0,109,13,0,
		109,30,0,20,2,36,40,0,176,35,0,92,14,12,
		1,83,36,0,36,41,0,106,1,0,98,36,0,122,
		2,36,42,0,106,5,48,49,53,48,0,98,36,0,
		92,2,2,36,43,0,109,30,0,98,36,0,92,3,
		2,36,44,0,176,26,0,106,6,120,78,111,109,101,
		0,176,27,0,109,29,0,12,1,12,2,98,36,0,
		92,4,2,36,45,0,176,26,0,106,6,99,80,97,
		105,115,0,176,27,0,109,29,0,12,1,12,2,98,
		36,0,92,5,2,36,46,0,109,30,0,98,36,0,
		92,6,2,36,47,0,176,26,0,106,4,67,80,70,
		0,176,27,0,109,29,0,12,1,12,2,98,36,0,
		92,7,2,36,48,0,176,26,0,106,3,73,69,0,
		176,27,0,109,29,0,12,1,12,2,98,36,0,92,
		8,2,36,49,0,176,26,0,106,5,99,77,117,110,
		0,176,27,0,109,29,0,12,1,12,2,98,36,0,
		92,9,2,36,50,0,176,26,0,106,5,73,83,85,
		70,0,176,27,0,109,29,0,12,1,12,2,98,36,
		0,92,10,2,36,51,0,176,26,0,106,5,120,76,
		103,114,0,176,27,0,109,29,0,12,1,12,2,98,
		36,0,92,11,2,36,52,0,176,26,0,106,4,110,
		114,111,0,176,27,0,109,29,0,12,1,12,2,98,
		36,0,92,12,2,36,53,0,176,26,0,106,5,120,
		99,112,108,0,176,27,0,109,29,0,12,1,12,2,
		98,36,0,92,13,2,36,54,0,176,26,0,106,8,
		120,66,97,105,114,114,111,0,176,27,0,109,29,0,
		12,1,12,2,98,36,0,92,14,2,36,55,0,176,
		37,0,109,36,0,109,8,0,20,2,36,68,0,176,
		34,0,109,36,0,176,26,0,106,6,120,70,65,78,
		84,0,176,27,0,109,29,0,12,1,12,2,20,2,
		36,69,0,176,34,0,109,36,0,176,26,0,106,5,
		120,77,117,110,0,176,27,0,109,29,0,12,1,12,
		2,20,2,36,70,0,176,34,0,109,36,0,176,26,
		0,106,3,85,70,0,176,27,0,109,29,0,12,1,
		12,2,20,2,36,71,0,176,34,0,109,36,0,176,
		26,0,106,4,67,69,80,0,176,27,0,109,29,0,
		12,1,12,2,20,2,36,72,0,176,34,0,109,36,
		0,176,26,0,106,6,120,80,97,105,115,0,176,27,
		0,109,29,0,12,1,12,2,20,2,36,73,0,176,
		34,0,109,36,0,176,26,0,106,5,102,111,110,101,
		0,176,27,0,109,29,0,12,1,12,2,20,2,36,
		74,0,176,34,0,109,36,0,176,26,0,106,5,73,
		69,83,84,0,176,27,0,109,29,0,12,1,12,2,
		20,2,36,75,0,176,34,0,109,36,0,176,26,0,
		106,6,101,109,97,105,108,0,176,27,0,109,29,0,
		12,1,12,2,20,2,36,76,0,176,34,0,109,36,
		0,176,26,0,106,3,73,77,0,176,27,0,109,29,
		0,12,1,12,2,20,2,36,77,0,176,34,0,109,
		36,0,176,26,0,106,5,99,110,97,101,0,176,27,
		0,109,29,0,12,1,12,2,20,2,36,78,0,176,
		37,0,109,36,0,109,10,0,20,2,36,25,0,109,
		25,0,23,21,83,25,0,109,22,0,15,29,40,252,
		36,13,0,109,14,0,23,21,83,14,0,109,12,0,
		15,29,119,251,36,83,0,122,165,83,14,0,26,232,
		8,36,84,0,176,15,0,98,4,0,109,14,0,1,
		122,1,12,1,83,16,0,36,85,0,176,17,0,106,
		9,114,101,103,67,49,48,48,32,0,109,16,0,72,
		176,18,0,109,14,0,12,1,72,106,2,47,0,72,
		176,18,0,109,12,0,12,1,72,20,1,36,86,0,
		176,19,0,109,2,0,109,16,0,72,12,1,83,20,
		0,36,87,0,176,23,0,106,8,110,102,101,80,114,
		111,99,0,109,20,0,12,2,83,24,0,36,88,0,
		109,24,0,121,15,29,102,8,36,89,0,176,23,0,
		106,6,99,104,78,70,101,0,109,20,0,12,2,83,
		24,0,36,90,0,176,35,0,92,30,12,1,83,36,
		0,36,91,0,176,38,0,109,20,0,109,24,0,92,
		6,72,92,44,12,3,83,39,0,36,92,0,176,38,
		0,109,39,0,92,7,92,14,12,3,83,40,0,36,
		93,0,176,38,0,109,39,0,122,92,2,12,3,83,
		41,0,36,94,0,176,38,0,109,39,0,92,3,92,
		2,12,3,83,42,0,36,95,0,176,38,0,109,39,
		0,92,5,92,2,12,3,83,43,0,36,96,0,176,
		27,0,176,18,0,176,44,0,176,38,0,109,39,0,
		92,26,92,9,12,3,12,1,12,1,12,1,83,45,
		0,36,97,0,176,27,0,176,18,0,176,44,0,176,
		38,0,109,39,0,92,23,92,3,12,3,12,1,12,
		1,12,1,83,46,0,36,98,0,176,38,0,109,39,
		0,92,21,92,2,12,3,83,47,0,36,99,0,176,
		26,0,106,6,84,79,84,65,76,0,176,27,0,109,
		20,0,12,1,12,2,83,29,0,36,100,0,176,26,
		0,106,8,73,67,77,83,84,79,84,0,176,27,0,
		109,29,0,12,1,12,2,83,29,0,36,101,0,106,
		4,86,78,70,0,106,6,86,80,82,79,68,0,106,
		4,86,66,67,0,106,6,86,73,67,77,83,0,106,
		5,86,73,80,73,0,106,5,86,80,73,83,0,106,
		8,86,67,79,70,73,78,83,0,106,6,86,66,67,
		83,84,0,106,4,86,83,84,0,106,7,86,79,85,
		84,82,79,0,106,6,86,68,69,83,67,0,106,5,
		86,83,69,71,0,106,7,86,70,82,69,84,69,0,
		4,13,0,83,48,0,36,102,0,92,13,92,17,92,
		22,92,23,92,26,92,27,92,28,92,24,92,25,92,
		21,92,15,92,20,92,19,4,13,0,83,49,0,36,
		103,0,122,165,83,50,0,25,47,36,104,0,176,26,
		0,98,48,0,109,50,0,1,176,27,0,109,29,0,
		12,1,12,2,98,36,0,98,49,0,109,50,0,1,
		2,36,103,0,109,50,0,23,21,83,50,0,176,11,
		0,109,48,0,12,1,15,28,202,36,106,0,176,51,
		0,176,52,0,176,53,0,176,26,0,106,5,100,69,
		109,105,0,176,27,0,109,20,0,12,1,12,2,106,
		2,45,0,106,1,0,12,3,12,1,12,1,83,54,
		0,36,107,0,176,53,0,109,54,0,106,2,47,0,
		106,1,0,12,3,83,54,0,36,108,0,106,1,0,
		98,36,0,122,2,36,109,0,106,5,67,49,48,48,
		0,98,36,0,92,2,2,36,110,0,106,2,48,0,
		98,36,0,92,3,2,36,111,0,106,2,49,0,98,
		36,0,92,4,2,36,112,0,109,40,0,98,36,0,
		92,5,2,36,113,0,109,47,0,98,36,0,92,6,
		2,36,114,0,106,3,48,48,0,98,36,0,92,7,
		2,36,115,0,109,46,0,98,36,0,92,8,2,36,
		116,0,109,45,0,98,36,0,92,9,2,36,117,0,
		109,39,0,98,36,0,92,10,2,36,118,0,109,54,
		0,98,36,0,92,11,2,36,119,0,106,1,0,98,
		36,0,92,12,2,36,120,0,106,2,57,0,98,36,
		0,92,14,2,36,121,0,121,98,36,0,92,16,2,
		36,122,0,176,26,0,106,9,109,111,100,70,114,101,
		116,101,0,176,27,0,109,20,0,12,1,12,2,98,
		36,0,92,18,2,36,123,0,121,98,36,0,92,29,
		2,36,124,0,121,98,36,0,92,30,2,36,125,0,
		176,37,0,109,36,0,109,8,0,20,2,36,126,0,
		176,37,0,109,36,0,109,10,0,20,2,36,128,0,
		122,83,55,0,36,130,0,109,55,0,92,10,35,28,
		39,36,131,0,106,12,100,101,116,32,110,73,116,101,
		109,61,34,0,176,56,0,109,55,0,122,12,2,72,
		106,2,34,0,72,83,57,0,25,38,36,133,0,106,
		12,100,101,116,32,110,73,116,101,109,61,34,0,176,
		56,0,109,55,0,92,2,12,2,72,106,2,34,0,
		72,83,57,0,36,135,0,176,23,0,109,57,0,109,
		20,0,12,2,83,58,0,36,136,0,176,38,0,109,
		20,0,109,58,0,122,49,12,2,83,29,0,36,137,
		0,176,26,0,109,57,0,176,27,0,109,29,0,12,
		1,100,106,4,100,101,116,0,12,4,83,29,0,36,
		138,0,109,29,0,106,2,48,0,5,28,15,176,11,
		0,109,29,0,12,1,122,5,32,143,4,36,142,0,
		176,35,0,92,38,12,1,83,36,0,36,143,0,106,
		1,0,98,36,0,122,2,36,144,0,106,5,67,49,
		55,48,0,98,36,0,92,2,2,36,145,0,176,27,
		0,176,18,0,109,55,0,12,1,12,1,98,36,0,
		92,3,2,36,146,0,176,26,0,106,6,67,80,82,
		79,68,0,176,27,0,109,29,0,12,1,12,2,98,
		36,0,92,4,2,36,147,0,176,26,0,106,6,88,
		80,82,79,68,0,176,27,0,109,29,0,12,1,12,
		2,98,36,0,92,5,2,36,148,0,176,26,0,106,
		5,113,67,111,109,0,176,27,0,109,29,0,12,1,
		12,2,98,36,0,92,6,2,36,149,0,176,26,0,
		106,5,117,67,111,109,0,176,27,0,109,29,0,12,
		1,12,2,98,36,0,92,7,2,36,150,0,176,26,
		0,106,7,118,85,110,67,111,109,0,176,27,0,109,
		29,0,12,1,12,2,98,36,0,92,8,2,36,151,
		0,106,1,0,98,36,0,92,9,2,36,152,0,106,
		1,0,98,36,0,92,10,2,36,154,0,176,26,0,
		106,5,73,67,77,83,0,176,27,0,109,29,0,12,
		1,12,2,83,59,0,36,155,0,176,26,0,106,4,
		67,83,84,0,176,27,0,109,59,0,12,1,12,2,
		98,36,0,92,11,2,36,156,0,176,26,0,106,5,
		67,70,79,80,0,176,27,0,109,59,0,12,1,12,
		2,98,36,0,92,12,2,36,157,0,106,1,0,98,
		36,0,92,13,2,36,158,0,176,26,0,106,4,86,
		66,67,0,176,27,0,109,59,0,12,1,12,2,98,
		36,0,92,14,2,36,159,0,176,26,0,106,6,112,
		73,67,77,83,0,176,27,0,109,59,0,12,1,12,
		2,98,36,0,92,15,2,36,160,0,176,26,0,106,
		6,118,73,67,77,83,0,176,27,0,109,59,0,12,
		1,12,2,98,36,0,92,16,2,36,163,0,176,26,
		0,106,6,118,66,67,83,84,0,176,27,0,109,29,
		0,12,1,12,2,98,36,0,92,17,2,36,164,0,
		176,26,0,106,8,112,73,67,77,83,83,84,0,176,
		27,0,109,29,0,12,1,12,2,98,36,0,92,18,
		2,36,165,0,176,26,0,106,8,118,73,67,77,83,
		83,84,0,176,27,0,109,29,0,12,1,12,2,98,
		36,0,92,19,2,36,167,0,106,1,0,98,36,0,
		92,20,2,36,169,0,176,26,0,106,4,73,80,73,
		0,176,27,0,109,29,0,12,1,12,2,83,59,0,
		36,170,0,176,26,0,106,4,67,83,84,0,176,27,
		0,109,59,0,12,1,12,2,98,36,0,92,21,2,
		36,171,0,176,26,0,106,5,67,69,78,81,0,176,
		27,0,109,59,0,12,1,12,2,98,36,0,92,22,
		2,36,172,0,176,26,0,106,4,86,66,67,0,176,
		27,0,109,59,0,12,1,12,2,98,36,0,92,23,
		2,36,173,0,176,26,0,106,5,112,73,80,73,0,
		176,27,0,109,59,0,12,1,12,2,98,36,0,92,
		24,2,36,174,0,176,26,0,106,5,118,73,80,73,
		0,176,27,0,109,59,0,12,1,12,2,98,36,0,
		92,25,2,36,176,0,176,26,0,106,4,80,73,83,
		0,176,27,0,109,29,0,12,1,12,2,83,59,0,
		36,177,0,176,26,0,106,4,67,83,84,0,176,27,
		0,109,59,0,12,1,12,2,98,36,0,92,26,2,
		36,178,0,176,26,0,106,4,86,66,67,0,176,27,
		0,109,59,0,12,1,12,2,98,36,0,92,27,2,
		36,179,0,176,26,0,106,5,80,80,73,83,0,176,
		27,0,109,59,0,12,1,12,2,98,36,0,92,28,
		2,36,180,0,176,26,0,106,8,113,66,67,80,114,
		111,100,0,176,27,0,109,59,0,12,1,12,2,98,
		36,0,92,29,2,36,181,0,176,26,0,106,10,118,
		65,108,105,113,80,114,111,100,0,176,27,0,109,59,
		0,12,1,12,2,98,36,0,92,30,2,36,182,0,
		176,26,0,106,5,86,80,73,83,0,176,27,0,109,
		59,0,12,1,12,2,98,36,0,92,31,2,36,184,
		0,176,26,0,106,7,67,79,70,73,78,83,0,176,
		27,0,109,29,0,12,1,12,2,83,59,0,36,185,
		0,176,26,0,106,4,67,83,84,0,176,27,0,109,
		59,0,12,1,12,2,98,36,0,92,32,2,36,186,
		0,176,26,0,106,4,86,66,67,0,176,27,0,109,
		59,0,12,1,12,2,98,36,0,92,33,2,36,187,
		0,176,26,0,106,8,80,67,79,70,73,78,83,0,
		176,27,0,109,59,0,12,1,12,2,98,36,0,92,
		34,2,36,188,0,176,26,0,106,8,113,66,67,80,
		114,111,100,0,176,27,0,109,59,0,12,1,12,2,
		98,36,0,92,35,2,36,189,0,176,26,0,106,10,
		118,65,108,105,113,80,114,111,100,0,176,27,0,109,
		59,0,12,1,12,2,98,36,0,92,36,2,36,190,
		0,176,26,0,106,8,86,67,79,70,73,78,83,0,
		176,27,0,109,59,0,12,1,12,2,98,36,0,92,
		37,2,36,191,0,106,1,0,98,36,0,92,38,2,
		36,193,0,176,37,0,109,36,0,109,8,0,20,2,
		36,194,0,176,37,0,109,36,0,109,10,0,20,2,
		36,199,0,109,55,0,23,83,55,0,26,200,250,36,
		83,0,109,14,0,23,21,83,14,0,109,12,0,15,
		29,23,247,36,204,0,122,165,83,14,0,26,196,3,
		36,205,0,176,15,0,98,4,0,109,14,0,1,122,
		1,12,1,83,16,0,36,206,0,176,17,0,106,9,
		82,69,71,68,49,48,48,32,0,109,16,0,72,176,
		18,0,109,14,0,12,1,72,106,2,47,0,72,176,
		18,0,109,12,0,12,1,72,20,1,36,207,0,176,
		19,0,109,2,0,109,16,0,72,12,1,83,20,0,
		36,208,0,176,23,0,106,8,99,116,101,80,114,111,
		99,0,109,20,0,12,2,83,24,0,36,209,0,109,
		24,0,121,15,29,66,3,36,210,0,176,23,0,106,
		4,73,100,61,0,109,20,0,12,2,83,24,0,36,
		211,0,176,35,0,92,24,12,1,83,36,0,36,212,
		0,176,38,0,109,20,0,109,24,0,92,7,72,92,
		44,12,3,83,39,0,36,213,0,176,38,0,109,39,
		0,92,7,92,14,12,3,83,40,0,36,214,0,176,
		38,0,109,39,0,122,92,2,12,3,83,41,0,36,
		215,0,176,38,0,109,39,0,92,3,92,2,12,3,
		83,42,0,36,216,0,176,38,0,109,39,0,92,5,
		92,2,12,3,83,43,0,36,217,0,176,27,0,176,
		18,0,176,44,0,176,38,0,109,39,0,92,26,92,
		9,12,3,12,1,12,1,12,1,83,45,0,36,218,
		0,176,27,0,176,18,0,176,44,0,176,38,0,109,
		39,0,92,23,92,3,12,3,12,1,12,1,12,1,
		83,46,0,36,219,0,176,38,0,109,39,0,92,21,
		92,2,12,3,83,47,0,36,220,0,176,26,0,106,
		7,86,80,82,69,83,84,0,176,27,0,109,20,0,
		12,1,12,2,83,29,0,36,221,0,176,26,0,106,
		8,86,84,80,82,69,83,84,0,176,27,0,109,29,
		0,12,1,12,2,83,60,0,36,222,0,176,26,0,
		106,4,73,77,80,0,176,27,0,109,20,0,12,1,
		12,2,83,29,0,36,223,0,176,26,0,106,5,73,
		67,77,83,0,176,27,0,109,29,0,12,1,12,2,
		83,29,0,36,224,0,176,26,0,106,4,86,66,67,
		0,176,27,0,109,29,0,12,1,12,2,83,61,0,
		36,225,0,176,26,0,106,6,86,73,67,77,83,0,
		176,27,0,109,29,0,12,1,12,2,83,62,0,36,
		226,0,176,26,0,106,4,67,83,84,0,176,27,0,
		109,29,0,12,1,12,2,83,63,0,36,227,0,176,
		51,0,176,52,0,176,53,0,176,38,0,176,26,0,
		106,6,100,104,69,109,105,0,176,27,0,109,20,0,
		12,1,9,12,3,122,92,10,12,3,106,2,45,0,
		106,1,0,12,3,12,1,12,1,83,54,0,36,228,
		0,176,53,0,109,54,0,106,2,47,0,106,1,0,
		12,3,83,54,0,36,229,0,106,1,0,98,36,0,
		122,2,36,230,0,106,5,68,49,48,48,0,98,36,
		0,92,2,2,36,231,0,106,1,0,98,36,0,92,
		3,2,36,232,0,106,2,49,0,98,36,0,92,4,
		2,36,233,0,109,40,0,98,36,0,92,5,2,36,
		234,0,109,47,0,98,36,0,92,6,2,36,235,0,
		106,1,0,98,36,0,92,7,2,36,236,0,109,46,
		0,98,36,0,92,8,2,36,237,0,106,1,0,98,
		36,0,92,9,2,36,238,0,109,45,0,98,36,0,
		92,10,2,36,239,0,109,39,0,98,36,0,92,11,
		2,36,240,0,109,54,0,98,36,0,92,12,2,36,
		241,0,106,1,0,98,36,0,92,13,2,36,242,0,
		176,26,0,106,6,116,112,67,84,101,0,176,27,0,
		109,20,0,12,1,12,2,98,36,0,92,14,2,36,
		243,0,176,26,0,106,7,114,101,102,67,84,69,0,
		176,27,0,109,20,0,12,1,12,2,98,36,0,92,
		15,2,36,244,0,109,60,0,98,36,0,92,16,2,
		36,245,0,106,1,0,98,36,0,92,17,2,36,246,
		0,106,1,0,98,36,0,92,18,2,36,247,0,106,
		1,0,98,36,0,92,19,2,36,248,0,109,61,0,
		98,36,0,92,20,2,36,249,0,109,62,0,98,36,
		0,92,21,2,36,250,0,106,1,0,98,36,0,92,
		22,2,36,251,0,106,1,0,98,36,0,92,23,2,
		36,252,0,106,1,0,98,36,0,92,24,2,36,253,
		0,176,37,0,109,36,0,109,8,0,20,2,36,254,
		0,176,37,0,109,36,0,109,10,0,20,2,36,204,
		0,109,14,0,23,21,83,14,0,109,12,0,15,29,
		59,252,36,3,1,176,64,0,109,8,0,20,1,36,
		4,1,176,64,0,109,10,0,20,1,36,5,1,176,
		17,0,106,14,99,111,110,99,108,117,105,100,111,32,
		46,46,46,0,20,1,7
	};

	hb_vmExecute( pcode, symbols );
}
