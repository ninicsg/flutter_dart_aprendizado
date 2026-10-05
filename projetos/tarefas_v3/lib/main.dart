import 'package:flutter/material.dart';

import 'database/banco_dados.dart';

// Importamos o arquivo que contém a configuração do banco Drift.
//
// É nesse arquivo que criamos a tabela Tarefas e a classe AppDatabase.
// O _MainAppState usa AppDatabase para inserir, consultar e excluir dados.

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final AppDatabase banco;
  // As tarefas ficam no SQLite através do Drift.
  // Atributo que guarda a instância do nosso banco de dados.
  //
  // late significa que vamos inicializar essa variável depois da criação
  // do objeto _MainAppState, no método initState().
  //
  // final significa que depois que recebermos um AppDatabase, não vamos
  // trocar essa variável por outro banco.

  final TextEditingController controladorTexto = TextEditingController();
  // Criando um objeto que controla o conteúdo do TextField

  @override
  void initState() {
    super.initState();

    banco = AppDatabase();
    // Criamos a nossa conexão com o banco.
    //
    // AppDatabase é a classe criada em banco_dados.dart.
    // Quando ela é instanciada, o Drift abre/prepara a conexão com o SQLite.
    //
    // Não colocamos AppDatabase() dentro do build() porque build() pode ser
    // executado várias vezes. Queremos uma única instância do banco para este
    // State, e por isso inicializamos aqui no initState().
  }

  Future<void> adicionarTarefa() async {
    // Função responsável por salvar uma nova tarefa no banco.
    //
    // Future<void> significa que a função realiza uma operação assíncrona e não
    // devolve um valor para quem chamou.
    //
    // O acesso ao banco é assíncrono, por isso usamos async/await.

    final texto = controladorTexto.text.trim();
    // Pegamos o texto atual do TextField através do TextEditingController.
    // trim() remove espaços que estejam no começo ou no final do texto.

    if (texto.isEmpty) return;
    // Se o usuário não digitou nada, não fazemos INSERT no banco.
    await banco
        .into(banco.tarefas)
        .insert(
          // Inserindo uma nova linha na tabela Tarefas.
          //
          // banco
          //   -> é a nossa instância de AppDatabase.
          //
          // banco.tarefas
          //   -> representa a tabela Tarefas definida em banco_dados.dart.
          //
          // into(...)
          //   -> informa ao Drift que queremos inserir um registro nessa tabela.
          //
          // insert(...)
          //   -> executa a operação de INSERT.
          TarefasCompanion.insert(
            // TarefasCompanion é uma classe gerada automaticamente pelo Drift.
            // Ela representa os valores que queremos enviar para uma operação
            // de escrita na tabela.
            //
            // Não precisamos informar o 'id' porque ele foi definido no banco
            // como autoIncrement(). O SQLite será responsável por gerar o ID.
            descricao: texto,
            // Aqui estamos dizendo que a coluna 'descricao' receberá o texto
            // digitado pelo usuário.
          ),
        );

    controladorTexto.clear();
    // Depois de salvar a tarefa no banco, limpamos o campo de texto.
  }

  Future<void> excluirTarefa(int id) async {
    // Função responsável por excluir uma tarefa do banco.
    // Recebemos o ID da tarefa que queremos excluir.
    await (banco.delete(
      banco.tarefas,
    )..where((tarefa) => tarefa.id.equals(id))).go();
    // banco.delete(banco.tarefas)
    //   -> informa ao Drift que queremos excluir registros da tabela Tarefas.
    //
    // where(...)
    //   -> define qual registro deve ser excluído.
    //
    // tarefa.id.equals(id)
    //   -> significa: encontre a linha cujo ID seja igual ao ID que recebemos.
    //
    // .go()
    //   -> executa a operação de DELETE.
  }

  @override
  void dispose() {
    controladorTexto.dispose();
    // Como o TextEditingController ocupa recursos, liberamos o objeto quando
    // o State deixar de existir.

    banco.close();
    // Fechamos a conexão do banco quando este State for destruído.
    // Isso libera os recursos usados pela conexão com o SQLite.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 0, 25, 255),
          title: const Text(
            "Minhas Tarefas",
            style: TextStyle(color: Colors.white),
          ),
        ),

        body: StreamBuilder(
          stream: banco.select(banco.tarefas).watch(),
          builder: (context, snapshot) {
            // Em vez de construirmos a lista a partir de
            // List<String> tarefas, agora observamos os dados do banco.
            //
            // StreamBuilder escuta um Stream e reconstrói sua parte da interface
            // quando o Stream envia novos dados.
            //
            // banco.select(banco.tarefas)
            //   -> cria uma consulta SELECT na tabela Tarefas.
            //
            // .watch()
            //   -> transforma a consulta em uma consulta observável.
            //      Quando a tabela mudar, o Drift envia um novo resultado pelo
            //      Stream.
            //
            // Assim, quando fazemos INSERT ou DELETE, não precisamos chamar
            // setState() para atualizar manualmente a lista.
            if (snapshot.hasError) {
              return const Center(child: Text("Erro ao carregar tarefas"));
            }
            // Se a consulta ao banco resultar em erro, mostramos uma mensagem
            // simples na tela.

            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            // Enquanto ainda não recebemos os dados da consulta, mostramos
            // um indicador de carregamento.

            final tarefas = snapshot.data!;
            // snapshot.data contém as linhas retornadas pelo SELECT.
            //
            // Diferente da List<String> antiga, cada 'tarefa' agora é um
            // registro da tabela Tarefas e possui campos como:
            //
            // tarefa.id
            // tarefa.descricao

            return ListView(
              scrollDirection: Axis.vertical,
              children: [
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 80.0),

                    CaixaInput(
                      controlador: controladorTexto,
                    ), // Passando o controlador do TextField para a CaixaInput

                    const SizedBox(width: 20.0),

                    // Passamos a função adicionarTarefa.
                    // Quando o botão for clicado, ela fará o INSERT no SQLite.
                    BotaoAdicionar(aoClicar: adicionarTarefa),
                  ],
                ),

                const SizedBox(height: 20.0),

                // Tarefa é uma linha da tabela Tarefas.
                for (final tarefa in tarefas)
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 70.0),

                        // Como tarefa agora é um registro do banco,
                        // precisamos acessar sua coluna descricao.
                        CaixaTarefa(texto: tarefa.descricao),

                        const SizedBox(width: 15.0),

                        BotaoExcluir(
                          aoExcluir: () {
                            // Passamos o ID desta linha para a função de
                            // exclusão.
                            //
                            // Dessa forma, o banco sabe exatamente qual tarefa
                            // deverá receber o DELETE.
                            excluirTarefa(tarefa.id);
                          },
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CaixaInput extends StatelessWidget {
  const CaixaInput({super.key, required this.controlador});

  final TextEditingController controlador;
  // Controlador usado para ler e alterar o texto digitado no TextField, ele é uma propriedade/atributo do meu widget

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: 400.0,
      color: const Color.fromARGB(255, 0, 60, 250),
      child: Center(
        child: TextField(
          controller: controlador,
          // Estou conectando a propriedade do meu widget a propriedade controller de TextField,
          // assim, quando eu crio o CaixaInput em _MainAppState passo o objeto TextEditingController que está dentro de controladorTexto
          // para a propriedade controlador de CaixaInput
          maxLength: 42,
          textAlign: TextAlign.center,
          cursorColor: Colors.white,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            counterStyle: TextStyle(color: Colors.white),
          ),
          autofocus: true,
          maxLines: 1,
          expands: false,
          enabled: true,
        ),
      ),
    );
  }
}

