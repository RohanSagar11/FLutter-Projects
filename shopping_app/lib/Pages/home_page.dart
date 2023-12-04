import 'package:flutter/material.dart';
import 'package:shopping_app/Pages/cart_page.dart';
import 'package:shopping_app/Widget/produc_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  List<Widget> pages = [
    const ProductList(),
    const CartPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
                selectedFontSize: 0,
                unselectedFontSize: 0,
                iconSize: 35,
                onTap: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                currentIndex: currentPage,
                items: const [
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart), label: ''),
                ]),
            body: IndexedStack(
              index: currentPage,
              children: pages,
            )));
  }
}
