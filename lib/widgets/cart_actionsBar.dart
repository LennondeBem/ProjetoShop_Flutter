import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/utils/app_routes.dart';

class CartActionBar extends StatelessWidget {
  const CartActionBar({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

     var cart = Provider.of<Cart>(context, listen: false);
     
    return  Padding(
                padding: EdgeInsets.only(right: width*0.03, top: width*0.02 ),
                child: Center(
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: height*0.1,
                        width: width*0.1,
                        child: IconButton(
                          icon: Icon(Icons.shopping_cart), 
                          onPressed: (){
                            Navigator.of(context).pushNamed(AppRoutes.CART);
                          },),
                      ),
                      CircleAvatar(
                        maxRadius: 11,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                        maxRadius: 10, 
                        backgroundColor: Theme.of(context).accentColor,
                        child: Consumer<Cart>(
                          builder: (ctx, cart,_) => Text(cart.itemsCount.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                            ),
                            ),
                        ),
                        ))
                      
                      ]),
                ),
              );
  }
}