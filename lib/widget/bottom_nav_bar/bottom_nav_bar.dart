import 'package:flutter/material.dart';
import 'package:tea_checker/utils/color_utils.dart';
import 'tab_item.dart';

class BottomNavBar extends StatelessWidget {
  final List<TabItem> items;
  final int currentIndex;
  // final bool fromMarchent;
  final Function(int) function;

  const BottomNavBar({
    super.key,
    required this.items,
    required this.currentIndex,
    // this.fromMarchent = false,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> navBarItems = List.generate(items.length, (int index) {
      return _buildTabItem(
        context,
        item: items[index],
        index: index,
        currentIndex: currentIndex,
        onPressed: () {
          function(index);
        },
      );
    });

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
      child: BottomAppBar(
        color: ColorUtils.primary,
        height: 65,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: navBarItems,
        ),
      ),
    );
  }

  Widget _buildTabItem(
    BuildContext context, {
    required TabItem item,
    required int index,
    required int currentIndex,
    required Function() onPressed,
  }) {
    final bool isSelected = currentIndex == index;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            item.imageUrl != null
                ? Image.asset(
                  item.imageUrl!,
                  color: isSelected ? Colors.white : Colors.white70,
                  height: isSelected ? 30 : 28,
                )
                : Icon(
                  item.icon,
                  color: isSelected ? Colors.green : Colors.white70,
                  size: isSelected ? 30 : 28,
                ),
            const SizedBox(height: 2),
            FittedBox(
              child: Text(
                item.title,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Colors.green : Colors.white70,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
