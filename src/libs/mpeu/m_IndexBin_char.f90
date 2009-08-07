!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!BOP -------------------------------------------------------------------
!
! !MODULE: m_IndexBin_char - Template of indexed bin-sorting module
!
! !DESCRIPTION:
!
! !INTERFACE:

    module m_IndexBin_char
      implicit none
      private	! except

      public :: IndexBin
      interface IndexBin; module procedure 	&
	IndexBin0_,	&
	IndexBin1_,	&
	IndexBin1w_
      end interface

! !REVISION HISTORY:
! 	17Feb99 - Jing Guo <guo@thunder> - initial prototype/prolog/code
!EOP ___________________________________________________________________

  character(len=*),parameter :: myname='m_IndexBin_char'

contains
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!BOP -------------------------------------------------------------------
!
! !IROUTINE: IndexBin0_ - Indexed sorting for a single value
!
! !DESCRIPTION:
!
! !INTERFACE:

    subroutine IndexBin0_(n,indx,keys,key0,ln0)
      use m_stdio, only : stderr
      use m_die,   only : die
      use m_mall,  only : mall_ison,mall_mci,mall_mco
      implicit none

      integer, intent(in) :: n
      integer, dimension(n), intent(inout) :: indx
      character(len=*), dimension(n), intent(in) :: keys
      character(len=*), intent(in) :: key0 ! value
      integer,optional,intent(out) :: ln0

! !REVISION HISTORY:
! 	16Feb99 - Jing Guo <guo@thunder> - initial prototype/prolog/code
!	27Sep99 - Jing Guo <guo@thunder> - Fixed a bug pointed out by
!					   Chris Redder
!EOP ___________________________________________________________________

  character(len=*),parameter :: myname_=myname//'::IndexBin0_'
  integer,allocatable,dimension(:) :: inew
  integer :: ni,ix,i,ier
  integer :: ln(0:1),lc(0:1)
!________________________________________

	allocate(inew(n),stat=ier)
		if(ier /= 0) then
		  write(stderr,'(2a,i4)') myname_,	&
			': allocate() error, stat =',ier
		  call die(myname_)
		endif
		if(mall_ison()) call mall_mci(inew,myname)
!________________________________________
		! Count numbers entries for the given key0
	
  lc(0)=1	! the location of values the same as key0
  ln(0)=0
  do i=1,n
    if(keys(i) == key0) ln(0)=ln(0)+1
  end do

  lc(1)=ln(0)+1	! the location of values not the same as key0
!________________________________________
		! Reset the counters
  ln(0:1)=0
  do i=1,n
    ix=indx(i)
    if(keys(ix) == key0) then
      ni=lc(0)+ln(0)
      ln(0)=ln(0)+1
      
    else
      ni=lc(1)+ln(1)
      ln(1)=ln(1)+1
    endif

    inew(ni)=ix
  end do

!________________________________________
		! Sort out the old pointers according to the new order
  indx(:)=inew(:)
  if(present(ln0)) ln0=ln(0)
!________________________________________

	  	if(mall_ison()) call mall_mco(inew,myname)
	  deallocate(inew)

end subroutine IndexBin0_

!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!BOP -------------------------------------------------------------------
!
! !IROUTINE: IndexBin1_ - Indexed sorting into a set of given bins
!
! !DESCRIPTION:
!
! !INTERFACE:

    subroutine IndexBin1_(n,indx,keys,bins,lcs,lns)
      use m_stdio, only : stderr
      use m_die,   only : die
      use m_mall,  only : mall_ison,mall_mci,mall_mco
      implicit none

      integer, intent(in) :: n
      integer, dimension(n),intent(inout) :: indx
      character(len=*),dimension(n),intent(in) :: keys
      character(len=*),dimension(:),intent(in) :: bins ! values
      integer, dimension(:),intent(out)   :: lcs ! locs. of the bins
      integer, dimension(:),intent(out)   :: lns ! sizes of the bins

! !REVISION HISTORY:
! 	16Feb99 - Jing Guo <guo@thunder> - initial prototype/prolog/code
!EOP ___________________________________________________________________

  character(len=*),parameter :: myname_=myname//'::IndexBin1_'
  integer,allocatable,dimension(:) :: ibin,inew
  integer :: nbin,lc0,ln0
  integer :: ni,ix,ib,i,ier
