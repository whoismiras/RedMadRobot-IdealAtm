// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' show LatLng;

class MapWidget extends StatelessWidget {
  const MapWidget({
    super.key,
    this.mapController,
    this.zoom = 13.5,
    this.markers = const [],
    this.onPositionChanged,
    this.children = const [],
    required this.center,
  });

  final MapController? mapController;
  final double zoom;
  final List<Marker> markers;
  final LatLng center;
  final void Function(MapPosition, bool)? onPositionChanged;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: LatLng(43.238949, 76.889709),
        zoom: 13.5,
        interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          //   'https://www.qwant.com/maps/#map=<z>/<x>/<y>.png',
          additionalOptions: const {
            'accessToken':
                'pk.eyJ1IjoiemhhaWdnIiwiYSI6ImNrcXJ6bTZnejFscTMybm5wYnJ5aGp2czIifQ.E8PCjXC2a5c5Tu-bOCrqQA',
            // 'id': 'mapbox.mapbox-streets-v8'
          },
        ),
        MarkerLayer(
          markers: markers,
        ),
        ...children,
      ],
    );
  }
}
