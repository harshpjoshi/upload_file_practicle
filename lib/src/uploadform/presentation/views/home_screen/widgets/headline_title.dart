import 'package:flutter/material.dart';

class HeadlineTitle extends StatelessWidget {
  final String title;
  final bool hasDivider;

  const HeadlineTitle({super.key, required this.title, this.hasDivider = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        if (hasDivider)
          const Divider(
            thickness: 1,
            height: 20,
          ),
      ],
    );
  }
}
