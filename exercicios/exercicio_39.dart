//38 - contar números maiores que 5

void main(){
    List<int> numeros = [10, 3, 8, 1, 20];
    int contador = 0;
    for (final numero in numeros){
        if (numero > 5){
            contador += 1;
        }
    }
    print(contador);
}
