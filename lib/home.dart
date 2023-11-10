import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final altura = TextEditingController();
  final peso = TextEditingController();
  String sexo = 'Homem';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Calculo IMC",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: sexo == 'Homem'
              ? const Color.fromARGB(255, 169, 209, 241)
              : const Color.fromARGB(255, 247, 114, 158),
        ),
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Sexo"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      sexo = "Homem";
                    });
                  },
                  child: const Text(
                    "Homem",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      sexo = "Mulher";
                    });
                  },
                  child: const Text(
                    "Mulher",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Sua altura"),
                const SizedBox(
                  width: 40,
                ),
                SizedBox(
                  width: 400,
                  child: TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    controller: altura,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Seu peso"),
                const SizedBox(
                  width: 40,
                ),
                SizedBox(
                  width: 400,
                  child: TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}')),
                    ],
                    controller: peso,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
              style: const ButtonStyle(
                padding: MaterialStatePropertyAll(
                  EdgeInsets.all(20),
                ),
                backgroundColor: MaterialStatePropertyAll(
                  Color(0xFF04e762),
                ),
                textStyle: MaterialStatePropertyAll(
                  TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () {
                calculateIMC();
              },
              child: const Text(
                "Calcular",
                style: TextStyle(color: Colors.black),
              ),
            ),
            const Row(),
          ],
        ),
      ),
    );
  }

  void calculateIMC() {
    try {
      double alturaValue = double.parse(altura.text);
      double pesoValue = double.parse(peso.text);

      if (alturaValue <= 0 || pesoValue <= 0) {
        showErrorMessage(
            'Por favor, insira valores positivos para peso e altura.');
        return;
      }

      double imc = pesoValue / (alturaValue * alturaValue);
      String resultado = interpretarResultadoIMC(imc);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: Text(
                'Resultado IMC',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            content: Text(
              'Seu IMC é: ${imc.toStringAsFixed(2)}\n\nResultado: $resultado',
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Fechar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Lidar com erro de conversão
      showErrorMessage(
          'Por favor, insira valores numéricos válidos para peso e altura.');
    }
  }

  String interpretarResultadoIMC(double imc) {
    String resultado = "";
    if (sexo == "Homem") {
      if (imc < 20.7) {
        resultado = "Abaixo do peso";
      } else if (imc < 26.4) {
        resultado = "Peso ideal";
      } else if (imc < 27.8) {
        resultado = "Pouco acima do peso";
      } else if (imc < 31.1) {
        resultado = "Acima do peso";
      } else if (31.2 < imc) {
        resultado = "Obesidade";
      }
    }
    if (sexo == "Mulher") {
      if (imc < 19.1) {
        resultado = "Abaixo do peso";
      } else if (imc < 25.8) {
        resultado = "Peso ideal";
      } else if (imc < 27.3) {
        resultado = "Pouco acima do peso";
      } else if (imc < 32.3) {
        resultado = "Acima do peso";
      } else if (32.4 < imc) {
        resultado = "Obesidade";
      }
    }
    return resultado;
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
