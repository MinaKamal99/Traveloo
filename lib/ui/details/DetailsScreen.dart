import 'package:book_hotels/model/Hotel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';

class DetailsScreen extends StatelessWidget {
  Hotel selectedObj ;
  DetailsScreen(Hotel _selectedObj){
    this.selectedObj = _selectedObj ;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

      ),
      body: Stack(
        children: [
          Hero(
          tag :selectedObj.id,
          child :Image.network(
            selectedObj.image,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: Align(
              alignment: Alignment.bottomCenter,
              heightFactor: double.infinity,
              widthFactor: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white.withOpacity(0.9),
                ),
                height: 180,
                width: 320,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedObj.title,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),

                              Text("family",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54))
                            ],
                          ),
                          Column(
                            children: [
                              Text("\$ ${selectedObj.price}",
                                  style: TextStyle(
                                      color: Colors.deepPurpleAccent,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                "/per night",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  Row(
                    children: [
                      Container(
                        margin : const EdgeInsetsDirectional.only(start:10,top: 10,end: 10,bottom: 10 ),
                          child:RatingBar.readOnly(
                            initialRating:selectedObj.rating,
                            isHalfAllowed: true,
                            filledColor: Colors.deepPurpleAccent,
                            //amberAccent
                            halfFilledIcon: Icons.star_half,
                            filledIcon: Icons.star,
                            emptyIcon: Icons.star_border,
                            size: 25,
                          )
                      ),
                    ],
                  ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.pin_drop_outlined,
                            color: Colors.black38,
                          ),
                          Text(selectedObj.location,
                              style: TextStyle(color: Colors.black45)),
                          Padding(
                            padding: const EdgeInsets.only(left: 110.0),
                            child: Icon(Icons.favorite_border_sharp),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}