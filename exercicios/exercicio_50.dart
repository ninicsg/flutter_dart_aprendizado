// 50 — procurar um nome na lista

void main(){
    List<String> nomes = ["Nicole", "Ana", "João", "Eduarda"];
    String nomeProcurado = "João";
    bool encontrou = false;
    for (final nome in nomes){
        if(nome == nomeProcurado){
            encontrou = true;
        }
    }
    if (encontrou){
        print("Nome encontrado");
    }else{
        print("Nome não encontrado");
    }
}