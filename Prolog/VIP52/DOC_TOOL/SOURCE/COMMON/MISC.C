/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: MISC.C
 Purpose: Usefull routines and ones to substitute
	  some of C RTL functions
	  ctype, strcpy, strncpy ...
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#include "../config.h"
#include "../docstr.h"
#include "y_pdcdef.h"

#ifndef __PROLOG__
  #include <ctype.h>
#else
  #define toupper(_c) ( (islower(_c)) ? _toupper(_c) : (_c) )
  #define tolower(_c) ( (isupper(_c)) ? _tolower(_c) : (_c) )
  #define _tolower(_c)    ( (_c)-'A'+'a' )
  #define _toupper(_c)    ( (_c)-'a'+'A' )
#endif

#include "misc.h"

long YYIN_Len;

void doclib_getversion(int *major, int *minor, int *build)
{
	*major=2;
	*minor=0;
	*build=59;
}

int IO_GetC (void)
{
        unsigned Top = GETSP;
	char C;

	if ( !RUN_StackBTrack() )
        {
                C = IO_GetCh();
		RUN_Cut (Top);
		return C;
        }
	else {
		return (-1);
	}
}

char *strcpy_toupper (char *dst,char *src)
{
	char *s1 = src;
	char *s2 = dst;

	while (*s1)
	{
		*s2=toupper(*s1);
		s1++;
		s2++;
	}
	*s2='\0';
	return dst;
}

char *strcpy_tolower (char *dst,char *src)
{
	char *s1 = src;
	char *s2 = dst;

	while (*s1)
	{
		*s2=tolower(*s1);
		s1++;
		s2++;
	}
	*s2='\0';
	return dst;
}

#ifdef __PROLOG__
/*
 *  Substitutions for some of C RTF
 *  strcpy (), strncpy (), memcpy, strchr ()
 *  bsearch ()
 */

char *strcpy (char *s1,const char *s2)
{
	while (*s2) *s1++ = *s2++;
        *s1='\0';
        return s1;
}

char *strncpy (char *s1,const char *s2,unsigned int count)
{
        unsigned int i;

        for (i=0;i<count;i++)
        {
                if (s2[i]) s1[i]=s2[i];
                else break;
        }
        s1[i++]='\0';
        return s1;
}

void *memset(void *p,int B,unsigned int count)
{
	char *ptmp = p;

	while ( count-- ) *ptmp++ = B;
	return p;
}

void* memcpy (void *p1, void *p2, int sz)
{
	char *pt1 = p1;
	char *pt2 = p2;

	while (sz--) *pt1++ = *pt2++;
	return p1;
}

char * strchr (char *s,int c)
{
	while (*s)
	{
		if (*s==c) return s;
		else s++;
	}
	return 0;
}


int isspace (char C)
{
	return ((C>=0x09 && C<=0x0D) || C==0x20) ? 1 : 0;
       /*
	if ((C>=0x09 && C<=0x0D) || C==0x20) return 1;
	else return 0;
       */
}

int islower (char C)
{
	return ( C>='a' && C<='z' ) ? 1 : 0;
	//if ( C>='a' && C<='z' ) return 1; else return 0;
}

int isupper (char C)
{
	return ( C>='A' && C<='Z' ) ? 1 : 0;
	//if ( C>='A' && C<='Z' ) return 1 else return 0;
}

void *searchb (	char *key,
		const void *base,
		unsigned int num,
		unsigned int width,
		int ( *compare ) (void*,void*))
{
	int high,low,mid;

	low = 0;
	high = num-1;

	while ( low <= high )
	{
		mid = (low+high)/2;
		if ( compare(key,(char*)base+mid*width) > 0 ) low = mid+1;
		else if ( compare(key,(char*)base+mid*width) < 0 ) high = mid-1;
		else return (char*)base+mid*width;
	}
	return 0;
}



#endif


/*
 *************** Test ******************
 *
main()
{
	char s1[255];
	char s2[255];

	printf (">");
	scanf ("%s",s1);

	str_toupper (s2,s1);
	printf ("%s\n",s2);
}
******************************************/


