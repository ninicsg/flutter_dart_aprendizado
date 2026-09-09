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
    print("Pedidos atendidos: $podeAtenderPedido\nPedidos não atendidos: $naoPodeAtenderPedido\nTotal vendido: $totalVendidoPedidos\nQuantidade total vendida: $quantiaTotal");
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

// List<int> calcularEstoquesFinais(List<int> estoques, List<int> quantidadesPedidas){

// }

// int encontrarIndiceMaiorValorVenda(List<double> precos, List<int> estoques, List<int> quantidadesPedidas){

// }

// int encontrarIndiceMenorEstoqueFinal(List<int> estoques, List<int> quantidadesPedidas){

// }