import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dev_mate_ai/core/di/service_locator.dart';
import 'package:dev_mate_ai/features/chat_screen/data/datasource/firebase_chat_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routing/route_name.dart';
import '../../../../core/services/gemini_service.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_dropdownButtonField.dart';
import '../../../../core/widgets/custom_feature_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/spacing_widgets.dart';
import '../../data/repositories/generate_readme_repository_impl.dart';
import '../../domain/usecases/generate_readme_use_case.dart';
import '../cubit/readme_cubit.dart';
import '../cubit/readme_state.dart';
import '../widgets/costom_readme_text_field.dart';

class _ReadmeConstants {
  static const List<String> projectTypes = [
    'Web App',
    'Mobile App',
    'Desktop App',
    'CLI Tool',
    'Library/Package',
    'Game',
    'Other',
  ];
  static const List<String> technologies = [
    'Flutter',
    'Dart',
    'React',
    'Angular',
    'Node.js',
    'Python',
    'Java',
    'Kotlin',
    'Swift',
    'Go',
    'Rust',
    'C#',
    'PHP',
    'Ruby',
    'Other',
  ];
}

class GenerateReadmeScreen extends StatelessWidget {
  const GenerateReadmeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ReadmeCubit>(),
      child: const GenerateReadmeView(),
    );
  }
}

class GenerateReadmeView extends StatefulWidget {
  const GenerateReadmeView({super.key});

  @override
  State<GenerateReadmeView> createState() => _GenerateReadmeViewState();
}

class _GenerateReadmeViewState extends State<GenerateReadmeView> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _featureController;
  late final TextEditingController _githubLinkController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _featureController = TextEditingController();
    _githubLinkController = TextEditingController();

    final state = context.read<ReadmeCubit>().state;
    _titleController.text = state.projectTitle;
    _descriptionController.text = state.projectDescription;
    _githubLinkController.text = state.githubLink;

    _titleController.addListener(() {
      context.read<ReadmeCubit>().updateProjectTitle(_titleController.text);
    });
    _descriptionController.addListener(() {
      context.read<ReadmeCubit>().updateProjectDescription(
        _descriptionController.text,
      );
    });
    _githubLinkController.addListener(() {
      context.read<ReadmeCubit>().updateGithubLink(_githubLinkController.text);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _featureController.dispose();
    _githubLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReadmeCubit, ReadmeState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          context.read<ReadmeCubit>().clearError();
        }
        if (state.readmeResult != null && !state.isLoading) {
          final navigator = GoRouter.of(context);
          Future.microtask(() async {
            final prompt = [
              'Project Title: ${state.projectTitle}',
              'Description: ${state.projectDescription}',
              'Project Type: ${state.projectType}',
              if (state.features.isNotEmpty)
                'Features: ${state.features.join(', ')}',
              if (state.technologies.isNotEmpty)
                'Technologies: ${state.technologies.join(', ')}',
              if (state.githubLink.isNotEmpty) 'GitHub: ${state.githubLink}',
            ].join('\n');

            try {
              await FirebaseChatDataSource(
                firestore: FirebaseFirestore.instance,
              ).saveQuickToolConversation(
                title: 'Generate README',
                type: 'Generate README',
                prompt: prompt,
                response: state.readmeResult!,
              );
            } catch (_) {}

            if (!mounted) return;
            navigator.pushNamed(
              RouteName.readmeResultScreen,
              extra: state.readmeResult,
            );
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: const CustomAppBar(title: 'Generate README'),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeightSpace(height: 35),
                  CostomReadmeTextField(
                    controller: _titleController,
                    title: 'Project Title',
                    description: 'Enter your project name',
                  ),
                  const HeightSpace(height: 20),
                  CostomReadmeTextField(
                    controller: _descriptionController,
                    title: 'Project Description',
                    description: 'Enter a brief description of your project...',
                  ),
                  const HeightSpace(height: 20),
                  CustomDropdownbuttonfield(
                    labelText: 'Project Type',
                    hintText: 'Select type',
                    initialValue: state.projectType,
                    items: _ReadmeConstants.projectTypes,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<ReadmeCubit>().updateProjectType(value);
                      }
                    },
                  ),
                  const HeightSpace(height: 20),
                  _buildFeatureInput(state),
                  const HeightSpace(height: 20),
                  _buildTechnologiesChips(state),
                  const HeightSpace(height: 20),
                  CostomReadmeTextField(
                    controller: _githubLinkController,
                    title: 'GitHub Link (Optional)',
                    description:
                        'Provide your GitHub repository link (optional).',
                    icon: Icons.link,
                  ),
                  const HeightSpace(height: 20),
                  CustomFeatureButton(
                    text: 'Generate README',
                    isLoading: state.isLoading,
                    onTap: state.isLoading
                        ? null
                        : () {
                            context.read<ReadmeCubit>().generateReadme();
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

  Widget _buildFeatureInput(ReadmeState state) {
    return CustomTextField(
      controller: _featureController,
      label: 'Feature',
      hintText: 'Add feature',
      labelStyle: GoogleFonts.inter(color: const Color(0xff6F7385)),
      cursorColor: const Color(0xffC3C5D7),
      keyBoardType: TextInputType.multiline,
      suffixIconWidget: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
          final text = _featureController.text.trim();
          if (text.isNotEmpty) {
            context.read<ReadmeCubit>().addFeature(text);
            _featureController.clear();
          }
        },
      ),
      fillColor: const Color(0xff1E1F26),
      borderColor: const Color(0xff434654),
      radius: 18.r,
      textStyle: GoogleFonts.inter(color: Colors.white),
      hintTextStyle: GoogleFonts.inter(
        color: const Color(0xff6F7385),
        fontSize: 14.sp,
      ),
      onFieldSubmitted: (value) {
        final text = value.trim();
        if (text.isNotEmpty) {
          context.read<ReadmeCubit>().addFeature(text);
          _featureController.clear();
        }
      },
    );
  }

  Widget _buildTechnologiesChips(ReadmeState state) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _ReadmeConstants.technologies.map((tech) {
        final selected = state.technologies.contains(tech);
        return FilterChip(
          label: Text(tech),
          selected: selected,
          onSelected: (_) {
            context.read<ReadmeCubit>().toggleTechnology(tech);
          },
        );
      }).toList(),
    );
  }
}
