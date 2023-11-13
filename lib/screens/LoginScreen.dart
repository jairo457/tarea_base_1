import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController TxtConPass = TextEditingController();
  TextEditingController TxtConUser = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String usuario = '123';
    String contrasena = '123';

    final TxtPass = TextField(
      style: TextStyle(color: Colors.black),
      controller: TxtConPass,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Contraseña'),
    );
    final TxtUser = TextField(
      style: TextStyle(color: Colors.black),
      controller: TxtConUser,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), labelText: 'Usuario'),
    );

    final BtnEntrar = FloatingActionButton.extended(
      icon: Icon(Icons.login),
      label: Text('Entrar'),
      onPressed: () {
        String us = TxtConUser.text;
        String con = TxtConPass.text;
        Navigator.pushNamed(context, '/home');
      },
    );

    return Scaffold(
      body: Container(
          // height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage('assets/gatos.png'))),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 50, bottom: 30),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(30),
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color.fromARGB(255, 203, 246, 254)),
                      child: Column(
                        children: [
                          TxtUser,
                          const SizedBox(
                            height: 10,
                          ),
                          TxtPass
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: BtnEntrar,
    );
  }
}
