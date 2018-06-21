#include<iostream>
#include<string>
#include<fstream>
#include<stdio.h>
using namespace std;

void gen_lib(const int& max_in, const char op, FILE* fp) {
    string eqn = "Y=A";
    string close_bracket_str = "";
    for ( int i = 2; i <=max_in; i++ ) {
        eqn += " ";
        eqn += op;
        eqn += " (";
        char literal = 'A'+i-1;
        eqn += literal;
        close_bracket_str += ")";
        char equation[60];
        sprintf(equation,"%s%s",eqn.c_str(), close_bracket_str.c_str());
/*
  GATE AND4X1     6.00  Y=A * (B * (C * (D))); PIN *      INV   1 999     1.00     0.00     1.00     0.00
  GATE OR4X1      6.00  Y=A + (B + (C + (D))); PIN *   NONINV   1 999     1.00     0.00     1.00     0.00
*/
        fprintf (fp, "GATE %s%dX1\t%8.2f\t%-59s; PIN * %-6s 1 999     1.00     0.00     1.00     0.00\n",
                (op=='*'?"AND":"OR"), i, (float)(2+i), equation, (op=='*'?"INV":"NONINV"));
    }
}
void gen_buf_and_inv(FILE* fp) {
    fprintf (fp, "GATE BUFX1\t%8.2f\t%-59s; PIN * NONINV 1 999     1.00     0.00     1.00     0.00\n",5.00,"Y=A");
    fprintf (fp, "GATE INVX1\t%8.2f\t%-59s; PIN * INV    1 999     1.00     0.00     1.00     0.00\n",2.00,"Y=!(A)");
}
void gen_constants(FILE* fp) {
    fprintf(fp, "GATE CONST1\t%8.2f\t%-59s;\n",1.00,"Y=CONST1");
    fprintf(fp, "GATE CONST0\t%8.2f\t%-59s;\n",1.00,"Y=CONST0");
}
void gen_and_lib(const int& max_in,FILE* fp) {
    gen_lib(max_in, '*', fp);
}
void gen_or_lib(const int& max_in, FILE* fp) {
    gen_lib(max_in, '+', fp);
}
int main() {
    int max_in;
    cout << "Enter Max number of inputs (<=10): ";
    cin >> max_in;
    if (max_in > 10)
        max_in = 10;
    FILE* fp = fopen("stdcell.genlib.large","w");
    if (fp == NULL) perror ("Error opening file");
    gen_buf_and_inv(fp);
    gen_and_lib(max_in,fp);
    gen_or_lib(max_in,fp);
    gen_constants(fp);
    fclose(fp);
    printf("Genlib written to %s\n.","stdcell.genlib.large");
}
