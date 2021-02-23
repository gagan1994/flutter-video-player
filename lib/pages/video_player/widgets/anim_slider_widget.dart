import 'package:flutter/material.dart';

class AnimSliderWidget extends StatelessWidget {
  bool isVissible;
  double value;
  Color activeColor;
  Function(double) onValueChanged;

  double min;
  double max;
  AnimSliderWidget(this.isVissible, this.value,
      {this.activeColor: Colors.blueAccent,
      this.onValueChanged,
      this.min: 0,
      this.max: 1});
  @override
  Widget build(BuildContext context) {
    print("Brightness val: $value");
    return AnimatedOpacity(
      opacity: isVissible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 500),
      child: Container(
        child: RotatedBox(
          quarterTurns: 3,
          child: SliderTheme(
            child: Slider(
              value: value,
              min: min,
              max: max,
              activeColor: activeColor,
              inactiveColor: Colors.black54,
              onChanged: onValueChanged,
            ),
            data: SliderTheme.of(context).copyWith(
              trackHeight: 10,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 0.0),
            ),
          ),
        ),
      ),
    );
  }
}
