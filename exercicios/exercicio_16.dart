//16 - permitir entrada somente se a pessoa tiver 18 anos ou mais e não estiver bloqueada.

void main() {
    bool estaBloqueado = false;
    int idade = 18;
    if (!estaBloqueado && idade >= 18){
        print("Entrada permitida");
    } else{
        print("Entrada negada");
    }
}