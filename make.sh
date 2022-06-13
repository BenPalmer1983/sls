mpif90 -g \
-fopenmp \
-fbounds-check \
-mtune=native \
src/kinds/kinds.f90 \
src/sls/sls.f90 \
src/main/main.f90 \
-J mod \
-o sls.x \
&& export OMP_NUM_THREADS=4 \
&& mpirun -n 1 sls.x
