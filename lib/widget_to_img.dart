library widget_to_img;

import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// A widget that wraps another widget and provides functionality to capture
/// the wrapped widget as an image.
class WidgetToImage extends StatelessWidget {
  /// The widget to be captured.
  final Widget child;

  /// The key used to identify the widget to be captured.
  final GlobalKey captureKey;

  /// Creates a [WidgetToImage] widget.
  ///
  /// The [captureKey] and [child] parameters must not be null.
  const WidgetToImage({Key? key, required this.captureKey, required this.child})
      : super(key: key);

  /// Captures the widget identified by [captureKey] as a byte array.
  ///
  /// Returns a [Uint8List] containing the image data in PNG format, or null
  /// if the capture fails.
  static Future<Uint8List?> captureAsByte(GlobalKey captureKey) async {
    if (captureKey.currentContext == null) return null;

    RenderRepaintBoundary boundary =
        captureKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    ui.Image image = await boundary.toImage(pixelRatio: 3.0);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    return byteData?.buffer.asUint8List();
  }

  /// Captures the widget identified by [captureKey] as an [Image] widget.
  ///
  /// Returns an [Image] widget containing the captured image, or null if the
  /// capture fails.
  static Future<Image?> captureAsImage(GlobalKey captureKey) async {
    if (captureKey.currentContext == null) return null;

    Uint8List? bytes = await captureAsByte(captureKey);
    if (bytes == null) return null;
    return Image.memory(bytes);
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(key: captureKey, child: child);
  }
}
