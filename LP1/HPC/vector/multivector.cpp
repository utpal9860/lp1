#include<stdio.h>
#include<iostream>
#include<cstdlib>
#include<omp.h>
using namespace std;
 
int main()
{
	int m=3,n=2;
	int mat[m][n],vec[n],out[m];
	 
 
	for(int row=0;row<m;row++)
	{
	 for(int col=0;col<n;col++)
            {
             mat[row][col]=1;
            }
            
            }

cout<<"Input Matrix"<<endl;
for(int row=0;row<m;row++)
{
for(int col=0;col<n;col++)
{
 cout<<"\t"<<mat[row][col];
}
 cout<<""<<endl;
}


	for(int row=0;row<m;row++)
{
vec[row]=2;
} 
cout<<"Input Col-Vector"<<endl;
for(int row=0;row<n;row++)
{
cout<<vec[row]<<endl;
}


        #pragma omp parallel  
{
        #pragma omp parallel 

for(int row=0;row<m;row++)
{
out[row]=0;
for(int col=0;col<n;col++)
{
out[row]+=mat[row][col]*vec[col];

}
}
}

cout<<"Resultant Col-Vector"<<endl;
for(int row=0;row<m;row++)
{

cout<<"\nvec["<<row<<"]:"<<out[row]<<endl;

}

return 0;
}
 

/* OUTPUT

ubuntu@ubuntu-HP-Notebook:~$ g++ multivector.cpp -fopenmp
ubuntu@ubuntu-HP-Notebook:~$ ./a.out
Input Matrix
	1	1
	1	1
	1	1
Input Col-Vector
2
2
Resultant Col-Vector

vec[0]:4

vec[1]:4

vec[2]:4

 */
