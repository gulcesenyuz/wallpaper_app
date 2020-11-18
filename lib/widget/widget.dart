import 'package:flutter/material.dart';
import 'package:pet_adoption_app/model/wallpaper_model.dart';
import 'package:pet_adoption_app/views/image_view.dart';

Widget BrandName(){
  return Row(children: <Widget>[
    Text('MyWallPaper'),
    Text('Hub')
  ],);
}

Widget wallpaperGridView({List<WallpaperModel> wallpapers,context}){
  return Container(
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        padding: const EdgeInsets.all(0.0),
        mainAxisSpacing: 6.0,
        //crossAxisSpacing: 2.0,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: wallpapers.map((wallpaper){
          return GridTile(
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>ImageView(
                      imgUrl: wallpaper.src.portrait,
                      context: context,
                    )
                ));
              },
              child: Hero(
                tag: wallpaper.src.portrait,
                child: Container(
                  child : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(wallpaper.src.portrait,fit: BoxFit.cover,)),
                  padding: EdgeInsets.only(bottom:5,left: 5 ,right:5 ),
                ),
              ),
            ),
          );
        }).toList(),
      )
  );
}

Widget wallpaperGridViewForFavorites({List<String> wallpapers,context}){
  return Container(
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        padding: EdgeInsets.all(2.0),
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 2.0,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: wallpapers.map((wallpaper){
          return GridTile(
            child: Hero(
                tag: wallpaper,
                child:Container(
                    child:ClipRRect(
                      borderRadius:BorderRadius.circular(12),
                      child: Image.network(wallpaper,fit: BoxFit.cover,),
                    )
                )
            ),
          );
        }).toList(),
      )
  );
}