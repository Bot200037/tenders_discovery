// ignore_for_file: file_names, avoid_print, prefer_const_constructors, prefer_final_fields, unnecessary_string_interpolations, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:tenders_discovery/pages/tender_pages/T_homepage.dart';
import '../../sqldb.dart';


class AddTender extends StatefulWidget {
  const AddTender({ Key? key }) : super(key: key);

  @override
  State<AddTender> createState() => _AddTenderState();
}

class _AddTenderState extends State<AddTender> {

/*

*/
SqlDb sqlDb = SqlDb();
TextEditingController _tenderTitle = TextEditingController();
TextEditingController _tenderOnwer = TextEditingController();
TextEditingController _tenderLocation = TextEditingController();
TextEditingController _startedDate = TextEditingController();
TextEditingController _finishedDate = TextEditingController();
TextEditingController _tenderCategory = TextEditingController();
TextEditingController _tenderDescription = TextEditingController();
String val="Personal";
List listItem = ["Personal", "Company"];

Future<void> _selectDateS() async {
  DateTime? _picked = await showDatePicker(
    context: context, 
    initialDate: DateTime.now(), 
    firstDate: DateTime(2000), 
    lastDate: DateTime(2100), 
    );
    if(_picked != null){
      setState(() {
        _startedDate.text = _picked.toString().split(" ")[0];
      });
    }
}
Future<void> _selectDateF() async {
  DateTime? _picked = await showDatePicker(
    context: context, 
    initialDate: DateTime.now(), 
    firstDate: DateTime(2000), 
    lastDate: DateTime(2100), 
    );
    if(_picked != null){
      setState(() {
        _finishedDate.text = _picked.toString().split(" ")[0];
      });
    }
}

     clearTable() async {
    await sqlDb.deleteData("DELETE FROM current_tender ");
    setState(() {});
     }

  @override
  void initState() {
    _tenderCategory.text = "Tender";
    readData();

    // TODO: implement initState
    super.initState();
  }
  Future<void> readData() async {
    Map<String, dynamic>? current_request = await sqlDb.getOneRow("current_request");

    if(current_request != null){
      setState(() {
      _tenderOnwer.text = current_request['user_name'];
      _tenderTitle.text = current_request['tenderTitle'];

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
                  onPressed: () async {
                    clearTable();
                    int responset1 = await sqlDb.insertData(
                      '''
                      INSERT INTO tenders ( user_name , tenderTitle , tenderLocation , startedDate , finishedDate , tenderCategory , tenderDescription)
                      VALUES ("${_tenderOnwer.text}" , "${_tenderTitle.text}" , "${_tenderLocation.text}" , "${_startedDate.text}" , "${_finishedDate.text}" , "${_tenderCategory.text}" , "${_tenderDescription.text}")
                      '''
                    );
                    if(responset1 > 0){
                    int responset2 = await sqlDb.insertData(
                      '''
                      INSERT INTO current_tender (tenderId , tenderTitle , tenderLocation , startedDate , finishedDate, tenderCategory, tenderDescription, user_name)
                      SELECT tenderId , tenderTitle , tenderLocation , startedDate , finishedDate, tenderCategory, tenderDescription , user_name
                      FROM tenders
                      '''
                    );
                    if(responset2 > 0){
                          print("done");
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => TenderHome()));
                    }}},
      ),
      body: SingleChildScrollView(
          child: Column(
               children: [
                SizedBox(height: 50),
                Container(
                  margin: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: Text('Add Tender', style: TextStyle(fontSize: 25)),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _tenderTitle,
                    decoration: InputDecoration(
                      labelText: 'Tender Title',
                      border: OutlineInputBorder(),
                      hintText: 'Tender Title',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _tenderOnwer,
                    decoration: InputDecoration(
                      labelText: 'Tender Onwer',
                      border: OutlineInputBorder(),
                      hintText: 'Tender Onwer',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _tenderLocation,
                    decoration: InputDecoration(
                      labelText: 'Tender Location',
                      border: OutlineInputBorder(),
                      hintText: 'Tender Location',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _startedDate,
                        decoration: InputDecoration(
                          labelText: 'Started Date',
                          hintText: 'Started Date',
                          icon: Icon(Icons.calendar_today),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)
                          ),
                        ),
                        readOnly: true,
                        onTap: _selectDateS,
                      ),
                      TextFormField(
                        controller: _finishedDate,
                        decoration: InputDecoration(
                          labelText: 'Finished Date',
                          hintText: 'Finished Date',
                          icon: Icon(Icons.calendar_today),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)
                          ),
                        ),
                        readOnly: true,
                        onTap: _selectDateF,
                      ),
                    ],
                  ),
                ),
                    Padding(
                     padding: const EdgeInsets.only(top: 20,left: 5,right: 5),
                          child: Text('Choose your Tender Category?',style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Theme.of(context).colorScheme.primaryVariant,
                                  ),),
                        ),
                    DropdownButton(
                          style: TextStyle(
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primaryVariant,
                              ),
                          borderRadius: BorderRadius.circular(20),
                          icon: Icon(Icons.arrow_drop_down),
                          underline: SizedBox(),
                          value: val,
                          onChanged: (newValue) {
                            setState(() {
                              val = newValue as String;
                              _tenderCategory.text = val;
                            });
                          },
                          items: listItem.map((valueItem){
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                        ),SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 10,
                    controller: _tenderDescription,
                    decoration: InputDecoration(
                      labelText: 'Tender Description',
                      border: OutlineInputBorder(),
                      hintText: 'Tender Description',
                    ),
                  ),
                ),               
               SizedBox(height: 20),
                ],
            ),
          ),
      

    );
  }
}
