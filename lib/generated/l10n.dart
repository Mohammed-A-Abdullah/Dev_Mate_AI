// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `DeveMat AI`
  String get appName {
    return Intl.message('DeveMat AI', name: 'appName', desc: '', args: []);
  }

  /// `POWERED BY ADVANCED LLMS`
  String get POWERED_BY_ADVANCED_LLMS {
    return Intl.message(
      'POWERED BY ADVANCED LLMS',
      name: 'POWERED_BY_ADVANCED_LLMS',
      desc: '',
      args: [],
    );
  }

  /// `Your AI-Powered Developer Assistant`
  String get Your_AI_Powered_Developer_Assistant {
    return Intl.message(
      'Your AI-Powered Developer Assistant',
      name: 'Your_AI_Powered_Developer_Assistant',
      desc: '',
      args: [],
    );
  }

  /// `AI Coding Assistant`
  String get AI_Coding_Assistant {
    return Intl.message(
      'AI Coding Assistant',
      name: 'AI_Coding_Assistant',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message('Get Started', name: 'getStarted', desc: '', args: []);
  }

  /// `Code Smarter`
  String get onboardingTitle1 {
    return Intl.message(
      'Code Smarter',
      name: 'onboardingTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Your 24/7 pair programmer. Get help with code completion, refactoring, and logical breakthroughs.`
  String get onboardingDesc1 {
    return Intl.message(
      'Your 24/7 pair programmer. Get help with code completion, refactoring, and logical breakthroughs.',
      name: 'onboardingDesc1',
      desc: '',
      args: [],
    );
  }

  /// `Refactor Instantly`
  String get onboardingTitle2 {
    return Intl.message(
      'Refactor Instantly',
      name: 'onboardingTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Clean your architecture and optimize functions with a single click inside your editor.`
  String get onboardingDesc2 {
    return Intl.message(
      'Clean your architecture and optimize functions with a single click inside your editor.',
      name: 'onboardingDesc2',
      desc: '',
      args: [],
    );
  }

  /// `Boost Productivity`
  String get onboardingTitle3 {
    return Intl.message(
      'Boost Productivity',
      name: 'onboardingTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Ship features faster without losing quality. Your personalized AI companion is ready.`
  String get onboardingDesc3 {
    return Intl.message(
      'Ship features faster without losing quality. Your personalized AI companion is ready.',
      name: 'onboardingDesc3',
      desc: '',
      args: [],
    );
  }

  /// `Project Planner`
  String get projectPlanner {
    return Intl.message(
      'Project Planner',
      name: 'projectPlanner',
      desc: '',
      args: [],
    );
  }

  /// `Project Title`
  String get projectTitle {
    return Intl.message(
      'Project Title',
      name: 'projectTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your project name here...`
  String get enterProjectName {
    return Intl.message(
      'Enter your project name here...',
      name: 'enterProjectName',
      desc: '',
      args: [],
    );
  }

  /// `Project Description`
  String get projectDes {
    return Intl.message(
      'Project Description',
      name: 'projectDes',
      desc: '',
      args: [],
    );
  }

  /// `Enter a brief description of your project...`
  String get enterProjectDes {
    return Intl.message(
      'Enter a brief description of your project...',
      name: 'enterProjectDes',
      desc: '',
      args: [],
    );
  }

  /// `Platform`
  String get platform {
    return Intl.message('Platform', name: 'platform', desc: '', args: []);
  }

  /// `Select platform`
  String get selectPlatform {
    return Intl.message(
      'Select platform',
      name: 'selectPlatform',
      desc: '',
      args: [],
    );
  }

  /// `Programming Language`
  String get programmingLang {
    return Intl.message(
      'Programming Language',
      name: 'programmingLang',
      desc: '',
      args: [],
    );
  }

  /// `Select Programming Language`
  String get selectProgrammingLang {
    return Intl.message(
      'Select Programming Language',
      name: 'selectProgrammingLang',
      desc: '',
      args: [],
    );
  }

  /// `Experience Level`
  String get experienceLevel {
    return Intl.message(
      'Experience Level',
      name: 'experienceLevel',
      desc: '',
      args: [],
    );
  }

  /// `Select experience level`
  String get selectExperienceLevel {
    return Intl.message(
      'Select experience level',
      name: 'selectExperienceLevel',
      desc: '',
      args: [],
    );
  }

  /// `Architecture`
  String get architecture {
    return Intl.message(
      'Architecture',
      name: 'architecture',
      desc: '',
      args: [],
    );
  }

  /// `Select architecture`
  String get selectArchitecture {
    return Intl.message(
      'Select architecture',
      name: 'selectArchitecture',
      desc: '',
      args: [],
    );
  }

  /// `Deadline`
  String get deadline {
    return Intl.message('Deadline', name: 'deadline', desc: '', args: []);
  }

  /// `Select Deadline`
  String get selectDeadline {
    return Intl.message(
      'Select Deadline',
      name: 'selectDeadline',
      desc: '',
      args: [],
    );
  }

  /// `Deployment Target`
  String get deploymentTarget {
    return Intl.message(
      'Deployment Target',
      name: 'deploymentTarget',
      desc: '',
      args: [],
    );
  }

  /// `Select deployment target`
  String get selectDeploymentTarget {
    return Intl.message(
      'Select deployment target',
      name: 'selectDeploymentTarget',
      desc: '',
      args: [],
    );
  }

  /// `Plan Project`
  String get planProject {
    return Intl.message(
      'Plan Project',
      name: 'planProject',
      desc: '',
      args: [],
    );
  }

  /// `Could not open the link. No supported app found.`
  String get couldNotOpenLink {
    return Intl.message(
      'Could not open the link. No supported app found.',
      name: 'couldNotOpenLink',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred while trying to open the link.`
  String get AboutErrorAccurre {
    return Intl.message(
      'An error occurred while trying to open the link.',
      name: 'AboutErrorAccurre',
      desc: '',
      args: [],
    );
  }

  /// `About DevMate AI`
  String get aboutDevMate {
    return Intl.message(
      'About DevMate AI',
      name: 'aboutDevMate',
      desc: '',
      args: [],
    );
  }

  /// `Your AI-Powered Developer Companion`
  String get yourAIPowerdDeleCompanion {
    return Intl.message(
      'Your AI-Powered Developer Companion',
      name: 'yourAIPowerdDeleCompanion',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get aboutDescription {
    return Intl.message(
      'Description',
      name: 'aboutDescription',
      desc: '',
      args: [],
    );
  }

  /// `DevMate AI helps developers write better code, understand concepts, and build amazing projects with the power of AI.`
  String get aboutDescriptionText {
    return Intl.message(
      'DevMate AI helps developers write better code, understand concepts, and build amazing projects with the power of AI.',
      name: 'aboutDescriptionText',
      desc: '',
      args: [],
    );
  }

  /// `Developer`
  String get aboutDeveloper {
    return Intl.message(
      'Developer',
      name: 'aboutDeveloper',
      desc: '',
      args: [],
    );
  }

  /// `Mohamed Ahmed Abdullah`
  String get aboutDeveloperName {
    return Intl.message(
      'Mohamed Ahmed Abdullah',
      name: 'aboutDeveloperName',
      desc: '',
      args: [],
    );
  }

  /// `Built With`
  String get aboutBuildWith {
    return Intl.message(
      'Built With',
      name: 'aboutBuildWith',
      desc: '',
      args: [],
    );
  }

  /// `Flutter • Firebase • Gemini AI • Cubit`
  String get aboutBuildWithData {
    return Intl.message(
      'Flutter • Firebase • Gemini AI • Cubit',
      name: 'aboutBuildWithData',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privaceyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privaceyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service`
  String get termService {
    return Intl.message(
      'Terms of Service',
      name: 'termService',
      desc: '',
      args: [],
    );
  }

  /// `Open Source Licenses`
  String get openSource {
    return Intl.message(
      'Open Source Licenses',
      name: 'openSource',
      desc: '',
      args: [],
    );
  }

  /// `© 2025 DevMate AI. All rights reserved.`
  String get copyWrite {
    return Intl.message(
      '© 2025 DevMate AI. All rights reserved.',
      name: 'copyWrite',
      desc: '',
      args: [],
    );
  }

  /// `Account Settings`
  String get accountSetting {
    return Intl.message(
      'Account Settings',
      name: 'accountSetting',
      desc: '',
      args: [],
    );
  }

  /// `Account deleted successfully.`
  String get accountDeleted {
    return Intl.message(
      'Account deleted successfully.',
      name: 'accountDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get personalInfo {
    return Intl.message(
      'Personal Information',
      name: 'personalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message('Full Name', name: 'fullName', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Loading...`
  String get loading {
    return Intl.message('Loading...', name: 'loading', desc: '', args: []);
  }

  /// `Security`
  String get security {
    return Intl.message('Security', name: 'security', desc: '', args: []);
  }

  /// `Change Password`
  String get changePass {
    return Intl.message(
      'Change Password',
      name: 'changePass',
      desc: '',
      args: [],
    );
  }

  /// `Update your password`
  String get updatePassword {
    return Intl.message(
      'Update your password',
      name: 'updatePassword',
      desc: '',
      args: [],
    );
  }

  /// `Email Verification`
  String get emailVerification {
    return Intl.message(
      'Email Verification',
      name: 'emailVerification',
      desc: '',
      args: [],
    );
  }

  /// `Your email status`
  String get emailStatus {
    return Intl.message(
      'Your email status',
      name: 'emailStatus',
      desc: '',
      args: [],
    );
  }

  /// `Unverified`
  String get unverified {
    return Intl.message('Unverified', name: 'unverified', desc: '', args: []);
  }

  /// `Verified`
  String get verified {
    return Intl.message('Verified', name: 'verified', desc: '', args: []);
  }

  /// `Danger Zone`
  String get dangerZone {
    return Intl.message('Danger Zone', name: 'dangerZone', desc: '', args: []);
  }

  /// `Delete Account`
  String get deleteAcount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAcount',
      desc: '',
      args: [],
    );
  }

  /// `Permanently delete your account`
  String get deleteAccountPermin {
    return Intl.message(
      'Permanently delete your account',
      name: 'deleteAccountPermin',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Delete Account`
  String get deleteAccount {
    return Intl.message(
      'Delete Account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to permanently delete your account? This action cannot be undone.`
  String get deleteAccountDesc {
    return Intl.message(
      'Are you sure you want to permanently delete your account? This action cannot be undone.',
      name: 'deleteAccountDesc',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Password updated successfully!`
  String get passwordUpdateSucceful {
    return Intl.message(
      'Password updated successfully!',
      name: 'passwordUpdateSucceful',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Password is required`
  String get passValidate {
    return Intl.message(
      'Password is required',
      name: 'passValidate',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get comfirmPass {
    return Intl.message(
      'Confirm Password',
      name: 'comfirmPass',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get comfirmPassValidator {
    return Intl.message(
      'Password is required',
      name: 'comfirmPassValidator',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Guest Explorer`
  String get guestEplorer {
    return Intl.message(
      'Guest Explorer',
      name: 'guestEplorer',
      desc: '',
      args: [],
    );
  }

  /// `AI Developer`
  String get aiDeveloper {
    return Intl.message(
      'AI Developer',
      name: 'aiDeveloper',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Chat`
  String get chats {
    return Intl.message('Chat', name: 'chats', desc: '', args: []);
  }

  /// `READMEs`
  String get readme {
    return Intl.message('READMEs', name: 'readme', desc: '', args: []);
  }

  /// `Analysis`
  String get analysis {
    return Intl.message('Analysis', name: 'analysis', desc: '', args: []);
  }

  /// `Theme`
  String get theme {
    return Intl.message('Theme', name: 'theme', desc: '', args: []);
  }

  /// `Dark`
  String get dark {
    return Intl.message('Dark', name: 'dark', desc: '', args: []);
  }

  /// `Light`
  String get light {
    return Intl.message('Light', name: 'light', desc: '', args: []);
  }

  /// `Languages`
  String get language {
    return Intl.message('Languages', name: 'language', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Camera`
  String get camera {
    return Intl.message('Camera', name: 'camera', desc: '', args: []);
  }

  /// `Gallery`
  String get gallary {
    return Intl.message('Gallery', name: 'gallary', desc: '', args: []);
  }

  /// `Choose Language`
  String get chooseLang {
    return Intl.message(
      'Choose Language',
      name: 'chooseLang',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `العربية`
  String get arabic {
    return Intl.message('العربية', name: 'arabic', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `Good morning, `
  String get goodMorning {
    return Intl.message(
      'Good morning, ',
      name: 'goodMorning',
      desc: '',
      args: [],
    );
  }

  /// `Good Afternoon, `
  String get goodAfternoon {
    return Intl.message(
      'Good Afternoon, ',
      name: 'goodAfternoon',
      desc: '',
      args: [],
    );
  }

  /// `Good Evening, `
  String get goodEvening {
    return Intl.message(
      'Good Evening, ',
      name: 'goodEvening',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get user {
    return Intl.message('User', name: 'user', desc: '', args: []);
  }

  /// `Ready to build something amazing today?`
  String get homeReadyToBuild {
    return Intl.message(
      'Ready to build something amazing today?',
      name: 'homeReadyToBuild',
      desc: '',
      args: [],
    );
  }

  /// `Quick Tools`
  String get homeQuickTool {
    return Intl.message(
      'Quick Tools',
      name: 'homeQuickTool',
      desc: '',
      args: [],
    );
  }

  /// `Recent Activity`
  String get homeRecentActivity {
    return Intl.message(
      'Recent Activity',
      name: 'homeRecentActivity',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get homeViewAll {
    return Intl.message('View All', name: 'homeViewAll', desc: '', args: []);
  }

  /// `No elements`
  String get noElements {
    return Intl.message('No elements', name: 'noElements', desc: '', args: []);
  }

  /// `New Chat`
  String get newChat {
    return Intl.message('New Chat', name: 'newChat', desc: '', args: []);
  }

  /// `No messages yet`
  String get noMessageYet {
    return Intl.message(
      'No messages yet',
      name: 'noMessageYet',
      desc: '',
      args: [],
    );
  }

  /// `What can I help you build today?`
  String get homeWhatCanIHelp {
    return Intl.message(
      'What can I help you build today?',
      name: 'homeWhatCanIHelp',
      desc: '',
      args: [],
    );
  }

  /// `Activity History`
  String get activityHistory {
    return Intl.message(
      'Activity History',
      name: 'activityHistory',
      desc: '',
      args: [],
    );
  }

  /// `Search history...`
  String get searchHistory {
    return Intl.message(
      'Search history...',
      name: 'searchHistory',
      desc: '',
      args: [],
    );
  }

  /// `Generate README`
  String get generateReadMe {
    return Intl.message(
      'Generate README',
      name: 'generateReadMe',
      desc: '',
      args: [],
    );
  }

  /// `Project Type`
  String get projectType {
    return Intl.message(
      'Project Type',
      name: 'projectType',
      desc: '',
      args: [],
    );
  }

  /// `Select type`
  String get selectType {
    return Intl.message('Select type', name: 'selectType', desc: '', args: []);
  }

  /// `GitHub Link (Optional)`
  String get githubLink {
    return Intl.message(
      'GitHub Link (Optional)',
      name: 'githubLink',
      desc: '',
      args: [],
    );
  }

  /// `Provide your GitHub repository link (optional).`
  String get githubDes {
    return Intl.message(
      'Provide your GitHub repository link (optional).',
      name: 'githubDes',
      desc: '',
      args: [],
    );
  }

  /// `Feature`
  String get feature {
    return Intl.message('Feature', name: 'feature', desc: '', args: []);
  }

  /// `Add feature`
  String get addFeature {
    return Intl.message('Add feature', name: 'addFeature', desc: '', args: []);
  }

  /// `README Result`
  String get readmeResult {
    return Intl.message(
      'README Result',
      name: 'readmeResult',
      desc: '',
      args: [],
    );
  }

  /// `Preview`
  String get preview {
    return Intl.message('Preview', name: 'preview', desc: '', args: []);
  }

  /// `Markdown`
  String get markDown {
    return Intl.message('Markdown', name: 'markDown', desc: '', args: []);
  }

  /// `README copied`
  String get readmeCopied {
    return Intl.message(
      'README copied',
      name: 'readmeCopied',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get copy {
    return Intl.message('Copy', name: 'copy', desc: '', args: []);
  }

  /// `Explain Code`
  String get explainCode {
    return Intl.message(
      'Explain Code',
      name: 'explainCode',
      desc: '',
      args: [],
    );
  }

  /// `Additional Instructions (Optional)`
  String get additionalInstruction {
    return Intl.message(
      'Additional Instructions (Optional)',
      name: 'additionalInstruction',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Explain line by line, focus on performance...`
  String get additionalinstructionDes {
    return Intl.message(
      'e.g. Explain line by line, focus on performance...',
      name: 'additionalinstructionDes',
      desc: '',
      args: [],
    );
  }

  /// `Debug Code`
  String get debugCode {
    return Intl.message('Debug Code', name: 'debugCode', desc: '', args: []);
  }

  /// `Debug & Error Instructions (Optional)`
  String get debugCodeInstruction {
    return Intl.message(
      'Debug & Error Instructions (Optional)',
      name: 'debugCodeInstruction',
      desc: '',
      args: [],
    );
  }

  /// `Provide any specific instructions or context for debugging the code.`
  String get debugCodeInstructionDes {
    return Intl.message(
      'Provide any specific instructions or context for debugging the code.',
      name: 'debugCodeInstructionDes',
      desc: '',
      args: [],
    );
  }

  /// `Code Review`
  String get codeReview {
    return Intl.message('Code Review', name: 'codeReview', desc: '', args: []);
  }

  /// `Review Depth`
  String get reveiwDepth {
    return Intl.message(
      'Review Depth',
      name: 'reveiwDepth',
      desc: '',
      args: [],
    );
  }

  /// `Select review depth`
  String get reviewDepthDes {
    return Intl.message(
      'Select review depth',
      name: 'reviewDepthDes',
      desc: '',
      args: [],
    );
  }

  /// `Review Focus`
  String get reviewFocus {
    return Intl.message(
      'Review Focus',
      name: 'reviewFocus',
      desc: '',
      args: [],
    );
  }

  /// `Select focus areas`
  String get reviewFocusDes {
    return Intl.message(
      'Select focus areas',
      name: 'reviewFocusDes',
      desc: '',
      args: [],
    );
  }

  /// `Project Context (Optional)`
  String get projectContext {
    return Intl.message(
      'Project Context (Optional)',
      name: 'projectContext',
      desc: '',
      args: [],
    );
  }

  /// `ex: This is a login screen using Firebase Authentication....`
  String get projectContextDes {
    return Intl.message(
      'ex: This is a login screen using Firebase Authentication....',
      name: 'projectContextDes',
      desc: '',
      args: [],
    );
  }

  /// `Message DevMate AI...`
  String get chatHintText {
    return Intl.message(
      'Message DevMate AI...',
      name: 'chatHintText',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back`
  String get welcomBack {
    return Intl.message('Welcome Back', name: 'welcomBack', desc: '', args: []);
  }

  /// `Create your DevMate AI account.`
  String get signupText {
    return Intl.message(
      'Create your DevMate AI account.',
      name: 'signupText',
      desc: '',
      args: [],
    );
  }

  /// `Continue your AI journey.`
  String get signinText {
    return Intl.message(
      'Continue your AI journey.',
      name: 'signinText',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgetPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `OR`
  String get or {
    return Intl.message('OR', name: 'or', desc: '', args: []);
  }

  /// `Already have an account? `
  String get haveAnAccount {
    return Intl.message(
      'Already have an account? ',
      name: 'haveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? `
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account? ',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signin {
    return Intl.message('Sign In', name: 'signin', desc: '', args: []);
  }

  /// `Sign Up`
  String get signup {
    return Intl.message('Sign Up', name: 'signup', desc: '', args: []);
  }

  /// `Check your email`
  String get checkYourEmail {
    return Intl.message(
      'Check your email',
      name: 'checkYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `We've sent a password reset link to:`
  String get checkYourEmailText {
    return Intl.message(
      'We\'ve sent a password reset link to:',
      name: 'checkYourEmailText',
      desc: '',
      args: [],
    );
  }

  /// `Open your inbox and click the reset link to create a new password.`
  String get checkYourEmailOpenBox {
    return Intl.message(
      'Open your inbox and click the reset link to create a new password.',
      name: 'checkYourEmailOpenBox',
      desc: '',
      args: [],
    );
  }

  /// `Back to Sign In`
  String get backToSignIn {
    return Intl.message(
      'Back to Sign In',
      name: 'backToSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Didn't receive the email?`
  String get dontRevieveEmail {
    return Intl.message(
      'Didn\'t receive the email?',
      name: 'dontRevieveEmail',
      desc: '',
      args: [],
    );
  }

  /// `Failed to send reset email.`
  String get failToSendEmail {
    return Intl.message(
      'Failed to send reset email.',
      name: 'failToSendEmail',
      desc: '',
      args: [],
    );
  }

  /// `Forget password email`
  String get forgetpasswordEmail {
    return Intl.message(
      'Forget password email',
      name: 'forgetpasswordEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email to send reset password email`
  String get sendEmailPassword {
    return Intl.message(
      'Enter your email to send reset password email',
      name: 'sendEmailPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address first.`
  String get showDialogSendEmail {
    return Intl.message(
      'Please enter your email address first.',
      name: 'showDialogSendEmail',
      desc: '',
      args: [],
    );
  }

  /// `Check email`
  String get checkEmail {
    return Intl.message('Check email', name: 'checkEmail', desc: '', args: []);
  }

  /// `Email address`
  String get emailAddress {
    return Intl.message(
      'Email address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Explain Code`
  String get explainCodeTitle {
    return Intl.message(
      'Explain Code',
      name: 'explainCodeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Break down complex logic`
  String get explainCodeDesc {
    return Intl.message(
      'Break down complex logic',
      name: 'explainCodeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Debug Code`
  String get debugCodeTitle {
    return Intl.message(
      'Debug Code',
      name: 'debugCodeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Find and fix errors fast`
  String get debugCodeDesc {
    return Intl.message(
      'Find and fix errors fast',
      name: 'debugCodeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Generate README`
  String get generateReadmeTitle {
    return Intl.message(
      'Generate README',
      name: 'generateReadmeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Instant documentation`
  String get generateReadmeDesc {
    return Intl.message(
      'Instant documentation',
      name: 'generateReadmeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Project Planner`
  String get projectPlannerTitle {
    return Intl.message(
      'Project Planner',
      name: 'projectPlannerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Architect your next app`
  String get projectPlannerDesc {
    return Intl.message(
      'Architect your next app',
      name: 'projectPlannerDesc',
      desc: '',
      args: [],
    );
  }

  /// `AI Chat`
  String get aiChatTitle {
    return Intl.message('AI Chat', name: 'aiChatTitle', desc: '', args: []);
  }

  /// `Open-ended coding help`
  String get aiChatDesc {
    return Intl.message(
      'Open-ended coding help',
      name: 'aiChatDesc',
      desc: '',
      args: [],
    );
  }

  /// `Code Review`
  String get codeReviewTitle {
    return Intl.message(
      'Code Review',
      name: 'codeReviewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Analyze for best practices`
  String get codeReviewDesc {
    return Intl.message(
      'Analyze for best practices',
      name: 'codeReviewDesc',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
