// ignore_for_file: file_names, avoid_print, prefer_const_constructors, prefer_final_fields, unnecessary_string_interpolations
import 'package:flutter/material.dart';
import 'package:tenders_discovery/components/drawerA.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.primaryVariant,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,

      drawer: const MyDrawerA(),

      body: Container(
        color: Colors.white,
        child: Center(
          child: Text('Admin Home Page'),),
        ),
    );
  }
}