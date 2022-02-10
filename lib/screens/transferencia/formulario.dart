import 'package:bytebank2/components/editor.dart';
import 'package:bytebank2/models/transferencia.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Criando Transferência';
const _rotuloNumeroConta = 'Número da Conta';
const _confirmar = 'Confirmar';
const _rotuloValor = 'Valor';
const _dicaConta = '0000';
const _dicaValor = '0.00';

class FormularioTransferencia extends StatefulWidget {
  FormularioTransferencia({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _numeroContaController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text(_tituloAppBar)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              EditorTexto(
                  controlador: _numeroContaController,
                  rotulo: _rotuloNumeroConta,
                  dica: _dicaConta,
                  icone: null),
              EditorTexto(
                  controlador: _valorController,
                  rotulo: _rotuloValor,
                  dica: _dicaValor,
                  icone: Icons.monetization_on),
              ElevatedButton(
                // style: ElevatedButton.styleFrom(
                // ),
                onPressed: () => _criaTransferencia(context),
                child: const Text(_confirmar),
              )
            ],
          ),
        ));
  }

  void _criaTransferencia(BuildContext context) {
    final int? numeroConta = int.tryParse(_numeroContaController.text);
    final double? valor = double.tryParse(_valorController.text);

    if (numeroConta != null && valor != null) {
      final transferenciaCriada = Transferencia(valor, numeroConta);
      Navigator.pop(context, transferenciaCriada);
    }
  }
}
