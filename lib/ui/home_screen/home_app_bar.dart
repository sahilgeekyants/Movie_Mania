import 'package:flutter/material.dart';
import 'package:movie_mania/utils/scale_config.dart';

class HomeAppBar {
  static getAppBar() {
    final SizeScaleConfig scaleConfig = SizeScaleConfig();
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        padding: EdgeInsets.only(left: scaleConfig.scaleWidth(50)),
        iconSize: scaleConfig.scaleWidth(45),
        icon: Icon(
          // Icons.movie_creation_rounded,
          // Icons.theaters_outlined,
          Icons.movie_filter_outlined,
          color: Colors.black87,
        ),
        onPressed: () {},
      ),
      centerTitle: false,
      title: Padding(
        padding: EdgeInsets.only(left: scaleConfig.scaleWidth(30)),
        child: Text(
          'Movie Mania',
          style: TextStyle(
            color: Colors.black87,
            fontSize: scaleConfig.scaleWidth(24),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          padding: EdgeInsets.only(right: scaleConfig.scaleWidth(40)),
          iconSize: scaleConfig.scaleWidth(35),
          icon: Icon(
            Icons.search,
            color: Colors.black87,
          ),
          onPressed: () {
            print('Search button pressed');
          },
        ),
      ],
    );
  }
}
