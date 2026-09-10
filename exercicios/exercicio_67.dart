void main(){
    List<String> pedidos = [
    "Pedido A",
    "Pedido B",
    "Pedido C",
    "Pedido D",
    "Pedido E",
    ];

    List<double> pesos = [
    12.0,
    35.0,
    8.0,
    50.0,
    20.0,
    ];

    List<double> valores = [
    100.0,
    300.0,
    80.0,
    500.0,
    150.0,
    ];

    List<bool> prioritarios = [
    false,
    true,
    false,
    true,
    false,
    ];

    double capacidade = 70.0;

    List<String> pedidosOk = listarPedidosCarregados(pedidos, pesos, capacidade);
    List<String> pedidosNaoOk = listarPedidosNaoCarregados(pedidos, pesos, capacidade);
    double capacidadeFinal = calcularCapacidadeRestante(pesos, capacidade);
    double somaPesos = calcularValorTotalCarga(pesos, valores, capacidade);
    int quantidadeCarregados = contarPedidosCarregados(pesos, capacidade);
    int quantosPrioritarios = contarPrioritariosCarregados(pesos, prioritarios, capacidade);
    int maiorIndiceAprovado = encontrarIndiceMaiorValorCarregado(pesos, valores, capacidade);
    String produtoMaiorAprovado = pedidos[maiorIndiceAprovado];
    int indiceMaiorPeso = encontrarIndiceMaiorPesoCarregado(pesos, capacidade);
    String maiorPeso = pedidos[indiceMaiorPeso];
    int indiceNaoCarregado = encontrarIndicePrimeiroNaoCarregado(pesos, capacidade);
    String pedidoNaoCarregado = pedidos[indiceNaoCarregado];
    print("Pedidos aptos: $pedidosOk, pedidos não aptos: $pedidosNaoOk\nCapacidade inicial: $capacidade\nPeso carregado $capacidadeFinal\nSoma dos pesos carregados: $somaPesos\nPedidos carregados: $quantidadeCarregados\nQuantidade de pedidos prioritários: $quantosPrioritarios\nMaior pedido aprovado: $produtoMaiorAprovado\nPedido de maior peso carregado: $maiorPeso\nPrimeiro pedido não carregado: $pedidoNaoCarregado"); 
}

List<String> listarPedidosCarregados(List<String> pedidos, List<double> pesos, double capacidade){
    int posicao = 0;
    List<String> pedidosAptos = [];
    int posicaoAtual = 0;
    for (double peso in pesos){
        if (peso <= capacidade){
            pedidosAptos.add(pedidos[posicao]);
            capacidade -= peso;
        }
        posicao += 1;
    }
    return pedidosAptos;
}

List<String> listarPedidosNaoCarregados(List<String> pedidos, List<double> pesos, double capacidade){
    int posicao = 0;
    List<String> pedidosNaoAptos = [];
    for (double peso in pesos){
        if (peso > capacidade){
            pedidosNaoAptos.add(pedidos[posicao]);
        }else{
            capacidade -= peso;
        }
        posicao += 1;
    }
    return pedidosNaoAptos;
}

double calcularCapacidadeRestante(List<double> pesos, double capacidade){
    int posicao = 0;
    for (double peso in pesos){
        if (peso <= capacidade){
            capacidade -= peso;
        }
        posicao += 1;
    }
    return capacidade;
}

double calcularValorTotalCarga(List<double> pesos, List<double> valores, double capacidade){
    int posicao = 0;
    double valorTotal = 0;
    for (double peso in pesos){
        if (peso <= capacidade){
            valorTotal += valores[posicao];
            capacidade -= peso;
        }
        posicao += 1;
    }
    return valorTotal;
}

int contarPedidosCarregados(List<double> pesos, double capacidade){
    int pedidosTotal = 0;
    for (double peso in pesos){
        if (peso <= capacidade){
            pedidosTotal += 1;
            capacidade -= peso;
        }
    }
    return pedidosTotal;
}

int contarPrioritariosCarregados(List<double> pesos, List<bool> prioritarios, double capacidade){
    int posicao = 0;
    int pedidosTotal = 0;
    for (double peso in pesos){
        if (peso <= capacidade){
            if (prioritarios[posicao]){
                pedidosTotal += 1;
            }
            capacidade -= peso;
        }
        posicao += 1;

    }
    return pedidosTotal;
}

int encontrarIndiceMaiorValorCarregado(List<double> pesos, List<double> valores, double capacidade){
    int posicao = 0;
    double maiorValor = 0;
    int posicaoMaiorValor = 0;
    for (double valor in valores){
        if (pesos[posicao] <= capacidade){
            if (maiorValor < valor){
                maiorValor= valor;
                posicaoMaiorValor = posicao;
            }
            capacidade -= pesos[posicao];
        }
        posicao += 1;
    }
    return posicaoMaiorValor;
}

int encontrarIndiceMaiorPesoCarregado(List<double> pesos, double capacidade){
    int posicao = 0;
    double maiorValor = 0;
    int posicaoMaiorValor = 0;
    for (double peso in pesos){
        if (pesos[posicao] <= capacidade){
            if (maiorValor < peso){
                maiorValor= peso;
                posicaoMaiorValor = posicao;
            }
            capacidade -= pesos[posicao];
        }
        posicao += 1;
    }
    return posicaoMaiorValor;
}
int encontrarIndicePrimeiroNaoCarregado(List<double> pesos, double capacidade){
    int posicao = 0;
    List<double> naoCoube = [];
    int posicaoNaoCoube = 0;
    for (double peso in pesos){
        if (peso > capacidade){
            return posicaoNaoCoube;
        }else{
            capacidade -= peso;
        }
        posicaoNaoCoube += 1;
    }
    return 0;
}