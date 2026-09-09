// 54 — separar aprovados e reprovados

void main(){
    List<double> notas = [7.5, 4.0, 8.0, 6.5, 9.0, 3.5];
    List<double> notasAprovados = [];
    List<double> notasReprovados = [];
    for (final nota in notas){
        if (nota >= 7){
            notasAprovados.add(nota);
        }else{
            notasReprovados.add(nota);
        }
    }
    print("Aprovadas: $notasAprovados\nReprovadas: $notasReprovados");
}