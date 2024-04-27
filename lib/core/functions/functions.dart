import "package:musicy/core/constants/constants.dart";
import "package:flutter_dotenv/flutter_dotenv.dart";

String? getYoutubeSearchQuery({required String query}) {
  if (dotenv.isInitialized) {
    try {
      String apiKey = dotenv.get("API_KEY");
      String adjustedUrl =
          "${Constants.baseUrl}?part=snippet&key=$apiKey&type=video&q=$query";
      return adjustedUrl;
    } on Exception {
      return null;
    }
  }
  return null;
}
