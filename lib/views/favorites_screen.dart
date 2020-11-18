import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption_app/model/favorites_provider.dart';
import 'package:pet_adoption_app/model/wallpaper_model.dart';
import 'package:pet_adoption_app/state/favorites_state.dart';
import 'package:pet_adoption_app/views/menu_frame.dart';
import 'package:pet_adoption_app/widget/widget.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatefulWidget {
  final Function menuCallback;
  FavoritesScreen({this.menuCallback});

  @override
  _FavoritesScreenState createState() =>  _FavoritesScreenState();
}

class  _FavoritesScreenState extends State<FavoritesScreen> {

  List <FavoritesModel> wallpapers = new List();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery
        .of(context)
        .size
        .width;
    final likes = Provider.of<FavoritesState>(context, listen: false);
    if (likes.favoritesIndex.length == 0) {
      return Material(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Icon(FontAwesomeIcons.bars),
                      onTap: widget.menuCallback,),
                    Column(
                      children: [
                        Text('WallPaper Hub', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),),
                        SizedBox(height: deviceWidth * 0.01,),
                        Text('Favorites', style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12
                        ),),
                      ],
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => MenuFrame()
                          ));
                        },
                        child: Icon(FontAwesomeIcons.home))
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Beğendiğin Fotoğraf Yok',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 25.0),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
    else {
      return Material(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Icon(FontAwesomeIcons.bars),
                      onTap: widget.menuCallback,),
                    Column(
                      children: [
                        Text('WallPaper Hub', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                        ),),
                        SizedBox(height: deviceWidth * 0.01,),
                        Text('Favorites', style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12
                        ),),
                      ],
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => MenuFrame()
                          ));
                        },
                        child: Icon(FontAwesomeIcons.home))
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      SingleChildScrollView(
                        child: Container(
                          child: Column(
                            children: [
                              wallpaperGridViewForFavorites(
                                  wallpapers: likes.favoritesIndex,
                                  context: context),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

}