// ignore_for_file: file_names, avoid_print, prefer_const_constructors, prefer_final_fields, unnecessary_string_interpolations
import 'package:flutter/material.dart';
import 'U_loginpage.dart';
import '../../sqldb.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

SqlDb sqlDb = SqlDb();
TextEditingController _userNameController = TextEditingController();
TextEditingController _userEmailController = TextEditingController();
TextEditingController _userMobileController = TextEditingController();
TextEditingController _userPasswordController = TextEditingController();
TextEditingController _userConfirmPasswordController = TextEditingController();
TextEditingController _userTypeController = TextEditingController();
String val="Contractor";
List listItem = ["Tender", "Contractor"];

  bool isVisible = true;
  final formKey = GlobalKey<FormState>();



@override
  void initState() {
    _userTypeController.text = "Tender";

    // TODO: implement initState
    super.initState();
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
                     Text('Create Your\nAccount!', style: TextStyle(
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
              padding: const EdgeInsets.only(top: 200.0),
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
                              suffixIcon: Icon(Icons.check,color: Colors.grey),
                              icon: Icon(Icons.person,color: Colors.grey),
                              label: Text('User Name',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primaryVariant,
                              ),),
                              hintText: 'User Name',
                          ),
                        ),
                        TextFormField(
                          controller: _userEmailController,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Gmail is Required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.check,color: Colors.grey),
                              icon: Icon(Icons.email,color: Colors.grey),
                              label: Text('Gmail',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primaryVariant,
                              ),),
                              hintText: 'Gmail',
                          ),
                        ),
                        TextFormField(
                          controller: _userMobileController,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Mobile is Required";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              suffixIcon: Icon(Icons.check,color: Colors.grey),
                              icon: Icon(Icons.phone_android,color: Colors.grey),
                              label: Text('Mobile',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primaryVariant,
                              ),),
                              hintText: 'Mobile',
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
                              label: Text('Password',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primaryVariant,
                              ),),
                              hintText: 'Password',
                          ),
                        ),
                        TextFormField(
                          controller: _userConfirmPasswordController,
                          validator: (value){
                            if(value!.isEmpty){
                              return "Password is Required";
                            }else if(_userPasswordController.text != _userConfirmPasswordController.text){
                              return "Password don't match";
                            }
                            return null;
                          },

                          obscureText: isVisible,
                          decoration: InputDecoration(
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
                              label: Text('Confirm Password',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primaryVariant,
                              ),),
                              hintText: 'Confirm Password',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20,left: 5,right: 5),
                          child: Text('Choose your job?',style: TextStyle(
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
                              _userTypeController.text = val;
                            });
                          },
                          items: listItem.map((valueItem){
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 40,),
                        GestureDetector(
                          onTap: ()async{
                            if(formKey.currentState!.validate()){
                       int response = await sqlDb.singup("users", {
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
                            }
                          },
                          child: Container(
                              height: 55,
                              width: 300,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Theme.of(context).colorScheme.primaryVariant,
                                  
                              ),
                              child: Center(child: Text('SIGN UP',style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.primary,

                              ),),
                              )
                          ),
                        ),
                        const SizedBox(height: 40,),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                             Text("You already have an account!",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                              ),),
                              GestureDetector(
                                onTap: () async{
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) => const LoginPage()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text("Login",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Theme.of(context).colorScheme.primaryVariant,
                                  ),),
                                ),
                              ),
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

/* 
                onPressed: () async {
                  int response = await sqlDb.singup("users", {
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
                  },

DropdownButton(
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
              
 */