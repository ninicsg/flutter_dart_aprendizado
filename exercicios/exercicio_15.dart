//15 - liberar acesso somente se a pessoa não estiver bloqueada.

void main() {
    bool estaBloqueado = true;
    if (!estaBloqueado){
        print("Acesso liberado");
    } else{
        print("Acesso negado");
    }
}