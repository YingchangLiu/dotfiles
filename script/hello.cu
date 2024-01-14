#include <iostream>
#include <math.h>
#include <cuda_runtime.h>
using namespace std;
int main() {
    int count = 0;
 	cudaGetDeviceCount(&count);
	cout <<"当前计算机包含GPU数为"<< count << endl;
    cudaError_t err = cudaGetDeviceCount(&count);
    if (err != cudaSuccess) 
	    printf("%s\n", cudaGetErrorString(err));


    cudaDeviceProp prop;
    cudaGetDeviceProperties(&prop, 0);
    printf("Device Number: %d\n", 0);
    cout << "当前设备名字为" << prop.name << endl;
	cout << "GPU全局内存总量为" << prop.totalGlobalMem << endl;
	cout << "单个线程块中包含的线程数最多为" << prop.maxThreadsPerBlock << endl;
  
}
