import 'package:flutter/material.dart';
import 'package:tarea_base_1/assets/GlobalValues.dart';
import 'package:tarea_base_1/database/Masterdb.dart';
import 'package:tarea_base_1/models/ProfesorModel.dart';
import 'package:tarea_base_1/screens/AddProfesor.dart';

class CardProfesorWidget extends StatelessWidget {
  CardProfesorWidget(
      {super.key,
      required this.profesorModel,
      this.masterDB}); //Las {} indican que los parametros son nombrado

  ProfesorModel profesorModel;
  MasterDB? masterDB;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.green),
      child: Row(
        children: [
          Column(
            children: [
              Text(profesorModel.NameProfesor!),
              Text(profesorModel.NameSubject!),
              Text(profesorModel.User!),
              Text(profesorModel.IdCareer!.toString())
            ],
          ),
          Expanded(child: Container()), //Se expande lo mas que puede
          Column(
            children: [
              GestureDetector(
                  //Para detectar eventos, en este caso en la imagen sin propiedad onpressed
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddProfesor(profesorModel: profesorModel))),
                  child: Image.asset(
                    'assets/database.png',
                    height: 50,
                  )),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Mensaje del sistema'),
                          content: Text('¿Dese borrar al profesor?'),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  int cant = await masterDB!.GETTASK_PROFESOR(
                                      profesorModel.IdProfesor!);
                                  if (cant == 0) {
                                    masterDB!
                                        .DELETE_Profesor('tblProfesor',
                                            profesorModel.IdProfesor!)
                                        .then((value) {
                                      Navigator.pop(context);
                                      GlobalValues.flagProfesor.value =
                                          !GlobalValues.flagProfesor
                                              .value; //Negamos la varaible y siempre cambia
                                    });
                                  } else {
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AlertDialog(
                                          content: Text(
                                              'Este profesor tiene tareas creadas'),
                                        );
                                      },
                                    );
                                  }
                                },
                                child: Text('Si')),
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('No'))
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.delete))
            ],
          ),
        ],
      ),
    );
  }
}
