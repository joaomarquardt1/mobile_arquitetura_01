import 'package:flutter/material.dart';
import '../data/datasources/product_remote_datasource.dart';
import '../data/repositories/product_repository_impl.dart';
import '../domain/entities/product.dart';

class ProductProvider extends ChangeNotifier {
  final ProductRemoteDataSource _datasource = ProductRemoteDataSource();
  late final ProductRepositoryImpl _repository;

  bool _isLoading = false;
  String? _errorMessage;
  List<Product> _products = [];

  ProductProvider() {
    _repository = ProductRepositoryImpl(_datasource);
  }

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _products = await _repository.getProducts();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Erro ao carregar produtos: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  Product? getProductById(int id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }
}
