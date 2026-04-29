import 'package:alalamia/core/general/cubit/general_state.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/widgets/card_with_purple_shadow.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/enums/request_status.dart';
import '../../../../../core/general/cubit/general_cubit.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../../generated/app_assets.dart';
import '../../../data/models/send_money_form_data.dart';
import '../../cubit/send_money_cubit.dart';

class SenderDataCard extends StatefulWidget {
  const SenderDataCard({super.key});

  @override
  State<SenderDataCard> createState() => _SenderDataCardState();
}

class _SenderDataCardState extends State<SenderDataCard> {
  static const _lookupSource = 'sender_data_card';

  late TextEditingController phoneController;
  late TextEditingController whatsAppController;
  late TextEditingController nameController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SendMoneyCubit>();
    phoneController = TextEditingController(
      text: cubit.state.formData?.senderPhone ?? '',
    );
    whatsAppController = TextEditingController(
      text: cubit.state.formData?.senderWhatsApp ?? '',
    );
    nameController = TextEditingController(
      text: cubit.state.formData?.senderName ?? '',
    );
    addressController = TextEditingController(
      text: cubit.state.formData?.senderAddress ?? '',
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    whatsAppController.dispose();
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void _updateFormData() {
    final cubit = context.read<SendMoneyCubit>();
    final currentFormData = cubit.state.formData ?? SendMoneyFormData.empty();
    cubit.updateFormData(
      currentFormData.copyWith(
        senderPhone: phoneController.text,
        senderWhatsApp: whatsAppController.text,
        senderName: nameController.text,
        senderAddress: addressController.text.isEmpty
            ? null
            : addressController.text,
      ),
    );
  }

  @override

  Widget build(BuildContext context) {
    return BlocListener<GeneralCubit, GeneralState>(
      listener: (context, state) {
        if (state.getUserByPhoneStatus.isSuccess &&
            state.userByPhoneRequestSource == _lookupSource) {
          nameController.text = state.userByPhone?.name ?? '';
          addressController.text = state.userByPhone?.address ?? '';
          _updateFormData();
        }else if (state.getUserByPhoneStatus.isError &&
            state.userByPhoneRequestSource == _lookupSource) {
          nameController.text = '';
          addressController.text = '';
          _updateFormData();
        }
      },
      child: CardWithPurpleShadow(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.senderInfo,
              style: context.textStyles.font16SemiBoldSecondaryColor,
            ),
            12.verticalSizedBox,
            CustomTextFieldWithLabel(
              controller: phoneController,
              label: context.phone,
              hintText: context.phoneHint,
              prefixWidget: AppAssets.svgsPhone,
              keyboardType: TextInputType.phone,
              isRequired: true,
              validator: (val) => Validator.validatePhone(val, context),
              onChanged: (val) {
                context.read<GeneralCubit>().getUserByPhone(
                  phone: val.trim(),
                  requestSource: _lookupSource,
                );
                _updateFormData();
              },
            ),
            16.verticalSizedBox,
            CustomTextFieldWithLabel(
              label: "رقم الواتساب",
              hintText: "أدخل رقم الواتساب",
              controller: whatsAppController,
              prefixWidget: AppAssets.svgsPhone,
              keyboardType: TextInputType.phone,
              isRequired: false,
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return null;
                }
                return Validator.validatePhone(val, context);
              },
              onChanged: (_) => _updateFormData(),
            ),
            16.verticalSizedBox,
            CustomTextFieldWithLabel(
              controller: nameController,
              label: context.name,
              hintText: context.enterNameHint,
              prefixWidget: AppAssets.svgsUser,
              isRequired: true,
              validator: (val) => Validator.validateName(val, context),
              onChanged: (_) => _updateFormData(),
            ),
            16.verticalSizedBox,
            CustomTextFieldWithLabel(
              controller: addressController,
              label: context.address,
              hintText: context.addressHint,
              prefixWidget: AppAssets.svgsMapIcon,
              onChanged: (_) => _updateFormData(),
            ),
          ],
        ),
      ),
    );
  }
}
