import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/models/OrderItems.dart';
import 'package:flutter_onboarding/models/user.dart';
import 'package:flutter_onboarding/services/viewOrderAdmin.dart';

class ViewOrder extends StatefulWidget {
  const ViewOrder({Key? key}) : super(key: key);

  @override
  State<ViewOrder> createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {

  List<Data> orderItems = [];
  List<User> users=[];


  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      List<Data> order = await ViewAdminOrder().getOrderItems();
      setState(() {
        orderItems = order;

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
        title: Text('Order Details'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: orderItems.length,
        itemBuilder: (context, index) {
          final order = orderItems[index];
          return orderItems.isNotEmpty
              ? Padding(
            padding: const EdgeInsets.only(top: 18, right: 12, left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipOval(
                      child: Image.asset("Server/Plant_App${orderItems[index].image}",// Replace with your asset image path
                        width: 66,
                        height: 66,
                        //fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Item: ${orderItems[index].productName}',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Price: ${orderItems[index].totalPrice ?? 'N/A'}',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                          Text(
                            'Quantity: ${orderItems[index].quantity ?? 'N/A'}',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Delivery with in ${orderItems[index].expday.toString()} days',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Divider(
                  color: Colors.grey[300],
                  thickness: 2,
                )
              ],
            ),
          )
              : Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
