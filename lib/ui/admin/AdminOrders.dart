import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/models/OrderItems.dart';
import 'package:flutter_onboarding/services/viewOrderAdmin.dart';
import 'package:flutter_onboarding/services/viewOrders.dart';
import 'package:flutter_onboarding/ui/admin/home_screen.dart';
import 'package:flutter_onboarding/ui/screens/detail_page.dart';
import 'package:flutter_onboarding/ui/screens/home_page.dart';


class ViewOrder extends StatefulWidget {
  const ViewOrder({Key? key}) : super(key: key);

  @override
  State<ViewOrder> createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {

  List<Data> orderItems=[];
  List<Data> _orderItems=[];

  TextEditingController productnameController=TextEditingController();

  Future<void> fetchOrderItems() async {
    ViewAdminOrder adminOrder  = ViewAdminOrder();
    List<Data> data = await adminOrder .getOrderItems();

    setState(() {
      orderItems = data;
      orderItems = _orderItems;
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrderItems();
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.primaryColor,
          leading: IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Homescreen()));
              },
              icon: const Icon(Icons.arrow_back)
          ),
          title: const Text('View Orders',style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: Colors.white
          ),),
        ),
        body: orderItems.isNotEmpty ? CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              forceElevated: true,
              elevation: 2,
              pinned: true,
              leadingWidth: MediaQuery.of(context).size.width,
              backgroundColor: Colors.white,
              expandedHeight: 65.0,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300)
                          ),
                          child: TextField(
                            controller: productnameController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: "Search your order here",
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){},
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image(image: AssetImage("Server/Plant_App${orderItems[index].image}"),
                                width: 85,height: 85,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(orderItems[index].productName.toString(),
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),maxLines: 2,),

                                  const SizedBox(height: 8,),
                                  Text(orderItems[index].totalPrice.toString(),
                                      style: TextStyle(fontSize: 16,color: Colors.grey.shade600)),
                                  const SizedBox(height: 8,),
                                  Container(
                                      constraints: BoxConstraints(
                                        maxWidth: itemWidth ,
                                      ),
                                      child: Text(orderItems[index].productName.toString(),style:
                                      const TextStyle(fontSize: 14,color: Colors.grey),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                ],
                              ),
                              const Icon(Icons.arrow_forward_ios,size: 15,)
                            ],
                          ),
                        ),
                        Divider(thickness: 1,color: Colors.grey.shade300,)
                      ],
                    ),
                  );
                },
                childCount: orderItems.length,
              ),
            )
          ],
        ) :Center(child: CircularProgressIndicator(),)
    );
  }
}