import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class ESettingsTile extends StatelessWidget {
  const ESettingsTile(
      {super.key,
      required this.icon,
      required this.title,
      required this.subTitle,
      this.trailing,
      this.onTap});

  final IconData icon;
  final String title, subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      leading: Icon(
        icon,
        size: 20,
        color: EColors.primaryColor,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.labelMedium!.apply(color: dark ? EColors.white : EColors.black ),
      ),
      subtitle: Text(
        subTitle,
        style: Theme.of(context).textTheme.labelMedium!.apply(color: dark ? EColors.white : EColors.black ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
