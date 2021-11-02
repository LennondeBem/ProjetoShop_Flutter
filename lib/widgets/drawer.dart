import 'package:flutter/material.dart';
import 'package:shop/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                  color: Theme.of(context).primaryColor,
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
          Divider(),
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
          ),
           Divider(),
           Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Icon(Icons.edit,
              size: 30,
              ),
              
              Padding(
                padding: const EdgeInsets.only(top: 7),
                child: Text('Gerenciar Produtos',
                style: TextStyle(
                       fontSize: 20,
                       )
                ),
              ),
              Spacer(),
              IconButton(
          icon: Icon(Icons.navigate_next_sharp, size: 40,),
          onPressed: (){ 
            Navigator.of(context).pushReplacementNamed(AppRoutes.PRODUCTS);}),
              ],
              ),
          ),

           
         ],
                ),
      );
  }
}