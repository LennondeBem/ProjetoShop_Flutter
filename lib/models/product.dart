import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {

  final _baseUrl = 'https://shop-4769d-default-rtdb.firebaseio.com/products';

final String name;
final String id;
final String description;
final String imageUrl;
final double price;
bool isFavorite;

Product({
  @required this.name,
  this.id,
  @required this.description,
  @required this.price,
  @required this.imageUrl,
  this.isFavorite = false,
});

void _toggleFavorite(){
  isFavorite = !isFavorite;
  notifyListeners();
}

Future<void> toggleFavorite(Product product, BuildContext context) async {

  try {
  _toggleFavorite();

  var response = await http.patch(Uri.parse('$_baseUrl/${product.id}.json'
  ),
 body: jsonEncode({
        "isFavorite" : isFavorite
      }
      ) 
  );
  
  if(response.statusCode >= 400){
      _toggleFavorite();
      Scaffold.of(context).showSnackBar(
        SnackBar(content: Text('Error ao inserir produto como favorito'))
      );
  }
  } catch (_){
       _toggleFavorite();
  }
}





}