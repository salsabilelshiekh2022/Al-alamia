import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/features/transactions/data/models/transaction_model.dart';
import 'package:alalamia/features/transactions/presentation/cubit/transactions_cubit.dart';
import 'package:alalamia/features/transactions/presentation/views/widgets/transaction_From_to.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/components/widgets/card_with_gray_border.dart';
import '../../../../../core/routes/routes.dart';
import 'transaction_status_box.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key, required this.transactionModel});
  final TransactionModel transactionModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed(
        Routes.transactionDetailsView,
        arguments: {
          'id': transactionModel.id,
          'transactionsCubit': context.read<TransactionsCubit>(),
        },
      ),
      child: CardWithGrayBorder(
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transactionModel.transactionUuid ?? '',
                      style: context.textStyles.font16RegularSecondaryColor,
                    ),
                    6.verticalSpace,
                    Text(
                      DateFormat(
                        'dd-MM-yyyy, hh:mm a',
                        EasyLocalization.of(context)!.locale.languageCode,
                      ).format(DateTime.parse(transactionModel.dateTime ?? '')),
                      style: context.textStyles.font14MediumGrayColor,
                    ),
                  ],
                ),
                Spacer(),
                TransactionStatusBox(status: transactionModel.status!),
              ],
            ),
            Divider(
              color: context.colors.strokeColor,
              thickness: 1,
            ).verticalPadding(10),
            TransactionFromTo(transactionModel: transactionModel),
            16.verticalSizedBox,
             Text(
              "${transactionModel.amountReceived!.toString()} ${transactionModel.currency?.code ?? ""}",
              style: context.textStyles.font20SemiBoldPrimaryColor,
            ),
            // Row(
            //   children: [
            //     Spacer(),
            //     Text(
            //       "${transactionModel.amountReceived!.toString()} ${transactionModel.currency?.code ?? ""}",
            //       style: context.textStyles.font20SemiBoldPrimaryColor,
            //     ),
            //     Spacer(),
            //     Text(
            //       "المزيد",
            //       style: context.textStyles.font14RegularPrimaryColor.copyWith(
            //         decoration: TextDecoration.underline,
            //         fontSize: 12
            //       ),
            //     ),

            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
