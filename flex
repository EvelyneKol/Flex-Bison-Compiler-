%option yylineno
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "bison.tab.h"
void token_print(int token_id);

int lines = 0;
int id_line = 0;
int layoutType = 0;
int RadioButtonCount1 = 0;
int RadioButtonCount2 = 0;
int RadioButtonCount = 0;
int progress = 0;
int max_value = 0;
int AndroidPadding = 0;
%}

digit		[0-9]
integer		{digit}+
float		{digit}*\.{digit}+
letter		[a-zA-z0-9_ ]*
word		{letter}+
propertyC	   {word}[.]{word}

%%
\"[0-9]+\"        		{printf("%s", yytext); yylval = atoi(yytext+1); return INT;}
"<LinearLayout"         {token_print(LINEAR_LAYOUT_START); return LINEAR_LAYOUT_START; }
"</LinearLayout>"       {token_print(LINEAR_LAYOUT_STOP); return LINEAR_LAYOUT_STOP; }
"<RelativeLayout"       {token_print(RELATIVE_LAYOUT_START); return RELATIVE_LAYOUT_START; }
"</RelativeLayout>"     {token_print(RELATIVE_LAYOUT_STOP); return RELATIVE_LAYOUT_STOP; }
"<TextView"             {token_print(TEXT_VIEW_START); return TEXT_VIEW_START; }
"</TextView>"           {token_print(TEXT_VIEW_STOP); return TEXT_VIEW_STOP; }
"<ImageView"            {token_print(IMAGE_VIEW_START); return IMAGE_VIEW_START; }
"</ImageView>"          {token_print(IMAGE_VIEW_STOP); return IMAGE_VIEW_STOP; }
"<Button"               {token_print(BUTTON_START); return BUTTON_START; }
"</Button>"             {token_print(BUTTON_STOP); return BUTTON_STOP; }
"<RadioGroup"           {token_print(RADIO_GROUP_START); return RADIO_GROUP_START; }
"</RadioGroup>"         {token_print(RADIO_GROUP_STOP); return RADIO_GROUP_STOP; }
"<RadioButton"          {token_print(RADIO_BUTTON_START); return RADIO_BUTTON_START; }
"</RadioButton>"        {token_print(RADIO_BUTTON_STOP); return RADIO_BUTTON_STOP; }
"<ProgressBar"          {token_print(PROGRESS_BAR_START); return PROGRESS_BAR_START; }
"</ProgressBar>"        {token_print(PROGRESS_BAR_STOP); return PROGRESS_BAR_STOP; }
"android:id="           {token_print(ANDROID_ID); return ANDROID_ID; }
"android:layout_width=" {token_print(ANDROID_LAYOUT_WIDTH); return ANDROID_LAYOUT_WIDTH; }
"android:layout_height=" {token_print(ANDROID_LAYOUT_HEIGHT); return ANDROID_LAYOUT_HEIGHT; }
"android:orientation=" 	 {token_print(ANDROID_ORIENTATION); return ANDROID_ORIENTATION; }
"android:text=" 		 {token_print(ANDROID_TEXT); return ANDROID_TEXT; }
"android:textColor=" 	 {token_print(ANDROID_TEXTCOLOR); return ANDROID_TEXTCOLOR; }
"android:src=" 		 {token_print(ANDROID_SRC); return ANDROID_SRC; }
"android:padding=" 		 {token_print(ANDROID_PADDING); return ANDROID_PADDING; }
"android:max=" 		 {token_print(ANDROID_MAX); return ANDROID_MAX; }
"android:progress=" 		 {token_print(ANDROID_PROGRESS); return ANDROID_PROGRESS; }
"android:checkedButton=" {token_print(ANDROID_CHECKEDBUTTON); return ANDROID_CHECKEDBUTTON; }
"android:radio_button_count=" {token_print(ANDROID_RADIO_BUTTON_COUNT); return ANDROID_RADIO_BUTTON_COUNT;}
["]{word}["]	    {printf("%s", yytext); return STR;}
">"                      {token_print(LWAGGER); return LWAGGER;}
"/>"                     {token_print(CLOSE_LWAGGER); return CLOSE_LWAGGER;}
["]{integer}["]		 {printf("%s", yytext); yylval = atoi(yytext); return INTEGER;}
{float}		 {printf("%s", yytext); return FLOAT;}
true 	    {printf("%s", yytext); return TRUE;}
false		 {printf("%s", yytext); return FALSE;}
[\n]+                    {printf("\n"); lines++; return NL;}  
"<!--"([^<]|"<"[^!])*"-->"   /* Ignore comments */
[\r]+?                   {printf("%s" ,yytext); /*Ignore carriage returns*/}
[ \t]+                   {printf("%s" ,yytext); /*Ignore spaces and tabs*/}
.                        {printf("Invalid token: %s\n", yytext); }

%%
void token_print(int token_id) {
    printf("%s", yytext);
}
