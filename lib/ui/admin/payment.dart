import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Apayment extends StatefulWidget {
  Apayment({Key? key}) : super(key: key);
  @override
  State<Apayment> createState() => _ApaymentState();
}
class _ApaymentState extends State<Apayment> {

  List _loaddata=[];
  late SharedPreferences prefs;
  bool isLoading = false;
  int artist=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _fetchData();
  }
 /* _fetchData() async {
    prefs = await SharedPreferences.getInstance();
    artist = prefs.getInt('user_id')?? 0;
    print(artist);
    var res = await Api()
        .getData('/api/payment_Asingle_view/' + artist.toString());
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        _loaddata = items;

      });
    } else {
      setState(() {
        _loaddata =[];
        Fluttertoast.showToast(
          msg:"Currently there is no data available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.blue, Colors.purple],
            ),
          ),
        ),
        title: Text('Payment_Details',),

      ),

      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _loaddata.length,
        itemBuilder: (context,index){

          return Padding(
            padding: const EdgeInsets.only(top: 16,right: 12,left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.payment,color: Colors.green,size: 36,),
                    ),
                    SizedBox(width: 16,),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(_loaddata[index]['name'],style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),
                          Text(_loaddata[index]['amount'],style: TextStyle(fontSize: 16),textAlign: TextAlign.justify,),


                        ],
                      ),
                    ),
                    SizedBox(width: 14,),

                    Text(_loaddata[index]['date'],style: TextStyle(fontSize: 15))
                  ],
                ),
                SizedBox(height: 12,),
                Divider(
                  color: Colors.grey[300],
                  thickness: 2,
                )
              ],
            ),
          );
        },


      ),




    );
  }
}
