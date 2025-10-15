import 'package:alalamia/core/components/widgets/custom_svg_builder.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/settings/presentation/views/settings_view.dart';
import 'package:alalamia/features/transactions/presentation/views/transactions_view.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({super.key});

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  final PageController _pageController = PageController(initialPage: 3);

  /// Controller to handle bottom nav bar and also handles initial page
  final NotchBottomBarController _controller = NotchBottomBarController(
    index: 3,
  );

  /// Total number of navigation items
  final int maxCount = 4;

  /// 👇 Your navigation pages (replace with your real views)
  final List<Widget> bottomBarPages = const [
    SettingsView(),
    Center(child: Text("Notifications View")),
    TransactionsView(),
    Center(child: Text("Home View")),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        extendBody: true,

        // 👇 PageView holds all your main pages
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: bottomBarPages,
        ),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedNotchBottomBar(
            color: Colors.white,
            showLabel: true,
            itemLabelStyle: context.textStyles.font13RegularPrimaryColor
                .copyWith(color: context.colors.grayColor),
            notchGradient: context.colors.navigationGradientColor,
            bottomBarHeight: 81.0,
            textOverflow: TextOverflow.visible,
            maxLine: 1,
            topMargin: 10,
            circleMargin: 10,
            shadowElevation: 10,
            showShadow: true,
            elevation: 5,
            kBottomRadius: 16.0,
            kIconSize: 24,
            removeMargins: true,
            notchBottomBarController: _controller,

            /// 👇 When a tab is tapped, animate PageView to that page
            onTap: (index) {
              _controller.index = index;
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },

            bottomBarItems: [
              BottomBarItem(
                inActiveItem: CustomSvgBuilder(
                  path: AppAssets.svgsSettings,
                  color: context.colors.grayColor,
                ),
                activeItem: CustomSvgBuilder(
                  path: AppAssets.svgsSettings,
                  color: context.colors.whiteColor,
                ),
                itemLabel: context.settings,
              ),
              BottomBarItem(
                inActiveItem: CustomSvgBuilder(
                  path: AppAssets.svgsBell,
                  color: context.colors.grayColor,
                ),
                activeItem: CustomSvgBuilder(
                  path: AppAssets.svgsBell,
                  color: context.colors.whiteColor,
                ),
                itemLabel: context.notifications,
              ),
              BottomBarItem(
                inActiveItem: CustomSvgBuilder(
                  path: AppAssets.svgsWallet,
                  color: context.colors.grayColor,
                ),
                activeItem: CustomSvgBuilder(
                  path: AppAssets.svgsWallet,
                  color: context.colors.whiteColor,
                ),
                itemLabel: context.transactions,
              ),
              BottomBarItem(
                inActiveItem: CustomSvgBuilder(
                  path: AppAssets.svgsHome,
                  color: context.colors.grayColor,
                ),
                activeItem: CustomSvgBuilder(
                  path: AppAssets.svgsHome,
                  color: context.colors.whiteColor,
                ),
                itemLabel: context.main,
              ),
            ],
          ),
        ),
      
    );
  }
}
