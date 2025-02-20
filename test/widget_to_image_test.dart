import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:widget_to_image/widget_to_image.dart';

void main() {
  testWidgets('WidgetToImage captures widget as image',
      (WidgetTester tester) async {
    // Create a GlobalKey to capture the widget.
    final captureKey = GlobalKey();

    // Build the WidgetToImage widget with a simple child.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: WidgetToImage(
            captureKey: captureKey,
            child: const Text('Test Widget'),
          ),
        ),
      ),
    );

    // Wait for the frame to be rendered.
    await tester.pumpAndSettle();

    // Capture the widget as a Uint8List.
    final imageBytes = await WidgetToImage.captureAsByte(captureKey);

    // Verify that the imageBytes is not null.
    expect(imageBytes, isNotNull);

    // You can add more specific checks here, such as verifying the image dimensions or content.
    // However, this requires more advanced image processing techniques.
  });

  testWidgets('WidgetToImage captures widget as Image widget',
      (WidgetTester tester) async {
    // Create a GlobalKey to capture the widget.
    final captureKey = GlobalKey();

    // Build the WidgetToImage widget with a simple child.
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: WidgetToImage(
            captureKey: captureKey,
            child: const Text('Test Widget'),
          ),
        ),
      ),
    );

    // Wait for the frame to be rendered.
    await tester.pumpAndSettle();

    // Capture the widget as an Image widget.
    final imageWidget = await WidgetToImage.captureAsImage(captureKey);

    // Verify that the imageWidget is not null.
    expect(imageWidget, isNotNull);

    // Verify that the imageWidget is of type Image.
    expect(imageWidget, isA<Image>());
  });

  test('captureAsByte returns null when context is null', () async {
    final captureKey = GlobalKey();
    // Don't build the widget, so the context will be null
    final imageBytes = await WidgetToImage.captureAsByte(captureKey);
    expect(imageBytes, isNull);
  });

  test('captureAsImage returns null when context is null', () async {
    final captureKey = GlobalKey();
    // Don't build the widget, so the context will be null
    final imageWidget = await WidgetToImage.captureAsImage(captureKey);
    expect(imageWidget, isNull);
  });
}
