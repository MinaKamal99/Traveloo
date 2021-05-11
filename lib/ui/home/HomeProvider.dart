import 'package:book_hotels/model/DestinationPopular.dart';
import 'package:book_hotels/model/Hotel.dart';
import 'package:book_hotels/services/repo/Repo.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier{
  RepoInterface repo ;
  List<DestinationPopular> destinationList ;
  List<Hotel> hotelList ;

  HomeProvider(RepoInterface _repo){
    this.repo = _repo ;
    getDestinationItems();
    getHotelItems();
  }
  Future<void> getDestinationItems(){
  repo.getDestination().then((value) {
    destinationList = value ;
    notifyListeners();
  });
  }
  Future<void> getHotelItems(){
    repo.getHotel().then((value) {
      hotelList = value ;
      notifyListeners();
    });
  }
}