import 'package:flutter/material.dart';
import 'package:shop/models/order.dart';
import 'package:intl/intl.dart';

class OrderWidget extends StatefulWidget {
  


  Order orders;
  
 OrderWidget({this.orders});

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;
  
  @override
  Widget build(BuildContext context) {


    return Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Chip(label: Text('R\$ ${widget.orders.total.toStringAsFixed(2)}')),
                        Text('${DateFormat('d/M/y H:m').format(widget.orders.date)}')
                      ],
                    ),
                    IconButton(icon:Icon(Icons.expand_more),
                     onPressed: (){
                      setState(() {
                        _expanded = !_expanded;
                      });
                      print(_expanded);
                     },)

                  ],
                ),
                 if(_expanded)Container(
                   margin: EdgeInsets.only(top:20),
                   height: 100,
                  child: ListView(
                    children: widget.orders.products.map((e) {
                     return Padding(
                       padding: const EdgeInsets.all(3),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(e.name,
                           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                           ),
                           Text('${e.quantity}X R\$${e.price}',
                           style: TextStyle(color: Colors.grey),
                           )
                         ],
                       ),
                     );
                    }).toList()
                     
                    
                    ),
                )
              ],
            ),
          ),
        );
  }
}