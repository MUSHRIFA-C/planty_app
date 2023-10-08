
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/ui/screens/home_page.dart';
import 'package:flutter_onboarding/ui/screens/myOrder.dart';
class OrderSuccessMessage extends StatefulWidget {
  const OrderSuccessMessage({Key? key}) : super(key: key);

  @override
  State<OrderSuccessMessage> createState() => _OrderSuccessMessageState();
}

class _OrderSuccessMessageState extends State<OrderSuccessMessage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: AssetImage('assets/images/ordersuccess.png',),
            color: Constants.primaryColor,),
          Text('Thank you for ordering!',style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),),
          SizedBox(height: 90,),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyOrder()));
                  },
                  child: Text('VIEW ORDER',style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),),
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 0.5),
                      fixedSize: Size(170, 10)
                  ),
                ),
                TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                  },
                  child: Text('CONTINUE',style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),),
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Constants.primaryColor,
                      fixedSize: Size(170, 10)
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}