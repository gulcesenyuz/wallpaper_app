import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption_app/data/data.dart';
import 'package:pet_adoption_app/model/categories_model.dart';
import 'package:pet_adoption_app/model/wallpaper_model.dart';
import 'package:pet_adoption_app/views/menu_frame.dart';
import 'package:pet_adoption_app/widget/widget.dart';
import 'package:pet_adoption_app/string_extension.dart';

class SearchScreen extends StatefulWidget {
  final Function menuCallback;
  final String searchQuery;
  SearchScreen({this.searchQuery,this.menuCallback});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  //List<CategorieModel> categories = new List();
  TextEditingController searchController = new TextEditingController();
  List<WallpaperModel> wallpapers = new List();
  int noOfImageToLoad = 40;
  int page = 1;
  ScrollController _scrollController ;

  //mapCategories(){
    //List<String> category = new List();
    //categories.forEach((element) => {category.add(element.categorieName) });

    //return category;
  //}

  getSearchWallpaper(String query)async{
    var response = await http.get('https://api.pexels.com/v1/search?query=$query?&per_page=$noOfImageToLoad&page=$page',
        headers:{
          "Authorization" : apiKey
        });

    Map<String,dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element){
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {
    });
  }
  _scrollListener(){
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
      noOfImageToLoad = noOfImageToLoad + 40;
      page = page +1;
      getSearchWallpaper(widget.searchQuery);

    }}
  @override
  void initState() {
    //categories = getCategories();
    getSearchWallpaper(widget.searchQuery);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
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
                    child: Icon(FontAwesomeIcons.bars),onTap: widget.menuCallback,),
                  Column(
                    children: [
                      Text('WallPaper Hub',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),),
                      SizedBox(height: deviceWidth*0.01,),
                      Text(widget.searchQuery.inCaps,style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12
                      ),),
                    ],
                  ),
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context)=>MenuFrame()
                        ));
                      },
                      child: Icon(FontAwesomeIcons.home))
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
      ),
    );
  }
}
