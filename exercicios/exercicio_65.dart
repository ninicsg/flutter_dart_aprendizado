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

    List<int> estoques = [
        3,
        10,
        0,
        8,
        2,
    ];
    int indice = encontrarIndiceMaisCaro(precos);
    String produto = produtos[indice];
    int indiceBarato = encontrarIndiceMaisBarato(precos);
    String produtoBarato = produtos[indiceBarato];
    int indiceEstoqueMaior = encontrarIndiceMaiorEstoque(estoques);
    String maiorEstoqueProduto = produtos[indiceEstoqueMaior];
    int indiceEstoqueMenor = encontrarIndiceMenorEstoque(estoques);
    String menorEstoqueProduto = produtos[indiceEstoqueMenor];
    List<String> semEstoque = listarProdutosSemEstoque(produtos, estoques);
    List<String> estoqueBaixo = listarProdutosEstoqueBaixo(produtos, estoques);
    double totalEstoque = calcularValorTotalEstoque(precos, estoques);
    int indiceEstoqueValorMaior = encontrarIndiceMaiorValorEstoque(precos, estoques);
    String produtoMaiorValorEstoque = produtos[indiceEstoqueValorMaior];
    print("Produto mais caro: $produto\nProduto mais barato: $produtoBarato\nProduto com maior estoque: $maiorEstoqueProduto\nProduto com menor estoque: $menorEstoqueProduto\nProdutos sem estoque: $semEstoque\nProdutos com estoque baixo: $estoqueBaixo\nTotal do estoque: $totalEstoque\nProduto com o maior valor de acordo com o estoque: $produtoMaiorValorEstoque");
}

double calcularValorTotalEstoque(List<double> precos, List<int> estoques){
    int posicaoAtual = 0;
    double resultado = 0;
    for (double preco in precos){
        resultado += preco * estoques[posicaoAtual];
        posicaoAtual += 1;
    }
    
    return resultado;
}

int encontrarIndiceMaisCaro(List<double> precos){
    int posicaoAtual = 0;
    double maisCaro = precos[0];
    int posicaoMaisCaro = 0;
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
    int posicaoAtual = 0;
    double maisBarato = precos[0];
    int posicaoMaisBarato = 0;
    for (double preco in precos){
        if (preco < maisBarato){
            maisBarato = preco;
            posicaoMaisBarato = posicaoAtual;
        }
        posicaoAtual+=1;
    }

    return posicaoMaisBarato;
}

int encontrarIndiceMaiorEstoque(List<int> estoques){
    int posicaoAtual = 0;
    int maiorEstoque = estoques[0];
    int posicaoMaiorEstoque = 0;
    for (int estoque in estoques){
        if (estoque > maiorEstoque){
            maiorEstoque = estoque;
            posicaoMaiorEstoque = posicaoAtual;
        }
        posicaoAtual += 1;
    }
    return posicaoMaiorEstoque;
}

int encontrarIndiceMenorEstoque(List<int> estoques){
    int posicaoAtual = 0;
    int menorEstoque = estoques[0];
    int posicaoMenorEstoque = 0;
    for (int estoque in estoques){
        if (estoque < menorEstoque){
            menorEstoque = estoque;
            posicaoMenorEstoque = posicaoAtual;
        }
        posicaoAtual += 1;
    }
    return posicaoMenorEstoque;
}

List<String> listarProdutosSemEstoque(List<String> produtos, List<int> estoques){
    int posicaoAtual = 0;
    List<String> produtosSemEstoque = [];
    for (int estoque in estoques){
        if (estoque == 0){
            produtosSemEstoque.add(produtos[posicaoAtual]);
        }
        posicaoAtual += 1;
    }
    return produtosSemEstoque;
}

List<String> listarProdutosEstoqueBaixo(List<String> produtos, List<int> estoques){
    int posicaoAtual = 0;
    List<String> produtosEstoqueBaixo = [];
    for (int estoque in estoques){
        if (estoque < 5){
            produtosEstoqueBaixo.add(produtos[posicaoAtual]);
        }
        posicaoAtual += 1;
    }
    return produtosEstoqueBaixo;
}

int encontrarIndiceMaiorValorEstoque(List<double> precos, List<int> estoques){
    int posicaoAtual = 0;
    double resultado = 0;
    int posicaoMaior = 0;
    int posicaoMaiorzona = 0;
    List<double> resultados = [];
    for (double preco in precos){
        resultado = preco * estoques[posicaoAtual];
        posicaoAtual += 1;
        resultados.add(resultado);
    }
    double maiorResultado = resultados[0];
    for (double result in resultados){
        if (result > maiorResultado){
            maiorResultado = result;
            posicaoMaiorzona = posicaoMaior;
        }
        posicaoMaior+=1;
    }
    return posicaoMaiorzona;
}
