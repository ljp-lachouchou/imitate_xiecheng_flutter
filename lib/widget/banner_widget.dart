import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/model/home_model.dart';
import 'package:flutter_learn/util/screen_adapter_helper.dart';

///轮播图的视线
class BannerWidget extends StatefulWidget {
  final List<CommonModel> bannerList;
  const BannerWidget({super.key, required this.bannerList});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _current = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CarouselSlider(
          items:
              widget.bannerList.map((item) => _tabImage(item, width)).toList(),
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 160.px,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
            viewportFraction: 1.0,
          ),
        ), // 轮播图(无指示器)
        Positioned(child: _indicator(), bottom: 10, left: 0, right: 0),
      ],
    );
  }

  Widget _tabImage(CommonModel model, double width) {
    return GestureDetector(
      onTap: () {
        //todo navigatorUtil
      },
      child: Image.network(model.icon!, width: width, fit: BoxFit.cover),
    );
  }

  _indicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          widget.bannerList.asMap().entries.map((e) {
            return GestureDetector(
              onTap: () => _carouselController.animateToPage(e.key),
              child: Container(
                width: 6,
                height: 6,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Colors.white).withOpacity(
                    _current == e.key ? 0.9 : 0.4,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}
