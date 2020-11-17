import 'package:flutter/material.dart';
import 'package:pet_adoption_app/model/favorites_provider.dart';
import 'package:pet_adoption_app/state/favorites_state.dart';
import 'package:pet_adoption_app/views/home_screen.dart';
import 'package:pet_adoption_app/views/category_frame.dart';
import 'package:pet_adoption_app/views/category_screen.dart';
import 'package:pet_adoption_app/views/menu_frame.dart';
import 'package:pet_adoption_app/views/menu_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}
Color mainColor = Color.fromRGBO(48, 96, 96, 1.0);
Color stratingColor = Color.fromRGBO(70, 112, 112, 1.0);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoritesState>(
      create: (context) => FavoritesState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black,
          brightness: Brightness.light
        ),
        home: MenuFrame()
      ),
    );
  }
}

