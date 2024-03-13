import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<String>_quotes=[];
  List<String> get quote => _quotes;

  void toggleFavorite(String? quote) {
    final isExist = _quotes.contains(quote);
    if(isExist){
      _quotes.remove(quote);
    }
    else {
      _quotes.add(quote!);

    }
    notifyListeners();

  }

  bool isExist(String? quote){
    final isExist = _quotes.contains(quote);
    return isExist;
  }
}