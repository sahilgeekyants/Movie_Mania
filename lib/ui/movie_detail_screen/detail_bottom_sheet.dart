import 'package:flutter/material.dart';
import 'package:movie_mania/utils/scale_config.dart';

class MovieDetailBottomSheet extends StatelessWidget {
  final SizeScaleConfig scaleConfig = SizeScaleConfig();
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: scaleConfig.scaleHeight(40)),
                height: SizeScaleConfig.screenHeight / 2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(scaleConfig.scaleWidth(15)),
                        topLeft: Radius.circular(scaleConfig.scaleWidth(15)))),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: scaleConfig.scaleWidth(30),
                    vertical: scaleConfig.scaleHeight(30),
                  ),
                  child: ListView(
                    children: [
                      Text(
                        'Joker',
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: scaleConfig.scaleHeight(40),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: scaleConfig.scaleHeight(15)),
                      Text(
                        'Crime, Drama, Thriller',
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: scaleConfig.scaleHeight(17),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: scaleConfig.scaleHeight(15)),
                      Text(
                        'Runtime: 2h 2min',
                        textScaleFactor: 1,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: scaleConfig.scaleHeight(17),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: scaleConfig.scaleHeight(20)),
                    ],
                  ),
                ),
              ),
              //Circular Icon Box
              Container(
                height: scaleConfig.scaleWidth(83),
                width: scaleConfig.scaleWidth(83),
                margin: EdgeInsets.only(
                    left: (SizeScaleConfig.screenWidth / 2) -
                        scaleConfig.scaleWidth(38)),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[600].withOpacity(0.2),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(scaleConfig.scaleHeight(8.0)),
                child: Icon(
                  Icons.play_arrow_outlined,
                  color: Colors.black87,
                  size: scaleConfig.scaleWidth(55),
                ),
              ),
              //
            ],
          ),
        ]);
  }
}
