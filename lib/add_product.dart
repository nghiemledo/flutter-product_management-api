import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatelessWidget {
  AddProduct({Key? key}) : super(key: key);

  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _stockController = TextEditingController();

  Future<void> handleAddProduct(BuildContext context) async {
    var url =
    Uri.https('66fe56242b9aac9c997b6b32.mockapi.io', 'api/v1/products');
    var response = await http.post(url, body: {
      'name': _nameController.text,
      'price': _priceController.text,
      'stock': _stockController.text
    });

    if (response.statusCode == 201) {
      Navigator.pop(context, true);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2EDAD4),
        title: const Text('Add Product'),
      ),
      body: Column(
        children: [
          const SizedBox(width: 0.0, height: 15.0),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: _priceController,
            decoration: const InputDecoration(
              labelText: 'Price',
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: _stockController,
            decoration: const InputDecoration(
              labelText: 'Stock',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(width: 0.0, height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: const Text('Add product'),
                onPressed: () => handleAddProduct(context),
              ),
            ],
          )
        ],
      ),
    );
  }
}