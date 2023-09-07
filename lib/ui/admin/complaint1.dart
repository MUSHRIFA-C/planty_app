import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/ui/admin/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class Achat2 extends StatefulWidget {
  final int id;
  const Achat2({required this.id});

  @override
  State<Achat2> createState() => _Achat2State();
}

class _Achat2State extends State<Achat2> {
  bool isObscurePassword=true;
  String reply='';
  late int id;
  // late int id;
  late SharedPreferences prefs;
  TextEditingController replyController=TextEditingController();


  /*Future<void> _updatereply(String reply) async {




    prefs = await SharedPreferences.getInstance();
    int id = widget.id;

    //id = (prefs.getInt('user_id') ?? 0 );
    // print(id);
    var uri = Uri.parse(Api().url+'/api/complaint_update/'+id.toString()); // Replace with your API endpoint
    var request = http.MultipartRequest('PUT', uri);
    request.fields['reply'] = reply;

    print(request.fields);
    final response = await request.send();
    print(response);

    if (response.statusCode == 200) {

      print('Complaint Updated successfully');

      Navigator.push(this.context, MaterialPageRoute(builder: (context) => Homescreen()));

    }

    else {
      print('Error Updating Complaint. Status code: ${response.statusCode}');
    }
  }*/
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text('Messaging'),
      ),

      body:  SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height*.35,
              child:
              Image.asset('images/message.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 12,right: 12,top: 20),
                child: Container(
                    height: 300.0,
                    child: Stack(
                        children: [
                          TextField(
                            controller: replyController,
                            maxLines: 10,
                            decoration: InputDecoration(
                              hintText: 'Please Message Here......',
                              hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),

                            ),
                          ),
                        ]
                    )
                )
            ),

            //
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: ElevatedButton(
                  onPressed: (){
                    /*_updatereply(replyController.text);*/
                  },
                  child: Text('Reply',style: TextStyle(fontSize: 19),),
                  style: ElevatedButton.styleFrom(fixedSize: Size(230, 55),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),primary: Colors.blue),
                ),
              ),

            )],
        ),

      ),
    );
  }
}