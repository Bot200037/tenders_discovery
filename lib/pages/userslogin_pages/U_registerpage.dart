// ignore_for_file: file_names, avoid_print, prefer_const_constructors, prefer_final_fields
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  
TextEditingController _userNameController = TextEditingController();
TextEditingController _userEmailController = TextEditingController();
TextEditingController _userMobileController = TextEditingController();
TextEditingController _userPasswordController = TextEditingController();
TextEditingController _userTypeController = TextEditingController();
String val="Tender";
List listItem = ["Tender", "Contractor"];


@override
  void initState() {
    _userTypeController.text = "Tender";

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
             children: [
              SizedBox(height: 200),
              Container(
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text('Register For Free', style: TextStyle(fontSize: 25)),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _userEmailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _userMobileController,
                  decoration: InputDecoration(
                    labelText: 'Mobile',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _userPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  hint: Text("Choose your job?"),
                  icon: Icon(Icons.arrow_drop_down),
                  underline: SizedBox(),
                  value: val,
                  onChanged: (newValue) {
                    setState(() {
                      val = newValue as String;
                      _userTypeController.text = val;
                    });
                  },
                  items: listItem.map((valueItem){
                    return DropdownMenuItem(
                      value: valueItem,
                      child: Text(valueItem),
                    );
                  }).toList(),
                )
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){},
                child: Text('Register'),
              ),
             ],
          ),
        ),

    );
  }
}