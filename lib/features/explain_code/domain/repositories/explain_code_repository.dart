import 'package:dev_mate_ai/features/explain_code/domain/entity/explain_code_entity.dart';

abstract class ExplainCodeRepository {
  Future<String> explainCode(ExplainCodeEntity request);
}