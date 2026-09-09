//59 - função que recebe lista e retorna soma
void main(){
    List<int> somas = [10, 20, 30, 40];
    int resultado = somarNumeros(somas);
    print(resultado);
}

int somarNumeros(List<int> somas){
    int total = 0;
    for (int soma in somas ){
        total += soma;
    }
    return total;
}