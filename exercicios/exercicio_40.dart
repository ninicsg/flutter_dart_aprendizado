//40 - descobrir o maior número da lista

void main(){
    List<int> numeros = [4, 12, 7, 25, 3];
    int maior = numeros[0];
    for (final numero in numeros){
        if (numero>maior){
            maior = numero;
        }
    }
    print(maior);
}
