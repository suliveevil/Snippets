/*
*@Author:yourname
*@Date:2020-05-3011:53:01
 * @LastEditTime: 2020-05-30 13:39:21
 * @LastEditors: Please set LastEditors
*@Description:InUserSettingsEdit
*@FilePath:\undefinedc:\Users\swy\Documents\GitHub\Snippets\C\3.c
*/
//
//Createdbyswyon2020/5/30.
//

#include <stdio.h>
#include <math.h>
voidmain()
{

    intscore, temp;
    charch;
    scanf("%d", &score);
    temp = score / 10;
    if (score < 0 && score > 100)
        printf("scoreerror,inputscoreagain!");
    else
        switch (temp)
        {
        case10:
            break;
        case9:
            ch = 'A';
            break;
        case8:
            ch = 'B';
            break;
        case7:
            ch = 'C';
            break;
        case6:
            ch = 'D';
            break;
        default:
            ch = 'E';
            printf("Youshouldhaveaworkhard\n");
            break;
        }
    printf("score=%d\nch=%c\n", score, ch);
}