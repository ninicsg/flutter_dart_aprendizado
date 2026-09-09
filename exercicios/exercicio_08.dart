// 8 - faça soma, subtração, multiplicação e divisao entre duas variaveis inteiras e atribua o resultado a variaveis. depois atribua a somente uma variavel e mostre todos os resultados no terminal

void main() {
    int numero = 22;
    int numero2 = 13;
    int resultado1 = numero + numero2;
    int resultado2 = numero - numero2;
    int resultado3 = numero * numero2;
    double resultado4 = numero / numero2;
    String resultados = "$resultado1 $resultado2 $resultado3 $resultado4";
    print(resultados);
}