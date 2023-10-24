import 'package:flutter/material.dart';
import 'package:tarea_base_1/assets/GlobalValues.dart';
import 'package:tarea_base_1/database/Masterdb.dart';
import 'package:tarea_base_1/models/TaskModel.dart';
import 'package:tarea_base_1/screens/AddTask.dart';

class CardTaskWidget extends StatelessWidget {
  CardTaskWidget(
      {super.key,
      required this.taskModel,
      this.masterDB}); //Las {} indican que los parametros son nombrado

  TaskModel taskModel;
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
              Text(taskModel.NameTask!),
              Text(taskModel.DscTask!),
              Text(taskModel.SttTask!)
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
                          builder: (context) => AddTask(taskModel: taskModel))),
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
                          content: Text('¿Dese borrar la tarea?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  masterDB!
                                      .DELETE_Task(
                                          'tblTareas', taskModel.IdTask!)
                                      .then((value) {
                                    Navigator.pop(context);
                                    GlobalValues.flagTask.value = !GlobalValues
                                        .flagTask
                                        .value; //Negamos la varaible y siempre cambia
                                  });
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
