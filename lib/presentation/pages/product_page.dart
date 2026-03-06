
import 'package:flutter/material.dart';
import '../../data/datasources/product_remote_datasource.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/entities/product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    final repo = ProductRepositoryImpl(ProductRemoteDataSource());
    products = repo.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Produtos")),
      body: FutureBuilder<List<Product>>(
        future: products,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar produtos"));
          }

          final items = snapshot.data!;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final product = items[index];

              return ListTile(
                leading: Image.network(product.image, width: 50),
                title: Text(product.title),
                subtitle: Text("R\$ ${product.price}"),
              );
            },
          );
        },
      ),
    );
  }
}
