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
    print("Sessões válidas: $sessoesValidasFinal");
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