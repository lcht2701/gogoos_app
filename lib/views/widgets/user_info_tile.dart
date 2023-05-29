import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class UserInfoTile extends StatelessWidget {
  final String label, value;
  final EdgeInsetsGeometry? margin, padding;
  final Color? valueBackground;
  const UserInfoTile({
    super.key,
    required this.label,
    required this.value,
    this.margin,
    this.padding,
    this.valueBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text('$label',
                style: TextStyle(color: AppColor.orangeColor, fontSize: 12)),
          ),
          Container(
            margin: EdgeInsets.only(top: 6),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            color: valueBackground,
            child: Text(
              '$value',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
