//64 — relatório de produtos com duas listas
void main(){
    List<String> produtos = [
        "Arroz",
        "Feijão",
        "Macarrão",
        "Leite",
        "Café",
    ];

    List<double> precos = [
        25.0,
        12.0,
        8.5,
        6.0,
        18.0,
    ];
    int indice = encontrarIndiceMaisCaro(precos);
    String produto = produtos[indice];
    double preco = precos[indice];
    int indiceBarato = encontrarIndiceMaisBarato(precos);
    String produtoBarato = produtos[indiceBarato];
    double precoBarato = precos[indiceBarato];
    double media = calcularMedia(precos);
    int acimaDaMedia = contarAcimaDaMedia(precos, media);
    List<String> prodAcimaMedia = listarProdutosAcimaDaMedia(produtos, precos, media);
    print("Produto mais caro: $produto, Preço: $preco\nProduto mais barato: $produtoBarato, Preço: $precoBarato\nPreço médio: $media\nProdutos acima da média: $acimaDaMedia\nLista: $prodAcimaMedia");
}

double calcularMedia(List<double> precos){
    double totalPreco = 0;
    for (double preco in precos){
        totalPreco+=preco;
    }
    return totalPreco/precos.length;
}

int encontrarIndiceMaisCaro(List<double> precos){
    double maisCaro = precos[0];
    int posicaoMaisCaro = 0;
    int posicaoAtual = 0;
    for (double preco in precos){
        if (preco > maisCaro){
            maisCaro = preco;
            posicaoMaisCaro = posicaoAtual;
        }
        posicaoAtual+=1;
    }
    return posicaoMaisCaro;
}

int encontrarIndiceMaisBarato(List<double> precos){
    double maisBarato = precos[0];
    int posicaoMaisBarato = 0;
    int posicaoAtual = 0;
    for (double preco in precos){
        if (preco < maisBarato){
            maisBarato = preco;
            posicaoMaisBarato = posicaoAtual;
        }
        posicaoAtual+=1;
    }
    return posicaoMaisBarato;
}

int contarAcimaDaMedia(List<double> precos, double media){
    int contadorAcimaMedia = 0;
    for (double preco in precos){
        if (preco > media){
            contadorAcimaMedia +=1;
        }
    }
    return contadorAcimaMedia;
}

List<String> listarProdutosAcimaDaMedia(List<String> produtos, List<double> precos, double media){
    List<String> produtosAcimaDaMedia = [];
    int posicaoAtual = 0;
    for (double preco in precos){
        if (preco > media){
            produtosAcimaDaMedia.add(produtos[posicaoAtual]);
        }
        posicaoAtual +=1;
    }
    return produtosAcimaDaMedia;
}