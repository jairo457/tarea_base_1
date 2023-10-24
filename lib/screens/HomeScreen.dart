import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenido'),
      ),
      drawer: CreateDrawer(context),
      body: CreateBody(context),
    );
  }

  Widget CreateDrawer(context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            //leading: Image.network('https://cdn3.iconfinder.com/data/icons/street-food-and-food-trucker-1/64/fruit-organic-plant-orange-vitamin-64.png'),
            leading: Image.asset('assets/naranja.png'),
            trailing: Icon(Icons.chevron_right),
            title: Text('FruitApp'),
            subtitle: Text('Carrusel'),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget CreateBody(context) {
    return ListView(
      children: [
        Column(
          children: [
            OutlinedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/Task');
              },
              child: Text('Tarea'),
            ),
            OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Profesor');
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
