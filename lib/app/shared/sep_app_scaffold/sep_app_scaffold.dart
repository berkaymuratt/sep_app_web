import 'package:flutter/material.dart';
import 'package:sep_app_web/app/shared/sep_app_scaffold/widgets/sep_app_bar.dart';
import 'package:sep_app_web/app/shared/sep_colors.dart';

class SepAppScaffold extends StatelessWidget {
  final Widget child;
  final bool singleTitle;

  const SepAppScaffold({
    Key? key,
    required this.child,
    this.singleTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SepAppBar(singleTitle: singleTitle),
        centerTitle: singleTitle,
      ),
      backgroundColor: SepColors.backgroundColor,
      body: child,
    );
  }
}