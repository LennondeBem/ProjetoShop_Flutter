import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop/widgets/drawer.dart';

class ProductFormPage extends StatefulWidget {
  

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
 
 final _priceFocus = FocusNode();
 final _descriptionFocus = FocusNode();
 final _imageUrlFocus = FocusNode();
 final _imageController = TextEditingController(); 
 
 
  
  @override
  void initState() {
    _imageController.addListener(()=>setState((){}));
    super.initState();
  }

  @override
  void dispose() {
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.dispose();
    _imageController.removeListener(()=>setState((){}));
    super.dispose();
  }
 
  void submitedForm(){
    print('Formulário submetido');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.save), 
            onPressed:(){
              submitedForm();
              })
        ],
        title: Text("Formulário")
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          child: ListView(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Nome'),
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_priceFocus);
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Preço'),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            focusNode: _priceFocus,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_descriptionFocus);
            },
          ),
           TextFormField(
            decoration: InputDecoration(labelText: 'Descrição'),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            focusNode: _descriptionFocus,
          ),
          SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                  decoration: InputDecoration(labelText: 'Url da imagem'),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.url,
                  focusNode: _imageUrlFocus,
                  controller: _imageController,
                  onFieldSubmitted: (_)=> submitedForm(),
                ),
                              ),
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(width: 2)
                ),
                child: _imageController.text.isEmpty? Center(child: Text('Informe URL')):
                 FittedBox(
                   child: Image.network(_imageController.text),
                   fit: BoxFit.cover,
                   ),
               
              )
            ],
          )
        ],
          )
          ),
      ) ,
    );
  }
}