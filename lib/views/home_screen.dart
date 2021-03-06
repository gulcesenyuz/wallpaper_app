import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption_app/data/data.dart';
import 'package:pet_adoption_app/model/wallpaper_model.dart';
import 'package:http/http.dart' as http;
import 'package:pet_adoption_app/widget/widget.dart';



class HomeScreen extends StatefulWidget {
  final Function menuCallback;
  HomeScreen({@required this.menuCallback});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List <WallpaperModel> wallpapers = new List();
  int noOfImageToLoad = 40;
  int page = 1;
  ScrollController _scrollController ;
  bool loading = false;

  Future<void> getTrendingWallpaper()async{
    try{
      var response = await http.get('https://api.pexels.com/v1/curated?&per_page=$noOfImageToLoad&page=$page',
        headers:{
          "Authorization" : apiKey
        },
      );
        Map<String,dynamic> jsonData = jsonDecode(response.body);
        jsonData["photos"].forEach((element){
          WallpaperModel wallpaperModel = new WallpaperModel();
          wallpaperModel = WallpaperModel.fromMap(element);
          wallpapers.add(wallpaperModel);
      });
      setState(() {

      });

    }
    catch(e){
      print(e);
    }
  }

  _scrollListener(){
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
      noOfImageToLoad = noOfImageToLoad + 40;
      page = page +1;
      //print(noOfImageToLoad);
      //print(page);
      getTrendingWallpaper();

    }}

  @override
  void initState() {
    getTrendingWallpaper();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 50),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    child: Icon(FontAwesomeIcons.bars),onTap: widget.menuCallback,),
                Text('WallPaper Hub',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15
                ),),
                Icon(FontAwesomeIcons.home)
              ],
            ),
          ),
          SizedBox(height: 20,),
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
    );
  }
}
