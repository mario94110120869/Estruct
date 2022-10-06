// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_proyectovariante1/innovando/menu.dart';
import 'package:flutter_application_proyectovariante1/models/data_model.dart';
import 'package:flutter_application_proyectovariante1/pages/homePage.dart';
import 'package:flutter_application_proyectovariante1/services/db_service.dart';
import 'package:flutter_application_proyectovariante1/utils/form_helper.dart';

class AddEditProduct extends StatefulWidget {
  AddEditProduct({Key key, this.model, this.isEditMode = false})
      : super(key: key);
  ProductModel model;
  bool isEditMode;

  @override
  _AddEditProductState createState() => _AddEditProductState();
}

class _AddEditProductState extends State<AddEditProduct> {
  ProductModel model;
  DBService dbService;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    dbService = new DBService();
    model = new ProductModel();

    if (widget.isEditMode) {
      model = widget.model;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(widget.isEditMode ? "Editar Producto" : "Agregar Producto"),
      ),
      body: new Form(
        key: globalFormKey,
        child: _formUI(),
      ),
    );
  }

  Widget _formUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHelper.fieldLabel("Nombre Producto"),
                FormHelper.textInput(
                  context,
                  model.productName,
                  (value) => {
                    this.model.productName = value,
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Entre el nombre del producto';
                    }
                    return null;
                  },
                  prefixIcon: const Icon(Icons.text_fields),
                ),
                FormHelper.fieldLabel("Descripción Producto"),
                FormHelper.textInput(
                    context,
                    model.productDesc,
                    (value) => {
                          this.model.productDesc = value,
                        },
                    isTextArea: true, onValidate: (value) {
                  return null;
                }),
                FormHelper.fieldLabel("Precio Producto"),
                FormHelper.textInput(
                  context,
                  model.price,
                  (value) => {
                    this.model.price = double.parse(value),
                  },
                  isNumberInput: true,
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Entre precio producto';
                    }

                    if (value.toString().isNotEmpty &&
                        double.parse(value.toString()) <= 0) {
                      return 'Please enter valid price.';
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Cantidad disponible en libras"),
                FormHelper.textInput(
                  context,
                  model.cantidadDisp,
                  (value) => {
                    this.model.cantidadDisp = double.parse(value),
                  },
                  isNumberInput: true,
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return 'Entre cantidad dispoible';
                    }

                    if (value.toString().isNotEmpty &&
                        double.parse(value.toString()) <= 0) {
                      return 'Please enter valid price.';
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Categoria del Producto"),
                _productCategory(),
                FormHelper.fieldLabel("Seleccionar Foto"),
                Container(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: FormHelper.picPicker(
                    model.productPic,
                    (file) => {
                      setState(
                        () {
                          model.productPic = file.path;
                        },
                      )
                    },
                  ),
                ),
                btnSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _productCategory() {
    return FutureBuilder<List<CategoryModel>>(
      future: dbService.getCategories(),
      builder: (BuildContext context,
          AsyncSnapshot<List<CategoryModel>> categories) {
        if (categories.hasData) {
          return FormHelper.selectDropdown(
            context,
            model.categoryId,
            categories.data,
            (value) => {this.model.categoryId = int.parse(value)},
            onValidate: (value) {
              if (value == null) {
                return 'seleccione la  categoria producto';
              }
              return null;
            },
          );
        }

        return CircularProgressIndicator();
      },
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Widget btnSubmit() {
    return Row(
      children: [
        new Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              if (validateAndSave()) {
                print(model.toMap());
                if (widget.isEditMode) {
                  dbService.updateProduct(model).then((value) {
                    FormHelper.showMessage(
                      context,
                      "SQFLITE CRUD",
                      "Datos Modificados Correctamente",
                      "Aceptar",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                    );
                  });
                } else {
                  dbService.addProduct(model).then((value) {
                    FormHelper.showMessage(
                      context,
                      "SQFLITE CRUD",
                      "Datos Guardados Correctamente",
                      "Aceptar",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuPagina(),
                          ),
                        );
                      },
                    );
                  });
                }
              }
            },
            child: Container(
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10), color: Colors.purple),
              height: 40.0,
              margin: EdgeInsets.only(left: 70),
              width: 100,
              color: Colors.blueAccent,
              child: Center(
                child: Text(
                  "Guardar ",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: (() => Navigator.of(context).pop()),
          child: Container(
            height: 40.0,
            margin: EdgeInsets.only(left: 10.0),
            width: 100,
            color: Colors.red,
            child: Center(
              child: Text(
                "Cancelar ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
