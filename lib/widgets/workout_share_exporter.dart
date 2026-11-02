import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> exportAndShareWorkoutCard({
  required GlobalKey boundaryKey,
  required String workoutTitle,
}) async {
  await Future<void>.delayed(const Duration(milliseconds: 50));
  final boundary =
      boundaryKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
  if (boundary == null) return;

  final image = await boundary.toImage(pixelRatio: 3);
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  if (byteData == null) return;

  final dir = await getTemporaryDirectory();
  final file = File(
    p.join(
      dir.path,
      'primegym_workout_${DateTime.now().millisecondsSinceEpoch}.png',
    ),
  );
  await file.writeAsBytes(byteData.buffer.asUint8List());

  await SharePlus.instance.share(
    ShareParams(
      files: [XFile(file.path, mimeType: 'image/png')],
      text: workoutTitle,
      subject: workoutTitle,
    ),
  );
}
