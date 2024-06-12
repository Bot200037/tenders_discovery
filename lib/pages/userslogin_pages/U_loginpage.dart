// ignore_for_file: file_names, avoid_print, prefer_const_constructors, prefer_final_fields, unnecessary_string_interpolations
import 'package:flutter/material.dart';
import 'package:tenders_discovery/pages/admin_pages/A_homepage.dart';
import 'package:tenders_discovery/pages/contractor_pages/C_homepage.dart';
import 'package:tenders_discovery/pages/tender_pages/T_homepage.dart';
import 'package:tenders_discovery/pages/userslogin_pages/U_registerpage.dart';
import 'package:tenders_discovery/test_table.dart';
import '../../sqldb.dart';
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
  bool isCheckTrue = false;
  final formKey = GlobalKey<FormState>();

  check()async{
    var responseA =
    await sqlDb.check('''
    SELECT * FROM users
    WHERE user_name = '${_userNameController.text}'
    AND user_password = '${_userPasswordController.text}'
    AND user_type = 'Admin'
    ''');

    var responseT =
    await sqlDb.check('''
    SELECT * FROM users
    WHERE user_name = '${_userNameController.text}'
    AND user_password = '${_userPasswordController.text}'
    AND user_type = 'Tender'
    ''');
    var responseC =
    await sqlDb.check('''
    SELECT * FROM users
    WHERE user_name = '${_userNameController.text}'
    AND user_password = '${_userPasswordController.text}'
    AND user_type = 'Contractor'
    ''');

      if (responseA == true){
      if(!mounted) return;      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => AdminHome()));
    } else if (responseT == true){
      if(!mounted) return;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => TenderHome()));
    } else if (responseC == true) {
      if(!mounted) return;
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => ContractorHome()));
    } else {
      setState(() {
        isCheckTrue = true;
      });
    }
  }
    clearTable() async {
    await sqlDb.deleteData("DELETE FROM current_user ");
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background
              
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 60.0,left: 22),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Text('Hello\nsign in!', style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).colorScheme.primaryVariant,
                        fontWeight: FontWeight.bold
                    ),),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                          },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_outlined,
                            textDirection: TextDirection.rtl,size: 50,color: Colors.white,),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 200.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    color: Theme.of(context).colorScheme.primary,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0,right: 18),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: _userNameController,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Username is Required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              icon: Icon(Icons.person,color: Colors.grey),
                              suffixIcon: Icon(Icons.check,
                                  color: Theme.of(context).colorScheme.primaryVariant),
                              label: Text('User Name',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primaryVariant
                              ),),
                              hintText: 'User Name',
                          ),
                        ),
                        TextFormField(
                          controller: _userPasswordController,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Password is Required";
                            }
                            return null;
                          },
                          obscureText: isVisible,
                          decoration: InputDecoration(
                              icon: Icon(Icons.lock,
                              color: Theme.of(context).colorScheme.secondary),
                              suffixIcon: IconButton(
                                icon: Icon(isVisible
                                    ?Icons.visibility_off
                                    :Icons.visibility,color: Colors.grey),
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },),
                              label: Text('Password',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primaryVariant
                              ),),
                              hintText: 'Password',
                          ),
                        ),
                        isCheckTrue
                            ? const Text(
                          "Username or Password is Incorrect",
                          style: TextStyle(color: Colors.red),
                        ) :const SizedBox(height: 20,),
                         Align(
                          alignment: Alignment.centerRight,
                          child: Text('Forget Password?',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Theme.of(context).colorScheme.primaryVariant
                          ),
                          ),
                        ),
                        const SizedBox(height: 70,),
                        GestureDetector(
                          onTap: () async{
                            if(formKey.currentState!.validate()){
                              clearTable();
                        int response = await sqlDb.insertData(
                          '''
                          INSERT INTO current_user (user_id , user_name , user_email , user_mobile , user_password , user_type)
                          SELECT user_id , user_name , user_email , user_mobile , user_password , user_type
                          FROM users
                          WHERE user_name = '${_userNameController.text}'
                          AND user_password = '${_userPasswordController.text}'
                          '''
                        );
                        if(response > 0){
                              check();
                        }
                            }
                          },
                          child: Container(
                              height: 55,
                              width: 300,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Theme.of(context).colorScheme.primaryVariant
                              ),
                              child: Center(child: Text('LOGIN',style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.primary

                              ),),
                              )
                          ),
                        ),
                        const SizedBox(height: 150,),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                             Text("Don't have account?",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.secondary
                              ),),
                              GestureDetector(
                                onTap: (){
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) => const RegisterPage()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child:  Text("Sign up",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  color: Theme.of(context).colorScheme.primaryVariant
                                  ),),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
