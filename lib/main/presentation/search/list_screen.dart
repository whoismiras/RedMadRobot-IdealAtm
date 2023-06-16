import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ideal_atm/core/constants/app_assets.dart';
import 'package:ideal_atm/core/constants/app_colors.dart';
import 'package:ideal_atm/core/constants/app_styles.dart';
import 'package:ideal_atm/main/business/bloc/map/map_bloc.dart';
import 'package:ideal_atm/main/business/models/layout/navigatable_pages.dart';
import 'package:ideal_atm/main/presentation/utils/app_router.dart';
import 'package:ideal_atm/main/presentation/widgets/app_widgets/app_bar.dart';
import 'package:ideal_atm/main/presentation/widgets/app_widgets/custom_nav_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ideal_atm/main/presentation/widgets/list_widget.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const QRScreenFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
              onPressed: () {},
            ),
          )
        ],
      ),
      body: BlocBuilder<MapBloc, MapState>(
        bloc: context.read<MapBloc>(),
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.atms.length,
                  itemBuilder: (context, index) {
                    return ListWidget(
                      list_atm: state.atms[index],
                      city: state.atms[index].city ?? '',
                      address: state.atms[index].location ?? '',
                      status: state.atms[index].status ?? '',
                    );
                  },
                  separatorBuilder: (_, sep) => const SizedBox(
                    height: 8,
                  ),
                ),
              ],
            ),
          );
        },
      ),
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
              color: AppColors.greyLight,
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
          onPressed: () {
            AppRouter.replaceWithMapScreen(context);
          },
        ),
        CupertinoButton(
          padding: EdgeInsets.zero,
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
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
          onPressed: () {},
        ),
      ],
    );
  }
}
