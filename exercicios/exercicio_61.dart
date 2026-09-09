//61 — função que retorna o maior número
void main(){
    List<int> numeros = [4, 18, 7, 25, 11];
    int resultado = encontrarMaior(numeros);
    print(resultado);
}

int encontrarMaior(List<int> numeros){
    int maior = numeros[0];
    for (int numero in numeros ){
        if (numero > maior){
            maior = numero;
        }
    }
    return maior;
}