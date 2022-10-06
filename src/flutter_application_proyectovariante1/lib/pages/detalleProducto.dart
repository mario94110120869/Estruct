// @dart=2.9
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_proyectovariante1/models/data_model.dart';

class Detalle extends StatefulWidget {
  Detalle({this.list, this.cart});
  final ProductModel list;
  final List<ProductModel> cart;

  @override
  State<Detalle> createState() => _Detalle();
}

class _Detalle extends State<Detalle> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
          ),
          backgroundColor: Colors.purple,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Hero(
                      tag: widget.list.productName,
                      child: Image.file(
                        File(widget.list.productPic),
                        width: 300,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.36,
                      ),
                    ),
                  ),
                  Text(
                    widget.list.productName,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        "\$${widget.list.price}",
                        style: Theme.of(context).textTheme.headline4.copyWith(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Descripción del Producto",
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.list.productDesc,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w200),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Cantidad Disponible en Libras",
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${widget.list.cantidadDisp.toStringAsFixed(0)} lb",
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: IconButton(
                        onPressed: () => null,
                        icon: Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                        )),
                  ),
                  Expanded(
                      flex: 4,
                      child: RaisedButton(
                        color: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                            "Agregar al Carrito",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onPressed: () {
                          widget.cart.add(widget.list);
                        },
                      ))
                ],
              ),
            )
          ],
        )
        // Padding(
        //   padding: const EdgeInsets.all(10.0),
        //   child: ListView(
        //     children: <Widget>[
        //       Center(
        //         // height: 280.0,
        //         // color: Colors.purple,
        //         child: Hero(
        //           tag: widget.list.productName,
        //           child: Image.file(File(widget.list.productPic),
        //               width: 200, fit: BoxFit.cover),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        );
  }
}
