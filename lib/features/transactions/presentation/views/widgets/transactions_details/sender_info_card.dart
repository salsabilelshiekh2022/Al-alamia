import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/transactions/presentation/cubit/transactions_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../../generated/app_assets.dart';
import '../../../cubit/transactions_state.dart';
import 'card_with_shadow.dart';
import 'info_widget.dart';

class SenderInfoCard extends StatelessWidget {
  const SenderInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWithShadow(
      child: BlocBuilder<TransactionsCubit, TransactionsState>(
        builder: (context, state) {
          return Column(
            children: [
              Row(
                children: [
                  CustomSvgBuilder(
                    path: AppAssets.svgsSendIcon,
                    width: 24,
                    height: 24,
                    fit: BoxFit.scaleDown,
                  ),
                  10.horizontalSpace,
                  Text(
                    context.infoContact,
                    style: context.textStyles.font16MediumSecondaryColor,
                  ),
                ],
              ),

              14.verticalSizedBox,
              InfoWidget(
                title: context.fullName,
                value: state.transactionDetails?.sender.name ?? '--',
                icon: AppAssets.svgsUser,
              ),
              24.verticalSizedBox,
              InfoWidget(
                title: context.phone,
                value: state.transactionDetails?.sender.phone ?? '--',
                icon: AppAssets.svgsPhone,
              ),
              24.verticalSizedBox,
              InfoWidget(
                title: context.address,
                value: state.transactionDetails?.sender.address ?? '--',
                icon: AppAssets.svgsMapIcon,
              ),
            ],
          );
        },
      ),
    );
  }
}
