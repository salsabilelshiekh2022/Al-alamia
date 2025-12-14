import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/widgets/card_with_purple_shadow.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../generated/app_assets.dart';
import '../../cubit/send_money_cubit.dart';

class SenderDataCard extends StatefulWidget {
  const SenderDataCard({super.key});

  @override
  State<SenderDataCard> createState() => _SenderDataCardState();
}

class _SenderDataCardState extends State<SenderDataCard> {
  late TextEditingController phoneController;
  late TextEditingController nameController;
  late TextEditingController addressController;
  @override
  Widget build(BuildContext context) {
    var state = context.read<SendMoneyCubit>().state;
    return CardWithPurpleShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.senderInfo,
            style: context.textStyles.font16SemiBoldSecondaryColor,
          ),
          12.verticalSizedBox,
          CustomTextFieldWithLabel(
            initialValue:  state.formData?.senderPhone ?? '',
            label: context.phone,
            hintText: context.phoneHint,
            prefixWidget: AppAssets.svgsPhone,
            keyboardType: TextInputType.phone,
            isRequired: true,
            validator: (val) => Validator.validatePhone(val, context),
          ),
          16.verticalSizedBox,
          CustomTextFieldWithLabel(
            label: context.name,
            hintText: context.enterNameHint,
            prefixWidget: AppAssets.svgsUser,
            isRequired: true,
            validator: (val) => Validator.validateName(val, context),
          ),
          16.verticalSizedBox,
          CustomTextFieldWithLabel(
            label: context.address,
            hintText: context.addressHint,
            prefixWidget: AppAssets.svgsMapIcon,
          ),
        ],
      ),
    );
  }
}
