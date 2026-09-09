//38 - percorrer uma lista e contar manualmente quantos itens existem, sem usar length.

void main(){
    List<String> nomes = ["Nicole", "Nicollas", "Eduarda", "Joao"];
    int contador = 0;
    for (final nome in nomes){
        contador += 1;
    }
    print(contador);
}
