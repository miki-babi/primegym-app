import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../theme/app_colors.dart';

/// Full-bleed looping muted asset video for backgrounds.
class LoopingBgVideo extends StatefulWidget {
  const LoopingBgVideo({
    super.key,
    this.assetPath =
        'assets/bg/c0c10333962598c1bcb2fb44c43a1d01_t4.mp4',
  });

  final String assetPath;

  @override
  State<LoopingBgVideo> createState() => _LoopingBgVideoState();
}

class _LoopingBgVideoState extends State<LoopingBgVideo> {
  VideoPlayerController? _controller;
  bool _ready = false;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final controller = VideoPlayerController.asset(widget.assetPath);
    try {
      await controller.initialize();
      await controller.setLooping(true);
      await controller.setVolume(0);
      await controller.play();
      if (!mounted) {
        await controller.dispose();
        return;
      }
      setState(() {
        _controller = controller;
        _ready = true;
      });
    } catch (_) {
      await controller.dispose();
      if (mounted) {
        setState(() => _failed = true);
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_failed || !_ready || _controller == null) {
      return const ColoredBox(color: AppColors.background);
    }

    final size = _controller!.value.size;
    return ColoredBox(
      color: AppColors.background,
      child: SizedBox.expand(
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
    );
  }
}
