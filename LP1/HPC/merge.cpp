#include<iostream>

#include<stdlib.h>
#include<omp.h>
using namespace std;
 
void merge(int arr[], int start, int middle, int end)
{


    int i, j, k;
    int n1 = middle - start + 1;
    int n2 =  end - middle;
 
    int L[30], R[30];
 
    for (i = 0; i < n1; i++)
    L[i] = arr[start + i];
    for (j = 0; j < n2; j++)
    R[j] = arr[middle + 1+ j];
 
    i = 0;
    j = 0;
    k = start;
    while (i < n1 && j < n2)
    {
    if (L[i] <= R[j])
    {
        arr[k] = L[i];
        i++;
    }
    else
    {
        arr[k] = R[j];
        j++;
    }
    k++;
    }
 
    while (i < n1)
    {
    arr[k] = L[i];
    i++;
    k++;
    }
 
    while (j < n2)
    {
    arr[k] = R[j];
    j++;
    k++;
    }
}
 
void mergeSort(int arr[], int start, int end)
{
    if (start < end)
    {
    int middle =start+(end-start)/2;
    #pragma omp parallel sections
    {
      #pragma omp section
      {
         mergeSort(arr, start, middle);
      }
      #pragma omp section
      {

         mergeSort(arr, middle+1, end);
      }
    }
      merge(arr,start,middle, end);
    
  }
} 
 
int main()
{  
    int array[50],n;
    cout<<"Enter the number of elements (MAX 50): ";
     cin>>n;
 
    for(int i=0;i<n;i++) 
{ 
cin>>array[i];
    }
 
 
    mergeSort(array, 0, n-1);
 
    cout<<"\n Array after sorting : ";
 
    for(int i=0;i<n;i++)
     cout<<array[i]<<" ";
 
}

/* OUTPUT

root1@clp-cc:~$ g++ mer1.cpp -fopenmp 
root1@clp-cc:~$ ./a.out
Enter the number of elements (MAX 50): 7
12
66
45
77
88
92
21

 Array after sorting : 12 21 45 66 77 88 92 root1@clp-cc:~$ 


*/
