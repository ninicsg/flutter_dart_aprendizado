// 53 — relatório de notas

void main(){
    List<double> notas = [7.5, 4.0, 8.0, 6.5, 9.0, 3.5];
    int aprovados = 0;
    int reprovados = 0;
    double maior = notas[0];
    double menor = notas[0];
    double contador = 0;
    for (final nota in notas){
        if(nota > maior){
            maior = nota;
        }
        if(nota < menor){
            menor = nota;
        }
        if (nota >= 7){
            aprovados += 1;
        }else{
            reprovados += 1;
        }
        contador += nota;
    }
    double media = contador / notas.length;
    print("Maior nota: $maior, menor nota: $menor. Média: $media. Aprovados: $aprovados, reprovados: $reprovados");
}