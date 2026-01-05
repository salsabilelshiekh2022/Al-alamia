import 'dart:async';

import 'package:alalamia/core/components/widgets/custom_page.dart';
import 'package:alalamia/core/components/widgets/empty_widget.dart';
import 'package:alalamia/core/helper/translation_extensions.dart';
import 'package:alalamia/features/support/presentation/cubit/support_cubit.dart';
import 'package:alalamia/features/support/presentation/cubit/support_state.dart';
import 'package:alalamia/generated/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgets/chat_bubble.dart';
import 'widgets/chat_support_bottom_sheet.dart';

class ChatSupportView extends StatefulWidget {
  const ChatSupportView({super.key});

  @override
  State<ChatSupportView> createState() => _ChatSupportViewState();
}

class _ChatSupportViewState extends State<ChatSupportView> {
  Timer? timer;
  
  Future<void> callMehtod() async {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      context.read<SupportCubit>().getMessages();
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<SupportCubit>().getMessages();
    callMehtod();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      title: "الدعم الفني",
      hasActions: false,
      isBack: true,
      bottomSheet: ChatSupportBottomSheet(),
      body: BlocBuilder<SupportCubit, SupportState>(
        builder: (context, state) {
          bool isEmpty = state.messages.isEmpty;
          return isEmpty 
            ? EmptyWidget(
                imagePath: AppAssets.imagesEmptyChat,
                title: context.notFoundMessages,
                description: context.notFoundMessagesDescription,
              )
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                reverse: false,
                itemBuilder: (context, index) {
                  return ChatBubble(
                    isMe: state.messages[index].senderType == 'me',
                    message: state.messages[index].message,
                  );
                },
                separatorBuilder: (_, __) => 12.verticalSpace,
                itemCount: state.messages.length,
              );
        },
      ),
    );
  }
}