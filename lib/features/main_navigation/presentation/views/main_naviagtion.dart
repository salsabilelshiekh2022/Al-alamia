import 'package:alalamia/core/components/widgets/custom_svg_builder.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/home/presentation/cubit/home_cubit.dart';
import 'package:alalamia/features/home/presentation/views/home_view.dart';
import 'package:alalamia/features/notifications/presentation/views/notifications_view.dart';
import 'package:alalamia/features/settings/presentation/views/settings_view.dart';
import 'package:alalamia/features/transactions/presentation/views/transactions_view.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/enums/reports_enum.dart';
import '../../../../core/enums/transactions_enum.dart';
import '../../../reports/presentation/cubit/reports_cubit.dart';
import '../../../reports/presentation/views/reports_view.dart';
import '../../../transactions/presentation/cubit/transactions_cubit.dart';

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({super.key});

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  final PageController _pageController = PageController(initialPage: 4);

  /// Controller to handle bottom nav bar and also handles initial page
  final NotchBottomBarController _controller = NotchBottomBarController(
    index: 4,
  );

  /// Total number of navigation items
  final int maxCount = 5;

  /// 👇 Your navigation pages (replace with your real views)
  final List<Widget> bottomBarPages = [
    SettingsView(),
    NotificationsView(),
    BlocProvider(create: (context) => getIt<ReportsCubit>()..getReports(type: ReportsEnum.day), child: ReportsView()),
    BlocProvider(
      create: (context) =>
          getIt<TransactionsCubit>()
            ..getTransactionList(transaction: TransactionsEnum.recieving),
      child: TransactionsView(),
    ),
    BlocProvider.value(
      value: getIt<HomeCubit>()
        ..getBranchCurrencies()
        ..getCurrencies(),
      child: HomeView(),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      // 👇 PageView holds all your main pages
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: bottomBarPages,
      ),

      bottomNavigationBar: AnimatedNotchBottomBar(
        color: Colors.white,
        showLabel: true,
        itemLabelStyle: context.textStyles.font13RegularPrimaryColor.copyWith(
          color: context.colors.grayColor,
        ),
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

        // When a tab is tapped, animate PageView to that page
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
              path: AppAssets.svgsReports,
              color: context.colors.grayColor,
            ),
            activeItem: CustomSvgBuilder(
              path: AppAssets.svgsReports,
              color: context.colors.whiteColor,
            ),
            itemLabel: context.reports,
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
    );
  }
}
