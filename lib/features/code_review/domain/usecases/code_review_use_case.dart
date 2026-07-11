import 'package:dev_mate_ai/features/code_review/domain/entities/code_review_request_entity.dart';
import 'package:dev_mate_ai/features/code_review/domain/repositories/code_review_repository.dart';

class CodeReviewUseCase {
  final CodeReviewRepository repository;

  CodeReviewUseCase({required this.repository});

  Future<String>call(CodeReviewRequestEntity request){
    return repository.reviewCode(request);
  }
}