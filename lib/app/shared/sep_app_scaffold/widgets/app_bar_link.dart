import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:sep_app_web/app/shared/sep_app_bar_links.dart';
import 'package:sep_app_web/locator.dart';

class AppBarLink extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String path;
  final bool isIconLink;

  late bool _isAvailable;

  AppBarLink(
      {Key? key,
      required this.title,
      required this.path,
      this.icon,
      this.isIconLink = false})
      : super(key: key) {
    final appBarState = locator<SepAppBarState>();
    _isAvailable = appBarState.isLinkActive(title);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: MaterialButton(
        onPressed: () {
          context.go(path);
        },
        color: _isAvailable ? Colors.white : null,
        child: !isIconLink
            ? _titleLink()
            : FaIcon(
                icon,
                color: _isAvailable ? Colors.red : Colors.white,
              ),
      ),
    );
  }

  Widget _titleLink() {
    if (icon == null) {
      return Text(
        title,
        style: TextStyle(
          color: _isAvailable ? Colors.red : Colors.white,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Row(
        children: [
          FaIcon(
            icon,
            color: _isAvailable ? Colors.red : Colors.white,
            size: 15,
          ),
          const SizedBox(width: 5),
          Text(
            title,
            style: TextStyle(
              color: _isAvailable ? Colors.red : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }
  }
}
