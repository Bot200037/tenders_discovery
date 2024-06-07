// ignore_for_file: file_names, avoid_print, prefer_const_constructors, prefer_final_fields, unnecessary_string_interpolations
import 'package:flutter/material.dart';
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
String val="Commercial";
List listItem = ["Commercial", "Company"];

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


  @override
  void initState() {
    _tenderCategory.text = "Tender";

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
                  onPressed: () async {
/*                   int response = await sqlDb.singup("users", {
                        "user_name" : "${_userNameController.text}", 
                        "user_email" : "${_userEmailController.text}", 
                        "user_mobile" : "${_userMobileController.text}", 
                        "user_password" : "${_userPasswordController.text}", 
                        "user_type" : "${_userTypeController.text}", 
                    });
                    if ( response > 0){
                      //Navigator
                      Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => const LoginPage()));
                                }
 */                  },
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
                          //filled: true,
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
                          //filled: true,
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text("Choose your Tender Category?"),
                      DropdownButton(
                        hint: Text("Choose your Tender Category?"),
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
                      ),
                    ],
                  )
                ),
               SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 10,
                    controller: _tenderDescription,
                    decoration: InputDecoration(
                      labelText: 'Tender Description',
                      border: OutlineInputBorder(),
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
