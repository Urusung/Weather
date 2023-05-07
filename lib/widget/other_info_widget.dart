import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtherInfoWidget extends StatelessWidget {
  final IconData titleIcon;
  final String title;
  final String value1;
  final String value2;
  final String value3;

  const OtherInfoWidget({
    required this.titleIcon,
    required this.title,
    required this.value1,
    required this.value2,
    required this.value3,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final otherInfoContainerWidth =
        (MediaQuery.of(context).size.width - 40) / 2;
    final otherInfoContainerHeight = MediaQuery.of(context).size.height / 5;
    return Container(
      padding: const EdgeInsets.all(16),
      width: otherInfoContainerWidth,
      height: otherInfoContainerHeight,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(otherInfoContainerHeight / 10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                titleIcon,
                color: Colors.white.withOpacity(0.5),
                size: otherInfoContainerHeight * 0.08,
              ),
              Padding(
                padding: EdgeInsets.only(right: 4.0),
              ),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                  fontSize: otherInfoContainerHeight * 0.08,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8),
          ),
          if (value1.isNotEmpty) ...[
            Text(
              value1,
              style: TextStyle(
                color: Colors.white,
                fontSize: otherInfoContainerHeight * 0.16,
              ),
            ),
          ],
          if (value2.isNotEmpty) ...[
            Text(
              value2,
              style: TextStyle(
                color: Colors.white,
                fontSize: otherInfoContainerHeight * 0.12,
              ),
            ),
          ],
          if (value3.isNotEmpty) ...[
            if (value1.isEmpty && value2.isEmpty) ...[
              Text(
                value3,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: otherInfoContainerHeight * 0.08,
                ),
              ),
            ],
            if (value1.isNotEmpty || value2.isNotEmpty) ...[
              Spacer(),
              Text(
                value3,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: otherInfoContainerHeight * 0.08,
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }
}
