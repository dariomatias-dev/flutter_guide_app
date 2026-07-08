import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

  Product({
    required this.id,
    required this.title,
    required this.description,
  });

  factory Product.fromJson(
    Map<String, dynamic> json,
  ) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }
  final int id;
  final String title;
  final String description;
}

/// Sample demonstrating `ScrollInfinitySample`.
class ScrollInfinitySample extends StatefulWidget {
  /// Creates a [ScrollInfinitySample].
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

    final data = response.data as Map<String, dynamic>;
    final products = data['products'] as List;

    return products
        .map((json) => Product.fromJson(json as Map<String, dynamic>))
        .toList();
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
              leading: Text('${index + 1}'),
              title: Text(product.title),
              subtitle: Text(product.description),
            );
          },
        ),
      ),
    );
  }
}
