import 'package:shop/models/cartI_tem.dart';

class Order {

final String id;
final double total;
final List<CartItem> products;
final DateTime date;

Order({this.id,this.total,this.products,this.date});



}