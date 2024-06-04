// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'sqldb.dart';

class TestTable extends StatefulWidget {
  const TestTable({ Key? key }) : super(key: key);

  @override
  State<TestTable> createState() => _TestTableState();
}

class _TestTableState extends State<TestTable> {
//========================================
String table_name = "users"  ;
  
  SqlDb sqlDb = SqlDb();
  bool isLoading = true;
  List table = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM $table_name");
    table.addAll(response);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: ListView(
                              children: [
                                ListView.builder(
                                  itemCount: table.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, i) {
                                    return Column(
                                      children: [
                                        Text("${i+1}"),
                                        Text(table[i]['user_name']),
                                        Text(table[i]['user_email']),
                                        Text(table[i]['user_mobile']),
                                        Text(table[i]['user_password']),
                                        Text(table[i]['user_type']),
                                        const SizedBox(height: 20),
                                      ],
                                    );
                                    },
                                ),
                              ],
                            ),
      );
  }
}