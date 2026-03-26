import 'package:alalamia/core/enums/message_type_enum.dart';
import 'package:alalamia/core/helper/app_extention.dart';
import 'package:alalamia/core/helper/number_extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Bottom sheet for selecting notification message type (SMS or WhatsApp)
class MessageTypeSelectionBottomSheet extends StatefulWidget {
  const MessageTypeSelectionBottomSheet({super.key, this.initialSelection});

  final MessageTypeEnum? initialSelection;

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
  }) {
    final isSelected = _selectedType == type;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedType = type;
        });
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colors.primaryColor.withOpacity(0.1)
              : context.colors.backgroundFieldColor,
          border: Border.all(
            color: isSelected
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
                color: isSelected
                    ? context.colors.primaryColor
                    : context.colors.grayColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: isSelected
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
                      color: isSelected
                          ? context.colors.primaryColor
                          : context.colors.primaryColor,
                    ),
                  ),
                  4.verticalSizedBox,
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: context.colors.grayColor,
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
                  color: isSelected
                      ? context.colors.primaryColor
                      : context.colors.grayColor,
                  width: 2,
                ),
                color: isSelected
                    ? context.colors.primaryColor
                    : Colors.transparent,
              ),
              child: isSelected
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
