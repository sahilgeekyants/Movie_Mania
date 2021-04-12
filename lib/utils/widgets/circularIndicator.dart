import 'package:flutter/material.dart';
import '../scale_config.dart';

class CircularIndicator extends StatelessWidget {
  final double height;
  CircularIndicator({@required this.height});
  final SizeScaleConfig scaleConfig = SizeScaleConfig();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: scaleConfig.scaleHeight(height),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 4,
          backgroundColor: Colors.black,
        ),
      ),
    );
  }
}
