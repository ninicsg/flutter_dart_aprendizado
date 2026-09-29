import 'dart:io';
import 'dart:convert';
import 'registro.dart';
import 'funcoes_registro.dart';
Future<void> main() async {
    List<Map<String, dynamic>> banco = carregarBanco();
    String opcaoMenu = '';
    while (opcaoMenu != '6') {
        opcaoMenu = mostrarMenu();
        if (opcaoMenu == '1'){
            executarCadastro(banco);
        }else if (opcaoMenu == '2'){
            Registro? resultado = executarBusca(banco);
            if (resultado != null){
                print(resultado.nome);
                print(resultado.numero);
                print(resultado.codigo);
            }else{
                print("Registro não encontrado");
            }
        }else if(opcaoMenu == '3'){
            executarEdicao(banco);
        }else if(opcaoMenu == '4'){
            listarRegistros(banco);
        }else if(opcaoMenu == '5'){
            int qtd = quantidadeRegistros(banco);
            print("Quantidade de registros: ${qtd}");
        }else if (opcaoMenu == '6'){
            print("Saindo...");
        }else{
            print("Opção inválida.");
        }
    }
}

String mostrarMenu(){
    print("====MENU====\n1-Cadastrar\n2-Buscar\n3-Editar\n4-Listar\n5-Mostrar quantidade de registros\n6-Sair");
    String opcao = stdin.readLineSync() ?? '';
    return opcao;
}

void executarCadastro(List<Map<String, dynamic>> banco) {
    print("Digite o nome: ");
    String nome = stdin.readLineSync() ?? '';
    print("Digite o número: ");
    String numero = stdin.readLineSync() ?? '';
    print("Digite o código: ");
    String codigo = stdin.readLineSync() ?? '';
    Registro? cadastro = criarRegistro(nome, numero, codigo);
    if (cadastro != null){
        if (!codigoJaExiste(banco, codigo)){
            print("Código disponível");
            cadastrarRegistro(banco, cadastro);
            salvarBancoEmArquivo(banco);
            print("Registro cadastrado com sucesso!");
            listarRegistros(banco);
        }else{
            print("Código já está sendo utilizado");
        }
        
    }else{
        print("Registro inválido!");
    }
}

Registro? executarBusca(List<Map<String, dynamic>> banco) {
    print("Digite o código que deseja buscar:");
    String codigo = stdin.readLineSync() ?? '';
    if (codigoValido(codigo)){
        Registro? registro = buscarPorCodigo(banco, codigo);
        return registro;
    }else{
        print("Codigo invalido!");
        return null;
    }
}

double? tentarConverterNumero(String texto) {
    double? convertido = double.tryParse(texto.replaceAll(',', '.'));
    return convertido;
}

void executarEdicao(List<Map<String, dynamic>> banco) {
    print("Digite o código do produto que deseja editar: ");
    String codigo = stdin.readLineSync() ?? '';
    if (codigoValido(codigo)){
        Registro? registro = buscarPorCodigo(banco, codigo);
        if (registro != null){
            print("Registro encontrado: \nNome: ${registro.nome}\nNúmero: ${registro.numero}\nCódigo: ${registro.codigo}");
            print("Você deseja editar:\n1-NOME\n2-NUMERO");
            String opcao = stdin.readLineSync() ?? '';
            if (opcao == '1'){
                print("Digite o novo nome: ");
                String novoNome = stdin.readLineSync() ?? '';
                if (textoValido(novoNome)){
                    if (valorFoiAlterado(registro.nome, novoNome)){
                        bool confirmou = confirmarAlteracao(registro.nome, novoNome);
                        if (confirmou) {
                            bool editou = editarNomePorCodigo(banco, codigo, novoNome);
                            if (editou){
                                salvarBancoEmArquivo(banco);
                                print("Nome alterado com sucesso");
                            }else{
                                print("Falha ao editar");
                            } 
                        }else{
                            print("Edição cancelada");
                        }
                    }
                } else {
                    print("Nome inválido");
                }   
            }else if (opcao == '2'){
                print("Digite o novo número: ");
                String numeroDigitado = stdin.readLineSync() ?? '';
                double? novoNumero = tentarConverterNumero(numeroDigitado);
                if (novoNumero != null){
                    if (valorFoiAlterado(registro.numero.toString(), novoNumero.toString())){
                        bool confirmou = confirmarAlteracao(registro.numero.toString(), novoNumero.toString());
                        if (confirmou) {
                            bool editou = editarNumeroPorCodigo(banco, codigo, novoNumero);
                            if (editou){
                                salvarBancoEmArquivo(banco);
                                print("Numero alterado com sucesso");
                            }else{
                                print("Falha ao editar");
                            }
                        }else{
                            print("Edição cancelada");
                        }
                    }
                } else {
                    print("Número inválido");
                }
            }else{
                print("Opção inválida");
            }
        }else{
            print("Registro não encontrado");
        }
    } else {
        print("Código inválido");
    }
}

