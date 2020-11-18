import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption_app/views/category_frame.dart';
import 'package:pet_adoption_app/views/favorites_frame.dart';
import 'package:pet_adoption_app/views/menu_frame.dart';
import 'package:pet_adoption_app/views/search_frame.dart';
import 'package:pet_adoption_app/views/search_screen.dart';
import 'category_screen.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

Color mainColor = Colors.black;
//fromRGBO(48, 96, 96, 1.0);
Color startingColor = Colors.black;
//fromRGBO(70, 112, 112, 1.0);

class _MenuScreenState extends State<MenuScreen> {

  TextEditingController searchController =  new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Material(
      child: Container(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(right:150,top: 100),
                  child: Column(
                    children: [
                     Container(
                       decoration: BoxDecoration(
                         //color: Colors.black12,
                          borderRadius: BorderRadius.circular(16)
                       ),
                       width: deviceWidth*0.6,
                       child: Row(
                         //mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Expanded(
                             child: TextField(
                               controller: searchController,
                               decoration: InputDecoration(
                                 hintText: 'Search',
                                 //border: InputBorder.none,
                               ),
                             ),
                           ),
                           Padding(
                             padding:  EdgeInsets.only(right:12.0),
                             child: GestureDetector(
                               onTap: (){
                                 searchController.text.isEmpty ? Navigator.push(context, MaterialPageRoute(
                                     builder: (context) => MenuFrame()
                                 ))
                                     :
                                 Navigator.push(context, MaterialPageRoute(
                                     builder: (context) => SearchFrame(
                                       searchQuery: searchController.text.toLowerCase(),
                                     )
                                 ));
                               },
                               child: Icon(
                                 FontAwesomeIcons.search,size: 20,
                               ),
                             ),
                           )
                         ],
                       ),
                     )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context)=> MenuFrame()
                        ));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.0),
                        child: Row(
                          children: [
                            Icon(Icons.home,),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Home',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context)=> FavoritesFrame()
                        ));

                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.0),
                        child: Row(
                          children: [
                            Icon(Icons.favorite,),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Favorites',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: Row(
                        children: [
                          Icon(Icons.file_download,),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Downloads',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => CategoryFrame()
                        ));
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.0),
                        child: Row(
                          children: [
                            Icon(Icons.category,),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Categories',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
                Row(

                ),
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.black, mainColor],
        )),
      ),
    );
  }
}
