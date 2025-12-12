import 'package:alalamia/core/components/widgets/card_with_purple_shadow.dart';
import 'package:alalamia/core/components/widgets/custom_page.dart';
import 'package:alalamia/core/components/widgets/custom_text_field_with_label.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/validator.dart';
import '../../../../generated/app_assets.dart';
import '../../../home/presentation/views/widgets/calculator/currency_calculator_section.dart';

class TransferCurrencyView extends StatelessWidget {
  const TransferCurrencyView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: context.currencyTransfer,
      isBack: true,
      hasActions: false,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClientInfoSection(),
          20.verticalSizedBox,
          CurrencyCalculatorSection(),
          20.verticalSizedBox,
          AmountSection(),
          20.verticalSizedBox,
          NotesSection(),
        ],
      ),
    );
  }
}

class ClientInfoSection extends StatelessWidget {
  const ClientInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWithPurpleShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.clientInfo,
            style: context.textStyles.font18SemiBoldSecondaryColor,
          ),
          12.verticalSizedBox,
          CustomTextFieldWithLabel(
            controller: TextEditingController(),
            label: context.phone,
            hintText: context.phoneHint,
            isRequired: true,
            prefixWidget: AppAssets.svgsPhone,
            keyboardType: TextInputType.phone,
            validator: (val) => Validator.validatePhone(val, context),
          ),
          16.verticalSizedBox,
          CustomTextFieldWithLabel(
            controller: TextEditingController(),
            label: context.clientName,
            hintText: context.clientNameHint,
            isRequired: true,
            prefixWidget: AppAssets.svgsUser,
            keyboardType: TextInputType.phone,
            validator: (val) => Validator.validateName(val, context),
          ),
        ],
      ),
    );
  }
}

class AmountSection extends StatelessWidget {
  const AmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWithPurpleShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.amount,
            style: context.textStyles.font17SemiBoldSecondaryColor,
          ),
          12.verticalSizedBox,
          CustomTextFieldWithLabel(
            controller: TextEditingController(),
            label: context.amountByChar,
            hintText: context.amountHint,
            isRequired: true,
            prefixWidget: AppAssets.svgsDollarIcon,
            keyboardType: TextInputType.text,
            validator: (val) => Validator.validateAnotherField(val, context),
          ),
        ],
      ),
    );
  }
}

class NotesSection extends StatelessWidget {
  const NotesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWithPurpleShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextFieldWithLabel(
            controller: TextEditingController(),
            label: context.addNotes,
            hintText: context.notesHint,
            maxLines: 3,
            keyboardType: TextInputType.text,
          ),
        ],
      ),
    );
  }
}
