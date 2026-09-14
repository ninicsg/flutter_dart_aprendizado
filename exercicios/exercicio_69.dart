import 'dart:io';

class Registro {
    String nome;
    double numero;
    String codigo;
    Registro(this.nome, this.numero, this.codigo);
    Map<String, dynamic> toMap(){
        return{
            'nome': nome,
            'numero': numero,
            'codigo': codigo,
        };
    }
    factory Registro.fromMap(Map<String, dynamic> dados){
        Registro registro = Registro(dados['nome'], dados['numero'], dados['codigo']);
        return registro;
    }
}

void main(){
    print("Digite seu nome:");
    String nome = stdin.readLineSync() ?? '';
    print("Digite um numero:");
    String numero = stdin.readLineSync() ?? '';
    print("Digite um código:");
    String codigo = stdin.readLineSync() ?? '';
    Registro? novoRegistro = criarRegistro(nome, numero, codigo);
    bool ehValido = textoValido(nome);
    bool numeroEhValido = numeroValido(numero);
    bool codigoEhValido = codigoValido(codigo);
    bool formularioEhValido = formularioValido(nome, numero, codigo);
    List<String> errosValidados = validarFormulario(nome, numero, codigo);
    bool seraQSalva = podeSalvar(nome, numero, codigo);
    List<Map<String, dynamic>> bancoDados = [];
    Map<String, dynamic> dados = {
        'nome': 'Nicole',
        'numero': 12.5,
        'codigo': 'ABC123',
    };
    Registro registroDoMap = Registro.fromMap(dados);
    List<Registro> registrosConvertidos = converterRegistrosDoBanco(bancoDados);
    print(registroDoMap.nome);
    print(registroDoMap.numero);
    print(registroDoMap.codigo);
    print("Nome é válido: $ehValido\nNúmero é válido: $numeroEhValido\nCódigo é válido: $codigoEhValido\nFormulário é válido: $formularioEhValido\nResultado: $errosValidados\nSerá que salva: $seraQSalva");
    if (novoRegistro != null) {
        print("Registro criado com sucesso!");

        print(novoRegistro.nome);
        print(novoRegistro.numero);
        print(novoRegistro.codigo);

        salvarRegistro(novoRegistro, bancoDados);
        listarRegistros(bancoDados);
        for (Registro registro in registrosConvertidos) {
            print(registro.nome);
            print(registro.numero);
            print(registro.codigo);
        }
    } else {
        print("Não foi possível criar o registro.");
        print(validarFormulario(nome, numero, codigo));
    }
}

bool textoValido(String nome){
    if (nome.trim().length > 0){
        return true;
    }
    return false;
}

bool numeroValido(String numero){
    double? numeroValido = double.tryParse(numero.replaceAll(',', '.'));
    if (numeroValido != null){
        return true;
    }
    return false;
}
bool codigoValido(String codigo){
    if (codigo.trim().length > 0){
        return true;
    }
    return false;
}

bool formularioValido(String nome, String numero, String codigo){
    if (textoValido(nome) && numeroValido(numero) && codigoValido(codigo)){
        return true;
    }
    return false;
}

List<String> validarFormulario(String nome, String numero, String codigo){
    List<String> erros = [];
    if (!formularioValido(nome, numero, codigo)){
        if (!textoValido(nome)){
            erros.add("Nome inválido!");
        }
        if (!numeroValido(numero)){
            erros.add("Numero inválido!");
        }
        if (!codigoValido(codigo)){
            erros.add("Código inválido!");
        }
    }
    return erros;
}

bool podeSalvar(String nome, String numero, String codigo){
    List<String> erros = validarFormulario(nome, numero, codigo);
    if (erros.isEmpty){
        return true;
    }
    return false;
}

double converterNumero(String numero){
    double numeroConvertido = double.parse(numero.replaceAll(',', '.'));
    return numeroConvertido;
}

Registro? criarRegistro(String nome, String numero, String codigo){
    Registro? registro = null;
    if (podeSalvar(nome, numero, codigo)){
        double numeroConvertido = converterNumero(numero);
        registro = Registro(nome, numeroConvertido, codigo);
        return registro;
    }
    return null;
}

void salvarRegistro(Registro registro, List<Map<String, dynamic>> banco){
    Map<String, dynamic> dados = registro.toMap();
    print(dados);
    banco.add(dados);
    print(banco);
}

void listarRegistros(List<Map<String, dynamic>> banco) {
  for (Map<String, dynamic> registro in banco) {
    print("Nome: ${registro['nome']}");
    print("Número: ${registro['numero']}");
    print("Código: ${registro['codigo']}");
    print("----------------");
  }
}

List<Registro> converterRegistrosDoBanco(List<Map<String, dynamic>> banco) {
  List<Registro> registros = [];

  for (Map<String, dynamic> dados in banco) {
    Registro registro = Registro.fromMap(dados);
    registros.add(registro);
  }

  return registros;
}