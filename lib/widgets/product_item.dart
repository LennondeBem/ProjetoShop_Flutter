import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductItem extends StatelessWidget {
  
  final Product product;

  ProductItem({
    @required this.product,
  });

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: Container(
        width: width*0.24,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.edit),
             onPressed: (){}
             ),
             IconButton(
            icon: Icon(Icons.delete),
             onPressed: (){}
             ), 
        ],
      ),
      ) ,
    );
  }
}