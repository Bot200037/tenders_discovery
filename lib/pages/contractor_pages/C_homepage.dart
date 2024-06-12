// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:tenders_discovery/components/drawerA.dart';
import 'package:tenders_discovery/components/drawerC.dart';
import 'package:tenders_discovery/pages/contractor_pages/C_addpage.dart';
import '../../sqldb.dart';

class ContractorHome extends StatefulWidget {
  const ContractorHome({ Key? key }) : super(key: key);

  @override
  State<ContractorHome> createState() => _ContractorHomeState();
}

class _ContractorHomeState extends State<ContractorHome> {
//========================================
  
  SqlDb sqlDb = SqlDb();
  List table = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM tenders");
    table.addAll(response);
    if (mounted) {
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        drawer: const MyDrawerC(),
      backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
                  child: Text(
                    'List of Tenders',
                    style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primaryVariant),
                  ),
                ),
                
                    table.isEmpty
                        ? const Center(
                            child: Text("There are no tenders yet"),)
                        :
                Column(
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
                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AddContract(
                                                                id: table[i]['tenderId'],
                                                              )));
                                  },
                                  title: Text(table[i]['tenderTitle']),
                                  subtitle: Text(table[i]['user_name']),
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