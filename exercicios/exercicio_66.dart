// 66 - Criar um programa que analisa pedidos de produtos usando listas relacionadas de produtos, preços, estoques e quantidades pedidas, identificando quais pedidos podem ou não ser atendidos, calculando o total vendido, a quantidade total vendida, o produto com maior valor de venda, o produto com menor estoque final e os estoques finais após os pedidos.

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

    List<int> quantidadesPedidas = [
    2,
    5,
    1,
    10,
    1,
    ];

    List<String> podeAtenderPedido = listarPedidosAtendidos(produtos, estoques, quantidadesPedidas);
    List<String> naoPodeAtenderPedido = listarPedidosNaoAtendidos(produtos, estoques, quantidadesPedidas);
    double totalVendidoPedidos = calcularValorTotalVendas(precos, estoques, quantidadesPedidas);
    int quantiaTotal = calcularQuantidadeTotalVendida(estoques, quantidadesPedidas);
    int indiceMaiorVenda = encontrarIndiceMaiorValorVenda(precos, estoques, quantidadesPedidas);
    String produtoMaiorVenda = produtos[indiceMaiorVenda];
    int menorEstoqueIndice = encontrarIndiceMenorEstoqueFinal(estoques, quantidadesPedidas);
    String menorEstoqueFinal = produtos[menorEstoqueIndice];
    List<String> estoqueFinal = calcularEstoquesFinais(estoques, quantidadesPedidas, produtos);
    print("Pedidos atendidos: $podeAtenderPedido\nPedidos não atendidos: $naoPodeAtenderPedido\nTotal vendido: $totalVendidoPedidos\nQuantidade total vendida: $quantiaTotal\nMaior valor de venda: $produtoMaiorVenda\nProduto com menor estoque final: $menorEstoqueFinal\nEstoques finais: $estoqueFinal");
}

List<String> listarPedidosAtendidos(List<String> produtos, List<int> estoques, List<int> quantidadesPedidas){
    int posicaoAtual = 0;
    List<String> podeAtender = [];
    int posicao = 0;
    for (int quantidadePedida in quantidadesPedidas){
        if (quantidadePedida <= estoques[posicaoAtual]){
            podeAtender.add(produtos[posicaoAtual]);
            posicao = posicaoAtual;
        }
        posicaoAtual +=1;
    }
    return podeAtender;
}

List<String> listarPedidosNaoAtendidos(List<String> produtos, List<int> estoques, List<int> quantidadesPedidas){
    int posicaoAtual = 0;
    List<String> naoPodeAtender = [];
    int posicao = 0;
    for (int quantidadePedida in quantidadesPedidas){
        if (quantidadePedida > estoques[posicaoAtual]){
            naoPodeAtender.add(produtos[posicaoAtual]);
            posicao = posicaoAtual;
        }
        posicaoAtual +=1;
    }
    return naoPodeAtender;
}

double calcularValorTotalVendas(List<double> precos, List<int> estoques, List<int> quantidadesPedidas){
    int posicaoAtual = 0;
    List<double> totalVendido = [];
    int posicao = 0;
    double resultado = 0;
    for (int quantidadePedida in quantidadesPedidas){
        if (quantidadePedida <= estoques[posicaoAtual]){
            totalVendido.add(precos[posicaoAtual] * quantidadePedida);
            posicao = posicaoAtual;
        }
        posicaoAtual +=1;
    }
    for (double total in totalVendido){
        resultado += total;
    }
    return resultado;
}

int calcularQuantidadeTotalVendida(List<int> estoques, List<int> quantidadesPedidas){
    int posicaoAtual = 0;
    List<int> quantidadeVendido = [];
    int posicao = 0;
    int resultado = 0;
    for (int quantidadePedida in quantidadesPedidas){
        if (quantidadePedida <= estoques[posicaoAtual]){
            quantidadeVendido.add(quantidadePedida);
            posicao = posicaoAtual;
        }
        posicaoAtual +=1;
    }
    for (int quantia in quantidadeVendido){
        resultado += quantia;
    }
    return resultado;
}

List<String> calcularEstoquesFinais(List<int> estoques, List<int> quantidadesPedidas, List<String> produtos){
    int posicaoAtual = 0;
    int posicao = 0;
    List<String> printar = [];
    List<int> resultadoEstoqueFinal = [];
    for (int quantidadePedida in quantidadesPedidas){
        if (quantidadePedida <= estoques[posicaoAtual]){
            resultadoEstoqueFinal.add(estoques[posicaoAtual] - quantidadePedida);
        }else{
            resultadoEstoqueFinal.add(estoques[posicaoAtual]);
        }
        posicaoAtual += 1;
    }
    int estoqueFinal = resultadoEstoqueFinal[0];
    for(String produto in produtos){
        estoqueFinal = resultadoEstoqueFinal[posicao];
        printar.add("\n$produto: $estoqueFinal");
        posicao+=1;
        
    }
    return printar;
}

int encontrarIndiceMaiorValorVenda(List<double> precos, List<int> estoques, List<int> quantidadesPedidas){
    int posicaoAtual = 0;
    double maiorValor = precos[0];
    int posicaoMaiorValor = 0;
    double maiores = 0;
    double maiorValorVenda = 0;
    for (int quantidadePedida in quantidadesPedidas){
        if (quantidadePedida <= estoques[posicaoAtual]){
            maiores = precos[posicaoAtual] * quantidadePedida;
        }
        if (maiores > maiorValorVenda){
            maiorValorVenda = maiores;
            posicaoMaiorValor = posicaoAtual;
        }
        posicaoAtual+=1;
    }
    return posicaoMaiorValor;
}

int encontrarIndiceMenorEstoqueFinal(List<int> estoques, List<int> quantidadesPedidas){
    int posicaoAtual = 0;
    int posicao = 0;
    int posicaoAtualResultado = 0;
    List<int> resultadoEstoque = [];
    for (int quantidadePedida in quantidadesPedidas){
        if (quantidadePedida <= estoques[posicaoAtual]){
            resultadoEstoque.add(estoques[posicaoAtual] - quantidadePedida);
        }else{
            resultadoEstoque.add(estoques[posicaoAtual]);
        }
        posicaoAtual += 1;
    }
    int menorEstoque = resultadoEstoque[0];
    for (int resultado in resultadoEstoque){
        if (resultado < menorEstoque){
            menorEstoque = resultado;
            posicao = posicaoAtualResultado;
        }
        posicaoAtualResultado+=1;
    }
    return posicao;
}