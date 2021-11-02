import 'package:flutter/material.dart';
import 'package:shop/widgets/drawer.dart';

class ProductFormPage extends StatefulWidget {
  

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Formulário")
      )
    );
  }
}