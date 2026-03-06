
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ProductRemoteDataSource {
  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao carregar produtos');
    }
  }
}
