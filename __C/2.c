/*
 * @Author: your name
 * @Date: 2020-05-30 11:53:01
 * @LastEditTime: 2020-05-30 13:28:03
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \undefinedc:\Users\swy\Documents\GitHub\Snippets\C\2.c
 */ 
//
// Created by swy on 2020/5/30.
//

#include<stdio.h>
void strcopy(char *s, char *t )
{
int i=0;
while(i==0)
    {
*s=*t;
if(*t!='\0') s++; else i=1;;
t++;
}
}
void main()
{char a[20], b[10];
    gets(b);
    strcopy(a,b);
    puts(a);
}