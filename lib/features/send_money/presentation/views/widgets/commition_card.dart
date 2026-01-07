import 'package:alalamia/core/general/cubit/general_cubit.dart';
import 'package:alalamia/core/general/data/models/fee_details_request_params.dart';
import 'package:alalamia/features/send_money/data/models/send_money_form_data.dart';
import 'package:alalamia/features/send_money/presentation/cubit/send_money_cubit.dart';
import 'package:alalamia/features/send_money/presentation/cubit/send_money_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:alalamia/core/enums/delivery_type_enum.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/components/widgets/card_with_purple_shadow.dart';
import '../../../../../core/components/widgets/commission_type_selection_bottom_sheet.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/enums/commission_type_enum.dart';
import '../../../../../core/utils/global_ui_utils.dart';
import '../../../../../generated/app_assets.dart';

class CommitionCard extends StatefulWidget {
  const CommitionCard({super.key});

  @override
  State<CommitionCard> createState() => _CommitionCardState();
}

class _CommitionCardState extends State<CommitionCard> {
  late TextEditingController commissionTypeController;
  late TextEditingController commissionController;
  CommissionTypeEnum? selectedCommissionType;

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

  void _onCommissionTypeSelected(CommissionTypeEnum type) {
    setState(() {
      commissionTypeController.text = type.getCommissionType(context);
      selectedCommissionType = type;
    });
    _updateFormData();
    _getFeeDetails();
  }

  void _showCommissionTypeBottomSheet() {
    GlobalUiUtils.showBottomSheet(
      context,
      child: CommissionTypeSelectionBottomSheet(
        selectedType: selectedCommissionType,
        onTypeSelected: (type) {
          _onCommissionTypeSelected(type);
          Navigator.pop(context);
        },
      ),
    );
  }

  void _updateFormData() {
    try {
      final cubit = context.read<SendMoneyCubit>();
      final currentFormData = cubit.state.formData ?? SendMoneyFormData.empty();

      // Get commission type
      CommissionTypeEnum? commissionType = selectedCommissionType;

      cubit.updateFormData(
        currentFormData.copyWith(
          commissionType: commissionType,
        ),
      );
    } catch (e, stackTrace) {
      debugPrint('ERROR in _updateFormData: $e');
      debugPrint('Stack trace: $stackTrace');
    }
  }

  void _getFeeDetails() {
    final sendMoneyCubit = context.read<SendMoneyCubit>();
    final formData = sendMoneyCubit.state.formData;

    if (formData == null ||
        formData.amount.isEmpty ||
        formData.fromCurrency == null) {
      return;
    }

    int? toCurrencyId = formData.toCurrency?.id;

    if (sendMoneyCubit.state.deliveryType == DeliveryTypeEnum.inside) {
      toCurrencyId = formData.fromCurrency?.id;
    }

    if (toCurrencyId == null) return;

    CommissionTypeEnum commissionType = selectedCommissionType ?? CommissionTypeEnum.none;

    context.read<GeneralCubit>().getFeeDetails(
          params: FeeDetailsRequestParams(
            fromCurrencyId: formData.fromCurrency!.id!,
            toCurrencyId: toCurrencyId,
            amount: formData.amount,
            commissionType: commissionType,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendMoneyCubit, SendMoneyState>(
      builder: (context, state) {
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
                      onTap: () {
                        _showCommissionTypeBottomSheet();
                      },
                      controller: commissionTypeController,
                      label: context.commissionType,
                      hintText: context.commissionType,
                      prefixWidget: AppAssets.svgsCoinsIcon,
                      isRequired: true,
                      isReadOnly: true,
                      suffixWidget: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          _showCommissionTypeBottomSheet();
                        },
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: context.colors.grayColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ).onlyPadding(topPadding: 8, bottomPadding: 20);
      },
    );
  }
}
