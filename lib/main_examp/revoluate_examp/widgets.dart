import 'package:flutter/material.dart';

class ZoomSlider extends StatelessWidget {
  final double zoomValue;
  final void Function(double)? onChanged;
  const ZoomSlider({Key? key,this.onChanged,required this.zoomValue}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Slider(
      value: zoomValue,
      min: 1,
      max: 100,
      divisions: 100,
      label: zoomValue.toString(),
      onChanged: onChanged,
    );
  }
}
