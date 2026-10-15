
import 'package:flutter/material.dart';
import 'package:shipments/screens/splash/widgets/animated_logo.dart';

class ShipmentsMark extends StatelessWidget {
  const ShipmentsMark({super.key, required this.animation});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 101,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 30,
            left: 0,
            child: AnimatedLogoPart(
              animation: animation,
              assetName: 'Vector 1.svg',
              width: 100,
              height: 71,
              beginVerticalOffset: -6,
              endVerticalOffset: 2,
            ),
          ),
          Positioned(
            top: 0,
            left: 7.75,
            child: AnimatedLogoPart(
              animation: animation,
              assetName: 'Rectangle 1.svg',
              width: 84.5,
              height: 44,
              beginVerticalOffset: 6,
              endVerticalOffset: 2,
            ),
          ),
        ],
      ),
    );
  }
}