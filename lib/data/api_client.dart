import 'package:http/http.dart' as http;
import 'dart:convert';

class ShrtCoderApiClient {
  static const baseUrl = "https://api.shrtco.de/v2/shorten?url=";
  final http.Client httpClient = http.Client();

  Future<String> getShortLink(String link) async {
    var preUrl = baseUrl + link;
    var url = Uri.parse(preUrl);
    var response = await http.get(url);

    if (response.statusCode != 201) {
      throw Exception("Failed to Fetch Data");
    }
    Map shrtLinkResponse = json.decode(response.body);
    return shrtLinkResponse["result"]["short_link"];
  }
}
