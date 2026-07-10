import 'package:highlight/highlight.dart';
import 'package:highlight/languages/bash.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:highlight/languages/cs.dart';
import 'package:highlight/languages/css.dart';
import 'package:highlight/languages/dart.dart';
import 'package:highlight/languages/go.dart';
import 'package:highlight/languages/java.dart';
import 'package:highlight/languages/javascript.dart';
import 'package:highlight/languages/kotlin.dart';
import 'package:highlight/languages/php.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/ruby.dart';
import 'package:highlight/languages/rust.dart';
import 'package:highlight/languages/sql.dart';
import 'package:highlight/languages/swift.dart';
import 'package:highlight/languages/typescript.dart';
import 'package:highlight/languages/xml.dart';

class LanguageHelper {
   static  Map<String, Mode> languageModes = {
    'Dart': dart,
    'Python': python,
    'JavaScript': javascript,
    'TypeScript': typescript,
    'Java': java,
    'Kotlin': kotlin,
    'Swift': swift,
    'C++': cpp,
    'C#': cs,
    'Rust': rust,
    'Go': go,
    'HTML': xml,
    'CSS': css,
    'PHP': php,
    'Ruby': ruby,
    'SQL': sql,
    'Shell / Bash': bash,
  };


  static List<String> languages = [
    // Core / Highly Popular
    'Dart',
    'Python',
    'JavaScript',
    'TypeScript',

    // Mobile / Systems
    'Kotlin',
    'Swift',
    'Java',
    'C++',
    'C#',
    'Rust',
    'Go',

    // Web / Backend / Data
    'HTML',
    'CSS',
    'PHP',
    'Ruby',
    'SQL',
    'Shell / Bash',
  ];
}