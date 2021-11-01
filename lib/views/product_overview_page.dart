import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/widgets/cart_actionsBar.dart';
import '../widgets/product_grid.dart';

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
                   textDirection: TextDirection.rtl,
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