import 'dart:io';
import 'registro.dart';
import 'funcoes_registro.dart';
void main(){
    List<Map<String, dynamic>> banco = [
        {
            'nome': 'Arroz',
            'numero': 25.0,
            'codigo': 'A001',
        },
        {
            'nome': 'Feijão',
            'numero': 12.0,
            'codigo': 'F002',
        },
        {
            'nome': 'Café',
            'numero': 18.0,
            'codigo': 'C003',
        },
    ];
    String opcaoMenu = mostrarMenu();
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
        print("Editar escolhido: ");
    }else if(opcaoMenu == '4'){
        print("Listar");
    }else if (opcaoMenu == '5'){
        print("Saindo...");
    }else{
        print("Opção inválida.");
    }
}

String mostrarMenu(){
    print("====MENU====\n1-Cadastrar\n2-Buscar\n3-Editar\n4-Listar\n5-Sair");
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
    Registro? registro = buscarPorCodigo(banco, codigo);
    return registro;
}

void executarEdicao(List<Map<String, dynamic>> banco) {
    print("Digite o código do produto que deseja editar: ");
    String codigo = stdin.readLineSync() ?? '';
    Registro? registro = buscarPorCodigo(banco, codigo);
    if (registro != null){
        print("Você deseja editar:\n1-NOME\n2-NUMERO");
        String opcao = stdin.readLineSync() ?? '';
        if (opcao == '1'){
            print("Digite o novo nome: ");
            String novoNome = stdin.readLineSync() ?? '';
            editarNomePorCodigo(banco, codigo, novoNome);
        }else if (opcao == '2'){
            print("Digite o novo número: ");
            String numeroDigitado = stdin.readLineSync() ?? '';
            double novoNumero = double.parse(numeroDigitado.replaceAll(',', '.'));
            editarNumeroPorCodigo(banco, codigo, novoNumero);
        }else{
            print("Opção inválida");
        }
    }else{
        print("Registro não encontrado");
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