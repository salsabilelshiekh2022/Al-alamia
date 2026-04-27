import 'package:alalamia/core/components/widgets/custom_text_field_with_label.dart';
import 'package:alalamia/core/components/widgets/main_button.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:alalamia/core/helper/widget_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../../core/components/widgets/custom_svg_builder.dart';
import '../../../../../core/utils/global_ui_utils.dart';
import '../../../../../generated/app_assets.dart';
import '../../cubit/transactions_cubit.dart';

class FilterBox extends StatefulWidget {
  const FilterBox({super.key});

  @override
  State<FilterBox> createState() => _FilterBoxState();
}

class _FilterBoxState extends State<FilterBox> {
  static const List<_StatusOption> _statusOptions = [
    _StatusOption(title: 'في انتظار القبول', value: 'waiting_approval'),
    _StatusOption(title: 'قيد التنفيذ', value: 'in_progress'),
    _StatusOption(title: 'تم التسليم', value: 'completed'),
    _StatusOption(title: 'معلق', value: 'pending'),
    _StatusOption(title: 'ملغي', value: 'canceled'),
  ];

  DateTime? _parseDate(String value) {
    if (value.trim().isEmpty) {
      return null;
    }
    try {
      return DateFormat('yyyy-MM-dd').parseStrict(value);
    } catch (_) {
      return null;
    }
  }

  String _normalizeDate(String value) => value.trim();

  Future<void> _showFiltersBottomSheet() async {
    final cubit = context.read<TransactionsCubit>();
    final fromDateController = TextEditingController(
      text: cubit.fromDateFilter ?? '',
    );
    final toDateController = TextEditingController(
      text: cubit.toDateFilter ?? '',
    );
    final selectedStatuses = <String>{...cubit.statusFilters ?? const []};

    await GlobalUiUtils.showBottomSheet(
      context,
      child: StatefulBuilder(
        builder: (sheetContext, setSheetState) {
          Future<void> pickDate({
            required TextEditingController controller,
          }) async {
            final selectedDate = _parseDate(controller.text);
            final pickedDate = await showDatePicker(
              context: sheetContext,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );

            if (pickedDate == null) {
              return;
            }

            controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
            setSheetState(() {});
          }

          return Column(
            children: [
              Text(
                'تصنيف حسب',
                style: sheetContext.textStyles.font16SemiBoldSecondaryColor,
              ),
              25.verticalSizedBox,
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'حسب التاريخ * ',
                  style: sheetContext.textStyles.font14BoldSecondaryColor,
                  textAlign: TextAlign.start,
                ),
              ),
              16.verticalSizedBox,
              Row(
                children: [
                  Expanded(
                    child: CustomTextFieldWithLabel(
                      label: 'من',
                      hintText: 'yyyy-mm-dd',
                      controller: fromDateController,
                      isReadOnly: true,
                      onTap: () => pickDate(controller: fromDateController),
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: CustomTextFieldWithLabel(
                      label: 'إلى',
                      hintText: 'yyyy-mm-dd',
                      controller: toDateController,
                      isReadOnly: true,
                      onTap: () => pickDate(controller: toDateController),
                    ),
                  ),
                ],
              ),
              48.verticalSizedBox,
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'حسب حالة الطلب * ',
                  style: sheetContext.textStyles.font16SemiBoldSecondaryColor,
                ),
              ),
              16.verticalSizedBox,
              Wrap(
                spacing: 24,
                runSpacing: 12,
                children: _statusOptions
                    .map(
                      (option) => CheckItem(
                        title: option.title,
                        isChecked: selectedStatuses.contains(option.value),
                        onTap: () {
                          setSheetState(() {
                            if (selectedStatuses.contains(option.value)) {
                              selectedStatuses.remove(option.value);
                            } else {
                              selectedStatuses.add(option.value);
                            }
                          });
                        },
                      ),
                    )
                    .toList(),
              ).onlyPadding(leftPadding: 16),
              28.verticalSizedBox,
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    setSheetState(() {
                      selectedStatuses.clear();
                      fromDateController.clear();
                      toDateController.clear();
                    });
                  },
                  child: Text(
                    'إعادة الضبط',
                    style: sheetContext.textStyles.font14SemiBoldSecondaryColor,
                  ),
                ),
              ),
              12.verticalSizedBox,
              MainButton(
                title: 'تم',
                onTap: () {
                  final fromDate = _normalizeDate(fromDateController.text);
                  final toDate = _normalizeDate(toDateController.text);

                  cubit.getTransactionList(
                    transaction: cubit.state.currentFilter,
                    status: selectedStatuses.isEmpty
                        ? null
                        : selectedStatuses.toList(),
                    fromDate: fromDate.isEmpty ? null : fromDate,
                    toDate: toDate.isEmpty ? null : toDate,
                    search: cubit.searchFilter,
                  );
                  context.pop();
                },
              ),
            ],
          );
        },
      ),
    );

    // fromDateController.dispose();
    // toDateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _showFiltersBottomSheet,
      child: Container(
        padding: 12.allPadding,
        decoration: BoxDecoration(
          color: context.colors.whiteColor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: context.colors.whiteColor.withValues(alpha: 0.22),
            width: 1,
          ),
        ),
        child: CustomSvgBuilder(
          path: AppAssets.svgsFilterIcon,
          width: 24,
          height: 24,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}

class CheckItem extends StatelessWidget {
  const CheckItem({
    super.key,
    required this.title,
    required this.isChecked,
    required this.onTap,
  });

  final String title;
  final bool isChecked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onTap,
          child: Image.asset(
            isChecked
                ? AppAssets.imagesCheckBoxMarked
                : AppAssets.imagesEmptyCheckBox,
            width: 24,
            height: 24,
          ),
        ),
        6.horizontalSizedBox,
        Text(title, style: context.textStyles.font14SemiBoldSecondaryColor),
      ],
    );
  }
}

class _StatusOption {
  final String title;
  final String value;

  const _StatusOption({required this.title, required this.value});
}
