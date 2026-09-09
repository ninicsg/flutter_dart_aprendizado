//25 - criar calcularMedia para receber duas notas e retornar a média.

void main(){
    double nota1 = 7.5;
    double nota2 = 10;
    double media = calcularMedia(nota1, nota2);
    print(media);
}
double calcularMedia(double nota1, double nota2){
    return (nota1 + nota2) / 2;
}