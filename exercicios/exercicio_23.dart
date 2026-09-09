//23 - criar uma função que recebe nome e idade e mostra os dois em uma frase.

void main(){
    String nome = "Nicole";
    int idade = 19;
    mostrarPessoa(nome, idade);
}
void mostrarPessoa(String nome, int idade){
    print("$nome tem $idade anos");
}