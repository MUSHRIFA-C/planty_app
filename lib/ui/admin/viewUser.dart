import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/models/user.dart';
import 'package:flutter_onboarding/services/viewUserService.dart';

class Viewuser extends StatefulWidget {
  const Viewuser({Key? key}) : super(key: key);

  @override
  State<Viewuser> createState() => _ViewuserState();
}
class _ViewuserState extends State<Viewuser> {


  List<User> users=[];

  @override
  void initState() {
    super.initState();
    _fetchData(); // Fetch user data when the widget is initialized
  }

  Future<void> _fetchData() async {
    try {
      List<User> user = await ViewUserService.getUsers();

      setState(() {
        users = user;
      });
    } catch (e) {
      print('Failed to fetch user details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        toolbarHeight: 60,
        title: Text('User Details',),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: users.length,
        itemBuilder: (context,index){
          final user = users[index];
          return users.isNotEmpty ? Padding(
            padding: const EdgeInsets.only(top: 18,right: 12,left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white60,
                      child: Icon(Icons.person,color: Colors.teal.shade800,size: 36,),
                    ),
                    SizedBox(width: 16,),
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Name: ${user.fullname}',
                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                          SizedBox(height: 5,),
                          Text(
                            'Email: ${user.email ?? 'N/A'}',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,),
                          Text(
                            'Contact: ${user.phonenumber ?? 'N/A'}',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12,),
                Divider(
                  color: Colors.grey[300],
                  thickness: 2,
                )
              ],
            ),
          ) : Center(child: CircularProgressIndicator(),);
        },


      ),
    );
  }
}