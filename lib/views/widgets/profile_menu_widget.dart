import 'package:flutter/material.dart';

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.endIcon = true,
    this.textColor,
    this.iconColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback onPressed;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: SizedBox(
        width: 40,
        height: 40,
        child: Icon(
          icon,
          color: iconColor,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.apply(color: textColor),
      ),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: const Icon(Icons.keyboard_arrow_right_outlined,
                  size: 18.0, color: Colors.grey))
          : null,
    );
  }
}
