//62 — função que conta aprovados
void main(){
    List<double> notas = [7.5, 4.0, 8.0, 6.5, 9.0, 3.5];
    int resultado = contarAprovados(notas);
    print(resultado);
}

int contarAprovados(List<double> aaaa){
    int muitos = 0;
    for (double numero in aaaa ){
        if (numero >= 7){
            muitos += 1;
        }
    }
    return muitos;
}