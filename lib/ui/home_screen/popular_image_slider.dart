import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_mania/utils/image_data.dart';
import 'package:movie_mania/utils/scale_config.dart';

class PopularImageSlider extends StatefulWidget {
  @override
  _PopularImageSliderState createState() => _PopularImageSliderState();
}

class _PopularImageSliderState extends State<PopularImageSlider> {
  final SizeScaleConfig scaleConfig = SizeScaleConfig();
  //image data temporary
  static final List<String> imageData = ImageData.getDestinationsData;
  CarouselController sliderController;
  int pageIndex;
  @override
  void initState() {
    super.initState();
    sliderController = CarouselController();
    pageIndex = 0;
  }

  @override
  void dispose() {
    // sliderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // sliderController.nextPage()
    return Container(
      child: Column(
        children: <Widget>[
          CarouselSlider(
            carouselController: sliderController,
            options: CarouselOptions(
              height: scaleConfig.scaleHeight(250),
              enableInfiniteScroll: true,
              autoPlay: true,
              aspectRatio: 2,
              viewportFraction: 0.45,
              enlargeCenterPage: false,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              onPageChanged: (index, reson) {
                setState(() {
                  pageIndex = index;
                });
              },
            ),
            items: imageData.map((item) {
              int _imageIndex = imageData.indexOf(item);
              return Container(
                child: Image.asset(
                  item,
                  fit: BoxFit.fitHeight,
                  width: scaleConfig.scaleWidth(120),
                  height: scaleConfig.scaleHeight(160),
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    return Container(
                      padding:
                          EdgeInsets.only(right: scaleConfig.scaleWidth(30)),
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          //image
                          Container(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22)),
                              child: GestureDetector(
                                onTap: () {
                                  print('Image clicked index : $_imageIndex');
                                },
                                child: child,
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[600].withOpacity(0.2),
                                  spreadRadius: 0,
                                  blurRadius: 2,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                          ),
                          //Movie Title
                          Container(
                            padding: EdgeInsets.only(
                                top: scaleConfig.scaleHeight(10),
                                bottom: scaleConfig.scaleHeight(5)),
                            child: Text(
                              'Joker',
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: scaleConfig.scaleWidth(22),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          //Movie Tags
                          Container(
                            child: Text(
                              'Crime, Drama',
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.black45,
                                fontSize: scaleConfig.scaleWidth(17),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
