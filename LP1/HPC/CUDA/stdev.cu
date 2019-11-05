#include<stdio.h>
#include<cuda.h>
__global__ void add(int *a,int *b,int *c)
{
	  int id = blockIdx.x*blockDim.x+threadIdx.x;
    if(id<5)
    	c[id] = a[id] + b[id];
}

 int main()
{
    const int arraySize = 5;
    float avg,sd;
	int d[arraySize];
 
    const int a[arraySize] = { 1, 2, 3, 4, 5 };
    const int b[arraySize] = { 10, 20, 30, 40, 50 };
    int c[arraySize] = { 0 };
int *d_a,*d_b,*d_c,*d_d,i;
int size=sizeof(int)*arraySize;
cudaMalloc((void **)&d_a,size);
cudaMalloc((void **)&d_b,size);
cudaMalloc((void **)&d_c,size);
cudaMalloc((void **)&d_d,size);
int blocksize=1024;
int threadsize=(int) ceil ((float)arraySize/blocksize);
cudaMemcpy(d_a,a,size,cudaMemcpyHostToDevice);
cudaMemcpy(d_b,b,size,cudaMemcpyHostToDevice);
add<<<blocksize,threadsize>>>(d_a,d_b,d_c);
cudaMemcpy(c,d_c,size,cudaMemcpyDeviceToHost);

for(i=0;i<arraySize;i++)
{
printf("%d\t",c[i]);
}
int sum=0;
for(i=0;i<arraySize;i++)
{
sum=sum+c[i];
}
printf("Sum=%d\n",sum);
avg=sum/arraySize;
printf("Avg=%f\n",avg);
for(int i=0;i<arraySize;i++)
{
 d[i]=c[i]-avg;
 d[i]=d[i]*d[i];
sum=sum+d[i];
}
sum=sum/arraySize;
sd=sqrt(sum);
printf("sd=%f\n",sd);
cudaFree(d_a);
cudaFree(d_b);
cudaFree(d_c);
cudaFree(d_d);
return 0;
}
/*OUTPUT
cpllab00@cpllab:~$ nvcc stdev.cu
cpllab00@cpllab:~$ ./a.out
11	22	33	44	55	Sum=165
Avg=33.000000
sd=16.583124
*/

