import 'package:http/http.dart' as http;

class CallApi {
  final String _url = 'https://type.fit/api/quotes';

  // Retrieve Data
  getQuotes() async {
    return await http.get(_url);
  }
}
