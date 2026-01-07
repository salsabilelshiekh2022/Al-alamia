import 'package:alalamia/core/general/data/models/payment_method_model.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text_field.dart';

class PaymentMethodSelectionBottomSheet extends StatefulWidget {
  const PaymentMethodSelectionBottomSheet({
    super.key,
    required this.paymentMethods,
    required this.onPaymentMethodSelected,
    this.selectedPaymentMethodId,
  });

  final List<PaymentMethodModel?> paymentMethods;
  final ValueChanged<PaymentMethodModel> onPaymentMethodSelected;
  final int? selectedPaymentMethodId;

  @override
  State<PaymentMethodSelectionBottomSheet> createState() =>
      _PaymentMethodSelectionBottomSheetState();
}

class _PaymentMethodSelectionBottomSheetState
    extends State<PaymentMethodSelectionBottomSheet> {
  late List<PaymentMethodModel?> filteredMethods;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredMethods = widget.paymentMethods;
    searchController.addListener(_filterMethods);
  }

  void _filterMethods() {
    setState(() {
      filteredMethods = widget.paymentMethods
          .where((method) =>
              method?.name
                  .toLowerCase()
                  .contains(searchController.text.toLowerCase()) ??
              false)
          .toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 16.allPadding,
      child: Column(
        children: [
          Text(
            context.deliveryMethod,
            style: context.textStyles.font18BoldSecondaryColor,
          ),
          16.verticalSizedBox,
          CustomTextField(
            controller: searchController,
            hintText: context.search,
            prefixWidget: AppAssets.svgsSearchIcon,
          ),
          16.verticalSizedBox,
          Expanded(
            child: ListView.separated(
              itemCount: filteredMethods.length,
              separatorBuilder: (context, index) => 8.verticalSizedBox,
              itemBuilder: (context, index) {
                final method = filteredMethods[index];
                if (method == null) return const SizedBox.shrink();
                final isSelected = widget.selectedPaymentMethodId == method.id;

                return InkWell(
                  onTap: () => widget.onPaymentMethodSelected(method),
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    padding: 14.allPadding,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? context.colors.primaryColor.withValues(alpha: 0.1)
                          : context.colors.backgroundFieldColor,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isSelected
                            ? context.colors.primaryColor
                            : context.colors.strokeColor,
                      ),
                    ),
                    child: Text(
                      method.name ,
                      style: isSelected
                          ? context.textStyles.font16MediumPrimaryColor
                          : context.textStyles.font16MediumSecondaryColor,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
