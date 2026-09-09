// 52 — somar apenas números maiores que 10

void main(){
    List<int> numeros = [5, 12, 7, 20, 3, 15];
    int contador = 0;
    for (final numero in numeros){
        if(numero > 10){
            contador += numero;
        }
    }
    print(contador);
}