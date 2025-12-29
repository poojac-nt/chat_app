import 'package:flutter/material.dart';

import '../../../utils/app_constants.dart';

class TitleSubtitle extends StatelessWidget {
  final String title;
  final String subTitle;
  const TitleSubtitle({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTexts.titleTextStyle),
        Text(subTitle, style: AppTexts.subTitleTextStyle),
      ],
    );
  }
}
