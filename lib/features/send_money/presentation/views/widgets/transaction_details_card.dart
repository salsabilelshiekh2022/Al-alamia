import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:alalamia/features/home/presentation/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/widgets/card_with_purple_shadow.dart';
import '../../../../../core/components/widgets/custom_drop_down_card.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../generated/app_assets.dart';
import '../../../../home/presentation/cubit/home_cubit.dart';

class TransactionDetailsCard extends StatefulWidget {
  const TransactionDetailsCard({super.key});

  @override
  State<TransactionDetailsCard> createState() => _TransactionDetailsCardState();
}

class _TransactionDetailsCardState extends State<TransactionDetailsCard> {
  late TextEditingController currencyController;
  bool openCurrencyDropDown = false;
  int? selectedCurrencyId;
  @override
  void initState() {
    currencyController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    currencyController.dispose();
    super.dispose();
  }

  void _onItemSelected(String selectedItem) {
    final homeCubit = context.read<HomeCubit>();
    final selectedCurrency = homeCubit.state.currenciesList.firstWhere(
      (currency) => currency.name == selectedItem,
    );
    setState(() {
      openCurrencyDropDown = false;
      currencyController.text = selectedItem;
      selectedCurrencyId = selectedCurrency.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CardWithPurpleShadow(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.transactionDetails,
            style: context.textStyles.font16SemiBoldSecondaryColor,
          ),
          12.verticalSizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomTextFieldWithLabel(
                  controller: currencyController,
                  label: context.currency,
                  hintText: context.currenyHint,
                  prefixWidget: AppAssets.svgsDollarIcon,
                  isRequired: true,
                  isReadOnly: true,
                  suffixWidget: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        openCurrencyDropDown = !openCurrencyDropDown;
                      });
                    },
                    child: Icon(
                      openCurrencyDropDown
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: openCurrencyDropDown
                          ? context.colors.primaryColor
                          : context.colors.grayColor,
                    ),
                  ),
                ),
              ),
              // openCurrencyDropDown
              //     ? BlocBuilder<HomeCubit, HomeState>(
              //         builder: (context, state) {
              //           return CustomDropDownCard(
              //             dropDownItems: state.currenciesList
              //                 .map((e) => e.name)
              //                 .whereType<String>()
              //                 .toList(),
              //             selectedValue: currencyController.text,
              //             onItemSelected: _onItemSelected,
              //           );
              //         },
              //       ).onlyPadding(topPadding: 6)
              //     : SizedBox(),
              14.horizontalSizedBox,
              Expanded(
                child: CustomTextFieldWithLabel(
                  label: context.amount,
                  hintText: context.amountHint,
                  prefixWidget: AppAssets.svgsDollarIcon,
                  isRequired: true,
                ),
              ),
            ],
          ),
          16.verticalSizedBox,
          CustomTextFieldWithLabel(
            label: context.amountByChar,
            hintText: context.amountHint,
            prefixWidget: AppAssets.svgsDollarIcon,
            isRequired: true,
            keyboardType: TextInputType.text,
          ),
          16.verticalSizedBox,
          CustomTextFieldWithLabel(
            label: context.resource,
            hintText: context.recourseHint,
            prefixWidget: AppAssets.svgsBank,
            isRequired: true,
          ),
          16.verticalSizedBox,
          CustomTextFieldWithLabel(
            label: context.destination,
            hintText: context.distinctionHint,
            prefixWidget: AppAssets.svgsBank,
            isRequired: true,
          ),
          16.verticalSizedBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomTextFieldWithLabel(
                  label: context.commission,
                  initialValue: "\$20",
                  hintText: "\$20",
                  enabled: false,
                  prefixWidget: AppAssets.svgsCoinsIcon,
                  isRequired: true,
                ),
              ),
              14.horizontalSizedBox,
              Expanded(
                child: CustomTextFieldWithLabel(
                  label: context.commissionType,
                  hintText: context.commissionType,
                  prefixWidget: AppAssets.svgsCoinsIcon,
                  isRequired: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
