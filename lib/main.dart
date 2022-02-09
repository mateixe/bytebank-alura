import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(primary:Colors.pinkAccent[700],secondary: Colors.lightBlue[500]),
              buttonTheme: ButtonThemeData(
                buttonColor: Colors.lightBlue[500]
              )
              ),
      home: ListaTransferencias(),
    );
  }
}

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
        appBar: AppBar(title: Text('Criando Transferência')),
        body: SingleChildScrollView(
          child: Column(
            children: [
              EditorTexto(
                  controlador: _numeroContaController,
                  rotulo: 'Número da Conta',
                  dica: '0000',
                  icone: null),
              EditorTexto(
                  controlador: _valorController,
                  rotulo: 'Valor',
                  dica: '0.00',
                  icone: Icons.monetization_on),
              ElevatedButton(
                  // style: ElevatedButton.styleFrom(
                  // ),
                  onPressed: () => _criaTransferencia(context),
                  child: Text('Confirmar'))
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

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia?> _transferencias = List.empty(growable: true);

  @override
  State<StatefulWidget> createState() {
    return ListaTransferenciasState();
  }
}

class ListaTransferenciasState extends State<ListaTransferencias> {
  @override
  Widget build(BuildContext context) {
    // widget._transferencias.add(Transferencia(100.00, 10000));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tranferências'),
      ),
      body: ListView.builder(
          itemCount: widget._transferencias.length,
          itemBuilder: (context, index) {
            final transferencia = widget._transferencias[index];
            return ItemTransferencia(transferencia!);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onPressedFloatingActionButton(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onPressedFloatingActionButton(BuildContext context) {
    final Future<Transferencia?> future =
        Navigator.push(context, MaterialPageRoute(builder: (context) {
      return FormularioTransferencia();
    }));

    future.then((transferenciaRecebida) {
      debugPrint("into the future");
      if (transferenciaRecebida != null) {
        setState(() {
          widget._transferencias.add(transferenciaRecebida);
        });
      }
    });
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
