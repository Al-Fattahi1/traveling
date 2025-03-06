import 'package:flutter/material.dart';
import '../screens/filters_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  ListTile buildListTile(String title, IconData icon, VoidCallback onTapLink) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: Colors.teal,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Lato-Bold',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTapLink, // ✅ تمرير الدالة كمرجع وليس تنفيذها فورًا
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 100,
            width: double.infinity,
            padding: EdgeInsets.only(top: 40),
            alignment: Alignment.center,
            color: Colors.teal,
            child: Text(
              'دليلك السياحي',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          SizedBox(height: 20),
          buildListTile('الرحلات', Icons.card_travel, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile('الفلترة', Icons.filter_list, () {
            Navigator.of(context)
                .pushReplacementNamed(FiltersScreen.screenRout);
          }),
        ],
      ),
    );
  }
}
