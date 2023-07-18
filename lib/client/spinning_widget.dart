import 'package:booksharing_service_app/constants.dart';
import 'package:flutter/material.dart';

class SpinningWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: FractionallySizedBox(
        widthFactor: 0.5, // Adjust the width as needed
        heightFactor: 0.5, // Adjust the height as needed
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(textColor!),
          ),
        ),
      ),
    );
  }
}
