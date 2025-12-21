import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/utils/validator.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/card_with_purple_shadow.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../generated/app_assets.dart';

class BeneficiaryDataCard extends StatefulWidget {
  const BeneficiaryDataCard({super.key});

  @override
  State<BeneficiaryDataCard> createState() => _BeneficiaryDataCardState();
}

class _BeneficiaryDataCardState extends State<BeneficiaryDataCard> {
    late TextEditingController nameController ;
  late TextEditingController phoneController;
  late TextEditingController additionalController;
  late TextEditingController addressController ;
  @override
  void initState() {
    nameController = TextEditingController();
    phoneController = TextEditingController();
    additionalController = TextEditingController();
    addressController = TextEditingController();
    super.initState();
    
  }
  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    additionalController.dispose();
    addressController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return CardWithPurpleShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.beneficiary,
            style: context.textStyles.font16SemiBoldSecondaryColor,
          ),
          12.verticalSizedBox,

          CustomTextFieldWithLabel(
            controller: nameController,
            label: context.name,
            hintText: context.fullNameHint,
            prefixWidget: AppAssets.svgsUser,
            isRequired: true,
            validator: (value)=>
              Validator.validateName(value, context)
            
          ),
          16.verticalSizedBox,
          CustomTextFieldWithLabel(
            controller: phoneController,
            label: context.phone,
            hintText: context.phoneHint,
            prefixWidget: AppAssets.svgsPhone,
            keyboardType: TextInputType.phone,
            isRequired: true,
             validator: (value)=>
              Validator.validatePhone(value, context)
          ),
          16.verticalSizedBox,
          CustomTextFieldWithLabel(
            controller: additionalController,
            label: context.additionalNumber,
            hintText: context.additionalNumberHint,
            prefixWidget: AppAssets.svgsAdditionalPhoneIcon,
            keyboardType: TextInputType.phone,
          ),
          16.verticalSizedBox,
          CustomTextFieldWithLabel(
            controller: addressController,
            label: context.address,
            hintText: context.addressHint,
            prefixWidget: AppAssets.svgsMapIcon,
            isRequired: false,
          ),
        ],
      ),
    );
  }
}
