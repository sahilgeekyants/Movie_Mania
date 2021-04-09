import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_mania/app.dart';
import 'package:movie_mania/ui/movie_detail_screen/movie_detail.dart';
import 'package:movie_mania/utils/image_data.dart';
import 'package:movie_mania/utils/scale_config.dart';

class RecentImageSlider extends StatefulWidget {
  @override
  _RecentImageSliderState createState() => _RecentImageSliderState();
}

class _RecentImageSliderState extends State<RecentImageSlider> {
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
              enableInfiniteScroll: false,
              autoPlay: false,
              aspectRatio: 0.8,
              viewportFraction: 0.75,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.scale,
              onPageChanged: (index, reson) {
                print('old index: $pageIndex');
                print('new index: $index');
                setState(() {
                  pageIndex = index;
                });
              },
            ),
            items: imageData.map((item) {
              int _imageIndex = imageData.indexOf(item);
              bool _isCenterPage = pageIndex == _imageIndex;
              return Container(
                child: Image.asset(
                  item,
                  fit: BoxFit.cover,
                  width: scaleConfig.scaleWidth(320),
                  height: scaleConfig.scaleHeight(_isCenterPage ? 450 : 380),
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    return Container(
                      // color: Colors.yellowAccent,
                      padding:
                          EdgeInsets.only(right: scaleConfig.scaleWidth(20)),
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          //image
                          Container(
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(28)),
                              child: GestureDetector(
                                onTap: () {
                                  //allow to click only center page in recent section
                                  if (_isCenterPage) {
                                    print('Image clicked index : $_imageIndex');
                                    navigatorKey.currentState.pushNamed(
                                      MovieDetail.routeName,
                                      arguments: MovieDetailArguments(
                                        movieId: _imageIndex,
                                      ),
                                    );
                                  }
                                },
                                child: child,
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(28)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[600].withOpacity(0.2),
                                  spreadRadius: 0,
                                  blurRadius: 5,
                                  offset: Offset(0, _isCenterPage ? 10 : 0),
                                ),
                              ],
                            ),
                          ),
                          //Movie Title
                          Container(
                            padding: EdgeInsets.only(
                                top: scaleConfig.scaleHeight(15),
                                bottom: scaleConfig.scaleHeight(10)),
                            child: Text(
                              'Joker',
                              maxLines: 1,
                              style: TextStyle(
                                color: _isCenterPage
                                    ? Colors.black
                                    : Colors.grey[700],
                                fontSize: scaleConfig.scaleWidth(28),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          //Movie Tags
                          Container(
                            child: Text(
                              'Crime, Drama, Thriller',
                              maxLines: 1,
                              style: TextStyle(
                                color: _isCenterPage
                                    ? Colors.black45
                                    : Colors.grey,
                                fontSize: scaleConfig.scaleWidth(18),
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
