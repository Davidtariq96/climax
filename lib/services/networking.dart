import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking {
  final String url;
  Networking({required this.url});
  Future fetchRemoteData() async {
    http.Response result = await http.get(Uri.parse(url));
    if (result.statusCode == 200) {
      String data = result.body;
      return jsonDecode(data);
    } else {
      print(result.statusCode);
    }
  }
}
