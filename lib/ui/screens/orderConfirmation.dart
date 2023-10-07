
import 'dart:convert';
import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/models/addtocart.dart';
import 'package:flutter_onboarding/models/orderAddress.dart';
import 'package:flutter_onboarding/services/Categoryservice.dart';
import 'package:flutter_onboarding/services/authdata.dart';
import 'package:flutter_onboarding/services/placeOrder.dart';
import 'package:flutter_onboarding/services/viewAddress.dart';
import 'package:flutter_onboarding/ui/screens/changeAddress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OrderConfirmation extends StatefulWidget {
  const OrderConfirmation({Key? key}) : super(key: key);

  @override
  State<OrderConfirmation> createState() => _OrderConfirmationState();
}

class _OrderConfirmationState extends State<OrderConfirmation> {

  String paymentType='';
  String orderAddress='';
  bool isRadioButtonSelected = false;

  late SharedPreferences prefs;
  late int outid;
  late int loginId;
  var _loaddata;

  List<OrderAddress> _orderAddress=[];

  void getoutId() async {
    prefs = await SharedPreferences.getInstance();
    //loginId = (prefs.getInt('login_id') ?? 0);
    outid = (prefs.getInt('login_id') ?? 0 ) ;
    setState(() {

    });

    fetchTotalPrice();
    fetchOrderAddress();
  }

  Future<void> fetchOrderAddress() async {
    ViewOrderAddress viewOrderAddress = ViewOrderAddress();
    List<OrderAddress> data = await viewOrderAddress.getOrderAddress();

    setState(() {
      _orderAddress = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getoutId();
  }

  Future<void> fetchTotalPrice() async {
    try {
      var response = await Apiservice().getData(APIConstants.totalOrderPrice + outid.toString());
      if (response.statusCode == 201) {
        var items = json.decode(response.body);
        var body=items['data']['total_price'];
        setState(() {
          _loaddata = body;
        });
      } else {
        setState(() {
          _loaddata = [];
          Fluttertoast.showToast(
            msg:"Currently there is no data available",
            backgroundColor: Colors.grey,
          );
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  OrderAddress? _changedAddress;
  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 1.5;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          'Order Confirmation',
          style: TextStyle(
            color: Colors.teal.shade800,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),

      body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: _orderAddress.isNotEmpty ? Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(22),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${_changedAddress?.addressType??_orderAddress[0].addressType} Delivery',style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 19,
                              color: Colors.black,
                            ),),
                            InkWell(
                              onTap: () async {
                                _orderAddress[0] = await Navigator.push(context, MaterialPageRoute(builder: (context)=>const ChangeAddress()));

                                setState(() {

                                });
                              },
                              child: Text('Change address',style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                                color: Colors.teal.shade800,
                              ),),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15,),
                        Text(_orderAddress[0].name!,style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.black,
                        ),),
                        const SizedBox(height: 10,),
                        Text('${_orderAddress[0].buildingName}, ${_orderAddress[0].area}, ${_orderAddress[0].city}, ${_orderAddress[0].state}-${_orderAddress[0].pincode}',style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey.shade600,
                        ),),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Text('Phone : ',style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey.shade600,
                            ),),
                            Text('${_orderAddress[0].contact}',style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey.shade800,
                            ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ExpansionWidget(
                  initiallyExpanded: false,
                  titleBuilder: (double animationValue, _, bool isExpanded, toggleFunction,) {
                    return Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Expected Delivery',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          InkWell(
                            onTap: toggleFunction,
                            child: Icon(
                              isExpanded
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  content: Container(
                      width: MediaQuery.of(context).size.width,
                      child: FutureBuilder<List<AddtoCart>>(
                          future: ViewCategoryApi.getSinglecartItems(outid), builder: (BuildContext content, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 90,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        image: DecorationImage(
                                          image: NetworkImage(APIConstants.url + snapshot.data![index].image.toString()),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Delivered in ${snapshot.data![index].expday} days",
                                          style: TextStyle(
                                              color: Colors.teal.shade800,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16
                                          ),
                                        ),
                                        const SizedBox(height: 3),
                                        Container(
                                          constraints: BoxConstraints(
                                            maxWidth: itemWidth ,
                                          ),
                                          child: Text(
                                            "${snapshot.data![index].itemname}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Colors.grey,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        }
                        else{
                          print('no data');
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      })
                  ),
                ),
              ),

              const SizedBox(height: 8,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*.07,
                decoration: const BoxDecoration(
                    color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Amount Payable',style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.black,
                        ),),
                        Text('₹ ${_loaddata}',style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),),
                      ]
                  ),
                ),
              ),
              const SizedBox(height: 8,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*.36,
                decoration: const BoxDecoration(
                    color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12, right: 12,top: 18,bottom: 18),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Payment Methods',style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.black,
                        ),),
                        const SizedBox(height: 15,),

