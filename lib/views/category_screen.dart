import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption_app/data/data.dart';
import 'package:pet_adoption_app/model/categories_model.dart';
import 'package:pet_adoption_app/views/menu_frame.dart';
import 'package:pet_adoption_app/views/specific_category_screen.dart';

class CategoryScreen extends StatefulWidget {
  final Function menuCallback;
  CategoryScreen({@required this.menuCallback});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<CategorieModel> categories = new List();

  @override
  void initState() {
    categories = getCategories();
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
                    child: Icon(FontAwesomeIcons.bars),
                    onTap: widget.menuCallback,
                  ),
                  //
                  Text(
                    'WallPaper Hub',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
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
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        child: ListView.builder(
                            itemCount: categories.length,
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return CategoriesTile(
                                title: categories[index].categorieName,
                                imgUrl: categories[index].imgUrl,
                              );
                            }),
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

class CategoriesTile extends StatelessWidget {
  final String imgUrl, title;
  CategoriesTile({@required this.title, @required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>Category(
          categorie: title,
        )
        ));
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only( bottom: 5),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  imgUrl,
                  fit: BoxFit.cover,
                  height: 200,
                  width: 350,
                )),
            Container(
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              height: 200,
              width: 350,
              child: Text(
                title,
                style: TextStyle(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 18,)
              ),
            )
          ],
        ),
      ),
    );
  }
}
