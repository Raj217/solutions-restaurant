import 'package:flutter/material.dart';
import 'section_child.dart';

class SectionSkeleton extends StatelessWidget {
  final String sectionHeading;
  final List<SectionChild> children;
  final double gap;
  const SectionSkeleton(
      {Key? key,
      required this.sectionHeading,
      required this.children,
      this.gap = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionHeading,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7)),
        ),
        const SizedBox(height: 10),
        ...children.map(
          (SectionChild child) => Padding(
            padding: const EdgeInsets.only(top: 5, left: 10),
            child: child,
          ),
        ),
      ],
    );
  }
}
