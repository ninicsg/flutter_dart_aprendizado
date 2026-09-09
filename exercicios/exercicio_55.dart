// 55 — estoque

void main(){
    List<int> itens = [8, 2, 15, 4, 20, 1];
    int contador = 0;
    int maiorItens = itens[0];
    int menorItens = itens[0];
    int estoqueBaixo = 0;
    for (final item in itens){
        contador += item;
        if (item > maiorItens){
            maiorItens = item;
        }
        if (item < menorItens){
            menorItens = item;
        }
        if (item < 5){
            estoqueBaixo += 1;
        }
    }
    print("Total: $contador\nMaior estoque: $maiorItens\nMenor estoque: $menorItens\nProdutos com estoque baixo: $estoqueBaixo");
}