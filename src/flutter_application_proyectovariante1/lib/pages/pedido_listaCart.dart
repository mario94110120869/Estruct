import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_proyectovariante1/models/data_model.dart';

class Cart extends StatefulWidget {
  final List<ProductModel> _cart;

  Cart(this._cart);

  @override
  _CartState createState() => _CartState(this._cart);
}

class _CartState extends State<Cart> {
  _CartState(this._cart);
  final _scrollController = ScrollController();
  var _firstScroll = true;
  bool _enabled = false;

  List<ProductModel> _cart;

  Container pagoTotal(List<ProductModel> _cart) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(left: 120),
      height: 70,
      width: 400,
      color: Colors.grey[200],
      child: Row(
        children: <Widget>[
          // Text("Total:  \$${valorTotal(_cart)}",
          //Text("Total:  ",
          Text("Total:  \$${valorTotal(_cart)}",
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.black))
        ],
      ),
    );
  }

  String valorTotal(List<ProductModel> listaProductos) {
    double total = 0.0;

    for (int i = 0; i < listaProductos.length; i++) {
      total = total + listaProductos[i].price * listaProductos[i].quantity;
    }

    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: Colors.purple,
      //   label: Text("       Pagar         "),
      //   onPressed: () {},
      // ),
      appBar: AppBar(
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.restaurant_menu),
        //     onPressed: null,
        //     color: Colors.white,
        //   )
        // ],
        title: Text('Detalle',
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              _cart.length;
            });
          },
          color: Colors.white,
        ),
        backgroundColor: Colors.purple,
      ),
      body: GestureDetector(
          onVerticalDragUpdate: (details) {
            if (_enabled && _firstScroll) {
              _scrollController
                  .jumpTo(_scrollController.position.pixels - details.delta.dy);
            }
          },
          onVerticalDragEnd: (_) {
            if (_enabled) _firstScroll = false;
          },
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _cart.length,
                itemBuilder: (context, index) {
                  final String imagen = _cart[index].productPic;
                  var item = _cart[index];
                  //item.quantity = 0;

                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(top: 2.0, right: 1.0),
                                  padding: EdgeInsets.only(left: 5),

                                  width: 150,
                                  height: 130,
                                  child: Image.file(
                                      File(_cart[index].productPic),
                                      width: 200,
                                      fit: BoxFit.cover),
                                  //  new Image.asset(
                                  //     "assets/images/$imagen",
                                  //     fit: BoxFit.contain),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(item.productName,
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                            color: Colors.black)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          width: 143,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.purple,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 6.0,
                                                  color: Colors.purple,
                                                  offset: Offset(0.0, 1.0),
                                                )
                                              ],
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(50.0),
                                              )),
                                          margin: EdgeInsets.only(
                                              top: 15.0, left: 4.0),
                                          padding: EdgeInsets.only(top: 2.0),
                                          // padding: EdgeInsets.only(
                                          //     bottom: 20.0, top: 3.0),

                                          child: new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              SizedBox(
                                                //width: 1,
                                                height: 5.0,
                                              ),
                                              IconButton(
                                                //iconSize: double.minPositive,
                                                icon: Icon(Icons.remove),
                                                onPressed: () {
                                                  _removeProduct(index);
                                                  valorTotal(_cart);
                                                  if (_cart[index].quantity <
                                                      6) {
                                                    print(
                                                        "Has llegado al limite disponible.............,${item.cantidadDisp}");

                                                    // setState(() {
                                                    //   _cart[index].cantidadDisp;
                                                    // });
                                                  }
                                                  // print(_cart);
                                                },
                                                color: Colors.white,
                                              ),
                                              //Qui se le pone lo del quilogramo KGGGGGGGGGGGGGGGGGGGGGGGGG
                                              Text(
                                                  '${_cart[index].quantity} lb',
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18.0,
                                                      color: Colors.white)),
                                              IconButton(
                                                icon: Icon(Icons.add),
                                                onPressed: () {
                                                  _addProduct(index);
                                                  valorTotal(_cart);
                                                },
                                                color: Colors
                                                    .white, // print(_cart);
                                              ),
                                              SizedBox(
                                                height: 8.0,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                //"Total:  \$$valorTotal(_cart)"

                                Container(
                                  //margin: EdgeInsets.only(left: 10.0),
                                  padding: EdgeInsets.only(right: 4.0),
                                  child:
                                      Text("\$${item.price.toStringAsFixed(0)}",
                                          style: new TextStyle(

                                              //fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                              color: Colors.black)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.purple,
                      )
                    ],
                  );
                },
              ),
              SizedBox(
                width: 10.0,
              ),
              pagoTotal(_cart),
              SizedBox(
                width: 20.0,
              ),
              Container(
                height: 100,
                width: 200,
                padding: EdgeInsets.only(top: 50),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.purple,
                  child: Text("PAGAR"),
                  onPressed: () => {},
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          ))),
    );
  }

  _addProduct(int index) {
    setState(() {
      _cart[index].quantity++;
    });
  }

  _removeProduct(int index) {
    setState(() {
      _cart[index].quantity--;
    });
  }
}
