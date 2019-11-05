#include<omp.h>
#include<stdio.h>
#include<stdlib.h>
#include<math.h>

int main()
{
	int  i,n=100;

	
	double a[100],b[100],c[100],d[100],sd,avg,sum,sum1=0.0;
	
	for(i=0;i<n;i++)
	{
		a[i]=b[i]=i*1.0;
		printf("%d %f",i,a[i]);
		printf("%d %f\n",i,b[i]);
	}
	sum=0.0;

#pragma omp parallel for reduction(+:sum)
	for(i=0;i<n;i++)
	{
		c[i]=a[i]+b[i];
		sum=sum+c[i];
	}
	
	

	printf("sum=%f\n",sum);
	avg=sum/n;
	printf("avg=%f\n",avg);
       
	for(i=0;i<n;i++)
	{
		d[i]=c[i]-avg;
		d[i]=d[i]*d[i];
	}
        for(i=0;i<n;i++)
        {
          printf("%f\n",d[i]);
        }
        for(i=0;i<n;i++)
        {
          sum1=sum1+d[i];
        }
	sum1=sum1/n;
        sd=sqrt(sum1);
	printf("sd=%f\n",sd);
	
}

/*output:-
gcc sdop.c -fopenmp -lm

cpllab00@cpllab:~$ ./a.out
0.0000000.000000
1.0000001.000000
2.0000002.000000
3.0000003.000000
4.0000004.000000
sum=20.000000
avg=4.000000
16.000000
4.000000
0.000000
4.000000
16.000000
sd=2.828427
 
*/
