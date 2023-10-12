import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/ui/admin/new_product_screen.dart';
import 'package:flutter_onboarding/ui/admin/notification.dart';
import 'package:flutter_onboarding/ui/admin/orders_screen.dart';
import 'package:flutter_onboarding/ui/admin/products_screen.dart';
import 'package:flutter_onboarding/ui/admin/AdminOrders.dart';
import 'package:flutter_onboarding/ui/admin/viewUser.dart';
import 'package:flutter_onboarding/ui/screens/signin_page.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  TextEditingController searchController = TextEditingController();

  var _plantList;

  var index;

  @override
  Widget build(BuildContext context) {

    int selectedIndex = 0;
    Size size = MediaQuery.of(context).size;



    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    width: size.width * .75,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.black54.withOpacity(.6),
                        ),
                        const Expanded(
                          child: TextField(
                            showCursor: false,
                            decoration: InputDecoration(
                              hintText: 'Search',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.mic,
                          color: Colors.black54.withOpacity(.6),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Constants.primaryColor.withOpacity(.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                    IconButton(onPressed: () {

                      Navigator.push(
                          context, MaterialPageRoute(
                          builder: (context) => SignIn()));



                    }, icon: Icon(Icons.logout_outlined))
                ],
              ),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: .85,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: [
                  _buildFeatureCard(
                    context,
                    'Manage Plants',
                    'assets/images/manage.png',
                        () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Productview(),
                            )
                        );
                      }
                  ),
                  _buildFeatureCard(
                    context,
                    'View User',
                    'assets/images/user.png',
                        () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Viewuser()));

                    },
                  ),
                  _buildFeatureCard(
                    context,
                    'Notifications',
                    'assets/images/notif.png',
                        () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
                    },
                  ),
                  _buildFeatureCard(
                    context,
                    'View Order',
                    'assets/images/vieworder.jpg',
                        () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ViewOrder()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
/*      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(""),
              accountEmail: Text(""),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "A",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Admin Home'),
              onTap: () {
                // Navigate to Home screen
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: const Text('Profile'),
              onTap: () {
                // Navigate to Profile screen
              },
            ),
            ListTile(
              leading: Icon(
                Icons.task,
              ),
              title: const Text('Complaint'),
              onTap: () {
                // Navigate to Complaint screen
              },
            ),
          ],
        ),
      ),*/
    );
  }

  Widget _buildFeatureCard(
      BuildContext context,
      String title,
      String imagePath,
      Function() onTap,
      ) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 17),
            blurRadius: 17,
            spreadRadius: -23,
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath)
                  )
                ),
              ),
              /*Image.asset(
                imagePath,
                height: 90,
                width: 150,
                alignment: Alignment.center,
              ),*/
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
