import 'package:flutter/material.dart';
import 'package:tarea_base_1/assets/GlobalValues.dart';
import 'package:tarea_base_1/database/Masterdb.dart';
import 'package:tarea_base_1/models/ProfesorModel.dart';
import 'package:tarea_base_1/widgets/CardProfesorWidget.dart';

class ProfesorScreen extends StatefulWidget {
  const ProfesorScreen({super.key});

  @override
  State<ProfesorScreen> createState() => _ProfesorScreenState();
}

class _ProfesorScreenState extends State<ProfesorScreen> {
  MasterDB? masterDB;
  String searchString = "";
  TextEditingController TxtSearch = TextEditingController();

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

    return Scaffold(
      appBar: AppBar(
        title: Text('Profesor Manager'),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/addProfesor').then((value) {
                    setState(() {});
                  }),
              icon: Icon(Icons.task))
        ],
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(children: [
          search,
          ValueListenableBuilder(
              valueListenable: GlobalValues.flagProfesor,
              builder: (context, value, _) {
                return FutureBuilder(
                    //Consumir un metodo future y retorna un widget
                    future: masterDB!.GETALL_Profesor(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<ProfesorModel>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (snapshot.data![index].NameProfesor!
                                  .contains(searchString)) {
                                return CardProfesorWidget(
                                  profesorModel: snapshot.data![index],
                                  masterDB: masterDB,
                                );
                              } else if (snapshot.data![index].NameSubject!
                                  .contains(searchString)) {
                                return CardProfesorWidget(
                                  profesorModel: snapshot.data![index],
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
