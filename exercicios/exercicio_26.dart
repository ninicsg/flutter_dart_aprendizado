//26 - criar uma função que recebe uma nota e retorna "aprovado" ou "reprovado".

void main(){
    double nota = 5;
    String resultado = verificarAprovacao(nota);
    print(resultado);
}
String verificarAprovacao(double nota){
    if (nota >= 7){
        return "aprovado";
    }else{
        return "reprovado";
    }
}