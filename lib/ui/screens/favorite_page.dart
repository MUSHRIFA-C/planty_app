import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/models/favorite.dart';
import 'package:flutter_onboarding/services/viewFavItem.dart';
import 'package:flutter_onboarding/ui/screens/widgets/plant_widget.dart';


class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key,}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  List<Favorite> _favoriteItem=[];
  var favoriteItem;
  var _plantList;

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: _favoriteItem.isEmpty
          ? Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Image.asset('assets/images/favorited.png'),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Your favorited Plants',
              style: TextStyle(
                color: Constants.primaryColor,
                fontWeight: FontWeight.w300,
                fontSize: 18,
              ),
            ),
          ],
        ),
      )
          : Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
        height: size.height * .5,
        child: ListView.builder(
            itemCount: _favoriteItem.length,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return PlantWidget(
                index: index,
                plantList: _plantList,
                favoriteItem: _favoriteItem,
              );
            }),
      ),
    );
  }
}

