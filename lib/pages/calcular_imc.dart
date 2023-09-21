import 'package:calculadoraimc/model/imc.dart';
import 'package:calculadoraimc/repositories/imc_repository.dart';
import 'package:calculadoraimc/shared/widgets/text_label.dart';
import 'package:flutter/material.dart';

class CalcularImcPage extends StatefulWidget {
  const CalcularImcPage({super.key});

  @override
  State<CalcularImcPage> createState() => _CalcularImcPageState();
}

class _CalcularImcPageState extends State<CalcularImcPage> {
  IMC imc = IMC(0, 0);
  List<IMC> _results = [];

  var pesoController = TextEditingController(text: "");
  var alturaController = TextEditingController(text: "");
  var imcRepository = ImcRepository();
  var resultadoImc = "";

  @override
  void initState() {
    super.initState();
    obterIMC();
  }

  void obterIMC() {
    _results = imcRepository.listar();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Calculando o Índice de Massa Corporal",
            style: TextStyle(
              fontSize: 18.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: const Icon(
            Icons.calculate_outlined,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          child: Column(
            children: [
              const TextLabel(
                texto: "Peso",
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: pesoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: "Digite o seu peso",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ))),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    imc.peso = double.tryParse(value) ?? 0.0;
                  } else {
                    imc.peso = 0.0;
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              const TextLabel(
                texto: "Altura",
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: alturaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    hintText: "Digite a sua altura",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ))),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    imc.altura = double.tryParse(value) ?? 0.0;
                  } else {
                    imc.altura = 0.0;
                  }
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
                  IMC novoImc = IMC(
                    imc.peso,
                    imc.altura,
                  );
                  novoImc.calcularIMC();
                  _results.add(novoImc);
                  setState(() {});
                  if (_results.isNotEmpty && _results.last.calcularIMC() < 16) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      "DIAGNÓSTICO: Magreza Grave",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                      textAlign: TextAlign.center,
                    )));
                    return;
                  } else if (_results.isNotEmpty &&
                      _results.last.calcularIMC() >= 16 &&
                      _results.last.calcularIMC() < 17) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      "DIAGNÓSTICO: Magreza Moderada",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                      textAlign: TextAlign.center,
                    )));
                    return;
                  } else if (_results.isNotEmpty &&
                      _results.last.calcularIMC() >= 17 &&
                      _results.last.calcularIMC() < 18.5) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      "DIAGNÓSTICO: Magreza Leve",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent),
                      textAlign: TextAlign.center,
                    )));
                    return;
                  } else if (_results.isNotEmpty &&
                      _results.last.calcularIMC() >= 18.5 &&
                      _results.last.calcularIMC() < 25) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      "DIAGNÓSTICO: Saudável",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent),
                      textAlign: TextAlign.center,
                    )));
                    return;
                  } else if (_results.isNotEmpty &&
                      _results.last.calcularIMC() >= 25 &&
                      _results.last.calcularIMC() < 30) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      "DIAGNÓSTICO: Sobrepeso",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber),
                      textAlign: TextAlign.center,
                    )));
                    return;
                  } else if (_results.isNotEmpty &&
                      _results.last.calcularIMC() >= 30 &&
                      _results.last.calcularIMC() < 35) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      "DIAGNÓSTICO: Obesidade Grau I",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent),
                      textAlign: TextAlign.center,
                    )));
                    return;
                  } else if (_results.isNotEmpty &&
                      _results.last.calcularIMC() >= 35 &&
                      _results.last.calcularIMC() <= 40) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      "DIAGNÓSTICO: Obesidade Grau II",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrangeAccent),
                      textAlign: TextAlign.center,
                    )));
                    return;
                  } else if (_results.isNotEmpty &&
                      _results.last.calcularIMC() > 40) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                      "DIAGNÓSTICO: Obesidade Grau III",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                      textAlign: TextAlign.center,
                    )));
                    return;
                  }
                },
                child: const Text(
                  "Calcular",
                  style: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (BuildContext bc, int index) {
                    return ListTile(
                      title: Text(
                        "${_results[index].peso} kg - ${_results[index].altura} cm - IMC: ${_results[index].calcularIMC().toStringAsFixed(2)},",
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
              Center(
                child: Text(
                  "Seu imc atual é ${imc.calcularIMC().toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.yellowAccent,
          onPressed: () {
            setState(() {
              _results.clear();
              pesoController.clear();
              alturaController.clear();
            });
          },
          tooltip: "Limpar",
          child: const Text("Limpar",
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ),
      ),
    );
  }
}
