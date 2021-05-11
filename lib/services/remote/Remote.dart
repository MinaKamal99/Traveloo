import 'package:book_hotels/model/DestinationPopular.dart';
import 'package:book_hotels/model/Hotel.dart';
import 'package:http/http.dart' as http;



abstract class RemoteInterface{
  Future<List<DestinationPopular>> getDestination() ;
  Future<List<Hotel>> getHotel();
}
class Remote extends RemoteInterface {
  @override
  Future<List<DestinationPopular>> getDestination() async{
    List<DestinationPopular> listDestinationPopular ;
    var url = Uri.parse('https://608d4294fe2e9c00171e16f1.mockapi.io/destination');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      listDestinationPopular = destinationPopularFromJson(response.body);
      print(" title is ${listDestinationPopular[0].title}");
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return listDestinationPopular ;
  }

  @override
  Future<List<Hotel>> getHotel() async{
    List<Hotel> listHotel ;
    var url = Uri.parse('https://608d4294fe2e9c00171e16f1.mockapi.io/rooms');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      // var jsonResponse =
      // convert.jsonDecode(response.body) as DestinationPopular;
      listHotel = hotelFromJson(response.body);

      print(" title is ${listHotel[0].title}");
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return listHotel ;

  }

}