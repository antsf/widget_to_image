import 'package:flutter/material.dart';
import 'package:widget_to_img/widget_to_img.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget to Image Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Widget to Image Example'),
        ),
        body: const Center(
          child: WidgetCaptureDemo(),
        ),
      ),
    );
  }
}

class WidgetCaptureDemo extends StatefulWidget {
  const WidgetCaptureDemo({super.key});

  @override
  State<WidgetCaptureDemo> createState() => _WidgetCaptureDemoState();
}

class _WidgetCaptureDemoState extends State<WidgetCaptureDemo> {
  final GlobalKey _globalKey = GlobalKey();
  Image? _capturedImage;

  void _captureWidget() async {
    final image = await WidgetToImage.captureAsImage(
      _globalKey,
    );
    setState(() {
      _capturedImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WidgetToImage(
          captureKey: _globalKey,
          child: Container(
            color: Colors.blue,
            padding: const EdgeInsets.all(20),
            child: const Text(
              'Capture this widget!',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _captureWidget,
          child: const Text('Capture Widget'),
        ),
        const SizedBox(height: 20),
        if (_capturedImage != null) _capturedImage!,
      ],
    );
  }
}
