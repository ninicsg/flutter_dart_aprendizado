// 56 — relatório de vendas

void main(){
    List<double> itens = [50.0, 120.0, 35.0, 200.0, 80.0, 150.0];
    double total = 0;
    double media = 0;
    double maiorVenda = itens[0];
    double menorVenda = itens[0];
    int maioresQCem = 0;
    for (final item in itens){
        total += item;
        if (item > maiorVenda){
            maiorVenda = item;
        }
        if (item < menorVenda){
            menorVenda = item;
        }
        if (item > 100){
            maioresQCem += 1;
        }
    }
    media = total / itens.length;
    print("Total: $total\nMaior venda: $maiorVenda\nMenor venda: $menorVenda\nMedia: $media\nQuantidade de vendas maiores que 100: $maioresQCem");
}