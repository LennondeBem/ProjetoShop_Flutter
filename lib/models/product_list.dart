import 'package:flutter/material.dart';
import 'package:shop/data/dummy_products.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier{

  List<Product> _items = dummyProducts;
  
  List<Product> get items => [..._items];
  List<Product> get favoriteItems => _items.where((element) => element.isFavorite == true).toList();

  int get itemsCount => _items.length;


  void addProduct(Product product){
    _items.add(product);
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