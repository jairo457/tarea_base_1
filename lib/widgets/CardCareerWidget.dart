import 'package:flutter/material.dart';
import 'package:tarea_base_1/assets/GlobalValues.dart';
import 'package:tarea_base_1/database/Masterdb.dart';
import 'package:tarea_base_1/models/CareerModel.dart';
import 'package:tarea_base_1/screens/AddCareer.dart';

class CardCareerWidget extends StatelessWidget {
  CardCareerWidget(
      {super.key,
      required this.careerModel,
      this.masterDB}); //Las {} indican que los parametros son nombrado

  CareerModel careerModel;
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
            children: [Text(careerModel.NameCareer!)],
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
                              AddCareer(careerModel: careerModel))),
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
                          content: Text('¿Dese borrar la carrera?'),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  int cant = await masterDB!.GETCAREER_PROFESOR(
                                      careerModel.IdCareer!);
                                  //print(cant.toString());
                                  if (cant == 0) {
                                    masterDB!
                                        .DELETE_Career(
                                            'tblCarrera', careerModel.IdCareer!)
                                        .then((value) {
                                      Navigator.pop(context);
                                      GlobalValues.flagCareer.value = !GlobalValues
                                          .flagCareer
                                          .value; //Negamos la varaible y siempre cambia
                                    });
                                  } else {
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const AlertDialog(
                                          content: Text(
                                              'Esta carrera tiene profesores asignados'),
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
