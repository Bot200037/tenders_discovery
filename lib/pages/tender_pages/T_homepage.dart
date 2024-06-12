// ignore_for_file: file_names, avoid_print, prefer_const_constructors, prefer_final_fields, unnecessary_string_interpolations, non_constant_identifier_names
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:tenders_discovery/pages/tender_pages/T_addpage.dart';

import '../../sqldb.dart';
import 'T_requestpage.dart';

class TenderHome extends StatefulWidget {
  const TenderHome({ Key? key }) : super(key: key);

  @override
  State<TenderHome> createState() => _TenderHomeState();
}

class _TenderHomeState extends State<TenderHome> {
  SqlDb sqlDb = SqlDb();
  List table = [];


TextEditingController _tenderTitle = TextEditingController();
TextEditingController _tenderOnwer = TextEditingController();
TextEditingController _tenderLocation = TextEditingController();
TextEditingController _startedDate = TextEditingController();
TextEditingController _finishedDate = TextEditingController();
TextEditingController _tenderCategory = TextEditingController();
TextEditingController _tenderDescription = TextEditingController();

  bool isCheckTrue = false;

  @override
  void initState() {
    super.initState();
    readData();
  }
  Map<String, dynamic>? current_tender;
  Future<void> readData() async {
     current_tender = await sqlDb.getOneRow("current_tender");
    List<Map> response = await sqlDb.readData("SELECT * FROM contracts");
    table.addAll(response);
    if (mounted) {
      setState(() {});
    }

    if(current_tender != null){
      setState(() {
      _tenderTitle.text = current_tender!['tenderTitle'];
      _tenderOnwer.text = current_tender!['user_name'];
      _tenderLocation.text = current_tender!['tenderLocation'];
      _startedDate.text = current_tender!['startedDate'];
      _finishedDate.text = current_tender!['finishedDate'];
      _tenderCategory.text = current_tender!['tenderCategory'];
      _tenderDescription.text = current_tender!['tenderDescription'];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                alignment: Alignment.center,
                color: Theme.of(context).colorScheme.primaryVariant,
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width * 1.0,
                child: 
                current_tender == null                
                ?
                IconButton(
                  icon: Icon(Icons.add_circle,color: Theme.of(context).colorScheme.primary),
                  iconSize: 100,
                  onPressed: (){
                  Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => RequestPage()));
                  },
                )
                :
                Card(
                  child: ListTile(
                    title: Text(_tenderTitle.text),
                    trailing: Text(_tenderOnwer.text),
                  ))
              ),
                                  table.isEmpty
                                      ? const Center(
                            child: Text("There are no tenders yet"),)
                        :
                ListView(
                  children: [
                    ListView.builder(
                      itemCount: table.length,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: ListTile(
                                  onTap: (){
/*                                     Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AddContract(
                                                                id: table[i]['tenderId'],
                                                              )));
 */                                  },
                                  title: Text(table[i]['user_name']),
                                  subtitle: Text(table[i]['user_mobile']),
                              )),
                            )
                          ],
                        );
                        },
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}