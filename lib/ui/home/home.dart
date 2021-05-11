

import 'package:book_hotels/model/DestinationPopular.dart';
import 'package:book_hotels/model/Hotel.dart';
import 'package:book_hotels/services/remote/Remote.dart';
import 'package:book_hotels/services/repo/Repo.dart';
import 'package:book_hotels/ui/details/DetailsScreen.dart';
import 'package:book_hotels/ui/home/HomeProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
  Widget displayCard(String _title , String _image ){
   return Container(
      margin: const EdgeInsetsDirectional.only(start:10,end: 10 ,top: 10,bottom: 10),
      width: 150,
      height: 200,
     decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)) ,
         color: Colors.white70,
         boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5),
             spreadRadius: 5,
             blurRadius: 10,
             offset: Offset(0, 3))]),
      child: Stack(
        children: [
          Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(_image,fit: BoxFit.fill,height: double.infinity,width: double.infinity,),
            ),
          ),
          Center(
            child:Text(_title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30,fontStyle: FontStyle.italic,color: Colors.white)),
          ),
        ],
      ),
    );
  }
  Widget displayText(String _leftTitle , String _rightTitle){
    return Container(
      margin: const EdgeInsetsDirectional.only(start:20,end: 20,top: 10,bottom: 10),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(_leftTitle,style: TextStyle(fontSize:20 ,fontWeight: FontWeight.bold) ),
          Text(_rightTitle , style: TextStyle(color: Colors.grey)),
        ],
      ),

    );
  }
  Widget displayCardVerticalHotel(String _hotelName , String _price , double _rate , String _image , String id){

    return   Container(
      margin: const EdgeInsetsDirectional.only(start:10,top: 10,end: 10,bottom: 10 ),
      width: 150,
      height: 230,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)) ,
        color: Colors.white70,
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5),
        spreadRadius: 5,
        blurRadius: 10,
        offset: Offset(0, 3))]),
      child:Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            //MediaQuery.of(context).size.height*0.20
            child:Hero(
              tag: id,
            child:Image.network(_image, fit: BoxFit.fill,
              height:150,
              width: double.infinity),
            ),
          ),
          Container(
            padding: const EdgeInsetsDirectional.only(start: 10),
            alignment: Alignment.centerLeft,
            child:Text(_hotelName,style:TextStyle(fontSize: 20 ,color: Colors.grey)),
          ),
          Container(
              padding: const EdgeInsetsDirectional.only(start: 10),
              alignment: Alignment.centerLeft,
              child:Text("\$$_price/night",style:TextStyle(fontSize: 15 ))
          ),

          Container(
            margin: const EdgeInsetsDirectional.only(start: 10),
            child: Row(
              children: [
                 RatingBar.readOnly(
                  initialRating: _rate,
                  isHalfAllowed: true,
                  filledColor: Colors.amberAccent,
                  halfFilledIcon: Icons.star_half,
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border,
                   size: 25,
                ),
                Container(
                    padding: const EdgeInsetsDirectional.only(start: 10),
                    alignment: Alignment.centerLeft,
                    child:Text("$_rate",style:TextStyle(fontSize: 15 ))
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  Widget getAppBar(){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:<Widget> [
          Text("Home", style: TextStyle(color: Colors.black ,fontWeight: FontWeight.bold,fontSize: 30)),
          ClipOval(
            child: Image.asset('images/ME.jpg',height: 50,width: 50),
          ),
        ],
      ),
    );
  }
}
class _HomePageState extends State<HomePage> {
  List<Hotel> hotelItems ;
  Hotel item ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //widget.getDestination();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      title: widget.getAppBar(),
      ),
        body: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            widget.displayText("Destination Populer", "See More"),
            Container(
            height: 200 ,
            width: 100,
              //double.infinity
              child:ChangeNotifierProvider<HomeProvider> (create: (context)=>HomeProvider(Repo(Remote())),child: Consumer<HomeProvider>(
                builder: (buildContext,homeProvider,_) {
                  return
                  ( homeProvider.destinationList != null)?

                  ListView.builder(scrollDirection: Axis.horizontal,
                  itemCount: homeProvider.destinationList.length
                  ,itemBuilder: (context,index){

                    var item = homeProvider.destinationList[index];
                    return widget.displayCard(item.title, item.image);
                  }
                  ): Center(
                         child :CircularProgressIndicator()
                  );

                },
              ),
              ),
            ),
            widget.displayText("Recommended Rooms", ""),

        ChangeNotifierProvider<HomeProvider> (create: (context)=>HomeProvider(Repo(Remote())),child: Consumer<HomeProvider>(
          builder: (buildContext,homeProvider,_) {
            return
              ( homeProvider.hotelList != null)?
              ListView.builder(scrollDirection: Axis.vertical,
                  itemCount: homeProvider.hotelList.length,
                  physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  itemBuilder: (context,index){
                    var item = homeProvider.hotelList[index];
                    return
                      InkWell( child:widget.displayCardVerticalHotel(item.title,item.price,item.rating,item.image,item.id),
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => DetailsScreen(homeProvider.hotelList[index]))
                                  );
                                   },
                              );
                  }
              ): Center(
                  child :CircularProgressIndicator()
              );
          },
        ),
        ),


          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              IconButton(icon: Icon(Icons.home),),
              Spacer(),
              IconButton(icon: Icon(Icons.mode_comment_outlined), ),
              Spacer(),
              IconButton(icon: Icon(Icons.airplanemode_active), ),
              Spacer(),
              IconButton(icon: Icon(Icons.star), ),
              Spacer(),
              IconButton(icon: Icon(Icons.account_circle), ),
            ],
          ),
        ),
    )
    );
  }
}
