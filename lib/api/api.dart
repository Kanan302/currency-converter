import 'package:http/http.dart' as http;
import 'dart:convert';

class ExchangeApi {
  static Future<Map<String, dynamic>> fetchExchangeRates() async {
    final uri = Uri.parse('https://open.er-api.com/v6/latest');
    final response = await http.get(uri);
    
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final Map<String, dynamic> rates = Map<String, dynamic>.from(data['rates']);
      return rates;
    } else {
      throw Exception('Something went wrong');
    }
  }
}
