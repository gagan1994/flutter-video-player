import 'package:flutter_app_video_player/db/moor_database.dart';

import 'src/aspect_exports.dart';

class Videos extends Aspect with ChildAspect {
  AppDatabase appDatabase;
  Videos(this.appDatabase);
}
