import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Tela1()));
}

class Tela1 extends StatelessWidget {
  const Tela1({super.key});

  @override
  Widget build(BuildContext context) {
    void trocarTela() {
      Navigator.push(
        // adiciona uma nova camada e vai para ela.
        context,
        MaterialPageRoute(
          builder: (context) {
            return Tela2();
          },
        ),
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: trocarTela,
            child: Text("Trocar para a tela 2"),
          ),
        ),
      ),
    );
  }
}

class Tela2 extends StatelessWidget {
  const Tela2({super.key});

  @override
  Widget build(BuildContext context) {
    void removerTela() {
      Navigator.pop(context); // remove a camada atual e volta para a anterior.
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: ElevatedButton(
            onPressed: removerTela,
            child: Text("Trocar para a tela 1"),
          ),
        ),
      ),
    );
  }
}
