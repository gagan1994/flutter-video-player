import 'package:flutter/material.dart';
import 'package:flutter_app_video_player/shared_state/providers_exports.dart';
import 'package:provider/provider.dart';

enum Speed {
  SPEED_025,
  SPEED_050,
  SPEED_1,
  SPEED_2,
  SPEED_3,
}

extension SpeedExtension on Speed {
  String get name {
    switch (this) {
      case Speed.SPEED_025:
        return '0.25';
      case Speed.SPEED_050:
        return '0.50';
      case Speed.SPEED_1:
        return '1.0';
      case Speed.SPEED_2:
        return '2.0';
      case Speed.SPEED_3:
        return '3.0';
      default:
        return null;
    }
  }

  double get val {
    switch (this) {
      case Speed.SPEED_025:
        return 0.25;
      case Speed.SPEED_050:
        return 0.50;
      case Speed.SPEED_1:
        return 1;
      case Speed.SPEED_2:
        return 2;
      case Speed.SPEED_3:
        return 3;
      default:
        return null;
    }
  }
}

class PopUpSpeedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<VideoPlayerPool>(
      builder: (context, model, child) {
        return Row(
          children: [
            Expanded(
              child: Text(
                'Speed',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SpeedItems(model.currentSpeed, Speed.SPEED_025),
            SpeedItems(model.currentSpeed, Speed.SPEED_050),
            SpeedItems(model.currentSpeed, Speed.SPEED_1),
            SpeedItems(model.currentSpeed, Speed.SPEED_2),
            SpeedItems(model.currentSpeed, Speed.SPEED_3),
          ],
        );
      },
    );
  }
}

class SpeedItems extends StatelessWidget {
  Speed currentSpeed;
  Speed thisSpeed;
  SpeedItems(this.currentSpeed, this.thisSpeed);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<VideoPlayerPool>().setSpeed(thisSpeed);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Text(
          thisSpeed.name,
          style: TextStyle(
              color:
                  thisSpeed == currentSpeed ? Colors.blueAccent : Colors.white),
        ),
      ),
    );
  }
}
