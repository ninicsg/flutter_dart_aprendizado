// 51 — contar quantas vezes um nome aparece

void main(){
    List<String> nomes = ["Ana", "Nicole", "Ana", "João", "Ana"];
    String nomeProcurado = "Ana";
    int contador = 0;
    for (final nome in nomes){
        if(nome == nomeProcurado){
            contador += 1;
        }
    }
    print(contador);
}