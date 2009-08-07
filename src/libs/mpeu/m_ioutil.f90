!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!-----------------------------------------------------------------------
!BOP
!
! !MODULE: m_ioutil - a F90 module for several convenient I/O functions
!
! !DESCRIPTION:
!
!	m\_ioutil is a module containing several portable interfaces for
!	some highly system dependent, but frequently used I/O functions.
!
! !INTERFACE:

	module m_ioutil
	implicit none
	private	! except

	public	:: opntext,clstext ! open/close a text file
	public	:: opnieee,clsieee ! open/close a binary sequential file
	public	:: luavail	   ! return a free logical unit
	public	:: luflush	   ! flush the buffer of a given unit
	!public	:: MX_LU

! !REVISION HISTORY:
! 	16Jul96 - J. Guo	- (to do)
! 	02Apr97 - Jing Guo <guo@eramus> - finished the coding
!	11Feb97 - Jing Guo <guo@thunder> - added luflush()
!EOP
!_______________________________________________________________________

	character(len=*),parameter :: myname="m_ioutil"
	integer,parameter :: MX_LU=255

contains

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!-----------------------------------------------------------------------
!BOP
!
! !IROUTINE: opnieee - portablly open an IEEE format file
!
! !DESCRIPTION:
!
!	Open a file in `IEEE' format.
!
!	`IEEE' format is refered as a FORTRAN "unformatted" file with
!	"sequantial" access and variable record lengths.  Under common
!	Unix, it is only a file with records packed with a leading 4-
!	byte word and a trailing 4-byte word indicating the size of
!	the record in bytes.  However, under UNICOS, it is also assumed
!	to have numerical data representations represented according to
!	the IEEE standard corresponding KIND conversions.  Under a DEC
!	machine, it means that compilations of the source code should
!	have the "-bigendian" option specified.
!
! !INTERFACE:

    subroutine opnieee(lu,fname,status,ier,recl)
      use m_stdio,only : stderr
      implicit none

      integer,         intent(in) :: lu     ! logical unit number
      character(len=*),intent(in) :: fname  ! filename to be opended
      character(len=*),intent(in) :: status ! the value for STATUS=
      integer,         intent(out):: ier    ! the status
      integer,optional,intent(in) :: recl   ! record length

! !REVISION HISTORY:
!	02Feb95 - Jing G. - First version included in PSAS.  It is not
!		used in the libpsas.a calls, since no binary data input/
!		output is to be handled.
!
! 	09Oct96 - J. Guo  - Check for any previous assign() call under
!		UNICOS.
!EOP
!_______________________________________________________________________

		! local parameter
	character(len=*),parameter :: myname_=myname//'::opnieee'

	integer,parameter :: iA=ichar('a')
	integer,parameter :: mA=ichar('A')
	integer,parameter :: iZ=ichar('z')

	logical :: direct
	character(len=16) :: clen
	character(len=len(status)) :: Ustat
	integer :: i,ic

	direct=.false.
	if(present(recl)) then
	  if(recl<0) then
	    clen='****************'
	    write(clen,'(i16)',iostat=ier) recl
	    write(stderr,'(3a)') myname_,	&
		': invalid recl, ',trim(adjustl(clen))
	    ier=-1
	    return
	  endif
	  direct = recl>0
	endif


	do i=1,len(status)
	  ic=ichar(status(i:i))
	  if(ic >= iA .and. ic <= iZ) ic=ic+(mA-iA)
	  Ustat(i:i)=char(ic)
	end do

	select case(Ustat)

	case ('APPEND')

	  if(direct) then
	    write(stderr,'(2a)') myname_,		&
		': invalid arguments, (status=="APPEND",recl>0)'
	    ier=1
	    return
	  endif

	  open(				&
	    unit	=lu,		&
	    file	=fname,		&
	    form	='unformatted',	&
	    access	='sequential',	&
	    status	='unknown',	&
	    position	='append',	&
	    iostat	=ier		)

	case default

	  if(direct) then
	    open(			&
	      unit	=lu,		&
	      file	=fname,		&
	      form	='unformatted',	&
	      access	='direct',	&
	      status	=status,	&
	      recl	=recl,		&
	      iostat	=ier		)

	  else
	    open(			&
	      unit	=lu,		&
	      file	=fname,		&
	      form	='unformatted',	&
	      access	='sequential',	&
	      status	=status,	&
	      position	='asis',	&
	      iostat	=ier		)
	  endif

	end select

	end subroutine opnieee
!-----------------------------------------------------------------------
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!-----------------------------------------------------------------------
!BOP
!
! !IROUTINE: clsieee - Close a logical unit opened by opnieee()
!
! !DESCRIPTION:
!
!	The reason for a paired clsieee() for opnieee() instead of a
!	simple close(), is for the portability reason.  For example,
!	under UNICOS, special system calls may be need to set up the
!	unit right, and the status of the unit should be restored upon
!	close.
!
! !INTERFACE:

	subroutine clsieee(lu,ier,status)
	  implicit none
	  integer,                    intent(in)  :: lu	   ! the unit used by opnieee()
	  integer,                    intent(out) :: ier	   ! the status
          Character(len=*), optional, intent(In)  :: status ! keep/delete

