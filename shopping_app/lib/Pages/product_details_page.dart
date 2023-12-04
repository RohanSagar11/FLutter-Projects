import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/Data/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;
  const ProductDetailsPage({super.key, required this.product});
  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedsize = 0;
  void onTap() {
    if (selectedsize != 0) {
      Provider.of<CartProvider>(context, listen: false).addProduct({
        'id': widget.product['id'],
        'title': widget.product['title'],
        'price': widget.product['price'],
        'imageUrl': widget.product["imageUrl"],
        'company': widget.product['company'],
        'size': selectedsize,
      });
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product Added Succesfully')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please! Select the Size')));
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.product['imageUrl']);
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Details')),
        ),
        body: Column(
          children: [
            Center(
              child: Text(
                widget.product['title'] as String,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: 1000,
              height: 250,
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.network(widget.product["imageUrl"] as String)),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(245, 247, 249, 1)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text('\$${widget.product['price']}',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: GestureDetector(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              (widget.product['sizes'] as List<int>).length,
                          itemBuilder: (context, index) {
                            final size =
                                (widget.product['sizes'] as List<int>)[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedsize = size;
                                  });
                                },
                                child: Chip(
                                    backgroundColor: selectedsize == size
                                        ? Theme.of(context).colorScheme.primary
                                        : null,
                                    label: Text(
                                      size.toString(),
                                    )),
                              ),
                            );
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(350, 50),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: onTap,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Add to Cart',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
