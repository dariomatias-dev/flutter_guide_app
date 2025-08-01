import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:scroll_infinity/scroll_infinity.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScrollInfinitySample(),
    ),
  );
}

class Product {
  final int id;
  final String title;
  final String description;

  Product({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Product.fromJson(
    Map<String, dynamic> json,
  ) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
    );
  }
}

class ScrollInfinitySample extends StatefulWidget {
  const ScrollInfinitySample({super.key});

  @override
  State<ScrollInfinitySample> createState() => _ScrollInfinitySampleState();
}

class _ScrollInfinitySampleState extends State<ScrollInfinitySample> {
  static const _limit = 10;
  final _dio = Dio();

  Future<List<Product>> _fetchProducts(int page) async {
    final skip = page * _limit;
    final response = await _dio.get(
      'https://dummyjson.com/products',
      queryParameters: {
        'limit': _limit,
        'skip': skip,
      },
    );

    final data = response.data;
    final List products = data['products'];

    return products.map((json) => Product.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ScrollInfinity<Product>(
          maxItems: _limit,
          loadData: _fetchProducts,
          itemBuilder: (product, index) {
            return ListTile(
              title: Text(product?.title ?? ''),
              subtitle: Text(product?.description ?? ''),
            );
          },
        ),
      ),
    );
  }
}
