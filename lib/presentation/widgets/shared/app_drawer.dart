import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // DrawerHeader(
            //   child: Text('Configuración'),
            //   decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            // ),
            ListTile(
              leading: Icon(Icons.dark_mode),
              title: Text('Tema'),
              onTap: () {
                // lógica para cambiar tema
              },
            ),
            ListTile(
              leading: Icon(Icons.language),
              title: Text('Idioma'),
              onTap: () {
                // lógica para cambiar idioma
              },
            ),
            ListTile(
              leading: Icon(Icons.color_lens),
              title: Text('Color primario'),
              onTap: () {
                // lógica para cambiar color
              },
            ),
          ],
        ),
      ),
    );
  }
}
