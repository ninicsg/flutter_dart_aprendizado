// 48 - transformar uma lista em outra

void main(){
    List<int> numeros = [1, 2, 3, 4];
    List<int> dobrados = [];
    for (final numero in numeros){
        int numero2 = numero * 2;
        dobrados.add(numero2);
    }
    print(dobrados);
}