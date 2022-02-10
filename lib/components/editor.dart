import 'package:flutter/material.dart';

class EditorTexto extends StatelessWidget {
  final TextEditingController? controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;

  EditorTexto({
    this.controlador,
    this.rotulo,
    this.dica,
    this.icone,
  });

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
