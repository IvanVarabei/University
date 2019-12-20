/*****************************************************************************

		Copyright (c) 1984 - 1999 Prolog Development Center A/S

 Project:  DOCCNV
 FileName: MISC.H
 Purpose: Usefull routines
 Written by: Oleg V. Erjomin
 Comments:
******************************************************************************/

#ifndef __MISC_H__
#define __MISC_H__

char *strcpy_toupper (char *dst,char *src);
char *strcpy_tolower (char *dst,char *src);

void doclib_getversion (int *major,int *minor, int *build);

#ifdef __IBMC__
#define UNDESCORES
#pragma map (doclib_getversion,"_doclib_getversion")
#endif


#ifdef __PROLOG__
  int C_DECL IO_GetC (void);
  char *strcpy (char *s1,const char *s2);
  char *strncpy (char *s1,const char *s2,unsigned int count);
  void *memset(void *p,int B,unsigned int count);
  void *memcpy (void *p1, void *p2, int sz);
  char *strchr (char *s,int c);
  int isspace (char C);
  int islower (char C);
  int isupper (char C);
  void *searchb(char *key,
		const void *base,
		unsigned int num,
		unsigned int width,
		int (*compare) (void *, void *));

#endif

#endif



