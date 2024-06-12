import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tenders_discovery/pages/userslogin_pages/U_welcomepage.dart';
import 'package:tenders_discovery/theme/theme_provider.dart';
import 'sqldb.dart';

//import 'test_table.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SqlDb().intialDb();

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (create) => SqlDb()),
      ChangeNotifierProvider(create: (create) => ThemeProvider()),
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
      home: const Welcome(),
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,

    );
  }
}
