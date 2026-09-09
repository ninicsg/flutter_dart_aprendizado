//44 - somar só os números pares

void main(){
    List<int> numeros = [1, 2, 3, 4, 5, 6];
    int contador = 0;
    for (final numero in numeros){
        if (numero % 2 == 0){
            contador += numero;
        }
    }
    print(contador);
}

