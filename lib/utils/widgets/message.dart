import 'package:flutter/material.dart';
import 'package:movie_mania/utils/scale_config.dart';

class Message extends StatelessWidget {
  final String message;
  final double height;
  Message({@required this.message, this.height});
  final SizeScaleConfig scaleConfig = SizeScaleConfig();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height != null ? scaleConfig.scaleHeight(height) : height,
      child: Center(
        child: Text(
          message,
          style: TextStyle(fontSize: 22.0, color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
