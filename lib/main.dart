import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  FormularioTransferencia({Key? key}) : super(key: key);

  final TextEditingController _numeroContaController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Criando Transferência')),
        body: Column(
          children: [
            EditorTexto(
                controlador:_numeroContaController, rotulo:'Número da Conta', dica:'0000', icone:null),
            EditorTexto(
                controlador:_valorController, rotulo:'Valor', dica:'0.00', icone:Icons.monetization_on),
            ElevatedButton(
                // style: ElevatedButton.styleFrom(
                // ),
                onPressed: () => _criaTransferencia(),
                child: Text('Confirmar'))
          ],
        ));
  }

  void _criaTransferencia() {
    final int? numeroConta =
        int.tryParse(_numeroContaController.text);
    final double? valor = double.tryParse(_valorController.text);

    if (numeroConta != null && valor != null) {
      final transferenciaCriada =
          Transferencia(valor, numeroConta);
      debugPrint('$transferenciaCriada');
    }
  }
}

class EditorTexto extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;

  EditorTexto({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
            icon: Icon(icone), labelText: rotulo, hintText: dica),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tranferências'),
      ),
      body: Column(children: [
        ItemTransferencia(Transferencia(100.25, 154785659)),
        ItemTransferencia(Transferencia(200.50, 154785659)),
        ItemTransferencia(Transferencia(300.0, 154785659)),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}
