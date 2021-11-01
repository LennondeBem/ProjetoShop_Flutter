import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:shop/models/cartI_tem.dart';
import 'package:shop/models/product.dart';

class Cart with ChangeNotifier {

 Map<String, CartItem> _items = {};

 Map<String, CartItem> get items => {..._items};

 void removeItem(String productId){
   _items.remove(productId);
   notifyListeners();
 }

 void clear(){
   _items = {};
   notifyListeners();
 }

 int get itemsCount => _items.length;

 double get totalAmount{
  double total = 0.0;
  _items.forEach((key, value) {
   total+= value.price * value.quantity;
  });
  return total;
 }

 void removeSingleItem(String productId){
    if(!_items.containsKey(productId)){
      return;
    }
    if(_items[productId].quantity == 1){
      return removeItem(productId);
    }else{
      _items.update(productId, (value) =>
       CartItem(
         id: value.id,
         productId: value.productId, 
         name: value.name, 
         quantity: value.quantity - 1, 
         price: value.price)
       );
    }
    notifyListeners();
 }

 void addItem(Product productId){
   if(_items.containsKey(productId.id)){
     _items.update(productId.id, (value) => CartItem(
      id: value.id,
      productId: value.productId, 
      name: value.name, 
      quantity: value.quantity + 1, 
      price: value.price,
      ) 
      ); 
   }else{
     _items.putIfAbsent(productId.id, () => CartItem(
       id: Random().nextDouble().toString() , 
       productId: productId.id, 
       name: productId.name, 
       quantity: 1, 
       price: productId.price,
       ));
   }
  notifyListeners();
 }
 




}