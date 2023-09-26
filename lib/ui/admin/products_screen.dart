import 'package:flutter/material.dart';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/models/product.dart';
import 'package:flutter_onboarding/services/viewproduct.dart';
import 'package:flutter_onboarding/ui/admin/new_product_screen.dart';

class Productview extends StatefulWidget {
  const Productview({Key? key}) : super(key: key);

  @override
  State<Productview> createState() => _ProductviewState();
}

class _ProductviewState extends State<Productview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.white),
        ),
        title: Text("Plants"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Aaddproducts()),
              );
            },
          )
        ],
      ),
      body: FutureBuilder<Product>(
        future: ViewProductService.getProducts(),
        builder: (BuildContext context, AsyncSnapshot<Product> snapshot) {

          if (snapshot.hasData) {
            print('snapshot data');
            print(snapshot.data!.detaildata);

            return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data?.detaildata?.length,
              itemBuilder: (context, index) {

                print(snapshot.data?.detaildata?[index].image);

                  return GestureDetector(
                    onTap: () {
                      setState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.all(4),
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              radius: 50.0,
                              backgroundColor: Constants.primaryColor,
                              backgroundImage: NetworkImage(
                                APIConstants.url + snapshot.data!.detaildata![index].image!,
                              ),
                            ),
                            title: Text(
                              snapshot.data!.detaildata![index].name!,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Constants.primaryColor,
                              ),
                              onPressed: () {
                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Productupdate(id: productData.id!),
                                  ),
                                );*/
                              },
                              child: const Text('Update'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                /*else {
                  return Container(
                    child: Text("No detail data available"),
                  );
              },*/
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
