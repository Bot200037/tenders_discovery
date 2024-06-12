// ignore_for_file: file_names, avoid_print, prefer_const_constructors, prefer_final_fields, unnecessary_string_interpolations
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tenders_discovery/pages/tender_pages/T_homepage.dart';

import '../settings_page.dart';
import 'drawer_tile.dart';


class MyDrawerT extends StatelessWidget {
  const MyDrawerT({Key? key}) : super(key: key);


  @override

  Widget build(BuildContext context) {

    return Drawer(
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children:  [
            DrawerHeader(
              padding: EdgeInsets.all(7.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.secondary,)

                      ),
                      child: const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.transparent,
                          //backgroundImage: AssetImage('assets/barber-logo.png')
                        //AssetImage('assets/programmer_light.jpg'),
                      )
                    ),
                    Container(
                      height: 25,
                      width: 150,
                      alignment: Alignment.center,
                      child: Text('Tenders Discovery',style: TextStyle(
                          fontSize: 17.5,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primaryVariant
                      ),),
                    ),
                    const SizedBox(height: 10,)
                  ],
                )),
            DrawerTile(
              title: 'Home Page',
              leading: const Icon(Icons.home),
              ontap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const TenderHome())
                );
              }),
            DrawerTile(
              title: 'Settings',
              leading: const Icon(Icons.settings),
              ontap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SettingsPage())
                );
              },),

/*             DrawerTile(
              title: Locales.string(context, 'about_drawer'),
              leading: const Icon(Icons.account_balance),
              ontap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AboutDev())
                );
              },),
 */
          ],
        ),
      ),
    );
  }
}