! !REVISION HISTORY:
! 	10Oct96 - J. Guo	- (to do)
!EOP
!_______________________________________________________________________
          character(len=*), parameter :: myname_ = myname//'::clsieee'
          Character(Len=6) :: status_

          status_ = 'KEEP'
          If (Present(status)) Then
             Select Case (Trim(status))
             Case ('DELETE','delete')
                status_ = 'DELETE'
             Case  ('KEEP','keep')
                status_ = 'KEEP'
             Case Default
                ier = -997
                return
             End Select
          End If
                
	  close(lu,iostat=ier,status=status_)

	end subroutine clsieee

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!-----------------------------------------------------------------------
!BOP
!
! !IROUTINE: opntext - portablly open a text file
!
! !DESCRIPTION:
!
!	Open a text (ASCII) file.  Under FORTRAN, it is defined as
!	"formatted" with "sequential" access.
!
! !INTERFACE:

    subroutine opntext(lu,fname,status,ier)
      implicit none

      integer,         intent(in) :: lu     ! logical unit number
      character(len=*),intent(in) :: fname  ! filename to be opended
      character(len=*),intent(in) :: status ! the value for STATUS=<>
      integer,         intent(out):: ier    ! the status


! !REVISION HISTORY:
!
!	02Feb95 - Jing G. - First version included in PSAS and libpsas.a
! 	09Oct96 - J. Guo  - modified to allow assign() call under UNICOS
!			  = and now, it is a module in Fortran 90.
!EOP
!_______________________________________________________________________

		! local parameter
	character(len=*),parameter :: myname_=myname//'::opntext'

	integer,parameter :: iA=ichar('a')
	integer,parameter :: mA=ichar('A')
	integer,parameter :: iZ=ichar('z')

	character(len=len(status)) :: Ustat
	integer :: i,ic


	do i=1,len(status)
	  ic=ichar(status(i:i))
	  if(ic >= iA .and. ic <= iZ) ic=ic+(mA-iA)
	  Ustat(i:i)=char(ic)
	end do

	select case(Ustat)

	case ('APPEND')

	  open(				&
	    unit	=lu,		&
	    file	=fname,		&
	    form	='formatted',	&
	    access	='sequential',	&
	    status	='unknown',	&
	    position	='append',	&
	    iostat	=ier		)

	case default

	  open(				&
	    unit	=lu,		&
	    file	=fname,		&
	    form	='formatted',	&
	    access	='sequential',	&
	    status	=status,	&
	    position	='asis',	&
	    iostat	=ier		)

	end select

	end subroutine opntext

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!-----------------------------------------------------------------------
!BOP
!
! !IROUTINE: clstext - close a text file opend with an opntext() call
!
! !DESCRIPTION:
!
! !INTERFACE:

    subroutine clstext(lu,ier,status)
      implicit none

      integer,                    intent(in)  :: lu     ! a logical unit to close
      integer,                    intent(out) :: ier    ! the status
      Character(len=*), optional, intent(In)  :: status ! keep/delete

! !REVISION HISTORY:
! 	09Oct96 - J. Guo	- (to do)
!EOP
!_______________________________________________________________________
          character(len=*), parameter :: myname_ = myname//'::clsitext'
          Character(Len=6) :: status_

          status_ = 'KEEP'
          If (Present(status)) Then
             Select Case (Trim(status))
             Case ('DELETE','delete')
                status_ = 'DELETE'
             Case  ('KEEP','keep')
                status_ = 'KEEP'
             Case Default
                ier = -997
                return
             End Select
          End If

	close(lu,iostat=ier,status=status_)

	end subroutine clstext

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!BOP -------------------------------------------------------------------
!
! !IROUTINE: luavail - locate the next available unit
!
! !DESCRIPTION:
!
!    luavail() Look for an available (not opened and not statically
!    assigned to any I/O attributes to) logical unit.
!
! !INTERFACE:

	function luavail()
	  use m_stdio
	  implicit none
	  integer :: luavail	! result

! !REVISION HISTORY:
! 	23Apr98 - Jing Guo <guo@thunder> - new prototype/prolog/code
!			- with additional unit constraints for SunOS.
!
! 	: Jing Guo, [09-Oct-96]
! 		+ Checking also Cray assign() attributes, with some
! 		  changes to the code.  See also other routines.
!
! 	: Jing Guo, [01-Apr-94]
! 		+ Initial code.
!EOP ___________________________________________________________________

  character(len=*),parameter :: myname_=myname//'::luavail'

	integer lu,ios
	logical inuse
	character*8 attr

	lu=-1
	ios=0
	inuse=.true.

	do while(ios.eq.0.and.inuse)
	  lu=lu+1

		! Test #1, reserved

	  inuse = lu.eq.stdout .or. lu.eq.stdin .or. lu.eq.stderr


		! Test #2, in-use

	  if(.not.inuse) inquire(unit=lu,opened=inuse,iostat=ios)


	  if(lu >= MX_LU) ios=-1
	end do

	if(ios.ne.0) lu=-1
	luavail=lu
end function luavail

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!-----------------------------------------------------------------------
!BOP
!
! !IROUTINE: luflush - a uniform interface of system flush()
!
! !DESCRIPTION:
!
!	Flush() calls available on many systems are often implementation
!	dependent.  This subroutine provides a uniform interface.  It
!	also ignores invalid logical unit value.
!
! !INTERFACE:

    subroutine luflush(unit)
      use m_stdio, only : stdout
      implicit none
      integer,optional,intent(in) :: unit

! !REVISION HISTORY:
! 	13Mar98 - Jing Guo <guo@thunder> - initial prototype/prolog/code
!EOP
!_______________________________________________________________________
  character(len=*),parameter :: myname_=myname//'::luflush'

  integer :: ier
  integer :: lu

	! Which logical unit number?

  lu=stdout
  if(present(unit)) lu=unit
  if(lu < 0) return

	! The following call may be system dependent.

  call flush(lu)

end subroutine luflush
!-----------------------------------------------------------------------
end module m_ioutil
!.
