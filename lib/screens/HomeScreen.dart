import 'package:flutter/material.dart';
import 'package:tarea_base_1/database/Masterdb.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  MasterDB? masterDB;

  @override
  void initState() {
    super.initState();
    masterDB = MasterDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
      ),
      body: CreateBody(context),
    );
  }

  Widget CreateBody(context) {
    return ListView(
      children: [
        Column(
          children: [
            OutlinedButton(
              onPressed: () async {
                int cant = await masterDB!.GETALL_Profesor_can();
                if (cant == 0) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const AlertDialog(
                          content: Text('Se necesita al menos un profesor'),
                        );
                      });
                } else {
                  Navigator.pushNamed(context, '/Task');
                }
              },
              child: Text('Tarea'),
            ),
            OutlinedButton(
                onPressed: () async {
                  int cant = await masterDB!.GETALL_Career_can();
                  if (cant == 0) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertDialog(
                            content: Text('Se necesita al menos una carrera'),
                          );
                        });
                  } else {
                    Navigator.pushNamed(context, '/Profesor');
                  }
                },
                child: Text('Profesor')),
            OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Career');
                },
                child: Text('Carrera')),
            OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Calendar');
                },
                child: Text('Calendario'))
          ],
        ),
      ],
    );
  }
}
