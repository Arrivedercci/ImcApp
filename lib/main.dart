import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
      child: MaterialApp(
        title: 'ImcApp',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late TextEditingController alturaController;

  late TextEditingController pesoController;

  String? imc;
  String? descricao;

  @override
  void initState() {
    super.initState();
    alturaController = TextEditingController();
    pesoController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Peso(kg)'),
            controller: pesoController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Altura(cm)'),
            controller: alturaController,
          ),
          ImcButton(onPressed: calcularImc, labelText: 'Calcular'),
          ImcButton(onPressed: resetar, labelText: 'Resetar'),
          if (imc != null) Text(imc!),
          if (descricao != null) Text(descricao!)
        ]),
      ),
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
      ),
    );
  }

  void calcularImc() {
    FocusScope.of(context).requestFocus(FocusNode());
    final peso = double.parse(pesoController.text);
    final altura = double.parse(alturaController.text) / 100;
    final localImc = peso / (altura * altura);

    if (localImc < 18.6) {
      setState(() {
        imc = localImc.toStringAsFixed(1);
        descricao = 'Abaixo do Peso';
      });
    } else if (localImc < 24.8) {
      setState(() {
        imc = localImc.toStringAsFixed(1);
        descricao = 'Peso Ideal';
      });
    } else if (localImc < 29.8) {
      setState(() {
        imc = localImc.toStringAsFixed(1);
        descricao = 'Levemente acima do peso';
      });
    } else if (localImc < 34.8) {
      setState(() {
        imc = localImc.toStringAsFixed(1);
        descricao = 'Obesidade I';
      });
    } else if (localImc < 39.8) {
      setState(() {
        imc = localImc.toStringAsFixed(1);
        descricao = 'Obesidade II';
      });
    } else {
      setState(() {
        imc = localImc.toStringAsFixed(1);
        descricao = 'Obesidade III';
      });
    }
  }

  void resetar() {
    pesoController.clear();
    alturaController.clear();
    descricao = null;
    imc = null;

    setState(() {});
  }
}

class ImcButton extends StatelessWidget {
  final String labelText;
  final VoidCallback onPressed;
  const ImcButton({
    Key? key,
    required this.labelText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
        onPressed: onPressed,
        child: Text(
          labelText,
          style: TextStyle(color: Colors.white),
        ));
  }
}
