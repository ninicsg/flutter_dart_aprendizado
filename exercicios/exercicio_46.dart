//46 - criar uma nova lista só com números pares

void main(){
    List<int> numeros = [1, 2, 3, 4, 5, 6];
    List<int> numerosPares = [];
    for (final numero in numeros){
        if(numero % 2 == 0){
            numerosPares.add(numero);
        }
    }
    print(numerosPares);
}