import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../theme/app_colors.dart';
import 'exercise_image.dart';

/// Sized looping muted exercise demo for the active-workout hero.
class ExerciseIllustrationVideo extends StatefulWidget {
  const ExerciseIllustrationVideo({
    super.key,
    required this.assetPath,
    required this.fallbackImageAsset,
    this.width = 200,
    this.height = 148,
    this.borderRadius = 20,
    this.onTap,
  });

  final String? assetPath;
  final String fallbackImageAsset;
  final double width;
  final double height;
  final double borderRadius;
  final VoidCallback? onTap;

  @override
  State<ExerciseIllustrationVideo> createState() =>
      _ExerciseIllustrationVideoState();
}

class _ExerciseIllustrationVideoState extends State<ExerciseIllustrationVideo> {
  VideoPlayerController? _controller;
  bool _ready = false;
  bool _failed = false;
  bool _revealed = false;
  String? _loadedPath;

  @override
  void initState() {
    super.initState();
    _initForPath(widget.assetPath);
  }

  @override
  void didUpdateWidget(covariant ExerciseIllustrationVideo oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.assetPath != widget.assetPath) {
      _initForPath(widget.assetPath);
    }
  }

  Future<void> _initForPath(String? path) async {
    await _disposeController();
    if (!mounted) return;

    if (path == null || path.isEmpty) {
      setState(() {
        _ready = false;
        _failed = true;
        _revealed = false;
        _loadedPath = null;
      });
      return;
    }

    setState(() {
      _ready = false;
      _failed = false;
      _revealed = false;
      _loadedPath = path;
    });

    final controller = VideoPlayerController.asset(path);
    try {
      await controller.initialize();
      await controller.setLooping(true);
      await controller.setVolume(0);
      await controller.play();
      if (!mounted || _loadedPath != path) {
        await controller.dispose();
        return;
      }
      setState(() {
        _controller = controller;
        _ready = true;
        _failed = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || _loadedPath != path) return;
        setState(() => _revealed = true);
      });
    } catch (_) {
      await controller.dispose();
      if (!mounted || _loadedPath != path) return;
      setState(() {
        _controller = null;
        _ready = false;
        _failed = true;
        _revealed = false;
      });
    }
  }

  Future<void> _disposeController() async {
    final previous = _controller;
    _controller = null;
    await previous?.dispose();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Widget _fallback() {
    return ExerciseImage(
      assetPath: widget.fallbackImageAsset,
      width: widget.width,
      height: widget.height,
      borderRadius: 0,
    );
  }

  Widget _placeholder() {
    return ColoredBox(
      color: AppColors.accentSoft,
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.accent.withValues(alpha: 0.8),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget content;
    if (_failed || widget.assetPath == null || widget.assetPath!.isEmpty) {
      content = _fallback();
    } else {
      final size = _controller?.value.size;
      content = Stack(
        fit: StackFit.expand,
        children: [
          _placeholder(),
          if (_ready && _controller != null && size != null)
            AnimatedOpacity(
              opacity: _revealed ? 1 : 0,
              duration: const Duration(milliseconds: 280),
              child: AnimatedScale(
                scale: _revealed ? 1 : 0.97,
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeOut,
                child: ColoredBox(
                  color: AppColors.surfaceElevated,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    clipBehavior: Clip.hardEdge,
                    child: SizedBox(
                      width: size.width == 0 ? 1 : size.width,
                      height: size.height == 0 ? 1 : size.height,
                      child: VideoPlayer(_controller!),
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    }

    return GestureDetector(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: content,
        ),
      ),
    );
  }
}
