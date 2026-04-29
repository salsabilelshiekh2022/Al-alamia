import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/widgets/card_with_purple_shadow.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/enums/request_status.dart';
import '../../../../../core/general/cubit/general_cubit.dart';
import '../../../../../core/general/cubit/general_state.dart';
import '../../../../../generated/app_assets.dart';
import '../../../data/models/send_money_form_data.dart';
import '../../cubit/send_money_cubit.dart';

class BeneficiaryDataCard extends StatefulWidget {
  const BeneficiaryDataCard({super.key});

  @override
  State<BeneficiaryDataCard> createState() => _BeneficiaryDataCardState();
}

class _BeneficiaryDataCardState extends State<BeneficiaryDataCard> {
  static const _lookupSource = 'beneficiary_data_card';

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController whatsAppController;
  late TextEditingController additionalController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<SendMoneyCubit>();
    nameController = TextEditingController(
      text: cubit.state.formData?.receiverName ?? '',
    );
    phoneController = TextEditingController(
      text: cubit.state.formData?.receiverPhone ?? '',
    );
    whatsAppController = TextEditingController(
      text: cubit.state.formData?.receiverWhatsApp ?? '',
    );
    additionalController = TextEditingController(
      text: cubit.state.formData?.receiverPhone2 ?? '',
    );
    addressController = TextEditingController(
      text: cubit.state.formData?.receiverAddress ?? '',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    whatsAppController.dispose();
    additionalController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void _updateFormData() {
    final cubit = context.read<SendMoneyCubit>();
    final currentFormData = cubit.state.formData ?? SendMoneyFormData.empty();
    cubit.updateFormData(
      currentFormData.copyWith(
        receiverPhone: phoneController.text,
        receiverWhatsApp: whatsAppController.text,
        receiverName: nameController.text,
        receiverAddress: addressController.text,
        receiverPhone2: additionalController.text.isEmpty
            ? null
            : additionalController.text,
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
          additionalController.text = state.userByPhone?.phone2 ?? '';
          addressController.text = state.userByPhone?.address ?? '';
          _updateFormData();
        }else if (state.getUserByPhoneStatus.isError &&
            state.userByPhoneRequestSource == _lookupSource) {
          nameController.text = '';
          additionalController.text = '';
          addressController.text = '';
          _updateFormData();
        } 
      },
      child: CardWithPurpleShadow(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.beneficiary,
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
              validator: (value) => Validator.validatePhone(value, context),
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
              controller: nameController,
              label: context.name,
              hintText: context.fullNameHint,
              prefixWidget: AppAssets.svgsUser,
              isRequired: true,
              validator: (value) => Validator.validateName(value, context),
              onChanged: (_) => _updateFormData(),
            ),
            16.verticalSizedBox,
            CustomTextFieldWithLabel(
              controller: whatsAppController,
              label: "رقم الواتساب",
              hintText: "ادخل رقم الواتساب",
              prefixWidget: AppAssets.svgsPhone,
              keyboardType: TextInputType.phone,
              isRequired: false,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return null;
                }
                return Validator.validatePhone(value, context);
              },
              onChanged: (_) => _updateFormData(),
            ),
            16.verticalSizedBox,
            CustomTextFieldWithLabel(
              controller: additionalController,
              label: context.additionalNumber,
              hintText: context.additionalNumberHint,
              prefixWidget: AppAssets.svgsAdditionalPhoneIcon,
              keyboardType: TextInputType.phone,
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
