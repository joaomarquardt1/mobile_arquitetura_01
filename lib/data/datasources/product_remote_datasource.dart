
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductRemoteDataSource {
  static const String _baseUrl = 'https://dummyjson.com';

  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/products'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List products = data['products'];
        return products.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        throw Exception('Erro ao carregar produtos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao carregar produtos: $e');
    }
  }
}

