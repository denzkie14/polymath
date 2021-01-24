import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

class TutorSubtract extends StatefulWidget {
  @override
  _TutorSubtractState createState() => _TutorSubtractState();
}

class _TutorSubtractState extends State<TutorSubtract> {
  PageController _pageController;
  List<ExactAssetImage> images = [ExactAssetImage('assets/img/subtraction/tutor-subtract-1.jpg'),ExactAssetImage('assets/img/subtraction/tutor-subtract-2.jpg'), ExactAssetImage('assets/img/subtraction/tutor-subtract-3.jpg'),ExactAssetImage('assets/img/subtraction/tutor-subtract-4.jpg')];

@override
  void initState() {
    // TODO: implement initState
    super.initState();
_pageController = PageController(initialPage: 0,viewportFraction: 0.99);
  }

  @override
  Widget build(BuildContext context) {
      
     return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: new IconThemeData(color:Colors.green),
      ),
       body: Carousel(
        boxFit: BoxFit.fill,
    images:  images,
   autoplay: false,
    dotSize: 10.0,
    dotSpacing: 25.0,
    dotColor: Colors.brown,
    indicatorBgPadding: 15.0,
    overlayShadow: false,
    dotBgColor: Colors.green.withOpacity(0.5),
    borderRadius: true,
  )
       //PageView.builder(
      //   controller: _pageController,
      //   itemCount: images.length,
      //   itemBuilder: (context, position){
      //     return imageSlider(position);
      //   },
      // ),
      // body: Container(
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage("assets/img/addition/teacher-add1.jpg"),
      //       fit: BoxFit.cover
      //     ),
      //   ),
      // ),
    );
    
  }

//   imageSlider(int index){
//       return AnimatedBuilder(
//         animation: _pageController,
//         builder: (context, widget){

//           double value =1;
// if(_pageController.position.haveDimensions){
//   value = _pageController.page - index;
//   value = (1 -(value.abs()* 0.3)).clamp(0.0, 1.0);
// }

//           return Center(
//             child: SizedBox(
//               height: Curves.easeInOut.transform(value) * 1000.0,
//               width: Curves.easeInOut.transform(value) * 550.0,
//               child: widget,
//             ),
//           );
//         },
//         child: Container(
//           child: Image.asset(images[index],fit: BoxFit.fill),
//         ),
//       );

//   }
}


