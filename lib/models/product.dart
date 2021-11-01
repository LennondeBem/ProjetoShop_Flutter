import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {

final String name;
final String id;
final String description;
final String imageUrl;
final double price;
bool isFavorite;

Product({
  @required this.name,
  @required this.id,
  @required this.description,
  @required this.price,
  @required this.imageUrl,
  this.isFavorite = false,
});

void toggleFavorite(){
  isFavorite = !isFavorite;
  notifyListeners();
}





}