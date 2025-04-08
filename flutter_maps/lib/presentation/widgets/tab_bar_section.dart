import 'package:flutter/material.dart';
import 'package:flutter_maps/utils/colors.dart';

class TabBarSection extends StatelessWidget {
  final int selectedTabIndex;
  final Function(int) onTabSelected;
  final List<IconData> _tabIcons = [Icons.home, Icons.favorite, Icons.person];
  final List<String> _tabLabels = ["Home", "Favorite", "Profile"];

  TabBarSection({
    required this.selectedTabIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(_tabIcons.length, (index) {
        final isSelected = selectedTabIndex == index;
        return GestureDetector(
          onTap: () => onTabSelected(index),
          child: Column(
            children: [
              Icon(
                _tabIcons[index],
                size: 28,
                color: isSelected ? XColors.darkBackgroundColor : XColors.white,
              ),
              const SizedBox(height: 4),
              Text(
                _tabLabels[index],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? XColors.darkBackgroundColor : XColors.white,
                ),
              ),
              if (isSelected)
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  height: 3,
                  width: 30,
                  color: XColors.lemonColor,
                )
            ],
          ),
        );
      }),
    );
  }
}
