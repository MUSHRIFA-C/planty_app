import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/models/addtocart.dart';
import 'package:flutter_onboarding/models/user.dart';
import 'package:flutter_onboarding/services/Categoryservice.dart';
import 'package:flutter_onboarding/services/authdata.dart';
import 'package:flutter_onboarding/services/decrementcart.dart';
import 'package:flutter_onboarding/services/deleteCartItem.dart';
import 'package:flutter_onboarding/services/incrementcart.dart';
import 'package:flutter_onboarding/services/viewProfile.dart';
import 'package:flutter_onboarding/ui/root_page.dart';
import 'package:flutter_onboarding/ui/screens/deliveryAddress.dart';
import 'package:flutter_onboarding/ui/screens/detail_page.dart';
import 'package:flutter_onboarding/ui/screens/home_page.dart';
import 'package:flutter_onboarding/ui/screens/orderConfirmation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  ViewCategoryApi cartSingleItemview = ViewCategoryApi();
  CartQuantityIncrementAPI cartincrement = CartQuantityIncrementAPI();
  CartQuantityDecrementAPI cartdecrement = CartQuantityDecrementAPI();
  DeleteCartItemAPI deleteCartItem = DeleteCartItemAPI();

  late SharedPreferences prefs;
  late int outid = 0;
  //late int loginId;
  var _loaddata;
  User? userDetails;
  var body;
  void getoutId() async {
    prefs = await SharedPreferences.getInstance();
    outid = (prefs.getInt('login_id') ?? 0);
    setState(() {});
    print(outid);
    fetchTotalPrice();
  }

  Future<void> CheckAndNavigate() async {
    try {
      final details = await ViewProfileAPI().getViewProfile(outid);
      userDetails = details;
      setState(() {
        if (userDetails!.userstatus == "1") {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => OrderConfirmation()));
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DeliveryAddress()));
        }
      });
    } catch (e) {
      // Handle errors here, e.g., show an error message
      print('Failed to fetch user details: $e');
      return null; // Return null in case of an error
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getoutId();
  }

  Future<void> fetchTotalPrice() async {
    try {
      var response = await Apiservice()
          .getData(APIConstants.totalOrderPrice + outid.toString());
      if (response.statusCode == 201) {
        var items = json.decode(response.body);
        body = items['data']['total_price'];
        print("total value${body}");
        setState(() {
          body;
        });
      } else {
        setState(() {
          _loaddata = [];
          Fluttertoast.showToast(
            msg: "Currently there is no data available",
            backgroundColor: Colors.grey,
          );
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  double counter = 0;

  late int count = 0;
  void updateCount(List<AddtoCart>? data) {
    if (data != null) {
      setState(() {
        count = data.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 3;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RootPage()),
            );
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        title: Column(
          children: [
            const Text(
              "Your Cart",
              style: TextStyle(color: Colors.black),
            ),
            Text(
              "${count} items",
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                child: FutureBuilder<List<AddtoCart>>(
                    future: ViewCategoryApi.getSinglecartItems(outid),
                    builder: (BuildContext content, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No Item in Cart'));
                      }
                      return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            final item = snapshot.data![index].id;
                            count = snapshot.data!.length;
                            return Dismissible(
                              onDismissed: (DismissDirection direction) async {
                                setState(() {
                                  deleteCartItem.deleteCartItems(
                                      snapshot.data![index].id!.toInt());
                                });
                                await fetchTotalPrice();
                              },
                              direction: DismissDirection.endToStart,
                              key: UniqueKey(),
                              background: Container(
                                decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.3)),
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Icon(
                                      Icons.delete,
                                      size: 41,
                                    )
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 8, right: 8),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            int? pid = snapshot
                                                .data![index].item
                                                ?.toInt();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailPage(
                                                            plantId: snapshot
                                                                .data![index]
                                                                .item!
                                                                .toInt())));
                                          },
                                          child: SizedBox(
                                            width: 120,
                                            child: AspectRatio(
                                              aspectRatio: 0.88,
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color:
                                                        Constants.primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Image(
                                                  image: AssetImage(
                                                      "Server/Plant_App${snapshot.data![index].image}"),
                                                  /*Image.network(widget.plantList[widget.index].image ?? '',*/
                                                  fit: BoxFit
                                                      .cover, // Adjust the BoxFit as needed
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              constraints: BoxConstraints(
                                                maxWidth: itemWidth,
                                              ),
                                              child: Text(
                                                snapshot.data![index].itemname
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text.rich(TextSpan(
                                                text:
                                                    "'₹'${snapshot.data?[index].totalPrice.toString()}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.grey)))
                                          ],
                                        ),
                                        Spacer(),
                                        Container(
                                          width: 100,
                                          height: 42,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey.shade300)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () async {
                                                  await cartdecrement
                                                      .cartQutyDecre(snapshot
                                                          .data![index].id!
                                                          .toInt());
                                                  setState(() {});
                                                  // await fetchTotalPrice();
                                                },
                                                child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    child: Icon(
                                                      Icons.remove,
                                                      color:
                                                          Colors.teal.shade800,
                                                      size: 18,
                                                    )),
                                              ),
                                              Text(
                                                '${snapshot.data![index].quantity}',
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  //counter++;
                                                  await cartincrement
                                                      .cartQutyIncre(snapshot
                                                          .data![index].id!
                                                          .toInt());
                                                  setState(() {});
                                                  //await fetchTotalPrice();
                                                },
                                                child: Container(
                                                    width: 30,
                                                    height: 30,
                                                    child: Icon(
                                                      Icons.add,
                                                      color:
                                                          Colors.teal.shade800,
                                                      size: 18,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    //SizedBox(height: 20,),
                                    Divider(
                                      thickness: 1,
                                      color: Colors.grey.shade200,
                                    )
                                  ],
                                ),
                              ),
                            );
                          });
                    }
                    )),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.grey.shade500,
              offset: const Offset(2, 1),
              blurRadius: 2,
              spreadRadius: 1)
        ]),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              body == null
                  ? Text(
                      '₹ 0',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )
                  : Text(
                      '₹ ${body}',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
              InkWell(
                onTap: () {
                  CheckAndNavigate();
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.9,
                  decoration: BoxDecoration(color: Constants.primaryColor),
                  child: const Center(
                    child: Text(
                      'Place order',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.white),
                    ),
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
