/* import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ReportScreen extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  late Future<List<Map<String, dynamic>>> _offers;

  @override
  void initState() {
    super.initState();
    _offers = DatabaseHelper().getOffers();
  }

  IconData _getIconForStatus(String status) {
    switch (status) {
      case 'معروضة':
        return Icons.visibility;
      case 'منتظرة':
        return Icons.hourglass_empty;
      case 'تمت':
        return Icons.check_circle;
      case 'ملغاة':
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('قائمة العروض'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _offers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ ما'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('لا توجد عروض'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final offer = snapshot.data![index];
                return ListTile(
                  leading: Icon(_getIconForStatus(offer['status'])),
                  title: Text(offer['title']),
                  subtitle: Text(offer['status']),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'offers.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE offers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            status TEXT
          )
        ''');
      },
    );
  }

  Future<List<Map<String, dynamic>>> getOffers() async {
    Database db = await database;
    return await db.query('offers');
  }
}

void main() {
  runApp(MaterialApp(
    home: OffersPage(),
  ));
} */