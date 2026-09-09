//31 - adicionar um novo nome em uma lista já criada.

void main(){
    List<String> nomes = ["Nicole", "Nicollas", "Eduarda"];
    print(nomes[0]);
    print(nomes[1]);
    print(nomes[2]);
    String nome_novo = "Joaozinho";
    nomes.add(nome_novo);
    print(nomes[3]);
}

