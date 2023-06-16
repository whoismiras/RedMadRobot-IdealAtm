import 'package:flutter/material.dart';
import 'package:ideal_atm/main/presentation/widgets/app_widgets/app_bar.dart';
import 'package:pdfx/pdfx.dart';

class PDFScreen extends StatefulWidget {
  const PDFScreen({Key? key, required this.asset}) : super(key: key);
  final String asset;

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  late PdfControllerPinch controller;

  @override
  void initState() {
    controller =
        PdfControllerPinch(document: PdfDocument.openAsset(widget.asset));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: PdfViewPinch(
        builders: PdfViewPinchBuilders<DefaultBuilderOptions>(
          options: const DefaultBuilderOptions(),
          documentLoaderBuilder: (_) =>
              const Center(child: CircularProgressIndicator()),
          pageLoaderBuilder: (_) =>
              const Center(child: CircularProgressIndicator()),
          errorBuilder: (_, error) => Center(child: Text(error.toString())),
        ),
        controller: controller,
      ),
    );
  }
}
