import 'package:dev_mate_ai/features/explain_code/domain/entity/explain_code_entity.dart';
import 'package:dev_mate_ai/features/explain_code/domain/repositories/explain_code_repository.dart';

class ExplainCodeUseCase {
  final ExplainCodeRepository repository;

  ExplainCodeUseCase({required this.repository});

  Future<String>call(ExplainCodeEntity request){
    return repository.explainCode(request);
  }
}