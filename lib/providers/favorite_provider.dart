import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  final List<int> _favorites = [];

  List<int> get favorites => _favorites;

  bool isFavorite(int productId) {
    return _favorites.contains(productId);
  }

  void toggleFavorite(int productId) {
    if (_favorites.contains(productId)) {
      _favorites.remove(productId);
    } else {
      _favorites.add(productId);
    }
    notifyListeners();
  }

  void addFavorite(int productId) {
    if (!_favorites.contains(productId)) {
      _favorites.add(productId);
      notifyListeners();
    }
  }

  void removeFavorite(int productId) {
    if (_favorites.contains(productId)) {
      _favorites.remove(productId);
      notifyListeners();
    }
  }
}
