import 'package:base_ui/base_ui.dart';
import 'package:flutter/material.dart';

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
      height: 52,
      child: TabBar(
        controller: tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: buildTabItems(context),
        isScrollable: isScrollable ?? false,
        tabAlignment: tabAlignment,
        labelStyle: context.textStyles.body2Medium,
        labelColor: context.colors.primary,
        unselectedLabelStyle: context.textStyles.body2Medium,
        unselectedLabelColor: context.colors.textSubtitle,
        indicatorWeight: 6,
        indicatorColor: context.colors.primary,
        dividerHeight: 1,
        dividerColor: context.colors.borderDivider,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 1, color: context.colors.primary),
        ),
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
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
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
          ],
        ),
      ),
    );
  }
}
