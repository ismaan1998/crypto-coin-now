import 'dart:convert';

import 'package:http/http.dart' as http;

const apiKey = "105BB565-35BD-460F-A2C8-2FCEC253E3F6";
const apiUrl = "http://rest.coinapi.io/v1/exchangerate";
// this function accept currency and cryptocurrency and returns the current rate accordingly
Future<String> getRate(String cur, String crypto) async{
      var requestUrl = '$apiUrl/$crypto/$cur?apikey=$apiKey';
    var response = await http.get(requestUrl);

    return jsonDecode(response.body)["rate"].toInt().toString();
}
