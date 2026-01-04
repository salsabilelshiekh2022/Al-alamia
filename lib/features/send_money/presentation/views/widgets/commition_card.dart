import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/card_with_purple_shadow.dart';
import '../../../../../core/components/widgets/custom_drop_down_card.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/enums/commission_type_enum.dart';
import '../../../../../generated/app_assets.dart';

class CommitionCard extends StatefulWidget {
  const CommitionCard({super.key});

  @override
  State<CommitionCard> createState() => _CommitionCardState();
}

class _CommitionCardState extends State<CommitionCard> {
  late TextEditingController commissionTypeController;
  late TextEditingController commissionController;
  bool openCommissionTypesDropDown = false;
  String? selectedCommissionType;

  @override
  void initState() {
    super.initState();
    commissionTypeController = TextEditingController();
    commissionController = TextEditingController();
  }

  @override
  void dispose() {
    commissionTypeController.dispose();
    commissionController.dispose();
    super.dispose();
  }

  void _onCommissionTypeSelected(String selectedItem) {
    setState(() {
      openCommissionTypesDropDown = false;
      commissionTypeController.text = selectedItem;
      selectedCommissionType = selectedItem;
    });
    // _updateFormData();
    // _getFeeDetails();
  }

  @override
  Widget build(BuildContext context) {
    return CardWithPurpleShadow(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomTextFieldWithLabel(
                  onTap: () {
                    setState(() {
                      openCommissionTypesDropDown =
                          !openCommissionTypesDropDown;
                    });
                  },
                  controller: commissionController,
                  label: context.commission,
                  hintText: "\$0.00",
                  enabled: false,
                  prefixWidget: AppAssets.svgsCoinsIcon,
                  isRequired: true,
                ),
              ),
              14.horizontalSizedBox,
              Expanded(
                child: CustomTextFieldWithLabel(
                  controller: commissionTypeController,
                  label: context.commissionType,
                  hintText: context.commissionType,
                  prefixWidget: AppAssets.svgsCoinsIcon,
                  isRequired: true,
                  isReadOnly: true,
                  suffixWidget: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      setState(() {
                        openCommissionTypesDropDown =
                            !openCommissionTypesDropDown;
                      });
                    },
                    child: Icon(
                      openCommissionTypesDropDown
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: openCommissionTypesDropDown
                          ? context.colors.primaryColor
                          : context.colors.grayColor,
                    ),
                  ),
                ),
              ),
            ],
          ),

          if (openCommissionTypesDropDown)
            CustomDropDownCard(
              dropDownItems: CommissionTypeEnum.values
                  .map((e) => e.getCommissionType(context))
                  .toList(),
              selectedValue: commissionTypeController.text,
              onItemSelected: _onCommissionTypeSelected,
            ).onlyPadding(topPadding: 6),
        ],
      ),
    ).onlyPadding(topPadding: 8, bottomPadding: 20);
  }
}
