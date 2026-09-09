//34 - remover um nome específico da lista e mostrar o resultado.

void main(){
    List<String> nomes = ["Nicole", "Nicollas", "Eduarda"];
    print(nomes[0]);
    print(nomes[1]);
    print(nomes[2]);
    nomes.remove("Eduarda");
    print(nomes);
}

