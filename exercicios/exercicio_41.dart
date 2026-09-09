// 41 - descobrir o menor número da lista
void main(){
    List<int> numeros = [4, 12, 7, 25, 3];
    int menor = numeros[0];
    for (final numero in numeros){
        if (numero<menor){
            menor = numero;
        }
    }
    print(menor);
}
