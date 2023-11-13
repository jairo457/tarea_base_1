import 'package:flutter/material.dart';
import 'package:tarea_base_1/assets/GlobalValues.dart';
import 'package:tarea_base_1/database/Masterdb.dart';
import 'package:tarea_base_1/models/CareerModel.dart';

class AddCareer extends StatefulWidget {
  AddCareer({super.key, this.careerModel});

  CareerModel? careerModel;

  @override
  State<AddCareer> createState() => _AddCareerState();
}

class _AddCareerState extends State<AddCareer> {
  String? dropDownValue = "Pendiente";

  TextEditingController TxtCareerName = TextEditingController();
  //SAcamos variables por que
  //si estuvieran adentro del build se reiniciarian en cada setState

  MasterDB? masterDB;
  @override
  void initState() {
    super.initState();
    masterDB = MasterDB();
    if (widget.careerModel != null) {
      TxtCareerName.text = widget.careerModel!.NameCareer!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final txtNameCareer = TextFormField(
      decoration: const InputDecoration(
          label: Text('Carrera'), border: OutlineInputBorder()),
      controller: TxtCareerName,
    );

    final space = SizedBox(
      height: 10,
    );

    final ElevatedButton btnGuardar = ElevatedButton(
        onPressed: () {
          if (widget.careerModel == null) {
            //verifica si es insercicion si no actualiza
            if (TxtCareerName.text == '') {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      content: Text('Ingrese un hombre valido'),
                    );
                  });
            } else {
              masterDB!.INSERT_Career('tblCarrera', {
                //El simbolo ! proteje contra  valores nulos
                'NameCareer': TxtCareerName.text,
              }).then((value) {
                //Entero que regresamos de la llamada a insertar
                var msj = (value > 0)
                    ? 'La insercion fue exitosa!'
                    : 'Ocurrio un error';
                var snackbar = SnackBar(content: Text(msj));
                ScaffoldMessenger.of(context).showSnackBar(snackbar); //aviso
                Navigator.pop(context);
              });
            }
          } else {
            masterDB!.UPDATE_Career('tblCarrera', {
              'IdCareer': widget.careerModel!.IdCareer,
              'NameCareer': TxtCareerName.text,
            }).then((value) {
              GlobalValues.flagCareer.value = !GlobalValues.flagCareer.value;
              var msj = (value > 0)
                  ? 'La insercion fue exitosa!'
                  : 'Ocurrio un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          }
        },
        child: Text('Save Career'));

    return Scaffold(
      //Cuerpo
      appBar: AppBar(
        //Su barra con el texto
        title: widget.careerModel == null
            ? Text('Add Career')
            : Text('Update Career'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [txtNameCareer, space, btnGuardar]),
      ), //añadimos clumna con una serie de hijos
    );
  }
}
