import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatefulWidget {
  
  final Product product;

  ProductItem({
    @required this.product,
  });

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {

    var productlist = Provider.of<ProductList>(context, listen: false);

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.product.imageUrl),
      ),
      title: Text(widget.product.name),
      trailing: Container(
        width: width*0.24,
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.edit, color: Theme.of(context).primaryColor,),
             onPressed: (){
              Navigator.of(context).pushNamed(AppRoutes.FORM,
              arguments: widget.product
              );
             }
             ),
             IconButton(
            icon: Icon(Icons.delete, color: Theme.of(context).errorColor,),
             onPressed: (){ 
               showDialog<bool>(
            context: context,  
            builder:(ctx) => AlertDialog(
              title: Text('Tem Certeza?'),
              actions: [
              TextButton(
                 child: Text('NÃO'),
                onPressed: (){
                 Navigator.of(context).pop(false);
                },),
                TextButton(
                 child: Text('SIM'),
                onPressed: (){
                 Navigator.of(context).pop(true);
                },)
              ])
            ).then((value) => {
              if(value){
              productlist.removeProduct(widget.product.id)
              }
            }); 
             }
             
             ), 
        ],
      ),
      ) ,
    );
  }
}