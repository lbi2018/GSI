!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!-----------------------------------------------------------------------
!BOP
!
! !MODULE: m_mpif - a portable interface to the MPI "mpif.h" COMMONs.
!
! !DESCRIPTION:
!
!   The purpose of \verb"m_mpif" module is to provide a portable
!   interface of \verb"mpif.h" with different MPI implementation.
!   By combining module \verb"m_mpif" and \verb"m_mpif90", it may be
!   possible to build a Fortran 90 MPI binding module graduately.
!
!   Although it is possible to use \verb'include "mpif.h"' directly
!   in individual modules, it has several problems:
!   \begin{itemize}
!   \item It may conflict with either the source code of a {\sl fixed}
!	format or the code of a {\sl free} format;
!   \item It does not provide the protection and the safety of using
!	these variables as what a \verb"MODULE" would provide.
!   \end{itemize}
!
!   More information may be found in the module \verb"m_mpif90".
!
! !INTERFACE:

	module m_mpif
	  implicit none
	  private	! except

	  public :: MPI_INTEGER
	  public :: MPI_REAL
	  public :: MPI_DOUBLE_PRECISION
	  public :: MPI_LOGICAL
	  public :: MPI_CHARACTER

	  public :: MPI_2INTEGER
	  public :: MPI_2REAL
	  public :: MPI_2DOUBLE_PRECISION

	  public :: MPI_REAL4
	  public :: MPI_REAL8
  	  public :: MPI_REAL16

  	  public :: MPI_INTEGER2
  	  public :: MPI_INTEGER4
  	  public :: MPI_INTEGER8

	  public :: MPI_COMM_WORLD
	  public :: MPI_COMM_NULL

	  public :: MPI_SUM
	  public :: MPI_PROD
	  public :: MPI_MIN
  	  public :: MPI_MAX
	  public :: MPI_MINLOC
  	  public :: MPI_MAXLOC

	  public :: MPI_MAX_ERROR_STRING
	  public :: MPI_STATUS_SIZE
	  public :: MPI_ERROR

  	  public :: MPI_OFFSET_KIND
  	  public :: MPI_INFO_NULL
  	  public :: MPI_MODE_RDWR
  	  public :: MPI_BYTE
  	  public :: MPI_SEEK_SET
  	  public :: MPI_MODE_RDONLY


