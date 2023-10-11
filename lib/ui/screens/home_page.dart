import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/models/favorite.dart';
import 'package:flutter_onboarding/models/product.dart';
import 'package:flutter_onboarding/services/deleteFavItemInHome.dart';
import 'package:flutter_onboarding/services/favoriteItemService.dart';
import 'package:flutter_onboarding/services/searchitem.dart';
import 'package:flutter_onboarding/services/viewFavItem.dart';
import 'package:flutter_onboarding/services/viewUserPlant.dart';
import 'package:flutter_onboarding/ui/screens/detail_page.dart';
import 'package:flutter_onboarding/ui/screens/widgets/plant_widget.dart';
import 'package:page_transition/page_transition.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<DetailData> _plantList =[];
  List<Favorite> _favoriteItem = [];
  List _favoritePlantItem=[];
  String name= '' ;
  bool isLoaded=false;

  Future<void> _loadPlantData() async {
    try {
      final plantData = await ViewUserplant.getPlants();
      setState(() {
        _plantList = plantData.detaildata ?? [];
      });
    } catch (e) {
      print('Error loading plant data: $e');
    }
  }

  Future<void> fetchFavoriteItems() async {
    List<Favorite> data = await ViewFavoriteItems().getFavoriteItems();
    setState(() {
      _favoriteItem=data;
      _favoritePlantItem = data.map((e) => e.item).toList();
    });
  }

late int plantid;

  @override
  void initState() {
    super.initState();
    _loadPlantData();
    fetchFavoriteItems();
  }

  Widget build(BuildContext context) {
    int selectedIndex = 0;
    Size size = MediaQuery.of(context).size;

    //Plants category
   List<String> _plantTypes = [
      'Recommended',
      'Indoor',
      'Outdoor',
      'Garden',
      'Supplement',
    ];

    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                      ),
                      width: size.width * .9,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.black54.withOpacity(.6),
                          ),
                           Expanded(
                              child: TextFormField(
                                showCursor: false,
                                onFieldSubmitted: (String text){
                                  setState(() {
                                    name=text;
                                    SearchItem.searchItems(context, name.trim());
                                    setState(() {
                                      isLoaded=false;
                                    });
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'Search Plant',
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                ),
                              )
                          ),
                          Icon(Icons.mic,
                            color: Colors.black54.withOpacity(.6),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Constants.primaryColor.withOpacity(.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 50.0,
                width: size.width,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _plantTypes.length,
                    itemBuilder: (BuildContext context, int index) {

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Text(
                            _plantTypes[index],
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: selectedIndex == index ?
                              FontWeight.bold
                                  : FontWeight.w300,
                              color: selectedIndex == index ?
                              Constants.primaryColor
                                  : Constants.blackColor,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: size.height * .3,
                child: ListView.builder(
                    itemCount: _plantList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      plantid=_plantList[index].id!;
                      return GestureDetector(
                        onTap: () {
                          print("$_plantList[index].id!");
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: DetailPage(
                                    plantId:_plantList[index].id!,
                                  ),
                                  type: PageTransitionType.bottomToTop));
                        },
                        child: Container(
                          width: 200,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 10,
                                right: 20,
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: IconButton(
                                    onPressed: () async{
                                      _favoritePlantItem.contains(_plantList[index].id!.toInt())  ? await DeleteFavoriteItemInHomePage.deleteFavoriteItemInHomePage(context,_plantList[index].id!.toInt()) :
                                      await  FavoriteItemAPI.FavoriteItem(context: context,productId: _plantList[index].id!.toInt());
                                      await fetchFavoriteItems();
                                      print(_favoritePlantItem.contains(_plantList[index].id));
                                    },
                                    icon:
                                    _favoritePlantItem.contains(_plantList[index].id) ?
                                    Icon(Icons.favorite,color: Constants.primaryColor,) :
                                    Icon(Icons.favorite_outline),
                                    iconSize: 30,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                             Positioned(
                                left: 50,
                                right: 50,
                                top: 50,
                                bottom: 50,
                                child: Image(image: AssetImage("Server/Plant_App${_plantList[index].image}"),
                                ),
                               /*Image.network(_plantList[index].image?? '' ,*/

                              ),
                              Positioned(
                                bottom: 15,
                                left: 20,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _plantList[index].category ?? '',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      _plantList[index].name?? '',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                bottom: 15,
                                right: 20,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    r'₹' + (_plantList[index].price ?? 0).toString(),
                                    style: TextStyle(
                                        color: Constants.primaryColor,
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Constants.primaryColor.withOpacity(.8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      );
                    }),
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, bottom: 20, top: 20),
                child: const Text(
                  'All Plants',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: size.height * .5,
                child:ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemCount: _plantList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                              onTap: () {
                                setState(() {
                                  print("----tapped");
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          child: DetailPage(
                                            plantId:_plantList[index].id!,
                                          ),
                                          type: PageTransitionType.bottomToTop));
                                });

                              },
                              child: PlantWidget(index: index,
                                  plantList: _plantList,
                                favoriteItem: _favoriteItem));
                        },
                ),
              ),
            ],
          ),
        ),
    );
  }
}