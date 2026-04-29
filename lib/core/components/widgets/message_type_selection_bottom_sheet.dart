import 'package:alalamia/core/enums/message_type_enum.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Bottom sheet for selecting notification message type (SMS or WhatsApp)
class MessageTypeSelectionBottomSheet extends StatefulWidget {
  const MessageTypeSelectionBottomSheet({
    super.key,
    this.initialSelection,
    this.allowWhatsApp = true,
  });

  final MessageTypeEnum? initialSelection;
  final bool allowWhatsApp;

  @override
  State<MessageTypeSelectionBottomSheet> createState() =>
      _MessageTypeSelectionBottomSheetState();
}

class _MessageTypeSelectionBottomSheetState
    extends State<MessageTypeSelectionBottomSheet> {
  MessageTypeEnum? _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.initialSelection;
    if (!widget.allowWhatsApp && _selectedType == MessageTypeEnum.whatsapp) {
      _selectedType = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: context.colors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'اختر طريقة الإرسال',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: context.colors.primaryColor,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.close, color: context.colors.grayColor),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          16.verticalSizedBox,
          Text(
            'يرجى اختيار طريقة إرسال الإشعار للعميل',
            style: context.textStyles.font14RegularSecondaryColor,
          ),
          24.verticalSizedBox,

          // SMS Option
          _buildOptionCard(
            type: MessageTypeEnum.sms,
            title: 'رسالة نصية (SMS)',
            description: 'إرسال إشعار عبر الرسائل النصية',
            icon: Icons.message_outlined,
          ),
          12.verticalSizedBox,

          // WhatsApp Option
          _buildOptionCard(
            type: MessageTypeEnum.whatsapp,
            title: 'واتساب (WhatsApp)',
            description: 'إرسال إشعار عبر تطبيق واتساب',
            icon: Icons.chat_bubble_outline,
            enabled: widget.allowWhatsApp,
          ),

          24.verticalSizedBox,

          // Confirm Button
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: _selectedType == null
                  ? null
                  : () => Navigator.pop(context, _selectedType),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colors.primaryColor,
                disabledBackgroundColor: context.colors.grayColor.withOpacity(
                  0.3,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'تأكيد',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: context.colors.whiteColor,
                ),
              ),
            ),
          ),
          16.verticalSizedBox,
        ],
      ),
    );
  }

  Widget _buildOptionCard({
    required MessageTypeEnum type,
    required String title,
    required String description,
    required IconData icon,
    bool enabled = true,
  }) {
    final isSelected = _selectedType == type;
    final isEnabled = enabled;
    final effectiveSelected = isSelected && isEnabled;
    final baseTextColor = isEnabled
        ? context.colors.primaryColor
        : context.colors.grayColor;

    return InkWell(
      onTap: isEnabled
          ? () {
              setState(() {
                _selectedType = type;
              });
            }
          : null,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: effectiveSelected
              ? context.colors.primaryColor.withOpacity(0.1)
              : context.colors.backgroundFieldColor,
          border: Border.all(
            color: effectiveSelected
                ? context.colors.primaryColor
                : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: effectiveSelected
                    ? context.colors.primaryColor
                    : context.colors.grayColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: effectiveSelected
                    ? context.colors.whiteColor
                    : context.colors.grayColor,
                size: 24.sp,
              ),
            ),
            16.horizontalSizedBox,

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: baseTextColor,
                    ),
                  ),
                  4.verticalSizedBox,
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: isEnabled
                          ? context.colors.grayColor
                          : context.colors.grayColor.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),

            // Radio Indicator
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: effectiveSelected
                      ? context.colors.primaryColor
                      : context.colors.grayColor,
                  width: 2,
                ),
                color: effectiveSelected
                    ? context.colors.primaryColor
                    : Colors.transparent,
              ),
              child: effectiveSelected
                  ? Icon(
                      Icons.check,
                      size: 16.sp,
                      color: context.colors.whiteColor,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
