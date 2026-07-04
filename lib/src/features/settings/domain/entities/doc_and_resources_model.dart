import 'package:flutter/material.dart';

class DocAndResourcesModel {
  const DocAndResourcesModel({
    required this.name,
    required this.icon,
    required this.url,
  });

  final String name;
  final IconData icon;
  final String url;
}
