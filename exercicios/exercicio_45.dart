//45 - calcular média da lista

void main(){
    List<int> numeros = [7, 8, 10, 5];
    int tamanho = numeros.length;
    int soma = 0;
    double mediaf = 0;
    for (final numero in numeros){
        soma += numero;
    }
    mediaf = soma / tamanho;
    print(mediaf);
}