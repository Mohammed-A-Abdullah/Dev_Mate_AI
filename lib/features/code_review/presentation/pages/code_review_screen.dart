import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/features/chat_screen/data/datasource/firebase_chat_data_source.dart';
import 'package:dev_mate_ai/features/code_review/presentation/widgets/custom_reveiw_types_chips.dart';
import 'package:dev_mate_ai/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:re_editor/re_editor.dart';
import '../../../../core/routing/route_name.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_dropdown_button_field.dart';
import '../../../../core/widgets/custom_feature_button.dart';
import '../../../../core/widgets/language_helper.dart';
import '../../../../core/widgets/spacing_widgets.dart';
import '../cubit/code_review_cubit.dart';
import '../cubit/code_review_state.dart';
import '../../../../core/widgets/custom_code_field.dart';
import '../widgets/custom_review_text_field.dart';

class CodeReviewScreen extends StatelessWidget {
  const CodeReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CodeReviewCubit>(),
      child: const CodeReviewView(),
    );
  }
}

class CodeReviewView extends StatefulWidget {
  const CodeReviewView({super.key});

  @override
  State<CodeReviewView> createState() => _CodeReviewViewState();
}

class _CodeReviewViewState extends State<CodeReviewView> {
  late CodeLineEditingController _codeController;
  late final TextEditingController _errorLogController;

  @override
  void initState() {
    super.initState();
    _errorLogController = TextEditingController();
    _codeController = CodeLineEditingController();
    _codeController.addListener(() {
      final cubit = context.read<CodeReviewCubit>();
      final currentCode = _codeController.text;
      if (cubit.state.code != currentCode) {
        cubit.updateCode(currentCode);
      }
    });
    _errorLogController.addListener(() {
      final cubit = context.read<CodeReviewCubit>();
      cubit.updateErrorLog(_errorLogController.text);
    });
  }

  @override
  void dispose() {
    _codeController.dispose();
    _errorLogController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local=S.of(context);
    return BlocConsumer<CodeReviewCubit, CodeReviewState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          context.read<CodeReviewCubit>().clearError();
        }
        if (state.reviewResult != null && !state.isLoading) {
          final navigator = GoRouter.of(context);
          Future.microtask(() async {
            final prompt = [
              'Language: ${state.language}',
              'Code:',
              state.code,
              'Review Types: ${state.reviewTypes.join(', ')}',
              'Experience: ${state.experienceLevel}',
              'Depth: ${state.reviewDepth}',
              if (state.errorLog.isNotEmpty) 'Context: ${state.errorLog}',
            ].join('\n');

            try {
              await FirebaseChatDataSource(
                firestore: FirebaseFirestore.instance,
              ).saveQuickToolConversation(
                title: 'Code Review',
                type: 'Code Review',
                prompt: prompt,
                response: state.reviewResult!,
              );
            } catch (_) {}

            if (!mounted) return;
            navigator.pushNamed(
              RouteName.ansewerEplainCode,
              extra: state.reviewResult,
            );
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar:  CustomAppBar(title: local.codeReview),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeightSpace(height: 35),
                  SizedBox(
                    width: 250.w,
                    child: CustomDropdownbuttonfield(
                      labelText: local.language,
                      hintText: local.selectProgrammingLang,
                      initialValue: state.language,
                      items: LanguageHelper.languages,
                      onChanged: (value) {
                        if (value != null) {
                          context.read<CodeReviewCubit>().updateLanguage(value);
                        }
                      },
                    ),
                  ),
                  const HeightSpace(height: 20),
                  CustomCodeEditor(controller: _codeController),
                  const HeightSpace(height: 20),
                  CustomDropdownbuttonfield(
                    labelText: local.experienceLevel,
                    hintText: local.selectExperienceLevel,
                    items: const [
                      'Beginner',
                      'Intermediate',
                      'Advanced',
                      'Expert',
                    ],
                    initialValue: state.experienceLevel,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<CodeReviewCubit>().updateExperienceLevel(
                          value,
                        );
                      }
                    },
                  ),
                  const HeightSpace(height: 20),
                  CustomDropdownbuttonfield(
                    labelText: local.reveiwDepth,
                    hintText: local.reviewDepthDes,
                    items: const [
                      'Quick Review',
                      'Detailed Review',
                      'In-depth Analysis',
                    ],
                    initialValue: state.reviewDepth,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<CodeReviewCubit>().updateReviewDepth(
                          value,
                        );
                      }
                    },
                  ),
                  const HeightSpace(height: 20),
                  CustomReveiwTypesChips(state: state),
                  const HeightSpace(height: 20),
                  CustomReviewTextField(
                    errorLogController: _errorLogController,
                  ),
                  const HeightSpace(height: 20),
                  CustomFeatureButton(
                    isLoading: state.isLoading,
                    text: local.codeReview,
                    onTap: state.isLoading
                        ? null
                        : () {
                            context.read<CodeReviewCubit>().submitReview();
                          },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
