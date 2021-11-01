import 'package:flutter/material.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/cartI_tem.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {

  final CartItem cartItem;

  const CartItemWidget({@required this.cartItem, Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
          confirmDismiss: (_) => showDialog<bool>(
            context: context,  
            builder:(ctx) => AlertDialog(
              title: Text('Tem Certeza?'),
              actions: [
              TextButton(
                 child: Text('NÂO'),
                onPressed: (){
                 Navigator.of(context).pop(false);
                },),
                TextButton(
                 child: Text('SIM'),
                onPressed: (){
                 Navigator.of(context).pop(true);
                },)
              ])
            ),
          key: ValueKey(cartItem.id),
          direction: DismissDirection.endToStart,
          background: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container( 
                      margin: EdgeInsets.symmetric(vertical: 10),
                   alignment: Alignment.centerRight,       
                   color: Colors.red,
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Icon(Icons.delete, size: 40, color: Colors.white,),
                   ),
            ),
          ),
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 10),      
        child:Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              child: FittedBox(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(cartItem.price.toString()),
              ))
              ),
              title: Column(
                children:[
                  Text(cartItem.name),
                  Text("Total R\$ ${(cartItem.price*cartItem.quantity).toStringAsFixed(2)}"),
                ]
              ),
              trailing: Text('${cartItem.quantity}X') ,
          ),
        )
          ),
          onDismissed: (_){
           Provider.of<Cart>(context, listen: false).removeItem(cartItem.productId);
          },
    );
  }
}