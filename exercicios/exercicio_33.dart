//33 - encontrar e mostrar o último item da lista SEM USAR O .last

void main(){
    List<String> nomes = ["Nicole", "Nicollas", "Eduarda"];
    String nome_novo = "Joaozinho";
    nomes.add(nome_novo);
    int tam = nomes.length - 1;
    print(nomes[tam]);
}

