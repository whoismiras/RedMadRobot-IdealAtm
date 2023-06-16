import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ideal_atm/core/constants/app_assets.dart';
import 'package:ideal_atm/core/extensions/animated_move.dart';
import 'package:ideal_atm/main/business/bloc/map/map_bloc.dart';
import 'package:ideal_atm/main/presentation/search/app_icon_button.dart';
import 'package:latlong2/latlong.dart' show LatLng;
import 'package:geolocator/geolocator.dart';

class CurrentLocationButton extends StatelessWidget {
  const CurrentLocationButton({
    Key? key,
    required this.mapController,
    required this.tickerProvider,
  }) : super(key: key);

  final MapController mapController;
  final TickerProviderStateMixin tickerProvider;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        final currentLocation = state.currentLocation;
        return AppIconButton(
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(AppAssets.arrowSharpIcon,
            color: Theme.of(context).colorScheme.outline,
            width: 40,
            height: 40,
          ),
          onPressed: () async {
            if (currentLocation == null) {
              Geolocator.openAppSettings().then((value) {
                context.read<MapBloc>().requestPermissions();
              });
              return;
            }
            final currentLatLng =
                LatLng(currentLocation.latitude, currentLocation.longitude);
            mapController.animatedMove(currentLatLng, 14.0, tickerProvider);
          },
        );
      },
    );
  }
}
