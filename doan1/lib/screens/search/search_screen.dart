import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final Function callbackSetNavbar;

  const SearchScreen({Key? key, required this.callbackSetNavbar})
      : super(key: key);

  @override
  createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Text('Search Screen')),
      ),
    );
  }
}