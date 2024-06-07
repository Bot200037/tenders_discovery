// ignore_for_file: file_names, avoid_print, prefer_const_constructors, prefer_final_fields, unnecessary_string_interpolations
import 'package:flutter/material.dart';
import 'package:tenders_discovery/pages/tender_pages/T_addpage.dart';

import 'T_requestppage.dart';

class TenderHome extends StatefulWidget {
  const TenderHome({ Key? key }) : super(key: key);

  @override
  State<TenderHome> createState() => _TenderHomeState();
}

class _TenderHomeState extends State<TenderHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              color: Colors.green,
              height: MediaQuery.of(context).size.height * 0.15,
              width: MediaQuery.of(context).size.width * 1.0,
              child: Text('User'),
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.blue,
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 1.0,
              child: IconButton(
                icon: Icon(Icons.add_circle),
                iconSize: 100,
                onPressed: (){
                Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => RequestPage()));
                },
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              color: Colors.yellow,
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 1.0,
              child: Text('Contract'),
            ),
          ],
        ),
      ),
    );
  }
}