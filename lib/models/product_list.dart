import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier{

  final _baseUrl = 'https://shop-4769d-default-rtdb.firebaseio.com/products';
 

  List<Product> _items = [];
  
  List<Product> get items => [..._items];
  List<Product> get favoriteItems => _items.where((element) => element.isFavorite == true).toList();


  Future<void> loadProducts() async {
    _items.clear();
    final response = await http.get(Uri.parse('$_baseUrl.json'));
     Map<String,dynamic> product = jsonDecode(response.body);
 
     if(product == null){
       return;
     }else{
     product.forEach((key, value) {
       _items.add(
        Product(
          id: key.toString(),
          name: value['name'],
          description: value['description'], 
          price: value['price'], 
          imageUrl: value['imageUrl'],
          isFavorite: value['isFavorite'],
          )
       );
     });
     }
    notifyListeners();
  }

  int get itemsCount => _items.length;

  Future<void> removeProduct(String id) async {
   int index = _items.indexWhere((element) => element.id == id);
   var product = _items[index];

   if(index >= 0){

    _items.removeAt(index);
    notifyListeners();

    http.Response response = 
    await http.delete(Uri.parse('$_baseUrl/${id.toString()}.json'));

    if(response.statusCode >= 400){
      _items.insert(index, product);
      notifyListeners();
    }

   }
    
  }

  Future<void> saveProduct(Map<String,Object> data){
    bool hasId = data['id'] != null;

    final product = Product(
      name:data['name'], 
      id: hasId ? data['id'] : Random().nextDouble().toString(), 
      description:data['description'], 
      price:data['price'] as double, 
      imageUrl:data['urlImage']);
  
      if(hasId){
       return updateProduct(product);
      }else{
       return addProduct(product);
      }


  }

  Future<void> updateProduct(Product product) async {
    int index = _items.indexWhere((element) => element.id == product.id);
    
    if(index >= 0){
      await http.patch(
      Uri.parse('$_baseUrl/${product.id}.json'),
      body: jsonEncode({
        "name" : product.name,
        "description" : product.description,
        "price" : product.price,
        "imageUrl" : product.imageUrl,
      }
      ) 
    );
      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> addProduct(Product product) async{
    final response = await http.post(
      Uri.parse('$_baseUrl.json'),
      body: jsonEncode({
        "name" : product.name,
        "description" : product.description,
        "price" : product.price,
        "imageUrl" : product.imageUrl,
        "isFavorite" : product.isFavorite,
      }
      ) 
    );
    
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