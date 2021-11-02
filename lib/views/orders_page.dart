import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/orders_item.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/widgets/drawer.dart';
import 'package:shop/widgets/order_widget.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
   
   var orders = Provider.of<OrderItem>(context);
  

    return Scaffold(
      drawer: AppDrawer(),
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