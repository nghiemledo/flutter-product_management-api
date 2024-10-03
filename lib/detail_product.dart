import 'package:flutter/material.dart';

class DetailProduct extends StatelessWidget {
  dynamic _product;
  DetailProduct({Key? key, required product}) : _product = product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Detail product'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              _product['id'],
              textScaler: TextScaler.linear(2),
            ),
            Text(
              _product['name'],
              textScaler: TextScaler.linear(2),
            ),
            Text(
              _product['price'],
              textScaler: TextScaler.linear(2),
            ),
            Text(
              _product['stock'].toString(),
              textScaler: TextScaler.linear(2),
            ),
            Text(
              _product['createdAt'],
              textScaler: TextScaler.linear(2),
            ),
          ],
        ),
      ),
    );
  }
}