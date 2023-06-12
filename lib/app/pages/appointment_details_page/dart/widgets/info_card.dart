import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sep_app_web/app/shared/widgets/sep_divider/sep_divider.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<InfoCardItem> items;

  const InfoCard({Key? key, required this.title, required this.icon, required this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: _decoration,
      child: Column(
        children: [
          Row(
            children: [
              FaIcon(
                icon,
                size: 23,
                color: Colors.red,
              ),
              Text(
                " $title",
                style: const TextStyle(
                  // color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: SepDivider(height: 2, width: 250, color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Column(
            children: _fields,
          ),
        ],
      ),
    );
  }

  List<Widget> get _fields {
    List<Widget> fields = [];

    for (var infoCard in items) {
      fields.add(
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "${infoCard.name}:",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    // color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  infoCard.value,
                  style: const TextStyle(
                      // color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return fields;
  }

  BoxDecoration get _decoration {
    return BoxDecoration(
        color: Colors.white,
        border: Border.all(
          style: BorderStyle.solid,
          width: 2,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10));
  }
}

class InfoCardItem {
  final String name;
  final String value;

  InfoCardItem({required this.name, required this.value});
}
