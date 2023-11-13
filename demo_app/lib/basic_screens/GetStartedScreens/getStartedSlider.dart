import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../resources/components/round_button.dart';
import '../Home.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int activeIndex=0;
  CarouselController carouselController = CarouselController();

  @override
  void initState(){
    super.initState();
    setStateForSlider();
  }

  setStateForSlider() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isSlideShow", true);
  }


  final List<String> images = [
    'assets/slider/image1.svg',
    'assets/slider/image2.svg',
    'assets/slider/image3.svg',
  ];

  final List<String> headings = [
    "Slider 1",
    "Slider 2",
    "Slider 3"
  ];

  final List<String> descriptions = [
    "description 1",
    "description 2",
    "description 3"
  ];

  final List<double> widths = [
    236.0,370.0,234.0
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 127.0,),
          Container(
            color: Color(0xFFF7F9F9),
            child: Center(
              child: CarouselSlider.builder(itemCount: images.length,
                  carouselController: carouselController,
                  itemBuilder: (context,index,realIndex){
                    final urlImage = images[index];
                        return buildImage(urlImage,index);
                  },
                  options: CarouselOptions(height: 400,viewportFraction: 1,enableInfiniteScroll: false,
                  onPageChanged: (index,reason)=>setState(()=>activeIndex=index)
                  )
              ),
            ),
          ),
          buildIndicator(),
          const SizedBox(height: 25.0,),
          Container(
            width: 324.0,
            child: buildText(activeIndex)
          ),
          const SizedBox(height: 25.0,),

          RoundButton(title: "Skip" , onPress:()async{
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (BuildContext context) => MyHomePage()),
            );
          }),
        ],
      )
    );
  }



  Widget buildText(index){
    return Column(
      children: [
        Text(headings[index],style: TextStyle(fontWeight: FontWeight.w400,fontSize: 25),textAlign: TextAlign.center,),
        const SizedBox(height: 20.0,),
        Text(
          descriptions[index],
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Widget buildImage(String urlImage, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      color: Color(0xFFF7F9F9),
      child: Container(
        width: widths[index],
         height: 321.0,
        child: SvgPicture.asset(
          urlImage,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }

  Widget buildIndicator()=>AnimatedSmoothIndicator(activeIndex: activeIndex, count: images.length,
    effect:ScaleEffect(
        spacing:  8.0,
        radius:  3.0,
        dotWidth:  5.0,
        dotHeight:  5.0,
        paintStyle:  PaintingStyle.fill,
        strokeWidth:  1.5,
        dotColor:  Colors.grey,
        activeDotColor:  Color(0xFF01B49E)
    ),
  );
}