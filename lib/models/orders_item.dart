import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cartI_tem.dart';
import 'package:shop/models/order.dart';
import 'package:http/http.dart' as http;

class OrderItem with ChangeNotifier {
  final _baseUrl = 'https://shop-4769d-default-rtdb.firebaseio.com/orders';

  List<Order> _items = [];

  List<Order> get items => [..._items];

  int get itemsCount => _items.length;

  Future<void> loadOrders() async {
    _items.clear();
    final response = await http.get(Uri.parse('$_baseUrl.json'));
    Map<String, dynamic> product = jsonDecode(response.body);

    if (response.body == 'null') {
      return;
    } else {
      print('>>>>>>>>>>>>>>>>>>>>>>>>>>');
      print(product);
      product.forEach((key, value) {
        
         _items.add(
           Order(
           id: key,
           date: DateTime.parse(value['date']),
           total: value['total'],
           products:  (value['products'] as List<dynamic>).map((e) => CartItem(
             id: e['id'], 
             productId: e['productId'], 
             name: e['name'], 
             quantity: e['quantity'], 
             price: e['price'])).toList(),     
        ));
       });
     print(_items);
     
    }
     notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    var listProducts = cart.items.values.toList();

    notifyListeners();
    var date = DateTime.now();
    var response = await http.post(Uri.parse('$_baseUrl.json'),
        body: jsonEncode({
          'total': cart.totalAmount.toDouble(),
          'date': date.toIso8601String(),
           'products':
            listProducts
              .map((cartitem) => {
                    'id': cartitem.id,
                    'productId': cartitem.productId,
                    'name': cartitem.name,
                    'quantity': cartitem.quantity,
                    'price': cartitem.price,
                  }).toList()
               
        }));

    final id = jsonDecode(response.body)['name'];
    _items.insert(
        0,
        Order(
          id: id,
          date: date,
          products: cart.items.values.toList(),
          total: cart.totalAmount,
        ));
    notifyListeners();
  }
}
