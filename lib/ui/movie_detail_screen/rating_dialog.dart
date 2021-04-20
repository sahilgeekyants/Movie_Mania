import 'package:flutter/material.dart';
import 'package:movie_mania/utils/scale_config.dart';

class RatingDialog extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focus;
  final Function(double) onTap;
  RatingDialog({
    @required this.controller,
    @required this.focus,
    @required this.onTap,
  });
  final SizeScaleConfig scaleConfig = SizeScaleConfig();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Container(
              height: scaleConfig.scaleWidth(50),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(scaleConfig.scaleWidth(20)),
                    topRight: Radius.circular(scaleConfig.scaleWidth(20))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.only(left: scaleConfig.scaleWidth(20)),
                      child: Text(
                        'Give Rating',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontFamily: 'Roboto',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: scaleConfig.scaleWidth(23),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      right: scaleConfig.scaleWidth(9),
                      top: scaleConfig.scaleWidth(3),
                    ),
                    child: Material(
                      color: Colors.blue,
                      child: IconButton(
                        icon: Icon(Icons.delete),
                        iconSize: scaleConfig.scaleWidth(28),
                        color: Colors.white,
                        padding: EdgeInsets.only(),
                        onPressed: () async {},
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: scaleConfig.scaleWidth(370),
              child: Container(
                padding: EdgeInsets.only(
                  top: scaleConfig.scaleWidth(80),
                  left: scaleConfig.scaleWidth(20),
                  right: scaleConfig.scaleWidth(20),
                  bottom: scaleConfig.scaleWidth(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: controller,
                      focusNode: focus,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Enter number between 0 to 10",
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue)),
                      ),
                      textInputAction: TextInputAction.done,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: scaleConfig.scaleWidth(370),
                bottom: scaleConfig.scaleWidth(60),
              ),
              child: Container(
                width: double.infinity,
                height: 60,
                margin: EdgeInsets.only(
                  left: scaleConfig.scaleHeight(100),
                  right: scaleConfig.scaleHeight(100),
                ),
                child: RaisedButton(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: Colors.green[700])),
                  onPressed: () async {
                    String text = controller.text;
                    double rating = double.parse(text);
                    if (rating >= 0 && rating <= 10) {
                      //Run rating func
                      await onTap(rating);
                      controller.text = '';
                      focus.unfocus();
                      Navigator.pop(context);
                    }
                  },
                  textColor: Colors.white,
                  color: Colors.green,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "SUBMIT",
                  ),
                ),
              ),
            ),
          ],
        ),
        //
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(scaleConfig.scaleWidth(20)),
      )),
    );
  }
}
