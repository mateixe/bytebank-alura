import 'package:bytebank2/screens/transferencia/lista.dart';
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
              ),
              ),
      home: ListaTransferencias(),
    );
  }
}
