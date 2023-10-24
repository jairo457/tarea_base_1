import 'package:flutter/material.dart';
import 'package:tarea_base_1/assets/GlobalValues.dart';
import 'package:tarea_base_1/database/Masterdb.dart';
import 'package:tarea_base_1/models/TaskModel.dart';
import 'package:tarea_base_1/widgets/CardTaskWidget.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  MasterDB? masterDB;
  String searchString = "";
  String filter = "";
  TextEditingController TxtSearch = TextEditingController();
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;

  @override
  void initState() {
    super.initState();
    masterDB = MasterDB();
  }

  @override
  Widget build(BuildContext context) {
    final TextField search = TextField(
      onChanged: (value) {
        setState(() {
          searchString = value;
        });
      },
      controller: TxtSearch,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
      ),
    );

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    final CheckboxListTile checkComplete = CheckboxListTile(
      title: const Text('Completado'),
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked1,
      onChanged: (bool? value) {
        setState(() {
          filter = 'C';
          isChecked1 = value!;
        });
      },
    );
    final CheckboxListTile checkProceso = CheckboxListTile(
      title: const Text('En proceso'),
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked1,
      onChanged: (bool? value) {
        setState(() {
          filter = 'E';
          isChecked1 = value!;
        });
      },
    );
    final CheckboxListTile checkPendiente = CheckboxListTile(
      title: const Text('Pendientes'),
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked1,
      onChanged: (bool? value) {
        setState(() {
          filter = 'P';
          isChecked1 = value!;
        });
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/addTask').then((value) {
                    setState(() {});
                  }),
              icon: Icon(Icons.task))
        ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(children: [
          checkPendiente,
          checkProceso,
          checkProceso,
          search,
          ValueListenableBuilder(
              valueListenable: GlobalValues.flagTask,
              builder: (context, value, _) {
                return FutureBuilder(
                    //Consumir un metodo future y retorna un widget
                    future: masterDB!.GETALL_Task(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<TaskModel>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (snapshot.data![index].NameTask!
                                  .contains(searchString)) {
                                return CardTaskWidget(
                                  taskModel: snapshot.data![index],
                                  masterDB: masterDB,
                                );
                              } else if (snapshot.data![index].DscTask!
                                  .contains(searchString)) {
                                return CardTaskWidget(
                                  taskModel: snapshot.data![index],
                                  masterDB: masterDB,
                                );
                              } else {
                                return Container();
                              }
                            });
                      } else {
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Error!'),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      }
                    });
              }),
        ]),
      ),
    );
  }
}
