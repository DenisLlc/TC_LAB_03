/*Denis Llamoca Cervantes*/
/*Ingienería de Sistemas UNSA*/
/*Ejercicio: Crear calculadora*/

/*Definicion*/
DIGITO [0-9]
NUMERO {DIGITO}+(\.{DIGITO}+)?
OPERACIONES [+*/-]
%{
    char operaciones;
    float operador1=0, operador2=0, resultado=0;
    /*banderas*/
    int flag1=0,flag2=-1;
    void evaluate();
%}
/*Reglas*/
%%
{NUMERO} {
    if(flag1 == 0){
        operador1 = atof(yytext); /*Conversion de cadena a float*/
        flag1 = 1;
    }else if(flag2 == 0){
        operador2 = atof(yytext); /*Conversion de cadena a float*/
        flag2 = 1;
    }
}
{OPERACIONES} {
    if(flag1 == 1){
        /*COnversion de una cadena a tipo char*/
        operaciones = (char)*yytext;
        flag2 = 0;
    }
}
[\n] {
    if(flag1 == 1 && flag2 == 1){
        evaluate();
        flag1 = 0;
        flag2 = -1;
    }
}
%%
/*Codigo usuario*/
/*Redefinir*/
int yywrap(){}
int main(){
    yylex();
    return 0;
}
void evaluate(){
    switch(operaciones){
        /*Operaciones básicas*/
        case '+':
            resultado = operador1 + operador2;
            break;
        case '-':
            resultado = operador1 - operador2;
            break;
        case '*':
            resultado = operador1 * operador2;
            break;
        case '/':
            if(operador2 == 0){
                printf("Error de división entre cero!!\nSe devolverá -1 como resultado\n");
                resultado = -1;
                break;
            }else{
                resultado = operador1 / operador2;
            }
            break;   
    }
    printf("El resultado de la operacion es: %f \n",resultado);
}