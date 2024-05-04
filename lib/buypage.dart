import 'package:flutter/material.dart';
import 'package:japfood/ConvertedApi.dart';

class buypage extends StatefulWidget {
  const buypage(
      {Key? key,
      required ConvertedApi apiList,
      required int result,
      required int initialCount})
      : super(key: key);

  @override
  State<buypage> createState() => _buypageState();
}

class _buypageState extends State<buypage> {
  List<ConvertedApi> selectedProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: selectedProducts.length,
        itemBuilder: (context, index) {
          final product = selectedProducts[index];
          return ListTile(
            title: Text(product.name ?? ''),
            subtitle: Text('Price: ₹${product.price ?? "0"}'),
            // You can add more details here if needed
          );
        },
      ),
    );
  }

  void addToCart(ConvertedApi product) {
    setState(() {
      selectedProducts.add(product);
    });
  }
}
