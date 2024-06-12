// ignore_for_file: file_names, avoid_print, prefer_const_constructors, prefer_final_fields, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:tenders_discovery/pages/userslogin_pages/U_loginpage.dart';
import 'package:tenders_discovery/pages/userslogin_pages/U_registerpage.dart';

import '../../sqldb.dart';

class Welcome extends StatefulWidget {
  const Welcome({ Key? key }) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
SqlDb sqlDb = SqlDb();
@override
  Future<void> readData() async {
        var responseA =
    await sqlDb.check('''
    SELECT * FROM users
    WHERE user_name = 'admin'
    AND user_password = '123'
    AND user_type = 'Admin'
    ''');
    if (responseA == false){
      if(!mounted) return;
    int responset2 = await sqlDb.singup("users", {
  "user_name" : "admin", 
  "user_email" : "tender_discovery@gmail.com", 
  "user_mobile" : "*************", 
  "user_password" : "123", 
  "user_type" : "Admin", 
  });
print(responset2);
    } 

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();

  }  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
                ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Container(
                color: Colors.transparent,
                height: 200,
                width: 200,
                child: Icon(Icons.account_circle,size: 200,
                color: Theme.of(context).colorScheme.primaryVariant),
              ),
            ),
            const SizedBox(height: 100,),
            Text('Welcome Back', style: TextStyle(
              fontSize: 30,
              color: Theme.of(context).colorScheme.primaryVariant
            ),),
            const SizedBox(height: 30,),
            GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
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
                child:  Center(child: Text('LOGIN',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primaryVariant
                ),),),
              ),
            ),
            const SizedBox(height: 30,),
            GestureDetector(
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()));
              },
              child: Container(
                height: 53,
                width: 320,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.secondary
                      )
                ),
                child: Center(child: Text('SIGN IN',style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primaryVariant
                ),),),

              ),
            ),
            const Spacer(),
             Text('Login with Social Media',style: TextStyle(
                fontSize: 17,
                color: Theme.of(context).colorScheme.primaryVariant
            ),),
            const SizedBox(height: 12,),
            Padding(
              padding: const EdgeInsets.only(top: 10.0,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.alternate_email,size: 30,color: Theme.of(context).colorScheme.primaryVariant,),
                  SizedBox(width: 10,),
                  Icon(Icons.facebook,size: 30,color: Theme.of(context).colorScheme.primaryVariant,),
                  SizedBox(width: 10,),
                  Icon(Icons.add_to_home_screen,size: 30,color: Theme.of(context).colorScheme.primaryVariant,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

