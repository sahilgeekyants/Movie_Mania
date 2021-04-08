import 'package:flutter/material.dart';
import 'package:movie_mania/utils/scale_config.dart';
import 'bottom_navigation_item.dart';

class HomeBottomNavigationBar extends StatefulWidget {
  @override
  _HomeBottomNavigationBarState createState() =>
      _HomeBottomNavigationBarState();
}

class _HomeBottomNavigationBarState extends State<HomeBottomNavigationBar> {
  int _currentIndex;
  final SizeScaleConfig scaleConfig = SizeScaleConfig();

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  onItemSelected(int index) {
    //item tapped
    print('item:$index tapped in BottomNavigationBar');
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: scaleConfig.scaleWidth(100),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        boxShadow: [
          BoxShadow(color: Colors.black26, spreadRadius: 0, blurRadius: 5),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: scaleConfig.scaleWidth(30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BottomNavigationItem(
                label: 'Feed',
                iconData: Icons.description_outlined,
                itemIndex: 0,
                isItemSelected: _currentIndex == 0,
                onTap: onItemSelected,
              ),
              BottomNavigationItem(
                label: 'Star',
                iconData: Icons.bookmark_outline_rounded,
                itemIndex: 1,
                isItemSelected: _currentIndex == 1,
                onTap: onItemSelected,
              ),
              BottomNavigationItem(
                label: 'Person',
                iconData: Icons.person_outline,
                itemIndex: 2,
                isItemSelected: _currentIndex == 2,
                onTap: onItemSelected,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
