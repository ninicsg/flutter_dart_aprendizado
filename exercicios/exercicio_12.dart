// 12 - classificar uma nota como Aprovado, Recuperação ou Reprovado.


void main() {
    int nota = 4;
    if (nota >= 7){
        print("Aprovado");
    }else if (nota >=5 && nota < 7) {
        print("Recuperação");
    } else{
        print("Reprovado");
    }
}