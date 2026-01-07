import 'package:alalamia/features/send_money/presentation/cubit/send_money_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/widgets/payment_method_selection_bottom_sheet.dart';
import '../../../../../core/components/widgets/custom_text_field_with_label.dart';
import '../../../../../core/enums/delivery_type_enum.dart';
import '../../../../../core/general/cubit/general_cubit.dart';
import '../../../../../core/general/cubit/general_state.dart';
import '../../../../../core/general/data/models/payment_method_model.dart';
import '../../../../../core/helper/app_extention.dart';
import '../../../../../core/helper/number_extentions.dart';
import '../../../../../core/helper/translation_extensions.dart';
import '../../../../../core/helper/widget_extentions.dart';
import '../../../../../core/utils/global_ui_utils.dart';
import '../../../../../generated/app_assets.dart';
import '../../../data/models/send_money_form_data.dart';

class DeliveryTypeWidget extends StatefulWidget {
  const DeliveryTypeWidget({super.key});

  @override
  State<DeliveryTypeWidget> createState() => _DeliveryTypeWidgetState();
}

class _DeliveryTypeWidgetState extends State<DeliveryTypeWidget> {
  int selectedIndex = 0;
  int? selectedPaymentMethod;
  late TextEditingController deliveryMethodController;
  @override
  void initState() {
    deliveryMethodController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
   deliveryMethodController.dispose();
    super.dispose();
  }

  void _onDeliveryMethodSelected(PaymentMethodModel method) {
    setState(() {
      deliveryMethodController.text = method.name;
      selectedPaymentMethod = method.id;
    });
    
    // Update form data with payment method ID
    final sendMoneyCubit = context.read<SendMoneyCubit>();
    final currentFormData = sendMoneyCubit.state.formData ?? SendMoneyFormData.empty();
    sendMoneyCubit.updateFormData(
      currentFormData.copyWith(paymentMethodId: selectedPaymentMethod),
    );
  }

  void _showPaymentMethodBottomSheet(List<PaymentMethodModel?> methods) {
    GlobalUiUtils.showBottomSheet(
      context,
      child: PaymentMethodSelectionBottomSheet(
        paymentMethods: methods,
        selectedPaymentMethodId: selectedPaymentMethod,
        onPaymentMethodSelected: (method) {
          _onDeliveryMethodSelected(method);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              context.deliveryType,
              style: context.textStyles.font16MediumSecondaryColor,
            ),
            Text(
              '  *',
              style: context.textStyles.font16MediumSecondaryColor.copyWith(
                color: Colors.red,
              ),
            ),
          ],
        ),
        16.verticalSizedBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(DeliveryTypeEnum.values.length, (index) {
            return InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                  context.read<SendMoneyCubit>().changeDeliveryType(DeliveryTypeEnum.values[index]);
                });
              },
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selectedIndex == index
                            ? context.colors.primaryColor
                            : context.colors.grayColor,
                      ),
                    ),
                    child: selectedIndex == index
                        ? Container(
                            width: 14,
                            height: 14,
                            decoration: BoxDecoration(
                              color: context.colors.primaryColor,
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ).center()
                        : null,
                  ),
                  10.horizontalSizedBox,
                  Text(
                    DeliveryTypeEnum.values[index].translate(context),
                    style: context.textStyles.font15MediumSecondaryColor,
                  ),
                ],
              ),
            ).onlyPadding(leftPadding: 12, bottomPadding: 16);
          }),
        ),
        if (selectedIndex == 1)
          BlocBuilder<GeneralCubit, GeneralState>(
            builder: (context, state) {
              return CustomTextFieldWithLabel(
                onTap: () {
                  _showPaymentMethodBottomSheet(state.paymentMethods ?? []);
                },
                controller: deliveryMethodController,
                label: context.deliveryMethod,
                hintText: context.chooseDeliveryMethod,
                isRequired: true,
                isReadOnly: true,
                prefixWidget: AppAssets.svgsDeliveryMethod,
                suffixWidget: InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    _showPaymentMethodBottomSheet(state.paymentMethods ?? []);
                  },
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: context.colors.grayColor,
                  ),
                ),
              );
            },
          ),
      ],
    );
  }
}
