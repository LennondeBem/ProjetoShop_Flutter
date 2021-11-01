import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/orders_item.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/widgets/order_widget.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
   
   var orders = Provider.of<OrderItem>(context);
  

    return Scaffold(
      drawer: Drawer(
       child: Column(
         children:[
           DrawerHeader(child: Container(
             width: 1000,
             child: Column(
               children: [
                 
                 Row(
                   children: [
                     Text('DeBems',
                     style: TextStyle(
                     fontFamily: 'Sacramento',
                     fontSize: 50,
                     fontWeight: FontWeight.bold,
                     color: Colors.white,
                     shadows: [Shadow(color: Colors.black, blurRadius: 10,)]
                     ),
                     ),
                   ],
                 ),
                  Row(
                    children: [
                      Text('Loja virtual',
                 style: TextStyle(
                 fontFamily: 'Sacramento',
                 fontSize: 30,
                     color: Colors.white,
                     shadows: [Shadow(color: Colors.black, blurRadius: 10,)]
                 ),
                 ),
                    ],
                  ),
               ],
             )
             ),
           decoration: BoxDecoration(   
                  color: Colors.pink,
                  ),
           ),
          Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          Icon(Icons.storefront_sharp,
          size: 30,
          ),
          
          Padding(
            padding: const EdgeInsets.only(top: 7),
            child: Text('Loja',
            style: TextStyle(
                   fontSize: 20,
                   )
            ),
          ),
          Spacer(),
          IconButton(
          icon: Icon(Icons.navigate_next_sharp, size: 40,),
          onPressed: (){ Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);}),
          ],
          ),
            ),
           Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Icon(Icons.assignment_turned_in_rounded,
              size: 30,
              ),
              
              Padding(
                padding: const EdgeInsets.only(top: 7),
                child: Text('Meus Pedidos',
                style: TextStyle(
                       fontSize: 20,
                       )
                ),
              ),
              Spacer(),
              IconButton(
          icon: Icon(Icons.navigate_next_sharp, size: 40,),
          onPressed: (){ Navigator.of(context).pushReplacementNamed(AppRoutes.ORDERS);}),
              ],
              ),
          )
           
         ],
                ),
      ),
      appBar: AppBar(
        title: Text('Pedidos'),
      
      ),
      body: ListView.builder(
        itemCount: orders.itemsCount,
        itemBuilder: (ctx,index) => OrderWidget(orders: orders.items[index]) ,
      ),
    );
  }
}