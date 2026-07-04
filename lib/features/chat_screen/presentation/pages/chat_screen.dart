import 'package:dev_mate_ai/features/chat_screen/domain/model/chat_message_model.dart';
import 'package:dev_mate_ai/core/services/gemini_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/widgets/code_builder.dart';
import '../../../../core/widgets/custom_text_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final gemini = GeminiService();
  final TextEditingController chatController = TextEditingController();
  final List<ChatMessage> messages = [];
  bool isLoading = false;

  void sendMessage() async {
    final userText = chatController.text.trim();
    if (userText.isEmpty) return;

    setState(() {
      messages.insert(0, ChatMessage(text: userText, isUser: true));
      isLoading = true;
    });
    chatController.clear();

    try {
      final response = await gemini.sendMessage(userText);

      setState(() {
        messages.insert(0, ChatMessage(text: response, isUser: false));
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        messages.insert(
          0,
          ChatMessage(text: "An error occur: $e", isUser: false),
        );
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff111319),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff111319),
        title: Text(
          'DevMate AI',
          style: GoogleFonts.geist(
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xffB5C4FF),
          ),
        ),
      ),
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];

                    return Align(
                      alignment: message.isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            message.expanded = !message.expanded;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(14),
                          constraints: BoxConstraints(
                            maxWidth: message.isUser
                                ? MediaQuery.of(context).size.width * .75
                                : MediaQuery.of(context).size.width * .90,
                          ),
                          decoration: BoxDecoration(
                            color: message.isUser
                                ? const Color(0xffB5C4FF)
                                : const Color(0xff1D1E25),
                            borderRadius: BorderRadius.circular(18),
                            border: message.isUser
                                ? null
                                : Border.all(color: const Color(0xff2A2D3A)),
                          ),
                          child: message.isUser
                              ? Text(
                                  message.text,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                )
                              : MarkdownBody(
                                  data: message.text,
                                  selectable: true,
                                  styleSheet: MarkdownStyleSheet(
                                    // تنسيقات النصوص العادية التي وضعناها مسبقاً
                                    p: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                    h1: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    h2: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    h3: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    listBullet: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    strong: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),

                                    // !! مهم جداً: نخفي خلفية الكود الافتراضية الخاصة بالحزمة لنستخدم تصميمنا !!
                                    code: const TextStyle(
                                      backgroundColor: Colors.transparent,
                                    ),
                                    codeblockDecoration: const BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  // --- السطر الجديد هنا ---
                                  builders: {'code': CodeElementBuilder()},
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              if (isLoading) ...[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(
                    color: Color(0xffB5C4FF),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],

              const SizedBox(height: 10),

              CustomTextField(
                controller: chatController,
                hintText: "Message DevMate AI...",
                fillColor: const Color(0xff1D1E25),
                borderColor: const Color(0xff2A2D3A),
                cursorColor: const Color(0xffB5C4FF),
                radius: 20.r,
                keyBoardType: TextInputType.multiline,
                textStyle: TextStyle(color: Colors.white, fontSize: 16.sp),
                hintTextStyle: TextStyle(
                  color: const Color(0xff686B75),
                  fontSize: 16.sp,
                ),
                prefixIcon: Icon(
                  Icons.attach_file,
                  color: const Color(0xffC4C6D0),
                  size: 24.sp,
                ),
                suffixIconWidget: Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    width: 45.w,
                    height: 45.h,
                    decoration: BoxDecoration(
                      color: const Color(0xffB5C4FF),
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: IconButton(
                      onPressed: sendMessage,
                      icon: const Icon(Icons.send, color: Color(0xff001A4B)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
