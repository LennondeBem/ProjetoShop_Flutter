import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product.dart';
import 'package:shop/utils/app_routes.dart';


class ProductGridItem extends StatefulWidget {


  @override
  _ProductGridItemState createState() => _ProductGridItemState();
}

class _ProductGridItemState extends State<ProductGridItem> {


  @override
  Widget build(BuildContext context) {
    
    
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: 200,
                                    height: 150,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushNamed(
                        AppRoutes.PRODUCT_DETAIL,
                        arguments: product,
                        );
                    },
                    child: Image.network(product.imageUrl, fit: BoxFit.cover,))
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                    child: Container(
                    height: 50,
                    color:Colors.black87,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      Consumer<Product>(
                          builder:(ctx,product,_) => IconButton(
                          icon: product.isFavorite ? Icon(Icons.favorite):Icon(Icons.favorite_border),
                           color: Theme.of(context).accentColor,
                           onPressed: (){
                             product.toggleFavorite();
                             print(product.isFavorite);
                           },),
                      ),
                      Text(
                        product.name,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                         ),
                      IconButton(
                        icon: Icon(Icons.shopping_cart_rounded), 
                        color: Theme.of(context).accentColor,
                        onPressed: (){
                          Scaffold.of(context).hideCurrentSnackBar();
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                             content: Text('Compra Realizada com sucesso!'),
                             action: SnackBarAction(label: 'CANCELAR',
                             onPressed: (){
                               cart.removeSingleItem(product.id);
                             }),
                            ));
                          cart.addItem(product);
                        },),
                      ]
                    ),
                  ),
                )
      ]
    );
  }
}