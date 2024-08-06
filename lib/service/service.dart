import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map> getBitcoinPrice() async{
  String url = "https://blockchain.info/ticker";
  http.Response response = await http.get(Uri.parse(url));
  if(response.statusCode == 200){
    Map<String, dynamic> responseJson = json.decode(response.body);
    return responseJson;
  }
    return {"error": " error"};
}