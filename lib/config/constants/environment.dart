import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String movieDbKey = dotenv.env["TMDB_API_KEY"] ?? "API key not found";
}
