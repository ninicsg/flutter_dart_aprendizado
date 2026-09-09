class Registro {
  final int? id;
  final String texto;
  final double numero;
  final String? data;
  final String codigo;

  Registro({
    this.id,
    required this.texto,
    required this.numero,
    this.data,
    required this.codigo,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'texto': texto,
      'numero': numero,
      'data': data,
      'codigo': codigo,
    };
  }

  factory Registro.fromMap(Map<String, dynamic> map) {
    return Registro(
      id: map['id'] as int?,
      texto: map['texto'] as String,
      numero: (map['numero'] as num).toDouble(),
      data: map['data'] as String?,
      codigo: map['codigo'] as String,
    );
  }
}