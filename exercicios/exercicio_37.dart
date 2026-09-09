//37 - percorrer uma lista de números com for e calcular a soma total.

void main(){
    List<int> numeros = [10, 20, 30, 40];
    int soma = 0;
    for (final numero in numeros){
        soma += numero;
    }
    print(soma);
}
