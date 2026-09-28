// Essa é a primeira versão do projeto para aprendizado,
// será feita outra versão com um botão para adicionar as tarefas e um botão para exclusão das tarefas.

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

  void adicionarTarefa(String textoDigitado) {
    // Função que não retorna nada, apenas recebe uma String através do parâmetro textoDigitado.
    setState(() {
      tarefas.add(textoDigitado);
    });
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
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(height: 20.0),
            Center(child: CaixaInput(aoEnviar: adicionarTarefa)),
            // aoEnviar é uma variável que recebe uma função, estou colocando adicionarTarefa dentro dela."
            SizedBox(height: 20.0),
            for (var tarefa in tarefas)
              Align(
                alignment: Alignment.center,
                child: CaixaTarefa(texto: tarefa),
              ),
          ],
        ),
      ),
    );
  }
}

class CaixaInput extends StatelessWidget {
  const CaixaInput({super.key, required this.aoEnviar});

  final ValueChanged<String> aoEnviar;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      width: 400.0,
      color: const Color.fromARGB(255, 0, 60, 250),
      child: Center(
        child: TextField(
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
          onSubmitted: aoEnviar,
          // Quando o TextField receber Enter, execute a função
          // que está guardada em aoEnviar.
        ),
      ),
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

// CaixaInput(
//   aoEnviar: adicionarTarefa
// )
//        │
//        ▼
// aoEnviar ───────────> adicionarTarefa

// TextField(
//   onSubmitted: aoEnviar
// )
//        │
//        ▼
// onSubmitted ────────> aoEnviar ───────> adicionarTarefa

// Usuário aperta Enter
//        │
//        ▼
// TextField chama:
// onSubmitted("Estudar Flutter")
//        │
//        ▼
// aoEnviar("Estudar Flutter")
//        │
//        ▼
// adicionarTarefa("Estudar Flutter")
//        │
//        ▼
// textoDigitado = "Estudar Flutter"
//        │
//        ▼
// setState()
