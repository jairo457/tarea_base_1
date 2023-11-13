import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:tarea_base_1/assets/GlobalValues.dart';
import 'package:tarea_base_1/database/Masterdb.dart';
import 'package:tarea_base_1/models/ProfesorModel.dart';
import 'package:tarea_base_1/models/TaskModel.dart';
import '../services/notifi_service.dart';
import 'package:timezone/data/latest.dart' as tz;

DateTime fecha = DateTime.now();

class AddTask extends StatefulWidget {
  AddTask({super.key, this.taskModel});

  TaskModel? taskModel;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  ProfesorModel? dropDownValue2;
  String? dropDownValue = "Pendiente";
  String formattedDate = '';
  List lit = [];
  ValueNotifier<bool> band = ValueNotifier<bool>(false);
  bool band2 = false;

  TextEditingController TxtTaskName = TextEditingController();
  TextEditingController TxtDscTask = TextEditingController();
  TextEditingController TxtSttTask = TextEditingController();
  List<String> dropDownValues = ['Pendiente', 'Completado', 'En proceso'];
  List<ProfesorModel> list_cn = [];
  //SAcamos variables por que
  //si estuvieran adentro del build se reiniciarian en cada setState

  MasterDB? masterDB;
  @override
  void initState() {
    super.initState();
    masterDB = MasterDB();
    listar();
    if (widget.taskModel != null) {
      TxtTaskName.text = widget.taskModel!.NameTask!;
      TxtDscTask.text = widget.taskModel!.DscTask!;
      TxtSttTask.text = widget.taskModel!.SttTask!;
      print(widget.taskModel!.FECRECORDATORIO.toString());
      fecha = DateTime.parse(widget.taskModel!.FECRECORDATORIO.toString());
      switch (widget.taskModel!.SttTask) {
        case 'E':
          dropDownValue = "En proceso";
          break;
        case 'C':
          dropDownValue = "Completado";
          break;
        case 'P':
          dropDownValue = "Pendiente";
      }
    }
  }

  listar() async {
    list_cn = await masterDB!.GETALL_Profesor();
    if (widget.taskModel != null) {
      for (ProfesorModel profe in list_cn) {
        if (widget.taskModel!.IdProfesor == profe.IdProfesor) {
          dropDownValue2 = profe;
        }
      }
    } else {
      dropDownValue2 = list_cn.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final txtProfesorName = TextFormField(
      decoration: const InputDecoration(
          label: Text('Tarea'), border: OutlineInputBorder()),
      controller: TxtTaskName,
    );
    final txtSubjectName = TextFormField(
      decoration: const InputDecoration(
          label: Text('Descripcion'), border: OutlineInputBorder()),
      controller: TxtDscTask,
    );
    final DropdownButton ddBStatus = DropdownButton(
        value: dropDownValue,
        items: dropDownValues
            .map((status) =>
                DropdownMenuItem(value: status, child: Text(status)))
            .toList(), //convertimos lista de texto a su tipo hijo
        onChanged: (value) {
          dropDownValue = value;
          setState(() {});
        });

    DropdownButton dbProfesor = DropdownButton(
        value: dropDownValue2,
        items: list_cn
            .map((item) => DropdownMenuItem(
                value: item, child: Text(item.NameProfesor.toString())))
            .toList(),
        //convertimos lista de texto a su tipo hijo
        onChanged: (value) {
          dropDownValue2 = value;
          setState(() {});
        });

    final space = SizedBox(
      height: 10,
    );

    final ElevatedButton btnGuardar = ElevatedButton(
        onPressed: () {
          if (widget.taskModel == null) {
            if (TxtTaskName.text == '' || TxtDscTask.text == '') {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      content: Text('Ingrese datos validos'),
                    );
                  });
            } else {
              NotificationService().scheduleNotification(
                  title: TxtTaskName.text.length > 20
                      ? TxtTaskName.text.substring(0, 20)
                      : TxtTaskName.text,
                  body: TxtDscTask.text.length > 20
                      ? TxtDscTask.text.substring(0, 20)
                      : TxtDscTask.text,
                  scheduledNotificationDateTime: fecha);
              //verifica si es insercicion si no actualiza
              masterDB!.INSERT_Task('tblTareas', {
                //El simbolo ! proteje contra  valores nulos
                'NameTask': TxtTaskName.text,
                'DscTask': TxtDscTask.text,
                'SttTask': dropDownValue!.substring(0, 1),
                'IdProfesor': dropDownValue2!.IdProfesor,
                'FECRECORDATORIO': fecha.toString()
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
            NotificationService().scheduleNotification(
                title: TxtTaskName.text.length > 20
                    ? TxtTaskName.text.substring(0, 20)
                    : TxtTaskName.text,
                body: TxtDscTask.text.length > 20
                    ? TxtDscTask.text.substring(0, 20)
                    : TxtDscTask.text,
                scheduledNotificationDateTime: fecha);
            masterDB!.UPDATE_Task('tblTareas', {
              'IdTask': widget.taskModel!.IdTask,
              'NameTask': TxtTaskName.text,
              'DscTask': TxtDscTask.text,
              'SttTask': dropDownValue!.substring(0, 1),
              'IdProfesor': dropDownValue2!.IdProfesor,
              'FECRECORDATORIO': fecha.toString(),
            }).then((value) {
              GlobalValues.flagTask.value = !GlobalValues.flagTask.value;
              var msj = (value > 0)
                  ? 'La actualizacion fue exitosa!'
                  : 'Ocurrio un error';
              var snackbar = SnackBar(content: Text(msj));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
              Navigator.pop(context);
            });
          }
        },
        child: Text('Save Task'));

//-------------------------------------------------------------------
    final TextButton datepic = TextButton(
        onPressed: () {
          DatePicker.showDateTimePicker(context, showTitleActions: true,
              onChanged: (date) {
            fecha = date;
            // print('change $date');
          }, onConfirm: (date) {
            fecha = date;
            band.value = !band.value;
            //print('confirm $date');
          }, currentTime: DateTime.now(), locale: LocaleType.es);
        },
        child: Text(
          'Seleccionar un dia',
          style: TextStyle(color: Colors.blue),
        ));
//-------------------------------------------------------------------
    return Scaffold(
      //Cuerpo
      appBar: AppBar(
        //Su barra con el texto
        title:
            widget.taskModel == null ? Text('Add Task') : Text('Update Task'),
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
              ddBStatus,
              space,
              DropdownButtonHideUnderline(
                child: FutureBuilder<List<ProfesorModel>>(
                  future: masterDB!.GETALL_Profesor(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Container();
                    } else if (snapshot.hasData) {
                      //convertimos lista de texto a su tipo hijo
                      return dbProfesor = DropdownButton(
                        items: list_cn
                            .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(item.NameProfesor.toString())))
                            .toList(),
                        onChanged: (value) {
                          dropDownValue2 = value;
                          setState(() {
                            dropDownValue2 = value;
                          });
                        },
                        hint: Text(
                          dropDownValue2!.NameProfesor.toString(),
                          style: new TextStyle(color: Colors.blue),
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ),
              space,
              datepic,
              ValueListenableBuilder<bool>(
                builder: (BuildContext context, bool value, Widget? child) {
                  return Text(
                    formattedDate = DateFormat('yyyy-MM-dd').format(fecha),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  );
                },
                valueListenable: band,
              ),
              // fechita,
              space,
              btnGuardar
            ]),
      ), //añadimos clumna con una serie de hijos
    );
  }
}
