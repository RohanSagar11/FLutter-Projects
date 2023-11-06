import 'package:flutter/material.dart';
import 'package:testproject/curreny_converter_Material_Page.dart';

void main() {
  runApp(const CurrencyConverter());
}

//Mainly there are two design schemes.
// Material App
// Cupertino App

class CurrencyConverter extends StatelessWidget {
  const CurrencyConverter({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CurrencyConverterMaterialPage(),
    );
  }
}
