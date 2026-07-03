import 'package:flutter/material.dart';

class SearchFieldController {
  SearchFieldController({
    required this.searchClear,
  });

  final VoidCallback searchClear;

  final searchFieldController = TextEditingController();

  void searchFieldClear() {
    searchClear();
    searchFieldController.clear();
  }

  void dispose() {
    searchFieldController.dispose();
  }
}
