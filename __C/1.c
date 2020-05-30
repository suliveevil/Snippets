#include <stdio.h>
int main(){  
    int i;
    //i控制行的数量
    for(i=1;i<=5;i++)   
        printstar(6-i);;
}
int printstar(int i){
    int j,k;
    char space =' '; 
    for(j=1; j<6-i; j++) 
        //j控制空格的数量
        printf(" ");;
    //k：控制星号的数量
    for(k=1; k<=2*i-1; k++)  
        printf("*");
    printf("\n");
    
}