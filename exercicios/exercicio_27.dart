//27- criar uma função que retorna true se a pessoa tiver 18 anos ou mais.

void main(){
    int idade = 18;
    bool resultado = ehMaiordeIdade(idade);
    print(resultado);
}
bool ehMaiordeIdade(int idade){
    if (idade >= 18){
        return true;
    }else{
        return false;
    }
}