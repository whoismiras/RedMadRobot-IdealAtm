import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideal_atm/core/constants/app_colors.dart';
import 'package:ideal_atm/main/business/bloc/user_state/user_bloc.dart';
import 'package:ideal_atm/main/business/models/atm/atm.dart';
import 'package:ideal_atm/main/presentation/atm/atm_additional_info_widget.dart';
import 'package:ideal_atm/main/presentation/atm/atm_address_widget.dart';
import 'package:ideal_atm/main/presentation/atm/atm_image_widget.dart';
import 'package:ideal_atm/main/presentation/atm/atm_review_widget.dart';
import 'package:ideal_atm/main/presentation/utils/app_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AtmDetailScreen extends StatefulWidget {
  const AtmDetailScreen({Key? key, required this.atm}) : super(key: key);

  final Atm atm;

  @override
  State<AtmDetailScreen> createState() => _AtmDetailScreenState();
}

class _AtmDetailScreenState extends State<AtmDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: SingleChildScrollView(
            child: Column(
              children: [
                AtmImageWidget(atm: widget.atm),
                const SizedBox(height: 16),
                AtmAddressWidget(atm: widget.atm),
                const SizedBox(height: 16),
                if (state.loginState == LoginState.loggedIn)
                  AtmAdditionalInfoWidget(atm: widget.atm),
                if (state.loginState == LoginState.loggedIn)
                  AtmReviewWidget(atm: widget.atm),
                if (state.loginState == LoginState.loggedOff)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                        color: AppColors.almostTransparent,
                      ),
                      child: CupertinoButton(
                        onPressed: () {
                          AppRouter.toAuth(context);
                        },
                        child: Text(
                          AppLocalizations.of(context).more_info,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }
}
