//28 - criar uma função que classifica a idade como criança, adolescente ou adulto.

void main(){
    int idade = 18;
    String resultado = classificarIdade(idade);
    print(resultado);
}
String classificarIdade(int idade){
    if (idade < 13){
        return "criança";
    }else if (idade < 18){
        return "adolescente";
    }else{
        return "adulto";
    }
}