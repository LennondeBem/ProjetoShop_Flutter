import 'package:flutter/material.dart';

import 'package:shop/widgets/cart_actionsBar.dart';
import '../widgets/product_grid.dart';
import 'package:shop/widgets/drawer.dart';

 enum FilterOption {
  Favorite,
  All,
  }

class ProductOverviewPage extends StatefulWidget {

  

  @override
  _ProductOverviewPageState createState() => _ProductOverviewPageState();
}

class _ProductOverviewPageState extends State<ProductOverviewPage> {

  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {

   
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            onSelected: (FilterOption value){
                if(value == FilterOption.Favorite){
                  setState(() {
                      _showFavoriteOnly = true;
                  });
                }else{
                  setState(() {
                    _showFavoriteOnly = false;
                  });
                }
                },
            color: Colors.pink[300],
            itemBuilder: (_)=> [
            PopupMenuItem(
              child: Text('Somente Favoritos'),
              value: FilterOption.Favorite,
              ),
              PopupMenuItem(
              child: Text('Todos'),
              value: FilterOption.All,
              )
              ]),
              CartActionBar()
             
        ],
        title: Center(child: Text('Minha Loja')),
      ),
      body: ProductGrid(_showFavoriteOnly),
    );
  }
}

//onPressed: (){
//             Navigator.of(context).pushNamed(AppRoutes.ORDERS);
//           }