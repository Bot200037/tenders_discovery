import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenders_discovery/test_table.dart';
import 'sqldb.dart';

import 'pages/userslogin_pages/U_registerpage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SqlDb().intialDb();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (create) => SqlDb()),
    ],
     child: const MyApp(),
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tenders Discovery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TestTable(),
    );
  }
}
