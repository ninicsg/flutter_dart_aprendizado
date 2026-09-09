// 47 - criar uma nova lista com números maiores que 10

void main(){
    List<int> numeros = [4, 15, 8, 22, 3, 11];
    List<int> maioresQueDez = [];
    for (final numero in numeros){
        if(numero > 10){
            maioresQueDez.add(numero);
        }
    }
    print(maioresQueDez);
}