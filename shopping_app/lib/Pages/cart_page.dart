import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/Data/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Cart',
          style: Theme.of(context).textTheme.titleLarge,
        )),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final cartItem = cart[index];
          return ListTile(
            trailing: IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Remove Product',
                              style: Theme.of(context).textTheme.titleMedium),
                          content: const Text(
                              'Are You sure you want to Remove the Product from Your Cart'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Provider.of<CartProvider>(context,
                                          listen: false)
                                      .removeProduct(cartItem);
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'No',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ))
                          ],
                        );
                      });
                },
                icon: const Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                  size: 30,
                )),
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30,
              backgroundImage: NetworkImage(cartItem["imageUrl"] as String),
            ),
            title: Text(
              cartItem['title'].toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            subtitle: Text('Size: ${cartItem['size']}'),
          );
        },
      ),
    );
  }
}
