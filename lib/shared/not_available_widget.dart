import 'package:flutter/material.dart';
import 'package:marche/shared/styles/dimensions.dart';

class NotAvailableWidget extends StatelessWidget {
  final double fontSize;
  final bool isStore;
  NotAvailableWidget({this.fontSize = 8, this.isStore = false});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      bottom: 0,
      right: 0,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            color: Colors.black.withOpacity(0.6)),
        child: Text(
          'Item Not Available',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: fontSize),
        ),
      ),
    );
  }
}
