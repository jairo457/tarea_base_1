import 'package:flutter/material.dart';
import 'package:tarea_base_1/assets/GlobalValues.dart';
import 'package:tarea_base_1/database/Masterdb.dart';
import 'package:tarea_base_1/models/CareerModel.dart';
import 'package:tarea_base_1/widgets/CardCareerWidget.dart';

class CareerScreen extends StatefulWidget {
  const CareerScreen({super.key});

  @override
  State<CareerScreen> createState() => _CareerScreenState();
}

class _CareerScreenState extends State<CareerScreen> {
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
    Future<List<CareerModel>> careers = masterDB!.GETALL_Career();

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
        title: Text('Career Manager'),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/addCareer').then((value) {
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
              valueListenable: GlobalValues.flagCareer,
              builder: (context, value, _) {
                return FutureBuilder(
                    //Consumir un metodo future y retorna un widget
                    future: masterDB!.GETALL_Career(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<CareerModel>> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (snapshot.data![index].NameCareer!
                                  .contains(searchString)) {
                                return CardCareerWidget(
                                  careerModel: snapshot.data![index],
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
