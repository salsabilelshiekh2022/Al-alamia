import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/features/transactions/presentation/cubit/transactions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/helper/app_extention.dart';
import '../../../cubit/transactions_state.dart';

class NotesInfoCard extends StatelessWidget {
  const NotesInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: 18.allPadding,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: BlocBuilder<TransactionsCubit, TransactionsState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ملاحظات",
                style: context.textStyles.font16RegularSecondaryColor,
              ),
              12.verticalSizedBox,
              Text(
                state.transactionDetails?.notes ?? '--',
                style: context.textStyles.font14SemiBoldPrimaryColor.copyWith(
                  color: context.colors.grayColor,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
