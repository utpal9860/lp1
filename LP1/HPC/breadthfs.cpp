#include<iostream>
#include<stdlib.h>
#include<queue>
using namespace std;
class node
{
public:
node *left,*right;
int data;
};
class Breadthfs
{
 public:
 node *insert(node *,int);
 void bfs(node*);
};
 node *insert(node * root, int data)
 {
  if(!root)
  {
   root=new node;
   root->left=NULL;
   root->right=NULL;
   root->data=data;
   return root;
  }
queue<node *> q;
q.push(root);
while(!q.empty())
 {
  node *temp=q.front();
  q.pop();
 if(temp->left==NULL)
  {
   temp->left=new node;
   temp->left->left=NULL;
   temp->left->right=NULL;
   temp->left->data=data;
   return root;
  }
else
{
q.push(temp->left);
}
 if(temp->right==NULL)
  {
   temp->right=new node;
   temp->right->left=NULL;
   temp->right->right=NULL;
   temp->right->data=data;
   return root;
 }
else{
q.push(temp->right);
}
}
}
void bfs(node*head)
{
queue <node*> q;
q.push(head);
int qsize;
while (!q.empty())
{
 qsize=q.size();
#pragma omp parallel for
for(int i=0;i<qsize;i++)
{
node* currNode;
#pragma omp critical
{
currNode=q.front();
q.pop();
cout<<"\t"<<currNode->data;
}
#pragma omp critical
{
if(currNode->left)
q.push(currNode->left);
if(currNode->right)
q.push(currNode->right);
}
}
}
}
int main()
{
node * root=NULL;
int data;
char ans;
do
{
cout<<"\n enter data=>";
cin>>data;
root=insert(root,data);
cout<<"do you want insert one more node?";
cin>>ans;
}
while(ans=='y'||ans=='y');
bfs(root);
return 0;
}

/**** OUTPUT   

root1@root1-OptiPlex-380:~$ g++ breadthfs.cpp -fopenmp
root1@root1-OptiPlex-380:~$ ./a.out

 enter data=>7
do you want insert one more node?y

 enter data=>90
do you want insert one more node?y

 enter data=>12
do you want insert one more node?y

 enter data=>56
do you want insert one more node?y

 enter data=>29
do you want insert one more node?y   

 enter data=>85
do you want insert one more node?y

 enter data=>78
do you want insert one more node?n
	7	90	12	56	29	85	78root1@root1-OptiPlex-380:~$ 
****/
  
