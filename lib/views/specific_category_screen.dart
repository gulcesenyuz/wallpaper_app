import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pet_adoption_app/data/data.dart';
import 'package:pet_adoption_app/model/wallpaper_model.dart';
import 'package:http/http.dart' as http;
import 'package:pet_adoption_app/views/menu_frame.dart';
import 'package:pet_adoption_app/widget/widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Category extends StatefulWidget {
  final String categorie;
  Category({@required this.categorie});

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  List <WallpaperModel> wallpapers = new List();
  int noOfImageToLoad = 40;
  int page = 1;
  ScrollController _scrollController ;

  getCategoryWallpaper()async{
    var response = await http.get('https://api.pexels.com/v1/search?query=${widget.categorie}&per_page=$noOfImageToLoad&page=$page',
        headers:{
          "Authorization" : apiKey
        });
        Map<String,dynamic> jsonData = jsonDecode(response.body);
        jsonData["photos"].forEach((element){
          WallpaperModel wallpaperModel = new WallpaperModel();
          wallpaperModel = WallpaperModel.fromMap(element);
          wallpapers.add(wallpaperModel);
      setState(() {

      });
    });
  }

  _scrollListener(){
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
      noOfImageToLoad = noOfImageToLoad + 40;
      page = page +1;
      //print(noOfImageToLoad);
      //print(page);
      getCategoryWallpaper();

    }}

  @override
  void initState() {
    getCategoryWallpaper();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.height;
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
                    child: Icon(FontAwesomeIcons.backward),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  //
                  Column(
                    children: [
                      Text(
                        'WallPaper Hub',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.white),
                      ),
                      SizedBox(height: deviceWidth*0.01,),
                      Text(
                        widget.categorie,
                        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14,color: Colors.white.withOpacity(0.5)),
                      )
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MenuFrame()));
                      },
                      child: Icon(FontAwesomeIcons.home))
                ],
              ),
            ),
            SizedBox(height: deviceWidth*0.025,),

            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: [
                            wallpaperGridView(wallpapers:wallpapers,context: context),
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

