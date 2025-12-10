import 'package:alalamia/core/enums/request_status.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/features/home/data/models/denominations_model.dart';
import 'package:alalamia/features/home/presentation/cubit/home_cubit.dart';
import 'package:alalamia/features/home/presentation/cubit/home_state.dart';
import 'package:alalamia/features/home/presentation/views/widgets/denomination_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DenominationsListView extends StatelessWidget {
  const DenominationsListView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        bool isLoading = state.denominationsStatus.isLoading;
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    context.cashCategory,
                    textAlign: TextAlign.start,
                    style: context.textStyles.font15MediumGrayColor,
                  ),
                ),
                Expanded(
                  child: Text(
                    context.number,
                    textAlign: TextAlign.center,
                    style: context.textStyles.font15MediumGrayColor,
                  ),
                ),
                Expanded(
                  child: Text(
                    context.total,
                    textAlign: TextAlign.end,
                    style: context.textStyles.font15MediumGrayColor,
                  ),
                ),
              ],
            ),
            Divider(color: context.colors.strokeColor).verticalPadding(14),
            Skeletonizer(
              enabled: isLoading,
              child: Column(
                children: (isLoading ? dummyDenominations : state.denominations)
                    .map(
                      (denomination) => DenominationListItem(
                        denomination: denomination,
                      ).onlyPadding(bottomPadding: 20),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
