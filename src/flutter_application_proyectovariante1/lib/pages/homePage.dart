// @dart=2.9

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_proyectovariante1/innovando/menu.dart';

import 'package:flutter_application_proyectovariante1/models/data_model.dart';
import 'package:flutter_application_proyectovariante1/pages/add_edit_product.dart';
import 'package:flutter_application_proyectovariante1/pages/tienda.dart';
import 'package:flutter_application_proyectovariante1/services/db_service.dart';
import 'package:flutter_application_proyectovariante1/utils/form_helper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DBService dbService;

  @override
  void initState() {
    super.initState();
    dbService = new DBService();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Lista de Productos"),
        centerTitle: true,
      ),
      body: ListView(children: [_fetchData()]),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditProduct(),
            ),
          );
        },
      ),
    );
  }

  Widget _fetchData() {
    return FutureBuilder<List<ProductModel>>(
      future: dbService.getProducts(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> products) {
        if (products.hasData) {
          return _buildUI(products.data);
        }

        return CircularProgressIndicator();
      },
    );
  }

  Widget _buildUI(List<ProductModel> products) {
    List<Widget> widgets = new List<Widget>();

    widgets.add(
      new Align(
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MenuPagina(),
              ),
            );
          },
          child: Container(
            height: 40.0,
            width: 200,
            color: Colors.blueAccent,
            child: Center(
              child: Text(
                "Agregar Productos a la tienda",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    // widgets.add(
    //   new Align(
    //     alignment: Alignment.centerRight,
    //     child: InkWell(
    //       onTap: () {
    //         for (int i = 0; i < products.length; i++) {
    //           if (products[i].categoryId.toString() == "1") {
    //             print(
    //                 "La opción fue enviada 1....................................................");
    //             break;
    //           } else if (products[i].categoryId.toString() == "2") {
    //             print(
    //                 "La opción fue enviada 2..................................................");
    //             break;
    //           }
    //         }
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => Tienda(),
    //           ),
    //         );
    //       },
    //       child: Container(
    //         height: 40.0,
    //         width: 100,
    //         color: Colors.red,
    //         child: Center(
    //           child: Text(
    //             "Agregar Productos a la tienda1",
    //             style: TextStyle(
    //               color: Colors.white,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    widgets.add(
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [_buildDataTable(products)],
      ),
    );

    return Padding(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
      padding: EdgeInsets.all(10),
    );
  }

  Widget _buildDataTable(List<ProductModel> model) {
    return DataTable(
      columns: [
        DataColumn(
          label: Text(
            "Nombre",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            "Precio",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        DataColumn(
          label: Text(
            "Acción",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
      sortColumnIndex: 1,
      rows: model
          .map(
            (data) => DataRow(
              cells: <DataCell>[
                // DataCell(
                //    Image.file(File(data.productPic)),
                // ),
                DataCell(
                  Text(
                    data.productName,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                DataCell(
                  Text(
                    data.price.toString(),
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
                DataCell(
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddEditProduct(
                                  isEditMode: true,
                                  model: data,
                                ),
                              ),
                            );
                          },
                        ),
                        new IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            FormHelper.showMessage(
                              context,
                              "Productos",
                              "Esta seguro que decea eliminar el producto de su lista?",
                              "Si",
                              () {
                                dbService.deleteProduct(data).then((value) {
                                  setState(() {
                                    Navigator.of(context).pop();
                                  });
                                });
                              },
                              buttonText2: "No",
                              isConfirmationDialog: true,
                              onPressed2: () {
                                Navigator.of(context).pop();
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
