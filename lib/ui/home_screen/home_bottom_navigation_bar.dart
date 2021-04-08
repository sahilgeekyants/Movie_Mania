import 'package:flutter/material.dart';
import 'package:movie_mania/utils/scale_config.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  final SizeScaleConfig scaleConfig = SizeScaleConfig();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          // fixedColor: Colors.black87,
          // unselectedItemColor: Colors.grey,
          iconSize: scaleConfig.scaleWidth(30),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedIconTheme: IconThemeData(
            color: Colors.black87,
            size: scaleConfig.scaleWidth(38),
          ),
          unselectedIconTheme: IconThemeData(
            color: Colors.grey,
            size: scaleConfig.scaleWidth(34),
          ),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.description_outlined),
              // activeIcon: Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.all(Radius.circular(30)),
              //     color: Colors.grey[300],
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     mainAxisSize: MainAxisSize.min,
              //     children: <Widget>[
              //       Icon(Icons.description_outlined),
              //       Text(
              //         'Feed',
              //         style: TextStyle(
              //           color: Colors.black87,
              //           fontSize: scaleConfig.scaleWidth(17),
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline_rounded),
              label: 'Bookmark',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Person',
            ),
          ],
        ),
      ),
    );
  }
}
