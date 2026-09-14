void main(){
    List<String> filmes = [
        "Filme A",
        "Filme B",
        "Filme C",
        "Filme D",
    ];

    List<int> capacidadeSalas = [
        100,
        80,
        120,
        60,
    ];

    List<int> ingressosVendidos = [
        95,
        80,
        70,
        65,
    ];

    List<double> precosIngressos = [
        30.0,
        25.0,
        20.0,
        35.0,
    ];
    List<String> sessoesValidasFinal = listarSessoesValidas(filmes, capacidadeSalas, ingressosVendidos);
    double valorArrecadado = calcularArrecadacaoValida(capacidadeSalas, ingressosVendidos, precosIngressos);
    int maiorIndiceArrecadado = encontrarIndiceMaiorArrecadacaoValida(capacidadeSalas, ingressosVendidos, precosIngressos);
    String maiorSessaoArrecadada = filmes[maiorIndiceArrecadado];
    int maiorOcupacaoIndice = encontrarIndiceMaiorOcupacao(capacidadeSalas, ingressosVendidos);
    String filmeOcupacao = filmes[maiorOcupacaoIndice];
    int sessoesLotadas = contarSessoesLotadas(capacidadeSalas, ingressosVendidos);
    int lugaresVaziosConta = calcularTotalLugaresVazios(capacidadeSalas, ingressosVendidos);
    int indiceMaiorVazio = encontrarIndiceMaisLugaresVazios(capacidadeSalas, ingressosVendidos);
    String filmeVazio = filmes[indiceMaiorVazio];
    print("Sessões válidas: $sessoesValidasFinal\nValor arrecadado: $valorArrecadado\nMaior arrecadação: $maiorSessaoArrecadada\nFilme com maior ocupação: $filmeOcupacao\nSalas lotadas: $sessoesLotadas\nLugares vazios que sobraram: $lugaresVaziosConta\nFilme com mais lugares vazios: $filmeVazio");
}


List<String> listarSessoesValidas(List<String> filmes, List<int> capacidadeSalas, List<int> ingressosVendidos){
    List<String> sessoesValidas = [];
    int posicao = 0;    
    for (int ingresso in ingressosVendidos){
        if (ingresso <= capacidadeSalas[posicao]){
            sessoesValidas.add(filmes[posicao]);
        }
        posicao += 1;
    }
    return sessoesValidas;
}

double calcularArrecadacaoValida(List<int> capacidadeSalas, List<int> ingressosVendidos, List<double> precosIngressos){
    double soma = 0; 
    int posicao = 0;  
    double total = 0;  
    for (int ingresso in ingressosVendidos){
        if (ingresso <= capacidadeSalas[posicao]){
            soma = ingresso * precosIngressos[posicao];
            total += soma;
        }
        posicao += 1;
    }
    return total;
}

int encontrarIndiceMaiorArrecadacaoValida(List<int> capacidadeSalas, List<int> ingressosVendidos, List<double> precosIngressos){
    double soma = 0; 
    double somaMaior = 0;
    int posicao = 0;  
    int posicaoMaiorIndice = 0;  
    for (int ingresso in ingressosVendidos){
        if (ingresso <= capacidadeSalas[posicao]){
            soma = ingresso * precosIngressos[posicao];
            if (soma > somaMaior){
                somaMaior = soma;
                posicaoMaiorIndice = posicao;
            }
        }
        posicao += 1;
    }
    return posicaoMaiorIndice;
}

int encontrarIndiceMaiorOcupacao(List<int> capacidadeSalas, List<int> ingressosVendidos){
    double ocupacao = 0; 
    double ocupacaoMaior = 0;
    int posicao = 0;  
    int posicaoMaiorOcupacao = 0;  
    for (int ingresso in ingressosVendidos){
        if (ingresso <= capacidadeSalas[posicao]){
            ocupacao = ingresso / capacidadeSalas[posicao];
            if (ocupacao > ocupacaoMaior){
                ocupacaoMaior = ocupacao;
                posicaoMaiorOcupacao = posicao;
            }
        }
        posicao += 1;
    }
    return posicaoMaiorOcupacao;
}

int contarSessoesLotadas(List<int> capacidadeSalas, List<int> ingressosVendidos){
    int posicao = 0;  
    int contador = 0;  
    for (int ingresso in ingressosVendidos){
        if (ingresso <= capacidadeSalas[posicao]){
            if (ingresso == capacidadeSalas[posicao]){
                contador += 1;
            }
        }
        posicao += 1;
    }
    return contador;
}

int calcularTotalLugaresVazios(List<int> capacidadeSalas, List<int> ingressosVendidos){
    int posicao = 0;  
    int lugaresVazios = 0;  
    int lugaresVaziosTotal = 0;  
    for (int ingresso in ingressosVendidos){
        if (ingresso <= capacidadeSalas[posicao]){
            lugaresVazios = capacidadeSalas[posicao] - ingresso;
            lugaresVaziosTotal += lugaresVazios;
        }
        posicao += 1;
    }
    return lugaresVaziosTotal;    
}

int encontrarIndiceMaisLugaresVazios(List<int> capacidadeSalas, List<int> ingressosVendidos){
    int posicao = 0;  
    int lugaresVazios = 0;  
    int lugaresVaziosTotal = 0; 
    int lugaresVaziosMaior = 0; 
    int posicaoMaiorVazio = 0;
    for (int ingresso in ingressosVendidos){
        if (ingresso <= capacidadeSalas[posicao]){
            lugaresVazios = capacidadeSalas[posicao] - ingresso;
            if (lugaresVazios > lugaresVaziosMaior){
                lugaresVaziosMaior = lugaresVazios;
                posicaoMaiorVazio = posicao;
            }
        }
        posicao += 1;
    }
    return posicaoMaiorVazio;     
}