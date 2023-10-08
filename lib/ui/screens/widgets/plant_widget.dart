import 'package:flutter/material.dart';
import 'package:flutter_onboarding/constants.dart';
import 'package:flutter_onboarding/models/favorite.dart';
import 'package:flutter_onboarding/models/product.dart';
import 'package:flutter_onboarding/ui/screens/detail_page.dart';
import 'package:page_transition/page_transition.dart';

class PlantWidget extends StatelessWidget {
  final int index;
  final List<Favorite> favoriteItem;
  final List<DetailData> plantList;

  PlantWidget({
    Key? key,
    required this.index,
    required this.favoriteItem,
    required this.plantList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        color: Constants.primaryColor.withOpacity(.1),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 80.0,
      padding: const EdgeInsets.only(left: 10, top: 10),
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  color: Constants.primaryColor.withOpacity(.8),
                  shape: BoxShape.circle,
                ),
              ),
              Positioned(
                bottom: 5,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 80.0,
                  child: Image(
                    image: AssetImage("Server/Plant_App${plantList[index].image}"),
                    fit: BoxFit.cover, // Adjust the BoxFit as needed
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                left: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plantList[index].name ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Constants.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              r'₹' + (plantList[index].price ?? 0).toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Constants.primaryColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
