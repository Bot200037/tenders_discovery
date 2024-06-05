// ignore_for_file: file_names, avoid_print, prefer_const_constructors, prefer_final_fields, unnecessary_string_interpolations
import 'package:flutter/material.dart';
import 'package:tenders_discovery/pages/contractor_pages/C_homepage.dart';
import 'package:tenders_discovery/pages/tender_pages/T_homepage.dart';
import 'package:tenders_discovery/pages/userslogin_pages/U_registerpage.dart';
import '../../sqldb.dart';
import '../../test_table.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
SqlDb sqlDb = SqlDb();
TextEditingController _userNameController = TextEditingController();
TextEditingController _userPasswordController = TextEditingController();
  bool isVisible = true;
  bool isLoginTrue = false;

  login()async{
    var responseT =
    await sqlDb.login('''
    SELECT * FROM users
    WHERE user_name = '${_userNameController.text}'
    AND user_password = '${_userPasswordController.text}'
    AND user_type = 'Tender'
    ''');
    var responseC =
    await sqlDb.login('''
    SELECT * FROM users
    WHERE user_name = '${_userNameController.text}'
    AND user_password = '${_userPasswordController.text}'
    AND user_type = 'Contractor'
    ''');

    if(responseT == true){
      if(!mounted) return;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => TenderHome()));
    } else if (responseC == true) {
      if(!mounted) return;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => ContractorHome()));
    } else {
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),),
      body: Padding(
  padding: const EdgeInsets.all(16.0),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _userNameController,
                  decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              icon: Icon(Icons.person,color: Colors.grey),
                              suffixIcon: Icon(Icons.check,color: Colors.grey),
                              label: Text('User Name'),
                          ),
                        ),
                ),
      SizedBox(height: 8),
      Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _userPasswordController,
                  obscureText: isVisible,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              icon: const Icon(Icons.lock,color: Colors.grey),
                              suffixIcon: IconButton(
                                icon: Icon(isVisible
                                    ?Icons.visibility_off
                                    :Icons.visibility,color: Colors.grey),
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },),
                              label: Text('Password')
                ),
              ),),
                        isLoginTrue
                            ? const Text(
                          "Username or Password is Incorrect",
                          style: TextStyle(color: Colors.red),
                        ) :const SizedBox(height: 20,),
      SizedBox(height: 16),
              ElevatedButton(onPressed: (){
                Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const RegisterPage()));        
              },
              child: Text("Register Page")),
              SizedBox(height: 20),
                    ElevatedButton(
        onPressed: () {
          // Handle login button press
          login();
        },
        child: Text('Login'),
      ),
    ],
  ),
),
    );
  }
}