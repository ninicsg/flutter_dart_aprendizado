import 'package:flutter/material.dart';

import '../models/registro.dart';
import '../services/database_service.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final textoController = TextEditingController();
  final numeroController = TextEditingController();
  final dataController = TextEditingController();
  final codigoController = TextEditingController();

  List<Registro> registros = [];

  @override
  void initState() {
    super.initState();
    carregarRegistros();
  }

  Future<void> carregarRegistros() async {
    final lista = await DatabaseService.listarRegistros();

    if (!mounted) {
      return;
    }

    setState(() {
      registros = lista;
    });
  }

  Future<void> salvarRegistro() async {
    if (textoController.text.isEmpty ||
        numeroController.text.isEmpty ||
        codigoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha os campos obrigatórios'),
        ),
      );

      return;
    }

    final numero = double.tryParse(
      numeroController.text.replaceAll(',', '.'),
    );

    if (numero == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Digite um número válido'),
        ),
      );

      return;
    }

    final registro = Registro(
      texto: textoController.text,
      numero: numero,
      data: dataController.text.isEmpty
          ? null
          : dataController.text,
      codigo: codigoController.text,
    );

    await DatabaseService.inserirRegistro(registro);

    await carregarRegistros();

    textoController.clear();
    numeroController.clear();
    dataController.clear();
    codigoController.clear();

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Registro salvo'),
      ),
    );
  }

  @override
  void dispose() {
    textoController.dispose();
    numeroController.dispose();
    dataController.dispose();
    codigoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: textoController,
              decoration: const InputDecoration(
                labelText: 'Texto',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: numeroController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Número',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: dataController,
              decoration: const InputDecoration(
                labelText: 'Data',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: codigoController,
              decoration: const InputDecoration(
                labelText: 'Código de barras / QR Code',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: salvarRegistro,
                child: const Text('Salvar'),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Registros salvos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            if (registros.isEmpty)
              const Text('Nenhum registro salvo ainda'),

            ...registros.map(
              (registro) => Card(
                child: ListTile(
                  title: Text(registro.texto),
                  subtitle: Text(
                    'Número: ${registro.numero}\n'
                    'Data: ${registro.data ?? '-'}\n'
                    'Código: ${registro.codigo}',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}