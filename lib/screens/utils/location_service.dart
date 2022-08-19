import 'dart:convert';
import 'package:http/http.dart' as http;

Future<http.Response> getLocationData(String text) async {
  http.Response response;

  response = await http.get(
    Uri.parse("http://mvs.bslmeiyu.com/api/v1/config/place-api-autocomplete?search_text=$text"),
    headers: {"Content-Type": "application/json"},);

  print(jsonDecode(response.body));
  return response;
}

Future<String> getPlaceId(String input) async {
  final String key = 'AIzaSyDiCBZhBIdyhJYPlMTiS6flPO2En0PrtiQ';
  final String url = 'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$input&inputtype=textquery&key=$key';

  var responsePlace = await http.get(Uri.parse(url));

  var json = jsonDecode(responsePlace.body);
  print(json);
  var placeId = json['candidate'][0]['place_id'];
print('my placeID$placeId');
return placeId;
}