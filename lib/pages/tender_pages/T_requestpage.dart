// ignore_for_file: file_names, avoid_print, prefer_const_constructors, prefer_final_fields, unnecessary_string_interpolations, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenders_discovery/pages/tender_pages/T_addpage.dart';
import '../../sqldb.dart';
import '/theme/theme_provider.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({ Key? key }) : super(key: key);

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
SqlDb sqlDb = SqlDb();
TextEditingController _user_name = TextEditingController();
TextEditingController _tenderTitle = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isCheckTrue = false;
  bool isRequestDone = false;

  check()async{
    var response =
    await sqlDb.check('''
    SELECT * FROM tender_request
    WHERE user_name = '${_user_name.text}'
    AND tenderTitle = '${_tenderTitle.text}'
    AND requestStatus = 'Done'
    ''');

    if (response == true){
      if(!mounted) return;
      isRequestDone = true;
              isCheckTrue = true;

       } else {
      setState(() {
        isCheckTrue = true;
        isRequestDone = false;

      });
    }
  }
    
     clearTable() async {
    await sqlDb.deleteData("DELETE FROM current_request ");
    setState(() {});
  }
  @override
  void initState() {
    super.initState();
    readData();
    check();
  }

  Future<void> readData() async {
    Map<String, dynamic>? current_request = await sqlDb.getOneRow("current_request");
    Map<String, dynamic>? current_user = await sqlDb.getOneRow("current_user");

    if(current_request != null){
      setState(() {
      _user_name.text = current_request['user_name'];
      _tenderTitle.text = current_request['tenderTitle'];

      });
    } else if(current_user != null){
      setState(() {
     _user_name.text = current_user['user_name'];

      });
    }
  }

  @override
  Widget build(BuildContext context) {

    bool colorDark = Provider.of<ThemeProvider>(context,listen: false).isDarkMode;


    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
              children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 25, right: 25),
              child: Text(
                'Tender Request',
                style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primaryVariant),
              ),
            ),
                
                const SizedBox(height: 1,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    height: 50,
                                  ),
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
                                            const SizedBox(
                                              height: 50,
                                            ),
                                             ListTile(
                                              title: const Center(child: Text("Write your name and title tender",style:
                                              TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                                              subtitle: Center( 
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                    TextFormField(
                                                      controller: _user_name,
                                                      validator: (value){
                                                        if(value!.isEmpty){
                                                          return "Username is Required";
                                                        }
                                                        return null;
                                                      },
                                                      decoration: InputDecoration(
                                                          icon: Icon(Icons.person,color: Theme.of(context).colorScheme.secondary),
                                                          label: Text('User Name',style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                          ),),
                                                          hintText: 'User Name',
                                                      ),
                                                    ),
                                                    TextFormField(
                                                      controller: _tenderTitle,
                                                      validator: (value){
                                                        if(value!.isEmpty){
                                                          return "Tender Title is Required";
                                                        }
                                                        return null;
                                                      },
                                                      decoration: InputDecoration(
                                                          icon: Icon(Icons.trending_up ,color: Theme.of(context).colorScheme.secondary),
                                                          label: const Text('Tender Title',style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                          ),),
                                                          hintText: 'Tender Title',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),                                          ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: Theme.of(context).colorScheme.primaryVariant,width: 5),
                                ),

                                child: colorDark == false
                                  ? CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                    child: Text(
                                    '1',
                                    style: TextStyle(
                                        fontSize: 60,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.primaryVariant),
                                  ),
                                  //backgroundImage: AssetImage('assets/programmer_light.jpg')
                                      //AssetImage('assets/programmer_light.jpg'),
                                )
                                  : CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                    child: Text(
                                    '1',
                                    style: TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.primaryVariant),
                                  ),

                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    height: 50,
                                  ),
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
                                            const SizedBox(
                                              height: 50,
                                            ),
                                             ListTile(
                                              title: const Center(child: Text("Pay 10\$",style:
                                              TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                                              subtitle: Center(
                                                child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: const [
                                                  Text('"',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                                                  Text("on one of our bank accounts",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                                  Text('"',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                                                ],
                                              )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text('Alomqy: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                                                        Text(' 2514325346356',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey)),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text('Albosaery: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                                                        Text(' 2514325346356',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey)),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text('Kuraimi: ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                                                        Text(' 2514325346356',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.grey)),
                                                      ],
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: Theme.of(context).colorScheme.primaryVariant,width: 5),
                                ),

                                child: colorDark == false
                                  ? CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                    child: Text(
                                    '2',
                                    style: TextStyle(
                                        fontSize: 60,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.primaryVariant),
                                  ),
                                  //backgroundImage: AssetImage('assets/programmer_light.jpg')
                                      //AssetImage('assets/programmer_light.jpg'),
                                )
                                  : CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                    child: Text(
                                    '2',
                                    style: TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.primaryVariant),
                                  ),

                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    height: 50,
                                  ),
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
                                            const SizedBox(
                                              height: 50,
                                            ),
                                             ListTile(
                                              title: const Center(child: Text("Send your payment bill",style:
                                              TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                                              subtitle: Center(child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: const [
                                                  Text('"',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                                                  Text("via our Gamil",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                                  Text('"',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                                                ],
                                              )),
                                            ),
                                            socialButtons(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: Theme.of(context).colorScheme.primaryVariant,width: 5),
                                ),

                                child: colorDark == false
                                  ? CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                    child: Text(
                                    '3',
                                    style: TextStyle(
                                        fontSize: 60,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.primaryVariant),
                                  ),
                                  //backgroundImage: AssetImage('assets/programmer_light.jpg')
                                      //AssetImage('assets/programmer_light.jpg'),
                                )
                                  : CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                    child: Text(
                                    '3',
                                    style: TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.primaryVariant),
                                  ),

                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(
                                    height: 50,
                                  ),
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
                                            const SizedBox(
                                              height: 50,
                                            ),
                                             ListTile(
                                              title: const Center(child: Text("Send a request to the admin",style:
                                              TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                                              subtitle: Center(child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: const [
                                                  Text('"',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                                                  Text("for view of Tender",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                                                  Text('"',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                                                ],
                                              )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                 GestureDetector(
                                                  onTap: () async{
                                                  clearTable();
                                                  int responset1 = await sqlDb.insertData(
                                                    '''
                                                    INSERT INTO tender_request (user_id , user_name , tenderTitle , requestStatus)
                                                    SELECT user_id , user_name , "${_tenderTitle.text}" , "Waiting"
                                                    FROM current_user
                                                    '''
                                                  );
                                                  if(responset1 > 0){
                                                  int responset2 = await sqlDb.insertData(
                                                    '''
                                                    INSERT INTO current_request (tend_requestId , user_id , user_name , tenderTitle , requestStatus)
                                                    SELECT tend_requestId , user_id , user_name , tenderTitle , requestStatus
                                                    FROM tender_request
                                                    '''
                                                  );
                                                  if(responset2 > 0){
                                                        print("done");
                                                  }}
                                                  },
                                                  child: Container(
                                                    height: 45,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(30),
                                                        border: Border.all(color: Colors.green)
                                                    ),
                                                    child: const Center(child: Text('Request',style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black
                                                    ),),),
                                                  ),
                                                ),
                                                 GestureDetector(
                                                  onTap: (){
                                                      Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    height: 45,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(30),
                                                        border: Border.all(color: Colors.red)
                                                    ),
                                                    child: const Center(child: Text('Cencel',style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black
                                                    ),),),
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
                                ],
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(color: Theme.of(context).colorScheme.primaryVariant,width: 5),
                                ),

                                child: colorDark == false
                                  ? CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Theme.of(context).colorScheme.primary,
                                    child: Text(
                                    '4',
                                    style: TextStyle(
                                        fontSize: 60,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.primaryVariant),
                                  ),
                                  //backgroundImage: AssetImage('assets/programmer_light.jpg')
                                      //AssetImage('assets/programmer_light.jpg'),
                                )
                                  : CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Theme.of(context).colorScheme.primary,
                                    child: Text(
                                    '4',
                                    style: TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.primaryVariant),
                                  ),

                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5,),
                isCheckTrue
                          ?                 
                        GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => AddTender()));
                          },
                        child: Container(
                          height: 45,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryVariant,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.green)
                          ),
                          child: Center(child: Text('Advance to the next',style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.primary,
                          ),),),
                        ),
                      )
                         :
                        GestureDetector(
                          onTap: (){
                          },
                        child: Container(
                          height: 45,
                          width: 150,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.red)
                          ),
                          child: Center(child: Text('Waiting',style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                          ),),),
                        ),
                      ),
                         const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      
    );
  }

  Widget socialButtons() {
    return ButtonBar(
      mainAxisSize: MainAxisSize.min,
      children: [
/*         IconButton(
            onPressed: (){
              final whatsappUrl = Uri.parse('https://wa.me/+967775445127');
              launchUrl(whatsappUrl,mode: LaunchMode.externalApplication);
              },
            icon: const Icon(SocialIcon.whatsapp)
        ), */
        IconButton(
            onPressed: (){
/*               String? encodeQueryParameters(Map<String, String> params) {
                return params.entries
                    .map((MapEntry<String, String> e) =>
                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                    .join('&');
              }
              final Uri emailLaunchUri = Uri(
                scheme: 'mailto',
                path: 'tenders_discovery@gmail.com',
                query: encodeQueryParameters(<String, String>{
                  'subject': '',
                  'body': '',
                }),
              );
              launchUrl(emailLaunchUri);
 */            },
            icon: const Icon(Icons.email,size: 30,)
        ),


/*         IconButton(
            onPressed: (){
              final Uri launchUri = Uri(
                scheme: 'tel',
                path: '+967775445127',
              );
              launchUrl(launchUri);
            },
            icon: const Icon(Icons.phone)
        ),
 */
      ],
    );
  }
}
