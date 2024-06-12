// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:tenders_discovery/components/drawerA.dart';
import '../../sqldb.dart';

class AllRequests extends StatefulWidget {
  const AllRequests({ Key? key }) : super(key: key);

  @override
  State<AllRequests> createState() => _AllRequestsState();
}

class _AllRequestsState extends State<AllRequests> {
//========================================
String table_name = "current_user"  ;
  
  SqlDb sqlDb = SqlDb();
  List table = [];

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM tender_request WHERE requestStatus = 'Waiting'");
    table.addAll(response);
    if (mounted) {
      setState(() {});
    }
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
                  appBar: AppBar(
          elevation: 0,
          foregroundColor: Theme.of(context).colorScheme.primaryVariant,
          backgroundColor: Colors.transparent,
        ),

        drawer: const MyDrawerA(),
      backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Column(
                        mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
                child: Text(
                  'List of Requests',
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primaryVariant),
                ),
              ),
              
                  table.isEmpty
                      ? Container(
                        child: const Center(
                            child: Text("There are no requests yet"),),
                      )
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
                            padding: const EdgeInsets.all(1.0),
                            child: Card(
                              child: ListTile(
                                title: Text(table[i]['tenderTitle']),
                                subtitle: Text(table[i]['user_name']),
                                trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                    onPressed: () async {
                                    int response = await sqlDb.updateData(
                                        '''
                                                    UPDATE tender_request SET
                                                    requestStatus = "Done"
                                                    WHERE tend_requestId = ${table[i]['tend_requestId']}
                                                    '''
                                    );
                                    if(response > 0){
                                      setState(() {
                                        
                                      });
                                      print("Done");
                                    }
                                    },
                                    icon: const Icon(Icons.check,color: Colors.green,)),
                                IconButton(
                                    onPressed: () {
                                      showDialog<void>(
                                        context: context,
                                        barrierDismissible:
                                        false,
                                        // false = user must tap button, true = tap outside dialog
                                        builder: (BuildContext
                                        dialogContext) {
                                          return AlertDialog(
                                            title: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      right:
                                                      5.0),
                                                  child: Icon(
                                                      Icons
                                                          .warning_amber_outlined),
                                                ),
                                                Text(
                                                  'Warnig',
                                                  style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            content:
                                            const Text(
                                                'Are you sure not to approve this request?'),
                                            actions: <Widget>[

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  TextButton(
                                                    child:
                                                    Text(
                                                      'Yes',
                                                      style: TextStyle(
                                                          color: Theme.of(context).colorScheme.primaryVariant),
                                                    ),
                                                    onPressed:
                                                        () async{
                                                      int response =
                                                      await sqlDb.deleteData(
                                                          "DELETE FROM tender_request WHERE tend_requestId = ${table[i]['tend_requestId']}");
                                                      if (response > 0) {
                                                        table.removeWhere(
                                                                (element) =>
                                                            element['tend_requestId'] ==
                                                                table[i]['tend_requestId']);
                                                        setState(() {});
                                                      }
                                                      Navigator.of(
                                                          dialogContext)
                                                          .pop(); // Dismiss alert dialog

                                                        },
                                                  ),

                                                  TextButton(
                                                    child:
                                                      Text(
                                                      'Cenel',
                                                      style: TextStyle(
                                                          color: Theme.of(context).colorScheme.primaryVariant),
                                                    ),
                                                    onPressed:
                                                        () {
                                                      Navigator.of(
                                                          dialogContext)
                                                          .pop(); // Dismiss alert dialog
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      );


                                    },
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    )),
                              ],
                            ),                                
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
      );
  }
}