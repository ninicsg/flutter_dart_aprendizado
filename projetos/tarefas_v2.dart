import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  List<String> tarefas = [];
  final TextEditingController controladorTexto = TextEditingController();
  // Criando um objeto que controla o conteúdo do TextField

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
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 80.0),
                CaixaInput(
                  controlador: controladorTexto,
                ), // Passando o controlador do TextField para a CaixaInput
                SizedBox(width: 20.0),
                BotaoAdicionar(
                  aoClicar: () {
                    // Essa é a minha função que não recebe nada e nem retorna nada
                    setState(() {
                      tarefas.add(controladorTexto.text);
                      controladorTexto.clear();
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),
            for (var (index, tarefa) in tarefas.indexed)
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 70.0),
                    CaixaTarefa(texto: tarefa),
                    SizedBox(width: 15.0),
                    BotaoExcluir(
                      aoExcluir: () {
                        setState(() {
                          tarefas.removeAt(index);
                        });
                      },
                    ),
                  ],
                ),
              ),
          ],
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
      // a função recebida através de aoClicar, que no caso é toda a parte do () { setState { ...
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

// O aplicativo começa criando um TextEditingController() dentro da variável controladorTexto.

// Depois, quando criamos o CaixaInput dentro do _MainAppState,
// passamos o objeto que está dentro de controladorTexto para a propriedade controlador do CaixaInput.

// Dentro do CaixaInput, usamos: controller: controlador
// Isso conecta a propriedade controlador do nosso widget à propriedade controller do TextField.

// Dessa forma, o mesmo objeto TextEditingController que foi criado em controladorTexto chega até o TextField.
// Assim, o controller consegue acompanhar o texto que está sendo digitado e também pode alterar o texto do TextField.
