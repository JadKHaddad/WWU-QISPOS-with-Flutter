import 'package:http/http.dart' as http;

class Session {
  Map<String, String> headers = {
    "user-agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36",
    "Content-Type": "application/x-www-form-urlencoded",
    "Accept": "application/json, text/html, image/gif, image/jpeg, *; q=.2, */*; q=.2",
  };

  Future<http.Response> get(String url) async {
    http.Response response = await http.get(url, headers: headers);
    updateCookie(response);
    return response;
  }

  Future<http.Response> post(String url, dynamic data) async {
    http.Response response = await http.post(url, body: data, headers: headers);
    updateCookie(response);
    return response;
  }

  void updateCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
      (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
}