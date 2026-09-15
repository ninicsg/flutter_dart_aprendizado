import 'dart:io';
import 'registro.dart';

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
    print("Digite o código:");
    String codigo = stdin.readLineSync() ?? '';
    print("Digite o novo nome");
    String novoNome = stdin.readLineSync() ?? '';
    Registro? achouCodigo = buscarPorCodigo(banco, codigo);
    if (achouCodigo != null){
        print(achouCodigo.nome);
        print(achouCodigo.numero);
        print(achouCodigo.codigo);
        bool alterou = editarNomePorCodigo(banco, codigo, novoNome);
        print(alterou);
        bool removeu = removerPorCodigo(banco, codigo);
        print(removeu);
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