
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource datasource;

  ProductRepositoryImpl(this.datasource);

  @override
  Future<List<Product>> getProducts() {
    return datasource.fetchProducts();
  }
}
