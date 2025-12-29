import 'package:alalamia/core/components/widgets/custom_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/chat_bubble.dart';
import 'widgets/chat_support_bottom_sheet.dart';

class ChatSupportView extends StatelessWidget {
  const ChatSupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: "الدعم الفني",
      hasActions: false,
      isBack: true,
      bottomSheet: ChatSupportBottomSheet(),
      body: Expanded(
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          reverse: false,
          itemBuilder: (context, index) {
            // if (index == 0) {
            //   return Column(
            //     children: [
            //       Text(
            //         context.leaveComplaintHere,
            //         style: appTextTheme.font12RegularLabelColor,
            //       ),
            //       Padding(
            //         padding: REdgeInsets.all(24.0),
            //         child: Text(
            //           context.supportWelcome,
            //           style: appTextTheme.font12RegularLabelColor,
            //           textAlign: TextAlign.center,
            //         ),
            //       ),
            //     ],
            //   );
            // }
            return ChatBubble(
              isMe: index % 2 == 0,
              message: 'Hello, how can I help you? ${index % 2 != 0}',
            );
          },
          separatorBuilder: (_, __) => 12.verticalSpace,
          itemCount: 2,
        ),
      ),
    );
  }
}