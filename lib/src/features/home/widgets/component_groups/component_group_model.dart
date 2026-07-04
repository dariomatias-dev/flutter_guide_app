import 'package:flutter/material.dart';

class ComponentGroupModel {
  const ComponentGroupModel({
    required this.icon,
    required this.title,
    required this.components,
  });

  final IconData icon;
  final String title;
  final List<String> components;
}
