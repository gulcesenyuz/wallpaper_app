import 'package:flutter/material.dart';
import 'package:pet_adoption_app/model/categories_model.dart';
import 'package:date_format/date_format.dart';
import 'package:pet_adoption_app/state/favorites_state.dart';
import 'package:provider/provider.dart';

class ImageView extends StatefulWidget {
  final BuildContext context;
  final String imgUrl;
  ImageView({this.imgUrl,this.context});

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  bool _hasBeenPressed = true;
  bool _oneTap = true;
  var filePath;
  //List<String> likes ;
  DateTime now = new DateTime.now();
  bool flag;

  @override
  void initState() {
    final likes = Provider.of<FavoritesState>(widget.context);
    if (likes.favoritesIndex.contains(widget.imgUrl)) {
      flag = true;
    } else {
      flag = false;
    }
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    var likes = Provider.of<FavoritesState>(context);
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
                      flag ? Icons.favorite : Icons.favorite_border,
                      size: 35,),
                    color: flag ? Colors.red : Colors.grey.shade500,
                    onPressed: (){
                      setState(() {
                        if (likes.favoritesIndex.contains(widget.imgUrl)) {
                          flag = true;
                          if (flag) {
                            likes.removeLikes(widget.imgUrl);

                            flag = false;
                          } else {
                            likes.addLikes(widget.imgUrl);
                            flag = true;
                          }
                        } else {
                          flag = false;
                          if (flag) {
                            likes.removeLikes(widget.imgUrl);
                            flag = false;
                          } else {
                            likes.addLikes(widget.imgUrl);
                            flag = true;
                          }

                        }
                      });
                      print(likes.favoritesIndex);
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





