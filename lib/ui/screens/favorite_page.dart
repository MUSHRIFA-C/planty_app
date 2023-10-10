
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/models/favorite.dart';
import 'package:flutter_onboarding/services/deleteFavoriteItem.dart';
import 'package:flutter_onboarding/services/viewFavItem.dart';
import 'package:flutter_onboarding/ui/screens/detail_page.dart';
import 'package:flutter_onboarding/ui/screens/home_page.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  List<Favorite> _favoriteItem=[];

  Future<void> fetchFavoriteItems() async {
    List<Favorite> data = await ViewFavoriteItems().getFavoriteItems();

    setState(() {
      _favoriteItem = data;
    });
    print(_favoriteItem);
    print(_favoriteItem[0].favStatus);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchFavoriteItems();
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 1.8;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15,left: 10,right: 10,bottom: 10),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                          },
                        icon: Icon(Icons.arrow_back)
                    ),
                    Text('Favorite List',style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      color: Colors.grey[800],
                    ),),
                  ],
                ),
              ),
              _favoriteItem.isNotEmpty ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _favoriteItem.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 5, left: 8, right: 8),
                      child: InkWell(
                        onTap: (){
                          if(_favoriteItem[index].item==null)
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(plantId: _favoriteItem[index].id!)));
                        },
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Stack(
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        child: AspectRatio(
                                          aspectRatio: 0.88,
                                          child: Container(
                                            padding: EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Constants.primaryColor,
                                                borderRadius:
                                                BorderRadius.circular(15)),
                                            child: Image(image: AssetImage("Server/Plant_App${_favoriteItem[index].image}"),
                                              width: 85,height: 85,
                                            ),
                                            //Image.network(APIConstants.url + _favoriteItem[index].image.toString()),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 1,
                                        child: IconButton(
                                            onPressed: () async{
                                              if(_favoriteItem[index].favStatus! == "1") {

                                                await  DeleteFavoriteItemAPI.deleteFavoriteItems(context,_favoriteItem[index].id!);
                                                await fetchFavoriteItems();

                                              }
                                            },
                                            icon: _favoriteItem[index].favStatus! == "1" ?
                                            Icon(Icons.favorite,color: Colors.red,) :
                                            Icon(Icons.favorite_outline)
                                        ),
                                      ),
                                    ]),
                                const SizedBox(
                                  width: 18,
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      constraints: BoxConstraints(
                                        maxWidth: itemWidth ,
                                      ),
                                      child: Text(_favoriteItem[index].itemName.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text.rich(TextSpan(
                                        text: "₨. ${_favoriteItem[index].price}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey)))
                                  ],
                                ),
                                const Spacer(),
                                // IconButton(onPressed: (){},
                                //     icon: Icon(Icons.delete)
                                // )
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey.shade200,
                            )
                          ],
                        ),
                      ),
                    );
                  }) : Center(child: CircularProgressIndicator(),)
            ],
          ),
        ),
      ),
    );
  }
}