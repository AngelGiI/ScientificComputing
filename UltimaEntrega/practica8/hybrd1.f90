!*****************************************************************************80
!
!! HYBRD1 seeks a zero of N nonlinear equations in N variables.
!
!  Discussion:
!
!    HYBRD1 finds a zero of a system of N nonlinear functions in N variables 
!    by a modification of the Powell hybrid method.  This is done by using the
!    more general nonlinear equation solver HYBRD.  The user must provide a 
!    subroutine which calculates the functions.  The jacobian is then 
!    calculated by a forward-difference approximation.
!
!  Reference:
!
!    Jorge More, Burton Garbow and Kenneth Hillstrom,
!    User Guide for MINPACK-1
!    Argonne National Laboratory,
!    Argonne, Illinois.
!
!  Parameters:
!
!    Input, external FCN, the name of the user-supplied subroutine which
!    calculates the functions.  The routine should have the form:
!
!      subroutine fcn ( n, x, fvec, iflag )
!      integer n
!      real fvec(n)
!      integer iflag
!      real x(n)
!
!    The value of IFLAG should not be changed by FCN unless
!    the user wants to terminate execution of the routine.
!    In this case set IFLAG to a negative integer.
!
!    Input, integer N, the number of functions and variables.
!
!    Input/output, real ( kind=kind(0d0) ) X(N).  On input, X must contain an initial 
!    estimate of the solution vector.  On output X contains the final 
!    estimate of the solution vector.
!
!    Output, real ( kind=kind(0d0) ) FVEC(N), the functions evaluated at the output X.
!
!    Input, real ( kind=kind(0d0) ) TOL.  Termination occurs when the algorithm
!    estimates that the relative error between X and the solution is at 
!    most TOL.  TOL should be nonnegative.
!
!    Output, integer INFO, error flag.  If the user has terminated execution, 
!    INFO is set to the (negative) value of IFLAG. See the description of FCN. 
!    Otherwise, INFO is set as follows:
!    0, improper input parameters.
!    1, algorithm estimates that the relative error between X and the 
!       solution is at most TOL.
!    2, number of calls to FCN has reached or exceeded 200*(N+1).
!    3, TOL is too small.  No further improvement in the approximate 
!       solution X is possible.
!    4, the iteration is not making good progress.
!
  implicit none

  integer lwa
  integer n

  real ( kind=kind(0d0) ) diag(n)
  real ( kind=kind(0d0) ) epsfcn
  real ( kind=kind(0d0) ) factor
  external fcn
  real ( kind=kind(0d0) ) fjac(n,n)
  real ( kind=kind(0d0) ) fvec(n)
  integer info
  integer j
  integer ldfjac
  integer lr
  integer maxfev
  integer ml
  integer mode
  integer mu
  integer nfev
  integer nprint
  real ( kind=kind(0d0) ) qtf(n)
  real ( kind=kind(0d0) ) r((n*(n+1))/2)
  real ( kind=kind(0d0) ) tol
  real ( kind=kind(0d0) ) x(n)
  real ( kind=kind(0d0) ) xtol

  info = 0

  if ( n <= 0 ) then
    return
  else if ( tol < 0.0D+00 ) then
    return
  end if

  maxfev = 200 * ( n + 1 )
  xtol = tol
  ml = n - 1
  mu = n - 1
  epsfcn = 0.0D+00
  mode = 2
  diag(1:n) = 1.0D+00
  nprint = 0
  lr = ( n * ( n + 1 ) ) / 2
  factor = 100.0D+00
  ldfjac = n

  call hybrd ( fcn, n, x, fvec, xtol, maxfev, ml, mu, epsfcn, diag, mode, &
    factor, nprint, info, nfev, fjac, ldfjac, r, lr, qtf )

  if ( info == 5 ) then
    info = 4
  end if

  return
end