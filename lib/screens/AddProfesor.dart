import 'package:flutter/material.dart';
import 'package:tarea_base_1/assets/GlobalValues.dart';
import 'package:tarea_base_1/database/Masterdb.dart';
import 'package:tarea_base_1/models/CareerModel.dart';
import 'package:tarea_base_1/models/ProfesorModel.dart';

class AddProfesor extends StatefulWidget {
  AddProfesor({super.key, this.profesorModel});

  ProfesorModel? profesorModel;

  @override
  State<AddProfesor> createState() => _AddProfesorState();
}

class _AddProfesorState extends State<AddProfesor> {
  CareerModel? dropDownValue;
  int band = 0;
  List lit = [];
  TextEditingController TxtProfesorName = TextEditingController();
  TextEditingController TxtSubjectName = TextEditingController();
  TextEditingController TxtUser = TextEditingController();
  TextEditingController TxtContra = TextEditingController();
  TextEditingController TxtCareer = TextEditingController();
  List<CareerModel> list_cn = [];
  //Sacamos variables por que
  //si estuvieran adentro del build se reiniciarian en cada setState

  MasterDB? masterDB;
  @override
  void initState() {
    super.initState();
    masterDB = MasterDB();
    listar();
    if (widget.profesorModel != null) {
      TxtProfesorName.text = widget.profesorModel!.NameProfesor!;
      TxtSubjectName.text = widget.profesorModel!.NameSubject!;
      TxtUser.text = widget.profesorModel!.User!;
      TxtContra.text = widget.profesorModel!.Contra!;
      band = 1;
      //haz magia viejo
    }
    //dropDownValue = list_cn.first;
  }

  listar() async {
    list_cn = await masterDB!.GETALL_Career();
    /*items = list_cn
        .map((item) => DropdownMenuItem(
            value: item, child: Text(item.NameCareer.toString())))
        .toList();*/
    if (widget.profesorModel != null) {
      for (CareerModel carre in list_cn) {
        if (widget.profesorModel!.IdCareer == carre.IdCareer) {
          dropDownValue = carre;
        }
      }
    } else {
      dropDownValue = list_cn.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final txtProfesorName = TextFormField(
      decoration: const InputDecoration(
          label: Text('Nombre'), border: OutlineInputBorder()),
      controller: TxtProfesorName,
    );
    final txtSubjectName = TextFormField(
      decoration: const InputDecoration(
          label: Text('Materia'), border: OutlineInputBorder()),
      controller: TxtSubjectName,
    );
    final txtUser = TextFormField(
        decoration: const InputDecoration(
            label: Text('Usuario'), border: OutlineInputBorder()),
        controller: TxtUser);
    final txtContra = TextFormField(
      decoration: const InputDecoration(
          label: Text('Contraseña'), border: OutlineInputBorder()),
      controller: TxtContra,
    );

    DropdownButton dbCareer = DropdownButton(
        value: dropDownValue,
        items: list_cn
            .map((item) => DropdownMenuItem(
                value: item, child: Text(item.NameCareer.toString())))
            .toList(),
        //convertimos lista de texto a su tipo hijo
        onChanged: (value) {
          dropDownValue = value;
          setState(() {});
        });

    final space = SizedBox(
      height: 10,
    );
    final ElevatedButton btnGuardar = ElevatedButton(
        onPressed: () {
          if (widget.profesorModel == null) {
            if (dropDownValue!.IdCareer != null) {
              //verifica si es insercicion si no actualiza
              masterDB!.INSERT_Profesor('tblProfesor', {
                //El simbolo ! proteje contra  valores nulos
                'NameProfesor': TxtProfesorName.text,
                'NameSubject': TxtSubjectName.text,
                'User': TxtUser.text,
                'Contra': TxtContra.text,
                'IdCareer': dropDownValue!.IdCareer,
              }).then((value) {
                //Entero que regresamos de la llamada a insertar
                var msj = (value > 0)
                    ? 'La insercion fue exitosa!'
                    : 'Ocurrio un error';
                var snackbar = SnackBar(content: Text(msj));
                ScaffoldMessenger.of(context).showSnackBar(snackbar); //aviso
                Navigator.pop(context);
              });
            } else {
              showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    content: Text('Necesita asignar una carrera'),
                  );
                },
              );
            }
          } else {
            masterDB!.UPDATE_Profesor('tblProfesor', {
              'IdProfesor': widget.profesorModel!.IdProfesor,
              'NameProfesor': TxtProfesorName.text,
              'NameSubject': TxtSubjectName.text,
              'User': TxtUser.text,
              'Contra': TxtContra.text,
              'IdCareer': dropDownValue!.IdCareer,
            }).then((value) {
              GlobalValues.flagProfesor.value =
                  !GlobalValues.flagProfesor.value;
              var msj = (value > 0)
                  ? 'La insercion fue exitosa!'
                  : 'Ocurrio un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          }
        },
        child: Text('Save Profesor'));

    return Scaffold(
      //Cuerpo
      appBar: AppBar(
        //Su barra con el texto
        title: widget.profesorModel == null
            ? Text('Add Profesor')
            : Text('Update Profesor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              txtProfesorName,
              space,
              txtSubjectName,
              space,
              txtUser,
              space,
              txtContra,
              space,
              DropdownButtonHideUnderline(
                child: FutureBuilder<List<CareerModel>>(
                  future: masterDB!.GETALL_Career(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Container();
                    } else if (snapshot.hasData) {
                      lit = list_cn
                          .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(item.NameCareer.toString())))
                          .toList();
                      //convertimos lista de texto a su tipo hijo
                      return dbCareer = DropdownButton(
                        items: list_cn
                            .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(item.NameCareer.toString())))
                            .toList(),
                        onChanged: (value) {
                          dropDownValue = value;
                          setState(() {
                            dropDownValue = value;
                          });
                        },
                        hint: Text(
                          dropDownValue!.NameCareer.toString(),
                          style: new TextStyle(color: Colors.blue),
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
              //dbCareer,
              space,
              btnGuardar
            ]),
      ), //añadimos clumna con una serie de hijos
    );
  }
}
