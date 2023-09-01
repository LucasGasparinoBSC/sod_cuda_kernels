#ifndef __KERNELS_CUH__
#define __KERNELS_CUH__

#include <cuda.h>
#include <cuda_runtime.h>

__global__ void fem_generic_convec(int nNode, int* connec);
__global__ void sem_generic_convec(int nNode, int* connec);
__global__ void fem_generic_diffu(int nNode, int* connec);
__global__ void sem_generic_diffu(int nNode, int* connec);

#endif // __KERNELS_CUH__