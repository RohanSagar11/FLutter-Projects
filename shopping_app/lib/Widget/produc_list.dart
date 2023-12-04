import 'package:flutter/material.dart';
import 'package:shopping_app/Data/global_variable.dart';
import 'package:shopping_app/Widget/product_card.dart';
import 'package:shopping_app/Pages/product_details_page.dart';
import 'package:http/http.dart' as http;

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ['All', 'Addidas', 'Nike', 'Bata'];
  late String selectedfilter;
  final count1 = 1;
  final count2 = 2;
  final count3 = 3;
  final count = 0;

  @override
  void initState() {
    super.initState();
    selectedfilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
        borderSide: BorderSide(
          color: Color.fromRGBO(225, 225, 225, 1),
        ));

    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Shoes \nCollection ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
            ),
            Expanded(
                child: TextField(
              decoration: InputDecoration(
                border: border,
                enabledBorder: border,
                focusedBorder: border,
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            )),
          ],
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedfilter = filter;
                      });
                    },
                    child: Chip(
                        side: const BorderSide(
                          color: Color.fromRGBO(245, 247, 249, 1),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        backgroundColor: selectedfilter == filter
                            ? Theme.of(context).colorScheme.primary
                            : const Color.fromRGBO(245, 247, 249, 1),
                        labelStyle: const TextStyle(fontSize: 16),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        label: Text(filter)),
                  ),
                );
              }),
        ),
        Expanded(
          child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth > 950 && constraints.maxWidth < 1450) {
              return GridView.builder(
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ProductDetailsPage(product: product);
                        }));
                      },
                      child: ProductCard(
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: Image.network(product["imageUrl"] as String),
                        backgroundColor: index.isEven
                            ? const Color.fromRGBO(216, 240, 253, 1)
                            : const Color.fromRGBO(
                                245,
                                247,
                                249,
                                1,
                              ),
                      ),
                    );
                  });
            }
            if (constraints.maxWidth < 950) {
              return GridView.builder(
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.7,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ProductDetailsPage(product: product);
                        }));
                      },
                      child: ProductCard(
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: Image.network(product["imageUrl"] as String),
                        backgroundColor: index.isEven
                            ? const Color.fromRGBO(216, 240, 253, 1)
                            : const Color.fromRGBO(
                                245,
                                247,
                                249,
                                1,
                              ),
                      ),
                    );
                  });
            }
            return Expanded(
              child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return ProductDetailsPage(product: product);
                        }));
                      },
                      child: ProductCard(
                        title: product['title'] as String,
                        price: product['price'] as double,
                        image: Image.network(
                          product["imageUrl"] as String,
                          height: 175,
                        ),
                        backgroundColor: index.isEven
                            ? const Color.fromRGBO(216, 240, 253, 1)
                            : const Color.fromRGBO(
                                245,
                                247,
                                249,
                                1,
                              ),
                      ),
                    );
                  }),
            );
          }),
        ),
      ],
    );
  }
}
