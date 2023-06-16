import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ideal_atm/core/constants/app_assets.dart';
import 'package:ideal_atm/core/constants/app_colors.dart';
import 'package:ideal_atm/core/constants/app_styles.dart';
import 'package:ideal_atm/core/services/alert_controller.dart';
import 'package:ideal_atm/main/business/bloc/map/map_bloc.dart';
import 'package:ideal_atm/main/business/models/atm/atm.dart';
import 'package:ideal_atm/main/business/models/layout/navigatable_pages.dart';
import 'package:ideal_atm/main/presentation/utils/app_router.dart';
import 'package:ideal_atm/main/presentation/search/marker_builder.dart';
import 'package:ideal_atm/main/presentation/widgets/app_widgets/app_bar.dart';
import 'package:ideal_atm/main/presentation/widgets/app_widgets/custom_nav_bar.dart';
import 'package:ideal_atm/main/presentation/widgets/map_widget.dart';
import 'package:latlong2/latlong.dart' show LatLng;
import 'package:ideal_atm/main/presentation/search/current_location_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

enum SingingCharacter { a, b, c, d }

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  final _mapController = MapController();
  final Atm atm1 = const Atm(name: "IB");

  @override
  void initState() {
    super.initState();
    context.read<MapBloc>().requestPermissions();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  SingingCharacter? _character = SingingCharacter.a;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MapBloc, MapState>(
      listener: (context, state) {
        if (state.error.isNotEmpty) {
          return AlertController.showMessage(
            context: context,
            title: 'warning',
            content: state.error,
          );
        }

        // if (state is MapCurrentLocationLoadedState) {
        //   return context.read<MapBloc>().addMarkers(atms);
        // }
      },
      builder: (context, state) {
        final placeMarkers = state.atms
            .map<Marker>(
              (e) => Marker(
                point: LatLng(e.latitude ?? 0.0, e.longitude ?? 0.0),
                height: 64,
                width: 64,
                builder: (_) => MarkerBuilder(atm: e),
              ),
            )
            .toList();
        final currentLocation = state.currentLocation;
        LatLng center = LatLng(43.238949, 76.889709);
        if (currentLocation != null) {
          center = LatLng(currentLocation.latitude, currentLocation.longitude);
        }
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          floatingActionButton: const QRScreenFloatingActionButton(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: const BottomNavBar(
            navPage: NavPages.findATMScreen,
            isFABPresent: true,
          ),
          appBar: CustomAppBar(
            titleWidget: const ATMPresenterSwitcher(),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: SvgPicture.asset(
                    AppAssets.optionsIcon,
                    color: Theme.of(context).colorScheme.onSurface,
                    width: 25,
                    height: 25,
                  ),
                  onPressed: () {
                    _filters();
                  },
                ),
              )
            ],
          ),
          body: MapWidget(
            mapController: _mapController,
            center: center,
            markers: [
              if (currentLocation != null)
                Marker(
                  point: LatLng(
                      currentLocation.latitude, currentLocation.longitude),
                  builder: (_) {
                    return SvgPicture.asset(
                      AppAssets.myLocation,
                      color: AppColors.blueLight,
                    );
                  },
                ),
              ...placeMarkers,
            ],
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: CurrentLocationButton(
                  mapController: _mapController,
                  tickerProvider: this,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _filters() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [
                const SizedBox(height: 20),
                const Text('Filters'),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      _character = SingingCharacter.a;
                    });
                  },
                  child: ListTile(
                    title: const Text('Online'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.a,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      _character = SingingCharacter.b;
                    });
                  },
                  child: ListTile(
                    title: const Text('Offline'),
                    leading: Radio<SingingCharacter>(
                      value: SingingCharacter.b,
                      groupValue: _character,
                      onChanged: (SingingCharacter? value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class ATMPresenterSwitcher extends StatelessWidget {
  const ATMPresenterSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
            width: 80,
            height: 40,
            child: Center(
              child: Text(
                AppLocalizations.of(context).map,
                style: AppStyles.s16w500.apply(color: AppColors.black),
              ),
            ),
          ),
          onPressed: () {},
        ),
        CupertinoButton(
          padding: EdgeInsets.zero,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.greyLight,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            width: 80,
            height: 40,
            child: Center(
              child: Text(
                AppLocalizations.of(context).list,
                style: AppStyles.s16w500.apply(color: AppColors.black),
              ),
            ),
          ),
          onPressed: () {
            AppRouter.replaceWithListScreen(context);
          },
        ),
      ],
    );
  }
}