                        Expanded(
                          child: RadioListTile(
                            title: const Text("UPI"),
                            value: "upi",
                            contentPadding: const EdgeInsets.only(left: 5),
                            groupValue: paymentType,
                            activeColor: Colors.teal.shade800,
                            onChanged: (value){
                              setState(() {
                                paymentType = value.toString();
                                isRadioButtonSelected = true;
                              });
                            },
                          ),
                        ),

                        Expanded(
                          child: RadioListTile(
                            title: const Text("Cradit / Debit Card"),
                            contentPadding: const EdgeInsets.only(left: 5),
                            value: "cards",
                            groupValue: paymentType,
                            activeColor: Colors.teal.shade800,
                            onChanged: (value){
                              setState(() {
                                paymentType = value.toString();
                                isRadioButtonSelected = true;
                              });
                            },
                          ),
                        ),

                        Expanded(
                          child: RadioListTile(
                            title: const Text("Net Banking"),
                            value: "netBanking",
                            groupValue: paymentType,
                            contentPadding: const EdgeInsets.only(left: 5),
                            activeColor: Colors.teal.shade800,
                            onChanged: (value){
                              setState(() {
                                paymentType = value.toString();
                                isRadioButtonSelected = true;
                              });
                            },
                          ),
                        ),

                        Expanded(
                          child: RadioListTile(
                            title: const Text("Wallet"),
                            value: "wallet",
                            groupValue: paymentType,
                            contentPadding: const EdgeInsets.only(left: 5),
                            activeColor: Colors.teal.shade800,
                            onChanged: (value){
                              setState(() {
                                paymentType = value.toString();
                                isRadioButtonSelected = true;
                              });
                            },
                          ),
                        ),

                        Expanded(
                          child: RadioListTile(
                            title: const Text("Cash on Delivery"),
                            value: "cashOnDelivery",
                            groupValue: paymentType,
                            contentPadding: const EdgeInsets.only(left: 5),
                            activeColor: Constants.primaryColor,
                            onChanged: (value){
                              setState(() {
                                paymentType = value.toString();
                                isRadioButtonSelected = true;
                              });

                            },

                          ),
                        ),

                      ]
                  ),
                ),
              ),
            ],
          ) :
          const Center(child: CircularProgressIndicator(),)
      ),

      bottomNavigationBar: InkWell(
        onTap: () {
          orderAddress='${_orderAddress[0].buildingName}, '
              '${_orderAddress[0].area}, '
              '${_orderAddress[0].city},'
              ' ${_orderAddress[0].state} - ${_orderAddress[0].pincode}';

          print(orderAddress);

          PlaceOrderAPI.placeOrder(context,orderAddress,
              '${_orderAddress[0].name}',
              '${_orderAddress[0].contact}');
        },
        child: Container(
          decoration: BoxDecoration(
            color: Constants.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 55,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: const Center(
            child: Text(
              'Confirm Order',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}