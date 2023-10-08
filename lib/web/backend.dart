import 'dart:math';

import 'package:flutter/material.dart' show debugPrint;
import 'package:html/dom.dart';
import 'package:html/parser.dart' as parse;
import 'package:http/http.dart' as http;

class UserAgentClient extends http.BaseClient {
  //أقدم الطلب من كمتصفح كروم
  final List<String> userAgent = ["Hello World", "Hassan Alkhamis", "Kill Yourself", "Mozilla/5.0"];
  final http.Client _inner = http.Client();
  final int userId = 0;

  UserAgentClient({required int userId});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['user-agent'] = userAgent[userId];
    return _inner.send(request);
  }
}

class WebScraper {
  static const String url = "https://banner.kfu.edu.sa:7710/KFU/ws?p_trm_code=144410&p_col_code=09&p_sex_code=11";

  static Future<List<Element>?> extractData() async {
    try {
      Random random = Random();
      final http.Client client = UserAgentClient(userId: random.nextInt(5));

      http.Response response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        response = await client.get(Uri.parse(url)); // get the html body
        final Document html = parse.parse(response.body); // convert the html to a document object
        final List<Element> container = html.getElementsByClassName('normaltxt');
        return container;
      }
      debugPrint("response.statusCode: ${response.statusCode}");
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
