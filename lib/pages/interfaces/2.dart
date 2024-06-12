/* import 'package:flutter/material.dart';
import '../database_helper.dart';
import 'tender_detail_screen.dart';

class TenderListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('قائمة العروض'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper().getTenders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('حدث خطأ ما'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('لا توجد عروض'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              var tender = snapshot.data![index];
              return ListTile(
                title: Text(tender['title']),
                subtitle: Text(tender['location']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TenderDetailScreen(tenderId: tender['id']),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
} */