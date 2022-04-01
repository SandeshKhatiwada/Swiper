// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main(){
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = CarouselController();
  int activeIndex = 0;
  final UrlImages = [
    'https://images.unsplash.com/photo-1621615578530-cbf3c443165f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    'https://images.unsplash.com/photo-1621615541963-49e6f4612daa?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    'https://images.unsplash.com/photo-1519245659620-e859806a8d3b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    'https://images.unsplash.com/photo-1600510424051-30d592a75353?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    'https://images.unsplash.com/photo-1622481178814-529856e39ba8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1372&q=80',
    'https://images.unsplash.com/photo-1630312465536-5c6b1f76dc3f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1527&q=80',
    'https://images.unsplash.com/photo-1620891549027-942fdc95d3f5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
    'https://images.unsplash.com/photo-1620891507099-170ea1456fd9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text("Swiper"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider.builder(
              carouselController: CarouselController(),
              options: CarouselOptions(
                height: 400,
                initialPage: 0,
                pageSnapping: false,
                autoPlayInterval: Duration(seconds: 2),
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                enableInfiniteScroll: false,
                onPageChanged:(index, reason) =>
                setState(() => activeIndex = index),
                ),
              itemCount: UrlImages.length,
              itemBuilder: (context, index, realIndex){
                final urlImage = UrlImages[index];
                return buildImage(urlImage, index);
              },
              
            ),
            const SizedBox(height: 32),
            buildIndicator(),
          ],
        ),
      ),

      
    );
  }

  Widget buildImage(String urlImage, int index) =>
    Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      color: Colors.grey,
      child: Image.network(
        urlImage,
        fit: BoxFit.cover,
      ),
    );

  buildIndicator() => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: UrlImages.length,
    effect: ScrollingDotsEffect(
      activeDotColor: Colors.green,
      dotColor: Colors.black12
    ),
   ); 

   Widget buildButtons({bool stretch = false}) =>Row(
     mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 32,),
          ),
          child: Icon(Icons.arrow_back, size: 32, color: Colors.red),
          onPressed: previous,
        ),
        stretch? Spacer() : SizedBox(width: 32),
         ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 32),
          ),
          onPressed:next,
          child: Icon(Icons.arrow_forward, size: 32, color: Colors.red),
          
        ),
      ],
   );
   void next()=> controller.nextPage();
   void previous()=> controller.previousPage();

}