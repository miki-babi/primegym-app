import 'package:flutter/material.dart';

import 'exercise_image.dart';

class ExerciseFullscreenViewer {
  static Future<void> show(
    BuildContext context, {
    required String path,
    bool isFile = false,
  }) {
    return showGeneralDialog<void>(
      context: context,
      barrierColor: Colors.black87,
      barrierDismissible: true,
      barrierLabel: 'Close',
      pageBuilder: (context, _, _) {
        return Material(
          type: MaterialType.transparency,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: InteractiveViewer(
                  maxScale: 4,
                  child: ExerciseImage(
                    assetPath: path,
                    isFile: isFile,
                    borderRadius: 0,
                    fit: BoxFit.contain,
                    width: MediaQuery.sizeOf(context).width,
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: IconButton(
                      icon: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
