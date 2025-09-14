import 'package:flutter/material.dart';
import 'pill_button.dart';

class SegmentedTwoTabs extends StatelessWidget {
  final String firstLabel;
  final String secondLabel;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const SegmentedTwoTabs({
    super.key,
    required this.firstLabel,
    required this.secondLabel,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PillButton(
            label: firstLabel,
            selected: selectedIndex == 0,
            onTap: () => onChanged(0),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: PillButton(
            label: secondLabel,
            selected: selectedIndex == 1,
            onTap: () => onChanged(1),
          ),
        ),
      ],
    );
  }
}
