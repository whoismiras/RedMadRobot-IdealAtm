import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ideal_atm/core/constants/app_assets.dart';
import 'package:ideal_atm/core/constants/app_colors.dart';
import 'package:ideal_atm/core/services/alert_controller.dart';
import 'package:ideal_atm/main/business/models/atm/atm.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';

class AtmAddressWidget extends StatelessWidget {
  const AtmAddressWidget({
    super.key,
    required this.atm,
  });

  final Atm atm;

  Future<void> share() async {
    const urlPreview = 'www.redmadrobot.kz/';
    await Share.share(
      'ATM# ${atm.id}\n${atm.location}\n\n$urlPreview',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: CupertinoButton(
        color: AppColors.almostTransparent,
        padding: EdgeInsets.zero,
        onPressed: () => openMaps(context),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(AppAssets.map),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 5,
              child: GestureDetector(
                onLongPress: () async {
                  try {
                    //  await Utils.copyToCliboard(atm.address);
                    AlertController.showMessage(
                        context: context, content: 'copied');
                  } catch (e) {
                    debugPrint('Not copied: $e');
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context).address,
                      style: Theme.of(context).textTheme.labelMedium?.apply(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      atm.city ?? '',
                      style: Theme.of(context).textTheme.bodyLarge?.apply(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                    Text(
                      atm.location ?? '',
                      style: Theme.of(context).textTheme.bodyLarge?.apply(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            MaterialButton(
              child: Icon(Icons.share,
                  color: Theme.of(context).colorScheme.outline),
              onPressed: () {
                share();
              },
            )
          ],
        ),
      ),
    );
  }

  void openMaps(BuildContext context) async {
    final availableMaps = await MapLauncher.installedMaps;
    return await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (BuildContext context) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.27,
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              boxShadow: [
                BoxShadow(color: AppColors.greyLight, blurRadius: 10.0),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const SizedBox(height: 5, width: 40),
                    ),
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Wrap(
                          spacing: 16,
                          runSpacing: 32,
                          alignment: WrapAlignment.spaceEvenly,
                          children: <Widget>[
                            for (var map in availableMaps)
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: () async {
                                  if (atm.latitude != null &&
                                      atm.longitude != null) {
                                    return map.showMarker(
                                      title: atm.name ?? '',
                                      coords:
                                          Coords(atm.latitude!, atm.longitude!),
                                    );
                                  }
                                },
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(16)),
                                      child: SvgPicture.asset(
                                        map.icon,
                                        height: 64.0,
                                        width: 64.0,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      map.mapName,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
