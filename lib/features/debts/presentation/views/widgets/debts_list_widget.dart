import 'package:alalamia/core/enums/debets_enum.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/debts/data/models/debt_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/components/widgets/empty_widget.dart';
import '../../../../../core/helper/widget_extentions.dart';
import '../../../../../generated/app_assets.dart';
import '../../cubit/debt_state.dart';
import '../../cubit/debts_cubit.dart';
import 'debt_item.dart';

class DebtsListWidget extends StatefulWidget {
  const DebtsListWidget({
    super.key,
    required this.debetType,
    required this.type,
  });

  final DebetsTypeEnum debetType;
  final String type;

  @override
  State<DebtsListWidget> createState() => _DebtsListWidgetState();
}

class _DebtsListWidgetState extends State<DebtsListWidget> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    context.read<DebtsCubit>().fetchDebtsTransactions(type: widget.type);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<DebtsCubit>().loadMoreDebts(type: widget.type);
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DebtsCubit, DebtsState>(
      builder: (context, state) {
        bool isInitialLoading = state.isLoading && state.debtsList.isEmpty;
        bool isEmpty = !isInitialLoading && state.debtsList.isEmpty;

        if (state.isSuccess && isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              65.verticalSizedBox,
              EmptyWidget(
                imagePath: AppAssets.imagesEmptyTransaction,
                title: context.notFoundTransactions,
                description: context.notFoundTransactionsDescription,
              ).center(),
            ],
          );
        }

        return RefreshIndicator(
          onRefresh: () => context.read<DebtsCubit>().refreshDebtsTransactions(type: widget.type),
          child: ListView.separated(
            controller: _scrollController,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const AlwaysScrollableScrollPhysics(),
            separatorBuilder: (context, index) => 12.verticalSizedBox,
            itemBuilder: (_, index) {
              if (isInitialLoading) {
                return Skeletonizer(
                  enabled: true,
                  child: DebtItem(
                    debetsTypeEnum: widget.debetType,
                    debtModel: dummyDebtModel,
                  ),
                );
              }

              if (index < state.debtsList.length) {
                return DebtItem(
                  debetsTypeEnum: widget.debetType,
                  debtModel: state.debtsList[index],
                );
              }

              // Show loading indicator when loading more
              if (state.isLoadingMore) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              return const SizedBox.shrink();
            },
            itemCount: isInitialLoading
                ? 3
                : state.debtsList.length + (state.isLoadingMore || state.hasReachedMax ? 1 : 0),
          ),
        );
      },
    );
  }
}
