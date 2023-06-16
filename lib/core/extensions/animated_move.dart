// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/widgets.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' show LatLng;

extension AnimatedMove on MapController {
  void animatedMove(
    LatLng destLocation,
    double destZoom,
    TickerProvider vsync, {
    Duration duration = const Duration(milliseconds: 500),
  }) {
    try {
      final latTween =
          Tween<double>(begin: center.latitude, end: destLocation.latitude);
      final lngTween =
          Tween<double>(begin: center.longitude, end: destLocation.longitude);
      final zoomTween = Tween<double>(begin: zoom, end: destZoom);

      final controller = AnimationController(duration: duration, vsync: vsync);
      final Animation<double> animation =
          CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

      controller.addListener(() {
        move(LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
            zoomTween.evaluate(animation));
      });

      animation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.dispose();
        } else if (status == AnimationStatus.dismissed) {
          controller.dispose();
        }
      });

      controller.forward();
    } catch (e) {
      move(destLocation, destZoom);
    }
  }
}
