import 'package:flutter/material.dart';

import '../../../../../core/helper/app_extention.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.isMe, required this.message});

  final bool isMe;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      width: MediaQuery.sizeOf(context).width,
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              decoration: BoxDecoration(
                color: isMe
                    ? context.colors.backgroundFieldColor
                    : context.colors.primaryColor,
                borderRadius: BorderRadiusDirectional.only(
                  topStart:
                      const Radius.circular(12),
                  topEnd: const Radius.circular(12),
                  bottomStart: !isMe ? const Radius.circular(12) : const Radius.circular(4),
                  bottomEnd: isMe ? const Radius.circular(12) : const Radius.circular(4),
                ),
              ),
              child: Text(
                message,
                style: context.textStyles.font14MediumSecondaryColor.copyWith(
                  color: isMe ? context.colors.secondaryColor : context.colors.whiteColor,
                ),
              ),
            ),
            // 8.verticalSpace,
            // Container(
            //   alignment: isMe
            //       ? AlignmentDirectional.centerEnd
            //       : AlignmentDirectional.centerStart,
            //   padding: REdgeInsetsDirectional.only(end: 16, start: 16),
            //   child: Text(
            //     'اليوم 14:44 PM',
            //     style: appTextStyles.font12RegularLabelColor,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}