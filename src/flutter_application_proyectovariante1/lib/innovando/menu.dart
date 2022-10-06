// @dart=2.9
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_proyectovariante1/models/data_model.dart';
import 'package:flutter_application_proyectovariante1/pages/add_edit_product.dart';
import 'package:flutter_application_proyectovariante1/pages/detalleProducto.dart';
import 'package:flutter_application_proyectovariante1/services/db_service.dart';
import 'package:flutter_application_proyectovariante1/utils/form_helper.dart';
import 'dart:math';

import 'package:image_picker/image_picker.dart';
import 'dart:io' as io;

class MenuPagina extends StatefulWidget {
  @override
  State<MenuPagina> createState() => _MenuPaginaState();
}

class _MenuPaginaState extends State<MenuPagina> {
  DBService dbService;

  // Tienda tienda = new Tienda();
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  //_MenuPaginaState(_productosModel);

  @override
  void initState() {
    super.initState();
    dbService = new DBService();
    // _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenido a tu Tienda"),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 0.0),
            color: Colors.purple,
            child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.purpleAccent,
                child: imageProfile(context)
                //PhotoPreviewScreen()
                //Image.asset("assets/images/ava.png"),
                ),
          )
        ],
        // leading: Padding(
        //   padding: EdgeInsets.only(left: 210),
        //   child: ClipOval(
        //     child: Image(
        //       image: Image.asset("assets/images/melon.png").image,
        //     ),
        //   ),
        // ),

        //  Container(
        //   //width: 58,

        //   child: CircleAvatar(
        //     child: Image.asset(
        //       "assets/images/melon.png",
        //       height: 50.0,
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 10.0, left: 210.0),
        //   child: Row(
        //     children: <Widget>[
        //       Image.asset("assets/images/melon.png", height: 50.0)
        //     ],
        //   ),
        // ),
        //centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      drawer: _menuDrawer(context),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            height: 160,
            child: _caruselImage(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              'Lista de Productos',
              style: TextStyle(fontSize: 23.0, decorationColor: Colors.black26),
            ),
          ),
          //SizedBox(height: 0.0),
          Container(
              padding: EdgeInsets.only(left: 0.0, right: 15.0),
              child: _fetchData()),
          // Container(
          //     padding: EdgeInsets.only(top: 5.0),
          //     height: 250.0,
          //     width: 20,
          //     child: Container(
          //       padding: EdgeInsets.all(8.0),
          //       child: Column(
          //         children: [
          //           _fetchData(),
          //           //lista(products),
          //         ],
          //       ),
          //     )
          //     //_cuadroProductos(),
          //     //color: Colors.purple,
          //     //  ListView(
          //     //   //scrollDirection: Axis.horizontal,
          //     //   children: <Widget>[
          //     //     //_cuadroProductos()
          //     //     // _buildListItem('Melón', 'assets/images/melon.png', '21',
          //     //     //     Color(0xFFDA9551), Color(0xFFDA9551)),
          //     //     // _buildListItem('Piña', 'assets/images/pina.png', '15',
          //     //     //     Color(0xFFC2E3FE), Color(0xFF6A8CAA)),
          //     //     // _buildListItem('Uva', 'assets/images/uva.png', '15',
          //     //     //     Color(0xFFD7FADA), Color(0xFF56CC7E)),
          //     //     // _buildListItem('Kiwi', 'assets/images/kiwi.png', '15',
          //     //     //     Color.fromARGB(255, 103, 87, 248), Color(0xFF56CC7E)),
          //     //   ],
          //     // )
          //     ),
        ],
      ),
      // _caruselImage()
      // body: Stack(
      //   children: <Widget>[
      //     Positioned(
      //         child: Container(
      //       margin: const EdgeInsets.only(top: 180.0),
      //       child: Text("Recomendaciones"),
      //     )),
      //     Positioned(
      //         child: Container(
      //       width: double.infinity,
      //       // margin: EdgeInsets.all(40),
      //       //margin: const EdgeInsets.only(top: 100.0),
      //       child: _caruselImage(),
      //     )),
      //   ],
      // )
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditProduct(),
            ),
          );
          // Navigator.pushNamed(context, "list");
        },
      ),
    );
  }

  // GridView _cuadroProductos() {
  //   return GridView.builder(
  //       scrollDirection: Axis.horizontal,
  //       padding: const EdgeInsets.only(left: 10.0, bottom: 100.0),
  //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 1,
  //       ),
  //       itemCount: products.length,
  //       itemBuilder: ((context, index) {
  //         final String imagen = products[index].productPic;
  //         var item = products[index];
  //         return Container(
  //           child: GestureDetector(
  //             onTap: () {
  //               Navigator.of(context).push(
  //                   PageRouteBuilder(pageBuilder: (context, animation, __) {
  //                 return FadeTransition(
  //                   opacity: animation,
  //                   child: Detalle(list: item, cart: listaCarro),
  //                 );
  //               }));
  //             },
  //             child: Card(
  //               elevation: 4.0,
  //               child: Stack(
  //                 fit: StackFit.loose,
  //                 alignment: Alignment.center,
  //                 children: <Widget>[
  //                   Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: <Widget>[
  //                       Expanded(
  //                         child: Hero(
  //                           tag: products[index].productName,
  //                           child: Image.file(File(products[index].productPic),
  //                               width: 200, fit: BoxFit.cover),
  //                         ),
  //                       ),
  //                       // Expanded(

  //                       //   child:ImageCache( item.productPic),
  //                       //   // new Image.asset("assets/images/$imagen",
  //                       //       fit: BoxFit.cover),
  //                       //   //fit: BoxFit.contain),+
  //                       // ),
  //                       Text(
  //                         item.productName,
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(fontSize: 20.0),
  //                       ),
  //                       SizedBox(
  //                         height: 15,
  //                       ),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: <Widget>[
  //                           SizedBox(
  //                             height: 25,
  //                           ),
  //                           Text(
  //                             "\$${item.price.toString()} ",
  //                             style: TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: 23.0,
  //                                 color: Colors.black),
  //                           ),
  //                           Padding(
  //                             padding: const EdgeInsets.only(
  //                               right: 8.0,
  //                               bottom: 8.0,
  //                             ),
  //                             child: Align(
  //                                 alignment: Alignment.bottomRight,
  //                                 child: GestureDetector(
  //                                   child: (!listaCarro.contains(item))
  //                                       ? Icon(
  //                                           Icons.shopping_cart,
  //                                           color: Colors.purple,
  //                                           size: 38,
  //                                         )
  //                                       : Icon(
  //                                           Icons.shopping_cart,
  //                                           color: Colors.red,
  //                                           size: 38,
  //                                         ),
  //                                   onTap: () {
  //                                     setState(() {
  //                                       if (!listaCarro.contains(item))
  //                                         listaCarro.add(item);
  //                                       else
  //                                         listaCarro.remove(item);
  //                                     });
  //                                   },
  //                                 )),
  //                           ),
  //                         ],
  //                       )
  //                     ],
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         );
  //       }));
  // }

  _buildListItem(String foodName, String imgPath, String price, Color bgColor,
      Color textColor) {
    return Padding(
        padding: EdgeInsets.only(left: 15.0),
        child: InkWell(
            // onTap: () {
            //   //ToDo
            //   Navigator.of(context).push(MaterialPageRoute(
            //       builder: (context) => BurgerPage(
            //           heroTag: foodName,
            //           foodName: foodName,
            //           pricePerItem: price,
            //           imgPath: imgPath)));
            // },
            child: Container(
                height: 175.0,
                width: 150.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0), color: bgColor),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                        tag: foodName,
                        child: Container(
                            height: 75.0,
                            width: 75.0,
                            decoration: BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            child: Center(
                                child: Image.asset(imgPath,
                                    height: 50.0, width: 50.0)))),
                    SizedBox(height: 25.0),
                    Text(
                      foodName,
                    ),
                    Text(
                      '\$' + price,
                    )
                  ],
                ))));
  }

  Widget imageProfile(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          InkWell(
            child: CircleAvatar(
              backgroundColor: Colors.purple,
              radius: 50.0,
              backgroundImage: _imageFile == null
                  ? AssetImage("assets/images/ava.png")
                  : FileImage(io.File(_imageFile.path)),
            ),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: ((builder) => bottomSheet(context)));
            },
          ),
          Positioned(
              bottom: 20.0,
              right: 10.0,
              top: 30.0,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: ((builder) => bottomSheet(context)));
                },
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 25.0,
                ),
              ))
        ],
      ),
    );
  }

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Seleccione foto de Perfil",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  icon: Icon(
                    Icons.camera,
                    color: Colors.purple,
                  ),
                  label: Text(
                    "Camara",
                    style: TextStyle(color: Colors.purple),
                  )),
              TextButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  icon: Icon(
                    Icons.image,
                    color: Colors.purple,
                  ),
                  label:
                      Text("Galeria", style: TextStyle(color: Colors.purple)))
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
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

    // widgets.add(
    //   new Align(
    //     alignment: Alignment.centerRight,
    //     child: InkWell(
    //       onTap: () {
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //             builder: (context) => MenuPagina(),
    //           ),
    //         );
    //       },
    //       child: Container(
    //         height: 40.0,
    //         width: 200,
    //         color: Colors.blueAccent,
    //         child: Center(
    //           child: Text(
    //             "Agregar Productos a la tienda",
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
        children: [lista(products)],
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

  // _loadData() async {
  //   List<ProductModel> aux = await dbService.getProducts();
  //   setState(() {});
  //   products = aux;
  // }

  lista(List<ProductModel> products) {
    return Column(
      children: products.map((dat) => listItem(dat)).toList(),
    );
  }

  Widget listItem(ProductModel dat) {
    return Column(
      children: [
        Container(
          height: 130.0,
          width: 340.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: GestureDetector(
              child: Card(
                shadowColor: Colors.black54,
                elevation: 6,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.file(File(dat.productPic),
                          width: 120, fit: BoxFit.cover),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              dat.productName,
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          // Text(
                          //   comida.productDesc,
                          //   maxLines: 2,
                          //   style: TextStyle(
                          //       color: _blueColor,
                          //       fontSize: 16,
                          //       fontWeight: FontWeight.bold),
                          // ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "\$${dat.price.toStringAsFixed(1)}",
                            style: TextStyle(
                                color: Colors.purple,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(
                          //       right: 15.0, bottom: 15.0, top: 0),
                          //   child: Align(
                          //     alignment: Alignment.bottomRight,
                          //     child: GestureDetector(
                          //       child: (!listaCarro.contains(comida))
                          //           ? Icon(
                          //               Icons.shopping_cart,
                          //               color: Colors.purple,
                          //               size: 38,
                          //             )
                          //           : Icon(
                          //               Icons.shopping_cart,
                          //               color: Colors.red,
                          //               size: 38,
                          //             ),
                          //       onTap: () {
                          //         setState(() {
                          //           if (!listaCarro.contains(comida))
                          //             listaCarro.add(comida);
                          //           else
                          //             listaCarro.remove(comida);
                          //         });
                          //       },
                          //     ),
                          //   ),
                          // ),
                          // new IconButton(
                          //   padding: EdgeInsets.all(0),
                          //   icon: Icon(Icons.edit),
                          //   onPressed: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => AddEditProduct(
                          //           isEditMode: true,
                          //           model: dat,
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0, top: 0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          padding: EdgeInsets.only(left: 40.0),
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddEditProduct(
                                  isEditMode: true,
                                  model: dat,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 5.0, bottom: 15.0, top: 0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          padding: EdgeInsets.only(right: 10.0),
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
                                dbService.deleteProduct(dat).then((value) {
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

ListView _caruselImage() {
  return ListView(
    children: [
      Padding(padding: EdgeInsets.all(1)),
      SizedBox(
        height: 5,
      ),
      CarouselSlider(
          items: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                  image: DecorationImage(
                      image: AssetImage("assets/images/fruta2.jpg"),
                      fit: BoxFit.cover)),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                  image: DecorationImage(
                      image: AssetImage("assets/images/fruta1.jpg"),
                      fit: BoxFit.cover)),
            )
          ],
          options: CarouselOptions(
            height: 150.0,
            autoPlay: true,
            autoPlayCurve: Curves.easeInOut,
            enlargeCenterPage: true,
            autoPlayInterval: Duration(seconds: 5),
            scrollDirection: Axis.horizontal,
          ))
    ],
  );
}

Widget _menuDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Container(),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/fruta2.jpg"),
                  fit: BoxFit.cover)),
        ),
        ListTile(
          leading: Icon(Icons.home, color: Colors.purple),
          title: Text('Home'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          leading: Icon(Icons.store, color: Colors.purple),
          title: Text('Tienda'),
          onTap: () {
            // Navigator.pushReplacementNamed(context, "tienda");
            // Navigator.of(context).push(new MaterialPageRoute(
            //     builder: (BuildContext context) => Tienda()));
          },
        ),
        ListTile(
          leading: Icon(Icons.contact_phone, color: Colors.purple),
          title: Text('Contacto'),
          onTap: () {
            // Navigator.of(context).push(new MaterialPageRoute(
            //     builder: (BuildContext context) => ListPage()));
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          leading: Icon(Icons.help, color: Colors.purple),
          title: Text('Manual de Usuario'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          leading: Icon(Icons.dark_mode_rounded, color: Colors.purple),
          title: Text('Temas'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          leading:
              Icon(Icons.leave_bags_at_home_outlined, color: Colors.purple),
          title: Text('Salir'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
      ],
    ),
  );
}
