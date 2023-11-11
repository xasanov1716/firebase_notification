import 'dart:convert';

import 'package:texno_bozor/data/models/news_model.dart';
import 'package:http/http.dart' as http;

class ApiProvider{

  Future<NewsModel> createAlbum(
      {required String title,required String description, required String image}) async {
    Uri uri = Uri.parse('https://fcm.googleapis.com/fcm/send');


    final response = await http.post(
    uri,
      headers: <String, String>{
        'content-type': 'application/json',
        'Authorization': 'key=AAAAbZONzgs:APA91bHuoq8PUkzRnEOTsKJCCiU7yCNbShlRuwzNoit_WZ75PCs_lCHoj-RkTfqWNa-K7-T8SmzTrY0ZyIOd_RlPhzlJ96tbA1fjILjqRkTZJ8-HdHhzI6Jdj_U8UQw9mIkxfknVx0t2',
      },
      body: jsonEncode(<String, dynamic>{
        'to' : "/topics/news",
        'notification': {
          "title":"Kun.uz",
          "body": "The Best",
        },
        'data' : {
          'title':title,
          'description':description,
          'image':image
        }
      })
    );
  print('ISHLADI');
    if (response.statusCode == 200) {
      print('ISHLADI');
      return NewsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }
}