// ignore_for_file: file_names, avoid_print, prefer_const_constructors, prefer_final_fields, unnecessary_string_interpolations, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:tenders_discovery/components/drawerC.dart';
import 'package:tenders_discovery/pages/contractor_pages/C_homepage.dart';

import '../../sqldb.dart';

class AddContract extends StatefulWidget {
  final id;

  const AddContract({Key? key, this.id}) : super(key: key);

  @override
  State<AddContract> createState() => _AddContractState();
}

class _AddContractState extends State<AddContract> {
  SqlDb sqlDb = SqlDb();
TextEditingController _tenderTitle = TextEditingController();
TextEditingController _tenderOnwer = TextEditingController();
TextEditingController _tenderLocation = TextEditingController();
TextEditingController _startedDate = TextEditingController();
TextEditingController _finishedDate = TextEditingController();
TextEditingController _tenderCategory = TextEditingController();
TextEditingController _tenderDescription = TextEditingController();
TextEditingController _user_name = TextEditingController();
TextEditingController _user_mobile = TextEditingController();
TextEditingController _contractDescription = TextEditingController();





  @override
  void initState() {
    readData();

    // TODO: implement initState
    super.initState();
  }

  Future<void> readData() async {
    Map<String, dynamic>? tenders = await sqlDb.readData("SELECT * FROM tenders WHERE tenderId = ${widget.id}");
    Map<String, dynamic>? current_user = await sqlDb.getOneRow("current_user");

    if(tenders != null){
      setState(() {
      _tenderTitle.text = tenders['tenderTitle'];
      _tenderOnwer.text = tenders['user_name'];
      _tenderLocation.text = tenders['tenderLocation'];
      _startedDate.text = tenders['startedDate'];
      _finishedDate.text = tenders['finishedDate'];
      _tenderCategory.text = tenders['tenderCategory'];
      _tenderDescription.text = tenders['tenderDescription'];
      });
    }
    if(current_user != null){
      setState(() {
     _user_name.text = current_user['user_name'];
     _user_mobile.text = current_user['_user_mobile'];

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
          alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
            children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryVariant,
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: Theme.of(context).colorScheme.primaryVariant),
                      ),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40),),
                        ),
                        color: Theme.of(context).colorScheme.primary,
                        elevation: 10,
                        child: Column(
                          children: [
                            const Text("Tender info",style:
                            TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                            ListTile(
                              title: Text(_tenderTitle.text,style:
                              TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                              trailing: Text(_tenderOnwer.text,style:
                              TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                              subtitle: Center(child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(_tenderCategory.text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                                  Text(_tenderLocation.text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                  Text(_startedDate.text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                                  Text(_finishedDate.text,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                                ],
                                
                              )),
                            ),
                            Container(
                              height: 450,
                              width: 300,
                              decoration: BoxDecoration(
                                border: Border.all(color: Theme.of(context).colorScheme.primaryVariant,width:1)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20,left: 5,right: 5),
                                child: Text(_tenderDescription.text,style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Theme.of(context).colorScheme.primaryVariant,
                                  ),),),),
                                  const SizedBox(height: 20,),                          
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                              child: Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primaryVariant,
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(color: Theme.of(context).colorScheme.primaryVariant),
                              ),
                              child: Card(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(40),),
                                ),
                                color: Theme.of(context).colorScheme.primary,
                                elevation: 10,
                                  child: Column(
                                    children: [
                                      const Text("Contract info",style:
                                      TextStyle(fontWeight: FontWeight.bold,fontSize: 10),),
                                      ListTile(
                                        title: Text(_user_name.text),
                                        subtitle: Text(_user_mobile.text),
                                      ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            maxLines: 10,
                                            controller: _contractDescription,
                                            decoration: InputDecoration(
                                              labelText: 'Contract Description',
                                              border: OutlineInputBorder(),
                                              hintText: 'Contract Description',
                                            ),
                                          ),
                                        ),               
                                      SizedBox(height: 20), 
                                      GestureDetector(
                                        onTap: ()async{
                                          int responset1 = await sqlDb.insertData(
                                          '''
                                          INSERT INTO contracts (user_name , user_mobile , user_id , tenderId , contractDescription)
                                          SELECT user_name , user_name , user_mobile ,
                                          ${widget.id}
                                          ${_contractDescription.text}
                                          FROM current_user
                                          '''
                                        );
                                        if(responset1 > 0){
                                        print("done");
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder: (context) => ContractorHome()));
                                        }
                                        },
                                        child: Container(
                                          height: 53,
                                          width: 320,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                              border: Border.all(
                                                color: Theme.of(context).colorScheme.primaryVariant
                                                )
                                          ),
                                          child:  Center(child: Text('Submit',style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context).colorScheme.primaryVariant
                                          ),),),
                                        ),
                                      ),
                                      const SizedBox(height: 30,),
                                    ],
                                  )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}