PROGRAM test_spline
! University of Birmingham
! Ben Palmer

USE kinds
USE sls, ONLY: sls_solve

IMPLICIT NONE

CALL main()

CONTAINS

! Subroutines


SUBROUTINE main()
!###########################################
! PRIVATE VARIABLES
INTEGER(kind=StandardInteger) :: error
INTEGER(kind=StandardInteger) :: proc_id, proc_count
INTEGER(kind=StandardInteger) :: thread_id, thread_count
INTEGER(kind=StandardInteger) :: OMP_GET_NUM_THREADS, OMP_GET_THREAD_NUM
INTEGER(kind=StandardInteger) :: n, i, j
REAL(kind=DoubleReal) :: r
REAL(kind=DoubleReal), DIMENSION(:,:), ALLOCATABLE :: A
REAL(kind=DoubleReal), DIMENSION(:), ALLOCATABLE :: x
REAL(kind=DoubleReal), DIMENSION(:), ALLOCATABLE :: y

!###########################################

n = 100

ALLOCATE(A(1:n, 1:n))
ALLOCATE(x(1:n))
ALLOCATE(y(1:n))

DO i=1,n
  DO j=1,n
    CALL RANDOM_NUMBER(r)
    A(i, j) = (0.5D0 - r) * 12.0D0 
  END DO
  CALL RANDOM_NUMBER(r)
  x(i) = (0.5D0 - r) * 12.0D0 
END DO

y = MATMUL(A, x)

print *, x(1:4)
x = 0.0D0
CALL sls_solve(A, y, x)
print *, x(1:4)

DEALLOCATE(A, x, y)
ALLOCATE(A(1:4, 1:4))
ALLOCATE(x(1:4))
ALLOCATE(y(1:4))

A(1,1) = 1.0d0
A(1,2) = -0.2d0
A(1,3) = -0.18d0
A(1,4) = -0.07d0
A(2,1) = 1.0d0
A(2,2) = 0.11d0
A(2,3) = -0.01d0
A(2,4) = -0.14d0
A(3,1) = 1.0d0
A(3,2) = -0.22d0
A(3,3) = 0.181d0
A(3,4) = 0.042d0
A(4,1) = 1.0d0
A(4,2) = -0.01d0
A(4,3) = -0.97d0
A(4,4) = 0.77d0
y(1) = 0.11d0
y(2) = 0.03d0
y(3) = -0.07d0
y(4) = 0.05d0
CALL sls_solve(A, y, x)
print *, x(1:4)

END SUBROUTINE main


END PROGRAM test_spline
