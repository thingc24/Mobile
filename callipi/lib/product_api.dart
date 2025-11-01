import 'dart:convert';
import 'package:http/http.dart' as http;

class ProductApi {
  static Future<Map<String, dynamic>> fetchProduct() async {
    final response = await http.get(
      Uri.parse('https://mock.apidog.com/m1/890655-872447-default/v2/product'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load product');
    }
  }
}
