/* import 'package:flutter/material.dart';
import 'database_helper.dart';
class OffersPage extends StatefulWidget {
  @override
  _OffersPageState createState() => _OffersPageState();
}

class _OffersPageState extends State<OffersPage> {
  late Future<List<Map<String, dynamic>>> _offers;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _offers = DatabaseHelper().getOffers();
  }

  void _filterOffers(String? category) {
    setState(() {
      _selectedCategory = category;
      _offers = DatabaseHelper().getOffers(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('قائمة العروض'),
        actions: [
          PopupMenuButton<String>(
            onSelected: _filterOffers,
            itemBuilder: (context) => [
              PopupMenuItem(value: null, child: Text('الكل')),
              PopupMenuItem(value: 'معروضة', child: Text('معروضة')),
              PopupMenuItem(value: 'منتظرة', child: Text('منتظرة')),
              PopupMenuItem(value: 'تمت', child: Text('تمت')),
              PopupMenuItem(value: 'ملغاة', child: Text('ملغاة')),
            ],
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _offers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ ما'));
          } else if (!snapshot.hasData  snapshot.data!.isEmpty) {
            return Center(child: Text('لا توجد عروض'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final offer = snapshot.data![index];
                return ListTile(
                  title: Text(offer['title']),
                  subtitle: Text(offer['details']),
                  onTap: () {
                    _showOfferDetails(context, offer);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showOfferDetails(BuildContext context, Map<String, dynamic> offer) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(offer['title']),
          content: Text(offer['details']),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('إغلاق'),
            ),
          ],
        );
      },
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
            details TEXT,
            category TEXT
          )
        ''');
      },
    );
  }

  Future<List<Map<String, dynamic>>> getOffers([String? category]) async {
    Database db = await database;
    if (category == null  category.isEmpty) {
      return await db.query('offers');
    } else {
      return await db.query('offers', where: 'category = ?', whereArgs: [category]);
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: OffersPage(),
  ));
} */