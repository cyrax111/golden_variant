import 'package:device_frame_plus/device_frame_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class DeviceVariant extends ValueVariant<DeviceInfo> {
  DeviceVariant(super.values);

  @override
  Future<DeviceInfo> setUp(DeviceInfo value) async {
    debugDefaultTargetPlatformOverride = value.identifier.platform;
    debugDisableShadows = false;

    final view = TestWidgetsFlutterBinding.instance.platformDispatcher.implicitView!;
    view.physicalSize = value.frameSize;
    view.devicePixelRatio = value.pixelRatio;
    view.padding = FakeViewPadding(
      left: value.safeAreas.left * 2,
      right: value.safeAreas.right * 2,
      top: value.safeAreas.top * 2,
      bottom: value.safeAreas.bottom * 2,
    );
    view.viewPadding = FakeViewPadding(
      left: value.safeAreas.left,
      right: value.safeAreas.right,
      top: value.safeAreas.top,
      bottom: value.safeAreas.bottom,
    );
    return super.setUp(value);
  }

  @override
  Future<void> tearDown(DeviceInfo value, DeviceInfo memento) async {
    final view = TestWidgetsFlutterBinding.instance.platformDispatcher.implicitView!;
    view.resetPadding;
    view.resetViewPadding;
    view.resetDevicePixelRatio;
    view.resetPhysicalSize;
    view.resetViewInsets;

    debugDisableShadows = true;
    debugDefaultTargetPlatformOverride = null;
    await super.tearDown(value, memento);
  }

  @override
  String describeValue(DeviceInfo value) => value.name;
}
