// 57 — relatório de temperaturas

void main(){
    List<double> temp = [18.5, 25.0, 31.5, 19.0, 28.0, 35.5, 22.0];
    double total = 0;
    double media = 0;
    double maiorTemp = temp[0];
    double menorTemp = temp[0];
    int acimaDaMedia = 0;
    int abaixoDaMedia = 0;
    for (final temperatura in temp){
        total += temperatura;
        if (temperatura > maiorTemp){
            maiorTemp = temperatura;
        }
        if (temperatura < menorTemp){
            menorTemp = temperatura;
        }
    }
    media = total / temp.length;
    for (final temperatura in temp){
        if (temperatura >= media){
            acimaDaMedia += 1;
        }
        else{
            abaixoDaMedia+=1;
        }
    }
    print("Maior temperatura: $maiorTemp\nMenor temperatura: $menorTemp\nMédia: $media\nQuantidade acima da média: $acimaDaMedia\nQuantidade abaixo da média: $abaixoDaMedia");
}