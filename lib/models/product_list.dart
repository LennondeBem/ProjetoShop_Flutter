import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/dummy_products.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier{

  final urlBase = 'https://shop-4769d-default-rtdb.firebaseio.com';

  List<Product> _items = dummyProducts;
  
  List<Product> get items => [..._items];
  List<Product> get favoriteItems => _items.where((element) => element.isFavorite == true).toList();

  int get itemsCount => _items.length;

  void removeProduct(String id){
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void saveProduct(Map<String,Object> data){
    bool hasId = data['id'] != null;

    final product = Product(
      name:data['name'], 
      id: hasId ? data['id'] : Random().nextDouble().toString(), 
      description:data['description'], 
      price:data['price'] as double, 
      imageUrl:data['urlImage']);
  
      if(hasId){
        updateProduct(product);
      }else{
        addProduct(product);
      }


  }

  void updateProduct(Product product){
    int index = _items.indexWhere((element) => element.id == product.id);
    
    if(index >= 0){
      _items[index] = product;
      notifyListeners();
    }

  }

  void addProduct(Product product){
    http.post(
      Uri.parse('$urlBase/products.json'),
      body: jsonEncode({
        "name" : product.name,
        "description" : product.description,
        "price" : product.price,
        "imageUrl" : product.imageUrl,
        "isFavorite" : product.isFavorite,
      }
      )
    ).then((response){
        final id = jsonDecode(response.body)['name'];
       _items.add(Product(
         name: product.name,
          id: id,
           description:product.description, 
           price:product.price, 
           imageUrl:product.imageUrl,
           isFavorite: product.isFavorite,
           ));
       notifyListeners();
    } );
   
   
  }
  

}


 // bool _showFavoriteOnly = false;

//  void showFavoriteOnly(){
//    _showFavoriteOnly = true;
  // notifyListeners();
 // }

 // void showALL(){
 //   _showFavoriteOnly =false;
 //   no
 
 // List<Product> get items {
 //   if(_showFavoriteOnly){
 //    return _items.where((element) => element.isFavorite == true).toList();
 //   }
 //   return [..._items];
 // } 