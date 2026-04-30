import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/features/home/data/models/wallet_model.dart';
import 'package:alalamia/features/home/presentation/cubit/home_cubit.dart';
import 'package:alalamia/features/home/presentation/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'wallet_grid_page.dart';
import 'wallet_page_indicator.dart';

class WalletsList extends StatefulWidget {
  const WalletsList({super.key});

  @override
  State<WalletsList> createState() => _WalletsListState();
}

class _WalletsListState extends State<WalletsList> {
  final PageController _pageController = PageController();
  static const int _itemsPerPage = 6;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final isLoading =
            state.homeStatus.isLoading && state.walletsList.isEmpty;
        final isEmpty = state.walletsList.isEmpty && !isLoading;
        final items = _getItemsList(state.walletsList, isLoading);
        final pages = _divideIntoPages(items);
        final pageCount = pages.isEmpty ? 1 : pages.length;

        if (isEmpty) {
          return _buildEmptyState();
        }

        return Column(
          children: [
            _buildPageView(pages, pageCount, isLoading),
            if (pageCount > 1) _buildPageIndicator(pageCount),
          ],
        );
      },
    );
  }

  List<WalletModel> _getItemsList(
    List<WalletModel> currencies,
    bool isLoading,
  ) {
    return isLoading
        ? List.generate(_itemsPerPage, (_) => dummyCurrenyModel)
        : currencies;
  }

  List<List<WalletModel>> _divideIntoPages(List<WalletModel> items) {
    final pages = <List<WalletModel>>[];
    for (int i = 0; i < items.length; i += _itemsPerPage) {
      final end = (i + _itemsPerPage < items.length)
          ? i + _itemsPerPage
          : items.length;
      pages.add(items.sublist(i, end));
    }
    return pages;
  }

  Widget _buildPageView(
    List<List<WalletModel>> pages,
    int pageCount,
    bool isLoading,
  ) {
    return SizedBox(
      height: 212.h,
      child: PageView.builder(
        controller: _pageController,
        itemCount: pageCount,
        itemBuilder: (context, pageIndex) {
          final pageItems = pages.isEmpty
              ? List.generate(_itemsPerPage, (_) => dummyCurrenyModel)
              : pages[pageIndex];

          return WalletGridPage(items: pageItems, isLoading: isLoading);
        },
      ),
    );
  }

  Widget _buildPageIndicator(int pageCount) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: WalletPageIndicator(controller: _pageController, count: pageCount),
    );
  }

  Widget _buildEmptyState() {
    return SizedBox(
      height: 212.h,
      child: Center(
        child: Text(
          'لا يوجد خزن متاحة',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
