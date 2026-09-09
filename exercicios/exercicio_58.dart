//58 - análise de notas com faixa
void main(){
    List<double> notas = [3.0, 5.5, 7.0, 8.5, 4.0, 9.5, 6.0];
    double total = 0;
    double media = 0;
    double maiorNota = notas[0];
    double menorNota = notas[0];
    int aprovados = 0;
    int reprovados = 0;
    int recuperacao = 0;
    int acimaDaMedia = 0;
    for (final nota in notas){
        total += nota;
        if (nota > maiorNota){
            maiorNota = nota;
        }
        if (nota < menorNota){
            menorNota = nota;
        }
        if (nota >= 7){
            aprovados += 1;
        }else if (nota >= 5){
            recuperacao += 1;
        }else{
            reprovados += 1;
        }
    }
    media = total / notas.length;
    for (final nota in notas){
        if (nota > media){
            acimaDaMedia += 1;
        }
    }
    print("Maior nota: $maiorNota\nMenor nota: $menorNota\nMédia: $media\nQuantidade de aprovados: $aprovados\nQuantidade em recuperação: $recuperacao\nQuantidade de reprovados: $reprovados\n Quantidade acima da média: $acimaDaMedia");
}