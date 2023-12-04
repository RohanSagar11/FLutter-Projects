import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/Data/cart_provider.dart';
import 'package:shopping_app/Pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shopping App',
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 20,
            color: Colors.black,
          )),
          textTheme: const TextTheme(
              titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              bodySmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              titleMedium:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          inputDecorationTheme: const InputDecorationTheme(
              prefixIconColor: Color.fromRGBO(119, 119, 119, 1),
              hintStyle: TextStyle(fontWeight: FontWeight.bold)),
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSeed(
              primary: Colors.yellow, seedColor: Colors.yellow),
        ),
        home: const HomePage(),
      ),
    );
  }
}
