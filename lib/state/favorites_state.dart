import 'package:flutter/material.dart';
import 'package:pet_adoption_app/model/favorites_provider.dart';
import 'package:pet_adoption_app/views/favorites_screen.dart';

class FavoritesState extends ChangeNotifier{
  final List<String> favoritesIndex = [];
  List get favorites => favoritesIndex;



  void addLikes(String index){
    if(favoritesIndex.contains(index)){
      notifyListeners();
    }
    favoritesIndex.add(index);
    notifyListeners();
  }
  void removeLikes(String index){
    favoritesIndex.remove(index);
    notifyListeners();
  }


}