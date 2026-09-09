//13 - permitir entrada somente se a pessoa tiver 18 anos ou mais e tiver documento.

void main() {
    int idade = 19;
    bool temDocumento = true;
    if (idade >= 18 && temDocumento){
        print("Pode entrar");
    } else{
        print("Não pode entrar");
    }
}