Registro? buscarPorCodigo(List<Map<String, dynamic>> banco,String codigo){
    for (Map<String, dynamic> dados in banco) {
        if (dados['codigo'] == codigo){
            Registro registro = Registro.fromMap(dados);
            return registro;
        }
    }
    return null;
}
bool confirmarAlteracao(String valorAntigo, String valorNovo) {
    print("Alteração:");
    print("$valorAntigo → $valorNovo");
    print("Confirmar alteração?\n1-Sim\n2-Não");
    String opcao = stdin.readLineSync() ?? '';
    if (opcao == '1'){
        return true;
    }else{
        print("Valor mantido: $valorAntigo");
        return false;
    }
}

bool removerPorCodigo(List<Map<String, dynamic>> banco, String codigo){
    int posicao = 0;
    for (Map<String, dynamic> dados in banco) {
        if (dados['codigo'] == codigo){
            banco.removeAt(posicao);
            return true;
        }
        posicao += 1;
    }
    return false;
}

bool editarNomePorCodigo(List<Map<String, dynamic>> banco, String codigo, String novoNome){
    for (Map<String, dynamic> dados in banco) {
        if (dados['codigo'] == codigo){
            dados['nome'] = novoNome;
            return true;
        }
    }
    return false;    
}

bool valorFoiAlterado(String valorAntigo,String valorNovo) {
    if (valorAntigo == valorNovo){
        print("O valor novo não pode ser igual ao antigo.");
        return false;
    }
    return true;
}

bool editarNumeroPorCodigo(List<Map<String, dynamic>> banco,String codigo,double novoNumero){
    for (Map<String, dynamic> dados in banco) {
        if (dados['codigo'] == codigo){
            dados['numero'] = novoNumero;
            return true;
        }
    }
    return false;      
}

void cadastrarRegistro(List<Map<String, dynamic>> banco, Registro registro){
    Map<String, dynamic> dados = registro.toMap();
    banco.add(dados);
}

bool codigoJaExiste(List<Map<String, dynamic>> banco,String codigo){
    for (Map<String, dynamic> dados in banco) {
        if (dados['codigo'] == codigo){
            return true;
        }
    }
    return false;    
}

int quantidadeRegistros(List<Map<String, dynamic>> banco) {
    int tamanho = banco.length;
    return tamanho;
}

String bancoParaTexto(List<Map<String, dynamic>> banco) {
    String texto = jsonEncode(banco);
    return texto;
}

void salvarBancoEmArquivo(List<Map<String, dynamic>> banco) {
    File arquivo = File('banco.json');
    String texto = bancoParaTexto(banco);
    arquivo.writeAsStringSync(texto);
}

String lerBancoDoArquivo() {
    File arquivo = File('banco.json');
    String texto = arquivo.readAsStringSync();
    return texto;
}

dynamic textoParaDados(String texto) {
    dynamic dados = jsonDecode(texto);
    return dados;

}

void mostrarTipoDosDados(dynamic dados) {
    print(dados.runtimeType);
}

List<Map<String, dynamic>> converterDadosParaBanco(dynamic dados) {
    List<Map<String, dynamic>> banco = List<Map<String, dynamic>>.from(dados);
    return banco;
}

List<Map<String, dynamic>> carregarBanco() {
    File arquivo = File('banco.json');
    if (!arquivo.existsSync()){
        List<Map<String, dynamic>> banco = [];
        return banco;
    }
    String texto = lerBancoDoArquivo();
    if (texto.trim().isEmpty){
        List<Map<String, dynamic>> banco = [];
        return banco;
    }
    try{
        dynamic dados = textoParaDados(texto);
        List<Map<String, dynamic>> banco = converterDadosParaBanco(dados);
        return banco;
    } catch(erro){
        print("Erro!");
        List<Map<String, dynamic>> banco = [];
        return banco;
    }
}


Future<String> lerBancoDoArquivoAsync() async {
  File arquivo = File('banco.json');
  String texto = await arquivo.readAsString();
  return texto;
}

Future<void> testarLeituraAsync() async {
    String texto = await lerBancoDoArquivoAsync(); 
    print(texto);
}