import 'package:device_frame_plus/device_frame_plus.dart';

import 'package:flutter/material.dart';

class DeviceFrameWrapper extends StatelessWidget {
  const DeviceFrameWrapper({
    super.key,
    required this.child,
    required this.device,
    this.orientation = Orientation.portrait,
    this.showVirtualKeyboard = false,
    this.isFrameVisible = false,
    this.textDirection = TextDirection.ltr,
  });

  final Widget child;
  final DeviceInfo device;
  final Orientation orientation;
  final bool showVirtualKeyboard;
  final bool isFrameVisible;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    final deviceFrame = DeviceFrame(
      device: device,
      isFrameVisible: isFrameVisible,
      orientation: orientation,
      screen: VirtualKeyboard(
        isEnabled: showVirtualKeyboard,
        child: child,
      ),
    );

    final direction = textDirection;
    final widget = direction != null
        ? Directionality(
            textDirection: direction,
            child: deviceFrame,
          )
        : deviceFrame;

    return widget;
  }
}
