class Registro {
  String nome;
  double numero;
  String codigo;

  Registro(this.nome, this.numero, this.codigo);

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'numero': numero,
      'codigo': codigo,
    };
  }

  factory Registro.fromMap(Map<String, dynamic> dados) {
    return Registro(
      dados['nome'],
      dados['numero'],
      dados['codigo'],
    );
  }
}