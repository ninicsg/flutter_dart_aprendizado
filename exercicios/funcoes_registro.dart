import 'registro.dart';

bool textoValido(String nome) {
  if (nome.trim().length > 0) {
    return true;
  }

  return false;
}

bool numeroValido(String numero) {
  double? numeroConvertido =
      double.tryParse(numero.replaceAll(',', '.'));

  if (numeroConvertido != null) {
    return true;
  }

  return false;
}

bool codigoValido(String codigo) {
  if (codigo.trim().length > 0) {
    return true;
  }

  return false;
}

bool formularioValido(
  String nome,
  String numero,
  String codigo,
) {
  if (textoValido(nome) &&
      numeroValido(numero) &&
      codigoValido(codigo)) {
    return true;
  }

  return false;
}

List<String> validarFormulario(
  String nome,
  String numero,
  String codigo,
) {
  List<String> erros = [];

  if (!formularioValido(nome, numero, codigo)) {
    if (!textoValido(nome)) {
      erros.add("Nome inválido!");
    }

    if (!numeroValido(numero)) {
      erros.add("Numero inválido!");
    }

    if (!codigoValido(codigo)) {
      erros.add("Código inválido!");
    }
  }

  return erros;
}

bool podeSalvar(
  String nome,
  String numero,
  String codigo,
) {
  List<String> erros =
      validarFormulario(nome, numero, codigo);

  if (erros.isEmpty) {
    return true;
  }

  return false;
}

double converterNumero(String numero) {
  double numeroConvertido =
      double.parse(numero.replaceAll(',', '.'));

  return numeroConvertido;
}

Registro? criarRegistro(
  String nome,
  String numero,
  String codigo,
) {
  Registro? registro = null;

  if (podeSalvar(nome, numero, codigo)) {
    double numeroConvertido = converterNumero(numero);

    registro = Registro(
      nome,
      numeroConvertido,
      codigo,
    );

    return registro;
  }

  return null;
}

void salvarRegistro(
  Registro registro,
  List<Map<String, dynamic>> banco,
) {
  Map<String, dynamic> dados = registro.toMap();

  banco.add(dados);
}

void listarRegistros(
  List<Map<String, dynamic>> banco,
) {
  for (Map<String, dynamic> registro in banco) {
    print("Nome: ${registro['nome']}");
    print("Número: ${registro['numero']}");
    print("Código: ${registro['codigo']}");
    print("----------------");
  }
}

List<Registro> converterRegistrosDoBanco(
  List<Map<String, dynamic>> banco,
) {
  List<Registro> registros = [];

  for (Map<String, dynamic> dados in banco) {
    Registro registro = Registro.fromMap(dados);

    registros.add(registro);
  }

  return registros;
}