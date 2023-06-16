import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ideal_atm/main/data/providers/local_provider.dart';
import 'package:ideal_atm/main/presentation/utils/app_router.dart';
import 'package:ideal_atm/main/presentation/utils/design_widget_constants.dart';
import 'package:provider/provider.dart';

class AgreementWidget extends StatelessWidget {
  const AgreementWidget(
      {required this.checkBoxEvent,
      required this.isChecked,
      required this.showWarning,
      Key? key})
      : super(key: key);
  final Function checkBoxEvent;
  final bool showWarning;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildChildren(),
    );
  }

  List<Widget> _buildChildren() {
    List<Widget> builder = [
      Padding(
        padding: persDataAgreementWidgetPadding,
        child: Row(children: [
          PersDataCheckBox(
            checkBoxEvent: checkBoxEvent,
            isChecked: isChecked,
            showWarning: showWarning,
          ),
          const PersDataText(),
        ]),
      ),
    ];
    if (showWarning) {
      builder.add(const PersDataWarning());
    }
    return builder;
  }
}

class PersDataCheckBox extends StatelessWidget {
  const PersDataCheckBox(
      {required this.checkBoxEvent,
      required this.isChecked,
      required this.showWarning,
      Key? key})
      : super(key: key);
  final Function checkBoxEvent;
  final bool showWarning;
  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        fillColor: MaterialStateColor.resolveWith(
          (Set<MaterialState> states) {
            return showWarning
                ? Colors.red
                : Theme.of(context).colorScheme.primary;
          },
        ),
        value: isChecked,
        onChanged: (isChecked) => checkBoxEvent(isChecked));
  }
}

class PersDataText extends StatefulWidget {
  const PersDataText({Key? key}) : super(key: key);

  @override
  State<PersDataText> createState() => _PersDataTextState();
}

class _PersDataTextState extends State<PersDataText> {
  late TapGestureRecognizer _tapGestureRecognizer;

  @override
  void didChangeDependencies() {
    final String? asset = _getAsset(context);
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () {
        if (asset != null) {
          _handleTap(context, asset);
        }
      };
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tapGestureRecognizer.dispose();
    super.dispose();
  }

  void _handleTap(BuildContext context, String asset) {
    AppRouter.toPDF(context, asset);
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: RichText(
          text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: AppLocalizations.of(context).dataUsageAgreementPart1,
            style:
                TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
        TextSpan(
            text: AppLocalizations.of(context).dataUsageAgreementPart2,
            style: persDataAgreementWidgetClickableTextStyle,
            recognizer: _tapGestureRecognizer)
      ])),
    );
  }

  String? _getAsset(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    switch (localeProvider.locale?.languageCode) {
      case 'ru':
      case 'en':
      case 'kk':
      default:
        return null;
    }
  }
}

class PersDataWarning extends StatelessWidget {
  const PersDataWarning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Text(
        AppLocalizations.of(context).dataUsageAgreementWarning,
        style: persDataAgreementWidgetWarningTextStyle,
      ),
    );
  }
}
