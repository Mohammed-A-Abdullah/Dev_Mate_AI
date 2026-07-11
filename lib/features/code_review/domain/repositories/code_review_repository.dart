import 'package:dev_mate_ai/features/code_review/domain/entities/code_review_request_entity.dart';

abstract class CodeReviewRepository {
  Future <String> reviewCode(CodeReviewRequestEntity request);
}