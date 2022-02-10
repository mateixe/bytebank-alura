import 'package:bytebank2/models/transferencia.dart';
import 'package:flutter/material.dart';
import 'formulario.dart';

const _tituloAppBar = 'Tranferências';

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
        title: const Text(_tituloAppBar),
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