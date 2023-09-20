import 'dart:convert';
import 'package:http/http.dart' as http;

class DiseaseService {
  
  static Future<String> predictHeartDisease({
    required int sex
  }) async {
    http.Request res = http.Request('POST',
        Uri.parse("http://deepakn7502.pythonanywhere.com/api/prediction/"));
    res.body = json.encode({
      "age": 52,
      "sex": sex,
      "cp": 0,
      "trestbps": 125,
      "chol": 212,
      "fbs": 0,
      "restecg": 1,
      "thalach": 168,
      "exang": 0,
      "oldpeak": 1,
      "slope": 2,
      "ca": 2,
      "thal": 3
    });
    http.StreamedResponse responce = await res.send();
    String op = await responce.stream.bytesToString();
    return op;
  }
}
