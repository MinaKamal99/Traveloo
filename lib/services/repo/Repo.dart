import 'package:book_hotels/model/DestinationPopular.dart';
import 'package:book_hotels/model/Hotel.dart';
import 'package:book_hotels/services/remote/Remote.dart';

abstract class RepoInterface{

  Future<List<DestinationPopular>> getDestination() ;
  Future<List<Hotel>> getHotel();
}
class Repo extends RepoInterface {
  //
  // final Repo instance ;
  //
  // static getInstance (){
  //   instance = Repo(_remote)
  // }
  RemoteInterface remote ;
  Repo(RemoteInterface _remote){
    this.remote = _remote ;
  }
  @override
  Future<List<DestinationPopular>> getDestination() {

    return remote.getDestination() ;
  }
  @override
  Future<List<Hotel>> getHotel() {
    return remote.getHotel();
  }


}