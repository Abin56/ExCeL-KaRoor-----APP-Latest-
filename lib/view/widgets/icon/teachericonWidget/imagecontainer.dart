import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
 
  final String image;
 // final void Function()? onTap;

  const ImageContainer({
    
    required this.image,
    //required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        //onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50.h,
              width: 50.w,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                 ),
              child: Center(
                child: Image.asset(height: 50,
                  image,
                  fit: BoxFit.contain,
                  scale: 2,
                ),
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
