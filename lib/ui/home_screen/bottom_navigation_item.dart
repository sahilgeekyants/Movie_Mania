import 'package:flutter/material.dart';
import 'package:movie_mania/utils/scale_config.dart';

class BottomNavigationItem extends StatelessWidget {
  final String label;
  final IconData iconData;
  final int itemIndex;
  final bool isItemSelected;
  final Function(int) onTap;
  BottomNavigationItem({
    @required this.label,
    @required this.iconData,
    @required this.itemIndex,
    @required this.isItemSelected,
    @required this.onTap,
  });
  final SizeScaleConfig scaleConfig = SizeScaleConfig();
  Widget get iconWidget => Icon(
        iconData,
        color: isItemSelected ? Colors.black87 : Colors.grey,
        size: scaleConfig.scaleWidth(isItemSelected ? 32 : 34),
      );
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onTap(itemIndex);
        },
        child: isItemSelected
            ? Container(
                margin:
                    EdgeInsets.symmetric(horizontal: scaleConfig.scaleWidth(5)),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.grey[200],
                ),
                child: Container(
                  margin:
                      EdgeInsets.symmetric(vertical: scaleConfig.scaleWidth(6)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      iconWidget,
                      SizedBox(width: scaleConfig.scaleWidth(5)),
                      Text(
                        label,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: scaleConfig.scaleWidth(19),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : iconWidget,
      ),
    );
  }
}
