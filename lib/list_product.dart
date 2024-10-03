import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:schoolexam/detail_product.dart';
import 'package:http/http.dart' as http;
import 'package:schoolexam/detail_product.dart';

class ListProducts extends StatefulWidget {
  const ListProducts({Key? key}) : super(key: key);

  @override
  _listProductState createState() => _listProductState();
}

class _listProductState extends State<ListProducts> {
  bool isLoading = true;
  List<dynamic> _products = [];
  List<dynamic> _foundProducts = [];
  TextEditingController _searchInputController = TextEditingController();

  @override
  void initState() {
    super.initState();

    loadProductData();

    _searchInputController.addListener(_filterProducts);
  }

  Future<void> loadProductData() async {
    var url = Uri.https('66fe56242b9aac9c997b6b32.mockapi.io', 'api/v1/products');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        _products = json.decode(response.body);
        _foundProducts = _products;
        isLoading = false;
      });
    } else {
      throw Exception('Get products failed');
    }
  }

  void _filterProducts() {
    String query = _searchInputController.text.toLowerCase();
    setState(() {
      _foundProducts = _products.where((product) {
        return product['name'].toLowerCase().contains(query) ||
            product['price']?.toLowerCase()?.contains(query) ?? false;
      }).toList();
    });
  }

  void onTapProduct(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailProduct(product: _foundProducts[index])),
    );
  }

  Future<void> handleDeleteProduct(int index) async {
    var url = Uri.https('66fe56242b9aac9c997b6b32.mockapi.io',
        'api/v1/products/${_foundProducts[index]['id']}');
    var response = await http.delete(url);

    if (response.statusCode == 200) {
      setState(() {
        _products.removeAt(index);
        _foundProducts.removeAt(index);
      });
    } else {
      throw Exception('Delete product failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return  Center(child: CircularProgressIndicator());
    }
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchInputController,
              decoration: const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _foundProducts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => onTapProduct(context, index),
                  child: Card(
                    elevation: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Text(
                              _foundProducts[index]['name'],
                              textScaleFactor: 1.5,
                            ),
                            Text(_foundProducts[index]['price'] ?? 'Null'),
                            Text(_foundProducts[index]['stock'] ?? '1'),
                            Text(_foundProducts[index]['createdAt'] ?? 'Null'),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => handleDeleteProduct(index),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}