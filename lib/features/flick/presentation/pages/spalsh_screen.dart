import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/logo.svg',
                width: size.width * .5, height: size.height * .15),
            SizedBox(
              height: 30,
            ),
            Text('FLICK'),
          ],
        ),
      ),
    );
  }
}
