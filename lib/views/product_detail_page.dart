import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:photo_view/photo_view.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

   var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height; 

  final Product product = ModalRoute.of(context).settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(product.name)),
      ),
      body: Column(
        children: [
          Container(
            height: height*0.4,
            width: width,
            child: PhotoView(
            imageProvider: NetworkImage(product.imageUrl)),
            ),
            SizedBox(height: height*0.01,),
            Text('R\$ ${product.price}',
            style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            Text(product.description),

        ],
      ),
    );
  }
}