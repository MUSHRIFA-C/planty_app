import 'dart:convert';
import 'package:flutter_onboarding/models/favorite.dart';
import 'package:flutter_onboarding/services/deleteFavItemInHome.dart';
import 'package:flutter_onboarding/services/favoriteItemService.dart';
import 'package:flutter_onboarding/services/ratePlants.dart';
import 'package:flutter_onboarding/services/viewFavItem.dart';
import 'package:flutter_onboarding/services/viewUserPlant.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:flutter_onboarding/const/api_constants.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/models/product.dart';
import 'package:flutter_onboarding/services/Categoryservice.dart';
import 'package:shared_preferences/shared_preferences.dart';


class DetailPage extends StatefulWidget {
  final int plantId;

  const DetailPage({Key? key,
    required this.plantId
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  String name='';
  String? price;
  String? description;
  String? size;
  String? humidity;
  String? temparature;
  double rating=0.0;
  String? image;
  String? category;

  late SharedPreferences localStorage;
  late int loginId;
  late SharedPreferences prefs;
  List _favoritePlantItem=[];
  ViewCategoryApi viewCategoryApi = ViewCategoryApi();
  DetailData ? plantDetails;

  Future<void> _viewPro() async {
    localStorage = await SharedPreferences.getInstance();
    loginId = (localStorage.getInt("login_id") ?? 0);

    final urls = APIConstants.url + APIConstants.viewsingleproduct + widget.plantId.toString();
    var response = await http.get(Uri.parse(urls));
    var body = json.decode(response.body);
    print(body);

    setState(() {
      name = body['data']['name'];
      price = body['data']['price'];
      description = body['data']['description'];
      size = body['data']['size'];
      humidity = body['data']['humidity'];
      temparature = body['data']['temperature'];
      category = body['data']['category'];
      rating = body['data']['rating']==null?0.0:body['data']['rating'];
      image = body['data']['image'];

      print(rating);

    });
  }

  Future<void> fetchFavoriteItems() async {
    List<Favorite> data = await ViewFavoriteItems().getFavoriteItems();
    if (mounted) {
      setState(() {
        _favoritePlantItem = data.map((e) => e.item).toList();
      });
    }
  }

  Future<Product?> fetchPlantDetails(plantId) async {
    try {
      final details = await ViewUserplant.getPlants();
      plantDetails = details.detaildata as DetailData?;
      setState(() {
        print(plantDetails);
      });
    } catch (e) {
      print('Failed to fetch plant details: $e');
      return null;
    }
  }

  void updateRating(double newRating) {
    setState(() {
      rating = newRating;
    });
  }

  @override
  void initState() {
    super.initState();
    // Fetch the user details when the widget initializes
    _viewPro();
    fetchFavoriteItems();
    fetchPlantDetails(widget.plantId);
  }

  @override
  Widget build(BuildContext context) {
    Size sizes = MediaQuery.of(context).size;

    List<DetailData> _plantList =[];


    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Constants.primaryColor.withOpacity(.15),
                    ),
                    child: Icon(
                      Icons.close,
                      color: Constants.primaryColor,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    debugPrint('favorite');
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: IconButton(
                        onPressed: () async{
                          _favoritePlantItem.contains(widget.plantId) ? await DeleteFavoriteItemInHomePage.deleteFavoriteItemInHomePage(context, widget.plantId) :
                          await FavoriteItemAPI.FavoriteItem(context: context, productId: widget.plantId);
                          await fetchFavoriteItems();

                         // FavoriteItemAPI.FavoriteItem(context: context, productId: widget.plantId);
                        },
                        icon:  _favoritePlantItem.contains(widget.plantId) ?
                        Icon(Icons.favorite,color: Constants.primaryColor) :
                        Icon(Icons.favorite_outline,size: 30,)
                    ),
                  ),
                ),
              ],
            ),
          ),
          image==null?Center(child: CircularProgressIndicator()):
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Container(
              width: sizes.width * .8,
              height: sizes.height * .8,
              padding: const EdgeInsets.all(20),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    left: 0,
                    child: SizedBox(
                      height: 350,
                      child: Image(image: AssetImage("Server/Plant_App$image"),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 0,
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PlantFeature(
                            title: 'Size',
                            plantFeature: '' + size.toString(),
                          ),
                          PlantFeature(
                            title: 'Humidity',
                            plantFeature:
                            '' + humidity.toString(),
                          ),
                          PlantFeature(
                            title: 'Temperature',
                            plantFeature: '' + temparature.toString(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
              height: sizes.height * .5,
              width: sizes.width,
              decoration: BoxDecoration(
                color: Constants.primaryColor.withOpacity(.4),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              color: Constants.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            r'₹' + price.toString(),
                            style: TextStyle(
                              color: Constants.blackColor,
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          RatingBar.builder(
                              initialRating: rating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 25,
                              itemBuilder: (context, _){
                                return Icon(Icons.star,
                                  size: 30.0,
                                  color: Constants.primaryColor);
                              },
                              onRatingUpdate:(newRating) async {
                                if (plantDetails != null) {
                                  await RatePlantAPI.ratePlants(context, widget.plantId, newRating);
                                  updateRating(newRating);
                                  //await fetchPlantDetails(widget.plantId);
                                  print(rating);
                                }
                              }
                          ),
                          SizedBox(width: 5,),
                          Text(rating!.toString())
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0,),
                  Expanded(
                    child: Text(
                      description.toString(),
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        height: 1.5,
                        fontSize: 18,
                        color: Constants.blackColor.withOpacity(.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox(
        width: sizes.width * .9,
        height: 50,
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              child: IconButton(onPressed: (){
                ViewCategoryApi().addtoCart(context: context, userId: loginId, productId: widget.plantId);
              },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: [widget.plantId] == true ?
                    Colors.white : Constants.primaryColor,
                  )),
              decoration: BoxDecoration(
                  color: [widget.plantId] == true ?
                  Constants.primaryColor.withOpacity(.5) : Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 5,
                      color: Constants.primaryColor.withOpacity(.3),
                    ),
                  ]),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Constants.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 1),
                        blurRadius: 5,
                        color: Constants.primaryColor.withOpacity(.3),
                      )
                    ]),
                child: const Center(
                  child: Text(
                    'BUY NOW',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlantFeature extends StatelessWidget {
  final String plantFeature;
  final String title;
  const PlantFeature({
    Key? key,
    required this.plantFeature,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Constants.blackColor,
          ),
        ),
        Text(
          plantFeature,
          style: TextStyle(
            color: Constants.primaryColor,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}