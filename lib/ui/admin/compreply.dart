import 'package:flutter/material.dart';
class acompreply extends StatefulWidget {
  const acompreply({Key? key}) : super(key: key);

  @override
  State<acompreply> createState() => _acompreplyState();
}

class _acompreplyState extends State<acompreply> {
  @override
  Widget build(BuildContext context) {
    var size;
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Complaint'),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [

              Text('Complaint 1' ,textAlign: TextAlign.left,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.', textAlign: TextAlign.justify,),
              ),


              Padding(
                padding: const EdgeInsets.only(left: 12,right: 12,top: 20),
                child: Container(
                  height: 350.0,
                  child: Stack(
                    children: [
                      TextField(
                        maxLines: 10,
                        decoration: InputDecoration(
                          hintText: 'Reply for the complaint',
                          hintStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.grey
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),

                        ),
                      ),



                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          child: ElevatedButton(
                            onPressed: (){

                            },
                            child: Text('Submit',style: TextStyle(fontSize: 19),),
                            style: ElevatedButton.styleFrom(fixedSize: Size(230, 55),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(29.0)),backgroundColor: Colors.pink),
                          ),
                        ),
                      )
                    ],
                  ),

                ),


              ),
            ],
          ),
        ),
      ),

    );
  }
}