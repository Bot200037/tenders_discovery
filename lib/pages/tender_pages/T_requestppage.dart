// ignore_for_file: file_names, avoid_print, prefer_const_constructors, prefer_final_fields, unnecessary_string_interpolations
import 'package:flutter/material.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.grey,
          child: Column(
            children: [
              Text("Do you want to ask the Admin to accept your tender?"),
              Row(
                children: [
                  Container(
                    color: Colors.green,
                    child: ElevatedButton(
                      onPressed: (){

                      },
                      child: Text("Send a Request")),   
                  ),
                  Container(
                    color: Colors.red,
                    child: ElevatedButton(
                      onPressed: (){

                      },
                      child: Text("Cancel")),   
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

