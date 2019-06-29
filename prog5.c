#include "mex.h"
#include "stdlib.h"

struct Node
{
    int x;
    int y;
    int n;
    struct Node *next;
};
typedef struct Node node;
int prog5(int si, int sj, int di, int dj, int z, node **map, int s)
{
    int v=0;
    map[si][sj].n=z;
    if (si==di&&sj==dj)
        return 1;
    if ((si-1)>=0){
        if (map[si-1][sj].n==1||map[si-1][sj].n>z+1){
            if(prog5(si-1,sj,di,dj,z+1,map,s)==1){
                v=1;
                map[si][sj].next=&(map[si-1][sj]);
            }
        }
    }
    if ((sj-1)>=0){
        if (map[si][sj-1].n==1||map[si][sj-1].n>z+1){
            if(prog5(si,sj-1,di,dj,z+1,map,s)==1){
                v=1;
                map[si][sj].next=&(map[si][sj-1]);
            }
        }
    }
    if ((si+1)<s){
        if (map[si+1][sj].n==1||map[si+1][sj].n>z+1){
            if(prog5(si+1,sj,di,dj,z+1,map,s)==1){
                v=1;
                map[si][sj].next=&(map[si+1][sj]);
            }
        }
    }
    if ((sj+1)<s){
        if (map[si][sj+1].n==1||map[si][sj+1].n>z+1){
            if(prog5(si,sj+1,di,dj,z+1,map,s)==1){
                v=1;
                map[si][sj].next=&(map[si][sj+1]);
            }
        }
    }
    if (v==1)
        return 1;
    else
        return 0;
}
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
    double  *pointer, *m, *s, *d;
    int i, j;
    node **map, *current;
    map=(node**)malloc(mxGetM(prhs[0])*sizeof(node));
    for (i=0;i<mxGetM(prhs[0]);i++)
        map[i]=(node*)malloc(mxGetM(prhs[0])*sizeof(node));
    if ( nrhs != 3 ) {
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:nrhs","This function takes 3 input arguments.");
    } 
    if (mxGetM(prhs[1])*mxGetN(prhs[1])!=2||mxGetM(prhs[2])*mxGetN(prhs[2])!=2)
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:nrhs","Starting position and destination should both be a two element array.");
    m=mxGetPr(prhs[0]);
    s=mxGetPr(prhs[1]);
    d=mxGetPr(prhs[2]);
    if (s[0]>mxGetM(prhs[0])||s[0]<1||s[1]>mxGetM(prhs[0])||s[1]<1||d[0]>mxGetM(prhs[0])||d[0]<1||d[1]>mxGetM(prhs[0])||d[1]<1)
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:nrhs","Starting position and destination should both be inside the map.");
    if (m[(int)((s[0]-1)*mxGetM(prhs[0])+s[1]-1)]==0||m[(int)((d[0]-1)*mxGetM(prhs[0])+d[1]-1)]==0)
        mexErrMsgIdAndTxt("MyToolbox:arrayProduct:nrhs","Starting position and destination should not be on the zero element of the map.");
    for (i=0;i<mxGetM(prhs[0]);i++)
        for (j=0;j<mxGetM(prhs[0]);j++){
            map[i][j].x=j+1;
            map[i][j].y=i+1;
            map[i][j].n=(int)m[j*mxGetM(prhs[0])+i];
            map[i][j].next=NULL;
        }
    if (prog5((int)(s[1]-1),(int)(s[0]-1),(int)(d[1]-1),(int)(d[0]-1),2,map,mxGetM(prhs[0]))==1)
    {
        plhs[0] = mxCreateNumericMatrix(((map[(int)(d[1]-1)][(int)(d[0]-1)]).n)-1,2, mxDOUBLE_CLASS, mxREAL);
        pointer = mxGetPr(plhs[0]);
        i=0;
        for (current=&(map[(int)(s[1]-1)][(int)(s[0]-1)]);current!=NULL;current=current->next){
            pointer[i]=current->x;
            pointer[i+mxGetM(plhs[0])]=current->y;
            i++;
        }
    }
    else
        plhs[0] = mxCreateNumericMatrix(0,0, mxDOUBLE_CLASS,mxREAL);
    return;
}
