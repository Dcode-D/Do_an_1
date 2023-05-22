import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),
      body: const Center(
        child: Text('Add Post'),
      ),);
  }
}