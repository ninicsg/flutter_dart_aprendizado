//60 — função que recebe lista e retorna média
void main(){
    List<double> media = [7.5, 8.0, 6.5, 9.0];
    double resultado = calcularMedia(media);
    print(resultado);
}

double calcularMedia(List<double> media){
    double mediaf = 0;
    for (double med in media ){
        mediaf += med;
    }
    return mediaf/media.length;
}