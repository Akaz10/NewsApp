import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/news_model.dart';



class ApiServices {
  static var client = http.Client();

  static Future<News?> fetchNews(String page,String? search) async {
    var response = await client.get(Uri.parse(
        "https://newsapi.org/v2/everything?q=$search&page=$page&apiKey=b479bfd2571a4948a90e78cd6cab8316"),
        );
    debugPrint("response giris yapildi");
    if(response.statusCode == 200) {
      var jsonString = response.body;
     // debugPrint(jsonString);
      print("Serviceden cıktı");
      return newsFromJson(jsonString);
    }
    else {
      return null;
    }
  }
}