import 'dart:convert';

import 'package:http/http.dart' as http;

const apiKey = "your api key goes here";
const apiUrl = "http://rest.coinapi.io/v1/exchangerate";
// this function accept currency and cryptocurrency and returns the current rate accordingly
Future<String> getRate(String cur, String crypto) async{
      var requestUrl = '$apiUrl/$crypto/$cur?apikey=$apiKey';
    var response = await http.get(requestUrl);
    return jsonDecode(response.body)["rate"].toInt().toString();
}
his