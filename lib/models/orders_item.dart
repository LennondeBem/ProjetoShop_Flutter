import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order.dart';
import 'package:http/http.dart' as http;

class OrderItem with ChangeNotifier{

   final _baseUrl = 'https://shop-4769d-default-rtdb.firebaseio.com/orders';

  List<Order> _items = [];

  List<Order> get items => [..._items];

  int get itemsCount => _items.length;
   
  Future<void> addOrder(Cart cart) async { 
   var listProducts = cart.items.values.toList();


   print(listProducts);
  
      // notifyListeners();
    // var response = await http.post(Uri.parse('$_baseUrl.json'),
    // body: jsonEncode({
    //     'date': DateTime.now().toString(),
    //     'products': {'name': listProducts[]},
    //     'total': cart.totalAmount.toString()
    //     }
    //     )
    // );
    // print(response.body);
     _items.insert(
      0, 
      Order(
        id: Random().nextDouble().toString(),
        date: DateTime.now(),
        products: cart.items.values.toList(),
        total: cart.totalAmount,       
      )
      );
      notifyListeners();
  }

}