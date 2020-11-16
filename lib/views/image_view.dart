import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pet_adoption_app/model/categories_model.dart';
import 'package:date_format/date_format.dart';

class ImageView extends StatefulWidget {
  final String imgUrl;
  ImageView({this.imgUrl});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  bool _hasBeenPressed = true;
  bool _oneTap = true;
  var filePath;
  List likes = new List();
  DateTime now = new DateTime.now();


  List<CategorieModel> favorites = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                _oneTap = !_oneTap;
              });
            },
            onDoubleTap: (){
              //TODO:İki tıklama yerine yana kaydırma olabilir??
            },

            child: Hero( // Hero fotografı tag ile hedefleyip açtığında Container ekranı resim ile kaplıyacak
              tag: widget.imgUrl,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.network(widget.imgUrl, fit: BoxFit.cover,),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height/2,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${formatDate(now, [HH,':',nn])}',
                  //TODO:Time ve Tarih ekle
                  style: TextStyle(
                      color: _oneTap ? Colors.white : Colors.transparent,
                      fontSize: 50,
                      fontWeight: FontWeight.w500),),
                Text('${formatDate(now, [d, ' ', M, ' ', D])}',
                  style: TextStyle(
                      color: _oneTap ? Colors.white : Colors.transparent,
                      fontSize: 30,
                      fontWeight: FontWeight.w200),)
              ],
            ),
          ),

          Container( // Buttonla
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 50),
                  child: IconButton(
                    icon : Icon(
                      Icons.favorite,
                      size: 35,),
                    color: _hasBeenPressed ? Colors.white54 : Colors.red,
                    onPressed: (){
                      setState(() {
                        _hasBeenPressed = !_hasBeenPressed;
                        //TODO: Favoriler listesi oluştur ve favori butonuna tıklandığında listeye aktar.
                      });
                      _hasBeenPressed ? likes.remove(widget.imgUrl) : likes.add(widget.imgUrl);
                      likes;
                      print(likes);
                    },),
                ),
                GestureDetector(
                  onTap: () {


                  },
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xff1C1B1B).withOpacity(0.6),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        width: MediaQuery.of(context).size.width / 4,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 4,
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white54, width: 1),
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                                colors: [
                                  Color(0x36FFFFFF),
                                  Color(0x0FFFFFFF),
                                ])),
                        child: Text('Save',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 50),
                  child: IconButton(
                    icon: Icon(
                      Icons.cancel,
                      size: 35,),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                ),
                SizedBox(height: 200,)
              ],
            ),
          ),
        ],),
    );
  }



  }