! IBM_PROLOG_BEGIN_TAG 
! This is an automatically generated prolog. 
!  
!  
!  
! Licensed Materials - Property of IBM 
!  
! (C) COPYRIGHT International Business Machines Corp. 1994,2007 
! All Rights Reserved 
!  
! US Government Users Restricted Rights - Use, duplication or 
! disclosure restricted by GSA ADP Schedule Contract with IBM Corp. 
!  
! IBM_PROLOG_END_TAG 
!  ***************************************************************************
!  @(#) 1.22 src/ppe/poe/include/thread/mpif.h, ppe.poe.mpi, ppe_rcha, rcha0810a 08/03/12 15:21:34
!
!  Name: thread/mpif.h
!
!  Description:
!
!  ***************************************************************************
!
!
!     NOTE:  This file contains information necessary for compiling
!            Fortran applications to be used with the threads based
!            MPI library.
!            (The threads based MPI library does not support MPL and
!             does contain an initial subset of MPI-2.)
!  *************************************************************************

      integer*4 MPI_VERSION,MPI_SUBVERSION
      parameter (MPI_VERSION=1,MPI_SUBVERSION=2)

      integer*4 MPI_SUCCESS,MPI_ERR_BUFFER,MPI_ERR_COUNT,MPI_ERR_TYPE
      integer*4 MPI_ERR_TAG,MPI_ERR_COMM,MPI_ERR_RANK,MPI_ERR_REQUEST
      integer*4 MPI_ERR_ROOT,MPI_ERR_GROUP,MPI_ERR_OP,MPI_ERR_TOPOLOGY
      integer*4 MPI_ERR_DIMS,MPI_ERR_ARG,MPI_ERR_UNKNOWN
      integer*4 MPI_ERR_TRUNCATE
      integer*4 MPI_ERR_OTHER,MPI_ERR_INTERN,MPI_ERR_IN_STATUS
      integer*4 MPI_PENDING,MPI_ERR_PENDING,MPI_ERR_INFO_KEY
      integer*4 MPI_ERR_INFO_VALUE,MPI_ERR_INFO_NOKEY,MPI_ERR_INFO
      integer*4 MPI_ERR_FILE,MPI_ERR_NOT_SAME,MPI_ERR_AMODE
      integer*4 MPI_ERR_UNSUPPORTED_DATAREP
      integer*4 MPI_ERR_UNSUPPORTED_OPERATION
      integer*4 MPI_ERR_NO_SUCH_FILE,MPI_ERR_FILE_EXISTS
      integer*4 MPI_ERR_BAD_FILE
      integer*4 MPI_ERR_ACCESS,MPI_ERR_NO_SPACE,MPI_ERR_QUOTA
      integer*4 MPI_ERR_READ_ONLY,MPI_ERR_FILE_IN_USE
      integer*4 MPI_ERR_DUP_DATAREP
      integer*4 MPI_ERR_CONVERSION,MPI_ERR_IO
      integer*4 MPI_ERR_WIN,MPI_ERR_BASE,MPI_ERR_SIZE,MPI_ERR_DISP
      integer*4 MPI_ERR_LOCKTYPE,MPI_ERR_ASSERT,MPI_ERR_RMA_CONFLICT
      integer*4 MPI_ERR_RMA_SYNC,MPI_ERR_NO_MEM
      integer*4 MPI_ERR_KEYVAL
      integer*4 MPI_ERR_LASTCODE
      parameter (MPI_SUCCESS=0,MPI_ERR_BUFFER=50,MPI_ERR_COUNT=51)
      parameter (MPI_ERR_TYPE=52,MPI_ERR_TAG=53,MPI_ERR_COMM=54)
      parameter (MPI_ERR_RANK=55,MPI_ERR_REQUEST=56,MPI_ERR_ROOT=57)
      parameter (MPI_ERR_GROUP=58,MPI_ERR_OP=59,MPI_ERR_TOPOLOGY=60)
      parameter (MPI_ERR_DIMS=61,MPI_ERR_ARG=62,MPI_ERR_UNKNOWN=63)
      parameter (MPI_ERR_TRUNCATE=64,MPI_ERR_OTHER=65,MPI_ERR_INTERN=66)
      parameter (MPI_ERR_IN_STATUS=67,MPI_PENDING=68,MPI_ERR_PENDING=68)
      parameter (MPI_ERR_INFO_KEY=69,MPI_ERR_INFO_VALUE=70)
      parameter (MPI_ERR_INFO_NOKEY=71)
      parameter (MPI_ERR_INFO=72,MPI_ERR_FILE=73,MPI_ERR_NOT_SAME=74)
      parameter (MPI_ERR_AMODE=75,MPI_ERR_UNSUPPORTED_DATAREP=76)
      parameter (MPI_ERR_UNSUPPORTED_OPERATION=77)
      parameter (MPI_ERR_NO_SUCH_FILE=78)
      parameter (MPI_ERR_FILE_EXISTS=79,MPI_ERR_BAD_FILE=80)
      parameter (MPI_ERR_ACCESS=81)
      parameter (MPI_ERR_NO_SPACE=82,MPI_ERR_QUOTA=83)
      parameter (MPI_ERR_READ_ONLY=84)
      parameter (MPI_ERR_FILE_IN_USE=85,MPI_ERR_DUP_DATAREP=86)
      parameter (MPI_ERR_CONVERSION=87,MPI_ERR_IO=88)
      parameter (MPI_ERR_WIN=89,MPI_ERR_BASE=90,MPI_ERR_SIZE=91)
      parameter (MPI_ERR_DISP=92,MPI_ERR_LOCKTYPE=93,MPI_ERR_ASSERT=94)
      parameter (MPI_ERR_RMA_CONFLICT=95,MPI_ERR_RMA_SYNC=96)
      parameter (MPI_ERR_NO_MEM=97)
      parameter (MPI_ERR_KEYVAL=98)
      parameter (MPI_ERR_LASTCODE=500)
 
      integer*4 MPI_PROC_NULL,MPI_ANY_SOURCE
      integer*4 MPI_ANY_TAG,MPI_UNDEFINED,MPI_ROOT
      parameter (MPI_PROC_NULL=-3,MPI_ANY_SOURCE=-1)
      parameter (MPI_ANY_TAG=-1,MPI_UNDEFINED=-1,MPI_ROOT=-99)
 
      integer*4 MPI_STATUS_SIZE,MPI_SOURCE,MPI_TAG,MPI_ERROR
      parameter (MPI_STATUS_SIZE=8,MPI_SOURCE=1,MPI_TAG=2,MPI_ERROR=3)
 
      integer*4 MPI_ERRORS_ARE_FATAL,MPI_ERRORS_RETURN,MPE_ERRORS_WARN
      parameter (MPI_ERRORS_ARE_FATAL=0,MPI_ERRORS_RETURN=1)
      parameter (MPE_ERRORS_WARN=2)

      integer*4 MPI_THREAD_SINGLE,MPI_THREAD_FUNNELED
      integer*4 MPI_THREAD_SERIALIZED,MPI_THREAD_MULTIPLE
      parameter (MPI_THREAD_SINGLE=0,MPI_THREAD_FUNNELED=1)
      parameter (MPI_THREAD_SERIALIZED=2,MPI_THREAD_MULTIPLE=3)
 
      integer*4 MPI_MAX_PROCESSOR_NAME,MPI_MAX_ERROR_STRING
      parameter (MPI_MAX_PROCESSOR_NAME=256,MPI_MAX_ERROR_STRING=128)
 
      integer*4 MPI_MAX_FILE_NAME,MPI_MAX_DATAREP_STRING
      integer*4 MPI_MAX_INFO_KEY,MPI_MAX_INFO_VAL
      parameter (MPI_MAX_FILE_NAME=1023,MPI_MAX_DATAREP_STRING=255)
      parameter (MPI_MAX_INFO_KEY=127,MPI_MAX_INFO_VAL=1023)

      integer*4 MPI_MAX_OBJECT_NAME
      parameter (MPI_MAX_OBJECT_NAME=256)

      integer*4 MPI_BSEND_OVERHEAD
      parameter (MPI_BSEND_OVERHEAD=23)
 
      integer*4 MPI_LB,MPI_UB,MPI_BYTE,MPI_PACKED
      parameter (MPI_LB=0,MPI_UB=1,MPI_BYTE=2,MPI_PACKED=3)

      integer*4 MPI_CHAR,MPI_UNSIGNED_CHAR,MPI_SIGNED_CHAR,MPI_SHORT
      integer*4 MPI_INT,MPI_LONG,MPI_UNSIGNED_SHORT,MPI_UNSIGNED
      integer*4 MPI_UNSIGNED_LONG,MPI_FLOAT,MPI_DOUBLE,MPI_LONG_DOUBLE
      integer*4 MPI_LONG_LONG_INT,MPI_LONG_LONG,MPI_UNSIGNED_LONG_LONG
      integer*4 MPI_WCHAR
      parameter (MPI_CHAR=4,MPI_UNSIGNED_CHAR=5,MPI_SIGNED_CHAR=6)
      parameter (MPI_SHORT=7,MPI_INT=8,MPI_LONG=9)
      parameter (MPI_UNSIGNED_SHORT=10,MPI_UNSIGNED=11)
      parameter (MPI_UNSIGNED_LONG=12,MPI_FLOAT=13,MPI_DOUBLE=14)
      parameter (MPI_LONG_DOUBLE=15,MPI_LONG_LONG_INT=39)
      parameter (MPI_LONG_LONG=44,MPI_UNSIGNED_LONG_LONG=40)
      parameter (MPI_WCHAR=41)
 
      integer*4 MPI_INTEGER1,MPI_INTEGER2,MPI_INTEGER4,MPI_INTEGER
      integer*4 MPI_REAL4,MPI_REAL,MPI_REAL8,MPI_DOUBLE_PRECISION
      integer*4 MPI_REAL16,MPI_COMPLEX8,MPI_COMPLEX,MPI_COMPLEX16
      integer*4 MPI_DOUBLE_COMPLEX,MPI_COMPLEX32,MPI_LOGICAL1
      integer*4 MPI_LOGICAL2,MPI_LOGICAL4,MPI_LOGICAL,MPI_CHARACTER
      parameter (MPI_INTEGER1=16,MPI_INTEGER2=17,MPI_INTEGER4=18)
      parameter (MPI_INTEGER=45,MPI_REAL4=19,MPI_REAL=46,MPI_REAL8=20)
      parameter (MPI_DOUBLE_PRECISION=47,MPI_REAL16=21,MPI_COMPLEX8=22)
      parameter (MPI_COMPLEX=48,MPI_COMPLEX16=23,MPI_DOUBLE_COMPLEX=49)
      parameter (MPI_COMPLEX32=24,MPI_LOGICAL1=25,MPI_LOGICAL2=26)
      parameter (MPI_LOGICAL4=27,MPI_LOGICAL=50,MPI_CHARACTER=28)
 
      integer*4 MPI_2REAL,MPI_2DOUBLE_PRECISION,MPI_2INTEGER
      integer*4 MPI_2COMPLEX
      parameter (MPI_2REAL=35,MPI_2DOUBLE_PRECISION=36,MPI_2INTEGER=37)
      parameter (MPI_2COMPLEX=38)
 
      integer*4 MPI_INTEGER8,MPI_LOGICAL8
      parameter (MPI_INTEGER8=42,MPI_LOGICAL8=43)

      integer*4 MPI_COMM_WORLD,MPI_COMM_SELF
      parameter (MPI_COMM_WORLD=0,MPI_COMM_SELF=1)
 
      integer*4 MPI_IDENT,MPI_CONGRUENT,MPI_SIMILAR,MPI_UNEQUAL
      parameter (MPI_IDENT=0,MPI_CONGRUENT=1,MPI_SIMILAR=2)
      parameter (MPI_UNEQUAL=3)
 
      integer*4 MPI_TAG_UB,MPI_IO,MPI_HOST,MPI_WTIME_IS_GLOBAL
      integer*4 MPI_WIN_BASE,MPI_WIN_SIZE,MPI_WIN_DISP_UNIT
      integer*4 MPI_LASTUSEDCODE
      parameter (MPI_TAG_UB=0,MPI_IO=1,MPI_HOST=2,MPI_WTIME_IS_GLOBAL=3)
      parameter (MPI_WIN_BASE=4,MPI_WIN_SIZE=5,MPI_WIN_DISP_UNIT=6)
      parameter (MPI_LASTUSEDCODE=7)
 
      integer*4 MPI_MAX,MPI_MIN,MPI_SUM,MPI_PROD,MPI_MAXLOC,MPI_MINLOC
      integer*4 MPI_BAND,MPI_BOR,MPI_BXOR,MPI_LAND,MPI_LOR,MPI_LXOR
      integer*4 MPI_REPLACE,MAX_OP
      parameter (MPI_MAX=0,MPI_MIN=1,MPI_SUM=2,MPI_PROD=3,MPI_MAXLOC=4)
      parameter (MPI_MINLOC=5,MPI_BAND=6,MPI_BOR=7,MPI_BXOR=8)
      parameter (MPI_LAND=9,MPI_LOR=10,MPI_LXOR=11,MPI_REPLACE=12)
      parameter (MAX_OP=13)
 
      integer*4 MPI_GROUP_NULL,MPI_COMM_NULL,MPI_DATATYPE_NULL
      integer*4 MPI_REQUEST_NULL,MPI_OP_NULL,MPI_ERRHANDLER_NULL
      parameter(MPI_GROUP_NULL=-1,MPI_COMM_NULL=-1,MPI_DATATYPE_NULL=-1)
      parameter (MPI_REQUEST_NULL=-1,MPI_OP_NULL=-1)
      parameter (MPI_ERRHANDLER_NULL=-1) 

      integer*4 MPI_INFO_NULL,MPI_FILE_NULL,MPI_WIN_NULL
      parameter (MPI_INFO_NULL=-1,MPI_FILE_NULL=-1,MPI_WIN_NULL=-1)

      integer*4 MPI_GROUP_EMPTY
      parameter (MPI_GROUP_EMPTY=0)

      integer*4 MPI_ADDRESS_KIND
      parameter (MPI_ADDRESS_KIND=4)
 
      integer*4 MPI_OFFSET_KIND
      parameter (MPI_OFFSET_KIND=8)

      integer*4 MPI_NON_ATOMIC,MPI_ATOMIC
      parameter (MPI_NON_ATOMIC=0,MPI_ATOMIC=1)

      integer(KIND=MPI_OFFSET_KIND) MPI_DISPLACEMENT_CURRENT
      parameter (MPI_DISPLACEMENT_CURRENT=-1_8)

      integer*4 MPI_DISTRIBUTE_NONE,MPI_DISTRIBUTE_BLOCK
      integer*4 MPI_DISTRIBUTE_CYCLIC,MPI_DISTRIBUTE_DFLT_DARG
      parameter (MPI_DISTRIBUTE_NONE=0,MPI_DISTRIBUTE_BLOCK=1)
      parameter (MPI_DISTRIBUTE_CYCLIC=2,MPI_DISTRIBUTE_DFLT_DARG=0)

      integer*4 MPI_ORDER_C,MPI_ORDER_FORTRAN
      parameter (MPI_ORDER_C=1,MPI_ORDER_FORTRAN=2)

      integer*4 MPI_SEEK_SET,MPI_SEEK_CUR,MPI_SEEK_END
      parameter (MPI_SEEK_SET=0,MPI_SEEK_CUR=1,MPI_SEEK_END=2)

      integer*4 MPI_MODE_RDONLY,MPI_MODE_WRONLY,MPI_MODE_RDWR
      integer*4 MPI_MODE_APPEND
      integer*4 MPI_MODE_CREATE,MPI_MODE_EXCL,MPI_MODE_DELETE_ON_CLOSE
      integer*4 MPI_MODE_UNIQUE_OPEN,MPI_MODE_SEQUENTIAL
!     parameter (MPI_MODE_RDONLY=X'000001', MPI_MODE_WRONLY=X'000002')
      parameter (MPI_MODE_RDONLY=       1 , MPI_MODE_WRONLY=       2 )
!     parameter (MPI_MODE_RDWR=X'000004',MPI_MODE_CREATE=X'000008')
      parameter (MPI_MODE_RDWR=       4 ,MPI_MODE_CREATE=       8 )
!     parameter (MPI_MODE_APPEND=X'000010',MPI_MODE_EXCL=X'000020')
      parameter (MPI_MODE_APPEND=      16 ,MPI_MODE_EXCL=      32 )
!     parameter (MPI_MODE_DELETE_ON_CLOSE=X'000040')
      parameter (MPI_MODE_DELETE_ON_CLOSE=      64 )
!     parameter (MPI_MODE_UNIQUE_OPEN=X'000080')
      parameter (MPI_MODE_UNIQUE_OPEN=     128 )
!     parameter (MPI_MODE_SEQUENTIAL=X'000100')
      parameter (MPI_MODE_SEQUENTIAL=     256 )

      integer*4 MPI_LOCK_EXCLUSIVE,MPI_LOCK_SHARED
      parameter (MPI_LOCK_EXCLUSIVE=0,MPI_LOCK_SHARED=1)

      integer*4 MPI_MODE_NOCHECK,MPI_MODE_NOSTORE,MPI_MODE_NOPUT
      integer*4 MPI_MODE_NOPRECEDE,MPI_MODE_NOSUCCEED
!     parameter (MPI_MODE_NOCHECK=X'000200',MPI_MODE_NOSTORE=X'000400')
      parameter (MPI_MODE_NOCHECK=     512 ,MPI_MODE_NOSTORE=    1024 )
!     parameter (MPI_MODE_NOPUT=X'000800',MPI_MODE_NOPRECEDE=X'001000')
      parameter (MPI_MODE_NOPUT=    2048 ,MPI_MODE_NOPRECEDE=    4096 )
!     parameter (MPI_MODE_NOSUCCEED=X'002000')
      parameter (MPI_MODE_NOSUCCEED=    8192 )

      integer*4  MPI_GRAPH,MPI_CART
      parameter (MPI_GRAPH=0,MPI_CART=1)
 
      integer*4 MPI_KEYVAL_INVALID
      parameter (MPI_KEYVAL_INVALID=-1)
 
      real*8 MPI_WTICK,MPI_WTIME,PMPI_WTICK,PMPI_WTIME
      external MPI_WTICK,MPI_WTIME,PMPI_WTICK,PMPI_WTIME
 
      external MPI_CONVERSION_FN_NULL
      external MPI_NULL_COPY_FN,MPI_DUP_FN,MPI_NULL_DELETE_FN
      external MPI_COMM_NULL_COPY_FN,MPI_COMM_DUP_FN
      external MPI_COMM_NULL_DELETE_FN
      external MPI_TYPE_NULL_COPY_FN,MPI_TYPE_DUP_FN
      external MPI_TYPE_NULL_DELETE_FN
      external MPI_WIN_NULL_COPY_FN,MPI_WIN_DUP_FN
      external MPI_WIN_NULL_DELETE_FN
      external MPI_BOTTOM,MPI_IN_PLACE
      external MPI_STATUS_IGNORE,MPI_STATUSES_IGNORE

      integer*4 MPI_COMBINER_NAMED,MPI_COMBINER_DUP
      integer*4 MPI_COMBINER_CONTIGUOUS
      integer*4 MPI_COMBINER_VECTOR,MPI_COMBINER_HVECTOR_INTEGER
      integer*4 MPI_COMBINER_HVECTOR,MPI_COMBINER_INDEXED 
      integer*4 MPI_COMBINER_HINDEXED_INTEGER,MPI_COMBINER_HINDEXED
      integer*4 MPI_COMBINER_INDEXED_BLOCK,MPI_COMBINER_STRUCT_INTEGER
      integer*4 MPI_COMBINER_STRUCT,MPI_COMBINER_SUBARRAY
      integer*4 MPI_COMBINER_DARRAY
      integer*4 MPI_COMBINER_F90_REAL,MPI_COMBINER_F90_COMPLEX 
      integer*4 MPI_COMBINER_F90_INTEGER,MPI_COMBINER_RESIZED
      parameter (MPI_COMBINER_NAMED=0,MPI_COMBINER_DUP=1)
      parameter (MPI_COMBINER_CONTIGUOUS=2,MPI_COMBINER_VECTOR=3)
      parameter (MPI_COMBINER_HVECTOR_INTEGER=4,MPI_COMBINER_HVECTOR=5)
      parameter (MPI_COMBINER_INDEXED=6,MPI_COMBINER_HINDEXED_INTEGER=7)
      parameter (MPI_COMBINER_HINDEXED=8,MPI_COMBINER_INDEXED_BLOCK=9)
      parameter (MPI_COMBINER_STRUCT_INTEGER=10,MPI_COMBINER_STRUCT=11)
      parameter (MPI_COMBINER_SUBARRAY=12,MPI_COMBINER_DARRAY=13)
      parameter (MPI_COMBINER_F90_REAL=14,MPI_COMBINER_F90_COMPLEX=15)
      parameter (MPI_COMBINER_F90_INTEGER=16,MPI_COMBINER_RESIZED=17)

      integer*4 MPI_TYPECLASS_REAL,MPI_TYPECLASS_INTEGER
      integer*4 MPI_TYPECLASS_COMPLEX
      parameter(MPI_TYPECLASS_REAL=1,MPI_TYPECLASS_INTEGER=2)
      parameter(MPI_TYPECLASS_COMPLEX=3)

      integer*4 MP_BW_MPI, MP_BW_LAPI
      parameter(MP_BW_MPI=2,MP_BW_LAPI=1)

! !REVISION HISTORY:
! 	01Apr98 - Jing Guo <guo@thunder> - initial prototype/prolog/code
!EOP
!_______________________________________________________________________
	character(len=*),parameter :: myname='m_mpif'

	end module m_mpif
!.
