import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int currentPosition = 0;
  List<SingleBannerWidget> banners = [];

  @override
  void initState() {
    banners.addAll(setBanners());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: options(),
        items: banners,
      ),
    );
  }

  CarouselOptions options() => CarouselOptions(
        autoPlay: true,
        pauseAutoPlayOnTouch: true,
        viewportFraction: 1.05,
        onPageChanged: (page, _) {
          setState(() => currentPosition = page);
        },
      );

  List<SingleBannerWidget> setBanners() => [
        SingleBannerWidget(image: NetworkImage('https://placehold.it/900x300'), onTap: null),
        SingleBannerWidget(image: NetworkImage('https://placehold.it/900x300'), onTap: null),
        SingleBannerWidget(image: NetworkImage('https://placehold.it/900x300'), onTap: null),
        SingleBannerWidget(image: NetworkImage('https://placehold.it/900x300'), onTap: null),
        SingleBannerWidget(image: NetworkImage('https://placehold.it/900x300'), onTap: null),
      ];
}

class SingleBannerWidget extends StatelessWidget {
  final ImageProvider image;
  final VoidCallback onTap;

  const SingleBannerWidget({
    Key key,
    @required this.image,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image(
          image: image,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
