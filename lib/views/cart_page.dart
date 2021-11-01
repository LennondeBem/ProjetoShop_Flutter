import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/orders_item.dart';
import 'package:shop/widgets/cart_item_widget.dart';

class CartPage extends StatelessWidget {


List<String> timeline= ['amarelo','amarelo', 'vermelho'];

  @override
  Widget build(BuildContext context) {

    var amarelo = timeline.map((e) => e.indexOf('amarelo'));

   

    print(amarelo);
    
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    var cart = Provider.of<Cart>(context);
    final items = cart.items.values.toList();

    var order =  Provider.of<OrderItem>(context);


    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.only(left: width*0.23),
          child: Text('carrinho')),
      ),
      body: Column(
        children:[
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
               Text('Total', style: TextStyle(
                 fontSize: 20,
                 ),),
               SizedBox(width: width*0.01),
               Chip(
                 label: Text('R\$ ${cart.totalAmount.toStringAsFixed(2)}'),
                 backgroundColor: Theme.of(context).primaryColor),
               Spacer(),
               TextButton(
                 child: Text('COMPRAR'),
                 onPressed: (){
                  order.addOrder(cart);
                  cart.clear();
                 },)
               
                ]
              ),
            ),
            ),
            Container(
              height: height*0.4,
                          child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CartItemWidget(cartItem: items[index]),
                  );
                },
              ),
            )
        ]
      )
    );
  }
}