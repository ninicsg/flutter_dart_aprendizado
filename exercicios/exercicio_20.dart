//20 - liberar acesso total somente para "admin" com 18 anos ou mais.

void main() {
    String usuario = "admain";
    int idade = 18;
    if (usuario == "admin" && idade >= 18){
        print("Acesso total");
    } else{
        print("Acesso negado");
    }
}