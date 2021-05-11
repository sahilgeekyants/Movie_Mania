import 'package:flutter/material.dart';
import 'package:movie_mania/utils/scale_config.dart';

class RatingDialog extends StatefulWidget {
  final double currentValue;
  final Function(double) onTap;
  RatingDialog({
    @required this.currentValue,
    @required this.onTap,
  });

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  double _values;

  @override
  void initState() {
    super.initState();
    _values = widget.currentValue;
    print('Given value : ${widget.currentValue}');
  }

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
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(scaleConfig.scaleWidth(20)),
                    topRight: Radius.circular(scaleConfig.scaleWidth(20))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    Text(
                      "Rating : ${_values.toString()}",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: scaleConfig.scaleWidth(25),
                      ),
                    ),
                    SizedBox(height: scaleConfig.scaleHeight(10)),
                    Slider(
                        activeColor: Colors.black,
                        inactiveColor: Colors.grey[300],
                        value: _values,
                        min: 0,
                        max: 10,
                        onChanged: (double values) {
                          double _newValue =
                              double.parse(values.toStringAsFixed(1));
                          print('selected value $_newValue');
                          setState(() {
                            if (_newValue != _values) {
                              _values = _newValue;
                            }
                          });
                        }),
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
                      side: BorderSide(color: Colors.black)),
                  onPressed: () async {
                    double rating = _values;
                    if (rating >= 0 && rating <= 10) {
                      print('GIving rating : $rating');
                      //Run rating func
                      await widget.onTap(rating);
                      Navigator.pop(context);
                    }
                  },
                  textColor: Colors.white,
                  color: Colors.black87,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(fontSize: scaleConfig.scaleWidth(20)),
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
