#include "kernels.cuh"

__global__  void fem_generic_convec(int nNode, int* connec)
{
    int iElem = blockIdx.x;  // Element index
    int idx_x = threadIdx.x;
    int idx_y = threadIdx.y;

    // Local memory for fe_bi
    __shared__ float fl_x[128]; // Assumes block with 128 threads
    __shared__ float fl_y[128]; // Assumes block with 128 threads
    __shared__ float fl_z[128]; // Assumes block with 128 threads
    
    // Local residual as shared memory
    __shared__ float Rl[128]; // Assumes block with 128 threads

    // Local ellement nodes
    __shared__ int iPoin[128];

    // Compute number of runs as floor(nNode/128+1)+1
    int nRuns = (nNode/128+1)+1;

    for(int iRun = 0; iRun < nRuns; iRun++)
    {
        int tmp = iRun*128 + idx_x;
        // Load global node indexes into shared memory
        if(tmp < nNode)
        {
            iPoin[idx_x] = 0;
            iPoin[idx_x] = connec[iElem*nNode + tmp];
        }
    }
}

__global__  void sem_generic_convec(int nNode, int* connec)
{
}

__global__  void fem_generic_diffu(int nNode, int* connec)
{
}

__global__  void sem_generic_diffu(int nNode, int* connec)
{
}