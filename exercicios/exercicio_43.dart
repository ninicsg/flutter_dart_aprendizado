//43 - contar números ímpares

void main(){
    List<int> numeros = [1, 2, 3, 4, 5, 6, 7, 8];
    int contador = 0;
    for (final numero in numeros){
        if (numero % 2 != 0){
            contador += 1;
        }
    }
    print(contador);
}

