import 'package:flutter/material.dart';

class CurrencyConverterMaterialPage extends StatefulWidget {
  const CurrencyConverterMaterialPage({super.key});

  @override
  State<CurrencyConverterMaterialPage> createState() =>
      _CurrencyConverterMaterialPageState();
}

class _CurrencyConverterMaterialPageState
    extends State<CurrencyConverterMaterialPage> {
  double result = 0;
  final TextEditingController textEditingController = TextEditingController();
  // 1. Create a variable that stores the converted currency value
  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          style: BorderStyle.solid,
          color: Colors.black,
        ),
        borderRadius: BorderRadius.all(Radius.circular(40)));
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 240, 196, 52),
          title: const Text(
            "Currency Converter",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'INR $result',
                style:
                    const TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: textEditingController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.attach_money),
                      hintText: "Enter the Amount to Convert in INR",
                      hintStyle: TextStyle(color: Colors.black),
                      fillColor: Colors.amberAccent,
                      focusedBorder: border,
                      enabledBorder: border,
                      filled: true,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        result = double.parse(textEditingController.text) * 81;
                      });
                    },
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40))),
                      minimumSize: const MaterialStatePropertyAll(
                          Size(double.infinity, 50)),
                      foregroundColor:
                          const MaterialStatePropertyAll(Colors.black),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.amberAccent),
                    ),
                    child: const Text(
                      "Convert",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      selectionColor: Colors.deepOrange,
                    )),
              ),
            ],
          ),
        ));
  }
}