class BotaoAdicionar extends StatefulWidget {
  const BotaoAdicionar({super.key, required this.aoClicar});

  final VoidCallback aoClicar;
  // Propriedade do meu widget que guarda uma função que não recebe nem retorna nada,
  // é uma forma simplificada de: final void Function() aoClicar;

  @override
  State<BotaoAdicionar> createState() => _BotaoAdicionar();
}

class _BotaoAdicionar extends State<BotaoAdicionar> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.aoClicar,
      // Quando o botão for clicado, o ElevatedButton executará
      // a função recebida através de aoClicar.
      //
      // Neste projeto, aoClicar aponta para adicionarTarefa().
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 0, 60, 250),
        foregroundColor: Colors.white,
      ),
      child: const Text("+", style: TextStyle(fontSize: 26)),
    );
  }
}

class BotaoExcluir extends StatefulWidget {
  const BotaoExcluir({super.key, required this.aoExcluir});

  final VoidCallback aoExcluir;
  // Função que será executada quando o botão for clicado

  @override
  State<BotaoExcluir> createState() => _BotaoExcluir();
}

class _BotaoExcluir extends State<BotaoExcluir> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.aoExcluir,
      // Quando o botão for clicado, o ElevatedButton executará
      // a função recebida através de aoExcluir.
      //
      // Neste projeto, aoExcluir chama excluirTarefa(tarefa.id).
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 250, 0, 12),
        foregroundColor: Colors.white,
      ),
      child: const Text("-", style: TextStyle(fontSize: 26)),
    );
  }
}

class CaixaTarefa extends StatelessWidget {
  const CaixaTarefa({super.key, required this.texto});

  final String texto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60.0,
        width: 400.0,
        color: const Color.fromARGB(255, 0, 215, 250),
        child: Center(
          child: Text(texto, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}

// ============================================================
// RESUMO DAS ALTERAÇÕES FEITAS PARA USAR O DRIFT
// ============================================================
//
// ANTES, o aplicativo trabalhava assim:
//
// List<String> tarefas = [];
//
// Botão +
//    ↓
// setState()
//    ↓
// tarefas.add(...)
//    ↓
// lista em memória
//
// Se o aplicativo fosse fechado, os dados seriam perdidos.
//
// AGORA, o fluxo é:
//
// Botão +
//    ↓
// adicionarTarefa()
//    ↓
// TarefasCompanion.insert(...)
//    ↓
// Drift
//    ↓
// SQLite
//
// E para mostrar os dados:
//
// SQLite
//    ↓
// Drift
//    ↓
// select(...).watch()
//    ↓
// StreamBuilder
//    ↓
// widgets na tela
//
// Para excluir:
//
// Botão -
//    ↓
// excluirTarefa(tarefa.id)
//    ↓
// DELETE ... WHERE id = ...
//    ↓
// SQLite
//    ↓
// watch() percebe a mudança
//    ↓
// StreamBuilder recebe os novos dados
//    ↓
// tela atualizada
//
// Outra mudança importante é que não precisamos mais utilizar setState()
// para adicionar ou remover itens da lista. O banco passou a ser a fonte
// dos dados e o StreamBuilder acompanha as alterações feitas pelo Drift.
//
// O arquivo banco_dados.g.dart é gerado automaticamente pelo Drift/build_runner.
// Não devemos editar esse arquivo manualmente.
//
// Quando alterarmos banco_dados.dart, devemos executar novamente:
//
// dart run build_runner build