!________________________________________

  nbin=size(bins)
  if(nbin==0) return
!________________________________________

	allocate(ibin(n),inew(n),stat=ier)
		if(ier /= 0) then
		  write(stderr,'(2a,i4)') myname_,	&
			': allocate() error, stat =',ier
		  call die(myname_)
		endif
		if(mall_ison()) then
		  call mall_mci(ibin,myname)
		  call mall_mci(inew,myname)
		endif
!________________________________________

  do ib=1,nbin
    lns(ib)=0
    lcs(ib)=0
  end do
!________________________________________
		! Count numbers in every bin, and store the bin-ID for
		! later use.
  do i=1,n
    ix=indx(i)

    call search_(keys(ix),nbin,bins,ib)	! ib = 1:nbin; =0 if not found

    ibin(i)=ib
    if(ib /= 0) lns(ib)=lns(ib)+1
  end do
!________________________________________
		! Count the locations of every bin.
  lc0=1
  do ib=1,nbin
    lcs(ib)=lc0
    lc0=lc0+lns(ib)
  end do
!________________________________________
		! Reset the counters
  ln0=0
  lns(1:nbin)=0
  do i=1,n
    ib=ibin(i)	! the bin-index of keys(indx(i))
    if(ib/=0) then
      ni=lcs(ib)+lns(ib)
      lns(ib)=lns(ib)+1
    else
      ni=lc0+ln0
      ln0=ln0+1
    endif
    inew(ni)=indx(i)	! the current value is put in the new order
  end do
!________________________________________
		! Sort out the old pointers according to the new order
  indx(:)=inew(:)
!________________________________________

		if(mall_ison()) then
		  call mall_mco(ibin,myname)
		  call mall_mco(inew,myname)
		endif
	  deallocate(ibin,inew)

contains
subroutine search_(key,nbin,bins,ib)
  implicit none
  character(len=*), intent(in) :: key
  integer,intent(in) :: nbin
  character(len=*), intent(in),dimension(:) :: bins
  integer,intent(out) :: ib
  integer :: i

  ib=0
  do i=1,nbin
    if(key==bins(i)) then
      ib=i
      return
    endif
  end do
end subroutine search_

end subroutine IndexBin1_
!~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
!       NASA/GSFC, Data Assimilation Office, Code 910.3, GEOS/DAS      !
!BOP -------------------------------------------------------------------
!
! !IROUTINE: IndexBin1w_ - IndexBin1_ wrapped without working arrays
!
! !DESCRIPTION:
!
! !INTERFACE:

    subroutine IndexBin1w_(n,indx,keys,bins)
      use m_stdio, only : stderr
      use m_die,   only : die
      use m_mall,  only : mall_ison,mall_mci,mall_mco
      implicit none

      integer,             intent(in)    :: n
      integer,dimension(n),intent(inout) :: indx
      character(len=*),dimension(n),intent(in)    :: keys
      character(len=*),dimension(:),intent(in)    :: bins ! values

! !REVISION HISTORY:
! 	17Feb99 - Jing Guo <guo@thunder> - initial prototype/prolog/code
!EOP ___________________________________________________________________

  character(len=*),parameter :: myname_=myname//'::IndexBin1w_'
  integer :: ier
  integer,dimension(:),allocatable :: lcs,lns
  integer :: nbin

  nbin=size(bins)
  if(nbin==0) return

  allocate(lcs(nbin),lns(nbin),stat=ier)
  if(ier /= 0) then
    write(stderr,'(2a,i4)') myname_,': allocate() error, stat =',ier
    call die(myname_)
  endif
  if(mall_ison()) then
    call mall_mci(lcs,myname)
    call mall_mci(lns,myname)
  endif

  call IndexBin1_(n,indx,keys,bins,lcs,lns)

  if(mall_ison()) then
    call mall_mco(lcs,myname)
    call mall_mco(lns,myname)
  endif
  deallocate(lcs,lns)
end subroutine IndexBin1w_
end module m_IndexBin_char
