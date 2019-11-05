#include<stdio.h>
#include<cuda.h>
# define s 1000

__global__ void min(int *a,int *c)
{
int id=threadIdx.x;
   *c=a[0];
  if(a[id]<*c)
    {
      *c=a[id];
    }
}

__global__ void max(int *a,int *d)
{
int id=threadIdx.x;
   *d=a[0];
  if(a[id]>*d)
    {
      *d=a[id];
    }
}

int main()
{
int i,a[s],c,d;
int *dev_a,*dev_c,*dev_d;
cudaMalloc((void **) &dev_a, s*sizeof(int));			
cudaMalloc((void **) &dev_c, s*sizeof(int));
cudaMalloc((void **) &dev_d, s*sizeof(int));

for(i=0;i<s;i++)
{
a[i]=rand()%1000+1;

}
cudaMemcpy(dev_a,a,s*sizeof(int),cudaMemcpyHostToDevice);
 
min<<<1,s>>>(dev_a,dev_c);
max<<<1,s>>>(dev_a,dev_d);

cudaMemcpy(&c, dev_c, s*sizeof(int),cudaMemcpyDeviceToHost);
cudaMemcpy(&d, dev_d, s*sizeof(int),cudaMemcpyDeviceToHost);

printf("min=%d",c);
printf("max=%d",d);
cudaFree(dev_a);
cudaFree(dev_c);
cudaFree(dev_d);
printf(" ");

return 0;
}

/*
OUTPUT
cpllab00@cpllab:~$ nvcc minmax.cu
cpllab00@cpllab:~$ ./a.out
min=251 max=578 */
