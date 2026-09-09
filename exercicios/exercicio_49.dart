// 49 - transformar lista de nomes

void main(){
    List<String> nomes = ["Nicole", "Ana", "João"];
    List<String> nomesComSaudacao = [];
    for (final nome in nomes){
        String nomes2 = "Olá $nome";
        nomesComSaudacao.add(nomes2);
    }
    print(nomesComSaudacao);
}