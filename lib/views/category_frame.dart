import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_adoption_app/views/home_screen.dart';
import 'package:pet_adoption_app/views/category_screen.dart';
import 'package:pet_adoption_app/views/menu_screen.dart';

class CategoryFrame extends StatefulWidget {
  @override
  _CategoryFrameState createState() => _CategoryFrameState();
}

class _CategoryFrameState extends State<CategoryFrame>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> scaleAnimation;
  Duration duration = Duration(milliseconds: 200);
  bool menuOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: duration);
    scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.6).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        MenuScreen(),
        AnimatedPositioned(
          duration: duration,
          top: 0,
          bottom: 0,
          left: menuOpen ? deviceWidth * 0.55 : 0.0,
          right: menuOpen ? deviceWidth * -0.45 : 0.0,
          child:
          ScaleTransition(
            scale: scaleAnimation,
            child: GestureDetector(
              onTap: (){
                if(menuOpen){
                  setState(() {
                    menuOpen = false;
                    _animationController.reverse();
                  });
                }
              },
              child: AbsorbPointer(
                absorbing: menuOpen,
                child: Material(
                  animationDuration: duration,
                  borderRadius: BorderRadius.circular(menuOpen ? 30.0 : 0.0),
                  child: CategoryScreen(menuCallback: (){
                    setState(() {
                      menuOpen = true;
                      _animationController.forward();
                    });
                  },),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
