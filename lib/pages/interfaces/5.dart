import 'package:flutter/material.dart';

class TenderDetailScreen extends StatelessWidget {
  final int tenderId;

  TenderDetailScreen({required this.tenderId});

  @override
  Widget build(BuildContext context) {
    // مدري وش احط في التفاصيل بس هنا بتظهر تفاصيل اي عرض احطه ويتحدد عن طريق tenderId
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل العرض'),
      ),
      body: Center(
        child: Text('تفاصيل العرض للعرض رقم: $tenderId'),
      ),
    );
  }
}