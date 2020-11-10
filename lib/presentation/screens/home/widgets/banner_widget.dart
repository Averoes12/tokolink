import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tokolink/application/carousel/carousel_bloc.dart';

class BannerWidget extends StatefulWidget {
  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final _bloc = CarouselBloc();
  int currentPosition = 0;
  List<SingleBannerWidget> banners = [];

  @override
  void initState() {
    _bloc.add(GetCarousel());
    banners.addAll(setBanners());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder(
        cubit: _bloc,
        builder: (context, state) {
          if (state is CarouselLoaded) {
            if (state.carousels.isEmpty) return Center(child: Text('no data'));
            return CarouselSlider(
              items: state.carousels.map<Widget>((e) => SingleBannerWidget(image: NetworkImage(e.image), onTap: null)).toList(),
              options: options(),
            );
          }
          return Shimmer.fromColors(
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
              ),
            ),
            baseColor: Colors.grey,
            highlightColor: Colors.grey.shade200,
          );
        },
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
