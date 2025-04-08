import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_maps/presentation/widgets/tab_bar_section.dart';
import 'package:flutter_maps/utils/colors.dart';
import 'package:flutter_maps/utils/strings.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int selectedTabIndex;
  final Function(int) onTabSelected;

  const CustomAppBar({
    super.key,
    required this.selectedTabIndex,
    required this.onTabSelected,
  });

  @override
  Size get preferredSize => const Size.fromHeight(130);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.menu, color: XColors.white),
      ),
      backgroundColor: XColors.extraLightColor,
      title: const Text("GreenMaps"),
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: XStrings.poppinsFont,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: XColors.darkBackgroundColor,
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.search, color: XColors.white)),
        IconButton(onPressed: () {}, icon: Icon(Icons.notifications, color: XColors.white)),
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: TabBarSection(
          selectedTabIndex: selectedTabIndex,
          onTabSelected: onTabSelected,
        ),
      ),
    );
  }
}
