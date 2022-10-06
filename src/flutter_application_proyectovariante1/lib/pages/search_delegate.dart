// @dart=2.9

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_proyectovariante1/models/data_model.dart';
import 'package:flutter_application_proyectovariante1/pages/detalleProducto.dart';
import 'package:flutter_application_proyectovariante1/pages/tienda.dart';

class SearchCountryDelegate extends SearchDelegate<Tienda> {
  List<ProductModel> _productosModel = List<ProductModel>();
  List<ProductModel> _listaCarro = List<ProductModel>();

  List<ProductModel> productos;
  List<ProductModel> _filter = [];

  SearchCountryDelegate(this._productosModel);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, Tienda());
        //close(context,  ProductosModel());
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // _filter = (query.isEmpty)
    //     ? _productosModel
    //     : _productosModel.where(
    //         (element) {
    //           element.name.toLowerCase().contains(query.trim().toLowerCase());
    //         },
    //       ).toList();
    // final listaSugerida = (query.isEmpty)
    //     ? _productosModel
    //     : _productosModel
    //         .where((element) =>
    //             element.name.toLowerCase().contains(query.trim().toLowerCase()))
    //         .toList();
    final listaSugerida = (query.isEmpty)
        ? _productosModel
        : _productosModel
            .where((element) => element.productName
                .toLowerCase()
                .startsWith(query.toLowerCase()))
            .toList();

    return GridView.builder(
      padding: const EdgeInsets.all(4.0),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: listaSugerida.length,
      itemBuilder: (context, index) {
        final String imagen = listaSugerida[index].productPic;
        var item = listaSugerida[index];
        return Container(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(PageRouteBuilder(pageBuilder: (context, animation, __) {
                return FadeTransition(
                  opacity: animation,
                  child: Detalle(list: item),
                );
              }));
            },
            child: Card(
                elevation: 4.0,
                child: Stack(
                  fit: StackFit.loose,
                  alignment: Alignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Image.file(File(imagen),
                              width: 200, fit: BoxFit.cover),
                        ),
                        Text(
                          item.productName,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              item.price.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23.0,
                                  color: Colors.black),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 8.0,
                                bottom: 8.0,
                              ),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  child: (!_listaCarro.contains(item))
                                      ? Icon(
                                          Icons.shopping_cart,
                                          color: Colors.purple,
                                          size: 38,
                                        )
                                      : Icon(
                                          Icons.shopping_cart,
                                          color: Colors.red,
                                          size: 38,
                                        ),
                                  onTap: () {
                                    // setState(() {
                                    //   if (!_listaCarro.contains(item))
                                    //     _listaCarro.add(item);
                                    //   else
                                    //     _listaCarro.remove(item);
                                    // });
                                  },
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                )),
          ),
        );
      },
    );
  }
}
