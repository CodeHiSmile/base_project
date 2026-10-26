import 'package:base_ui/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:base_project/app/themes/app_colors.dart';

class TabBarWidget extends StatelessWidget {
  final TabController? tabController;
  final List<String> tabItems;
  final bool? isScrollable;
  final TabAlignment? tabAlignment;
  final Function(int page)? onTap;
  final List<int> tabCount;
  final int? activeIndex;

  const TabBarWidget({
    super.key,
    this.tabController,
    this.tabItems = const [],
    this.isScrollable = false,
    this.tabAlignment,
    this.onTap,
    this.tabCount = const [],
    this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 44,
      child: TabBar(
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: buildTabItems(context),
        isScrollable: isScrollable ?? false,
        tabAlignment: tabAlignment,
        labelStyle: context.textStyles.body2SemiBold,
        labelColor: context.colors.primary,
        unselectedLabelStyle: context.textStyles.body2Regular,
        unselectedLabelColor: AppColors.neutral500,
        indicatorWeight: 2,
        indicatorColor: context.colors.primary,
        dividerHeight: 1,
        dividerColor: AppColors.neutral100,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2, color: context.colors.primary),
        ),
        labelPadding: EdgeInsets.zero,
        onTap: (pageIndex) {
          onTap?.call(pageIndex);
        },
      ),
    );
  }

  List<Widget> buildTabItems(BuildContext context) {
    List<Widget> items = [];
    for (int i = 0; i < tabItems.length; i++) {
      items.add(
        buildTabItem(
          context,
          title: tabItems[i],
          index: i,
          count: tabCount.isNotEmpty ? tabCount[i] : null,
        ),
      );
    }
    return items;
  }

  Widget buildTabItem(
    BuildContext context, {
    required String title,
    required int index,
    int? count,
  }) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Center(child: Text(title, overflow: TextOverflow.ellipsis)),
          ),
          if (count != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: activeIndex == index
                    ? context.colors.primarySurface
                    : context.colors.backgroundGray,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    count.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: context.textStyles.caption1Regular.copyWith(
                      color: activeIndex == index
                          ? context.colors.primary
                          : context.colors.textLabel,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (index < tabItems.length) ...[
            VerticalDividerWidget(color: AppColors.neutral100, height: 16),
          ],
        ],
      ),
    );
  }
}
