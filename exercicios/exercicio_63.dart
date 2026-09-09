//63 — Saldo final, Total de dinheiro que entrou,Total de dinheiro que saiu,Maior entrada,Maior saída,Quantidade de entradas, Quantidade de saídas,Menor saldo que a conta atingiu durante o mês, Se em algum momento o saldo ficou negativo, Maior sequência de saídas consecutivas
void main(){
    double saldoInicial = 300.0;
    List<double> movimentacoes = [
    500.0,
    -120.0,
    200.0,
    -80.0,
    -300.0,
    150.0,
    -50.0,
    -100.0,
    -200.0,
    400.0,
    ];
    double saldoFinal = calcularSaldoFinal(movimentacoes,saldoInicial);
    double totalEntradas = calcularTotalEntradas(movimentacoes);
    double totalSaidas = calcularTotalSaidas(movimentacoes);
    double maiorEntrada = encontrarMaiorEntrada(movimentacoes);
    double maiorSaida = encontrarMaiorSaida(movimentacoes);
    double menorSaldo = encontrarMenorSaldo(movimentacoes,saldoInicial);
    int entradas = contarEntradas(movimentacoes);
    int saidas = contarSaidas(movimentacoes);
    bool negativo = ficouNegativo(movimentacoes,saldoInicial);
    int sequenciaSaidas = maiorSequenciaSaidas(movimentacoes);
    String resultado = "======= RELATÓRIO DA CONTA =======\nSaldo inicial: $saldoInicial\nSaldo final: $saldoFinal\nTotal de entradas: $totalEntradas\nTotal de saídas: $totalSaidas\n Maior entrada: $maiorEntrada\n Maior saída: $maiorSaida\nQuantidade de entradas: $entradas\nQuantidade de saídas: $saidas\nMenor saldo: $menorSaldo\nFicou negativo: $negativo\nMaior sequencia de saidas: $sequenciaSaidas";
    print(resultado);
}

double calcularSaldoFinal(List<double> movimentacoes,double saldoInicial){
    double total = saldoInicial;
    for (double movimentacao in movimentacoes){
        total += movimentacao;
    }
    return total;
}

double calcularTotalEntradas(List<double> movimentacoes){
    double total = 0;
    for (double movimentacao in movimentacoes){
        if (movimentacao > 0){
            total += movimentacao;
        }
    }
    return total;
}

double calcularTotalSaidas(List<double> movimentacoes){
    double total = 0;
    for (double movimentacao in movimentacoes){
        if (movimentacao < 0){
            total -= movimentacao;
        }
    }
    return total;
}

double encontrarMaiorEntrada(List<double> movimentacoes){
    double maiorEntrada = movimentacoes[0];
    for (double movimentacao in movimentacoes){
        if (movimentacao > maiorEntrada){
            maiorEntrada = movimentacao;
        }
    }
    return maiorEntrada;
}

double encontrarMaiorSaida(List<double> movimentacoes){
    double maiorSaida = movimentacoes[0];
    for (double movimentacao in movimentacoes){
        if (movimentacao < maiorSaida){
            maiorSaida = movimentacao;
        }
    }
    return maiorSaida * -1;
}

int contarEntradas(List<double> movimentacoes){
    int total = 0;
    for (double movimentacao in movimentacoes){
        if (movimentacao > 0){
            total += 1;
        }
    }
    return total;
}

int contarSaidas(List<double> movimentacoes){
    int total = 0;
    for (double movimentacao in movimentacoes){
        if (movimentacao < 0){
            total += 1;
        }
    }
    return total;
}

double encontrarMenorSaldo(List<double> movimentacoes, double saldoInicial){
    double menorSaldo = saldoInicial;
    double total = saldoInicial;
    double saldoAtual = 0;
    for (double movimentacao in movimentacoes){
        total += movimentacao;
        saldoAtual = total;
        if (saldoAtual < menorSaldo){
            menorSaldo = saldoAtual;
        }
    }
    return menorSaldo;
}

bool ficouNegativo(List<double> movimentacoes, double saldoInicial){
    double total = saldoInicial;
    bool result = false;
    for (double movimentacao in movimentacoes){
        total += movimentacao;
        if (total < 0){
            result = true;
        }
    }
    return result;
}

int maiorSequenciaSaidas(List<double> movimentacoes){
    int sequenciaAtual = 0;
    int maiorSequencia = 0;
    for (double movimentacao in movimentacoes){
        if (movimentacao < 0){
            sequenciaAtual+=1;
        }
        if (sequenciaAtual > maiorSequencia){
            maiorSequencia = sequenciaAtual;
        }
        if (movimentacao > 0){
            sequenciaAtual = 0;
        }
    }
    return maiorSequencia;
}

