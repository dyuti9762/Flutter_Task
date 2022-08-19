import 'package:get/get.dart';
class LocaleString extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    //ENGLISH LANGUAGE
    'en_US':{
      'hello':'Hello World',
      'message':'Welcome to Sprots analytics app',
      'title':'Flutter Language - Localization',
      'Track Progress':'Track Progress',
      'changelang':'Change Language',
      'What you want to Explore ?': 'What you want to Explore ?',
      'Physical Activity': 'Physical Activity'
    },
    //HINDI LANGUAGE
    'hi_IN':{
      'hello': 'नमस्ते दुनिया',
      'message':'स्प्रोट्स एनालिटिक्स ऐप में आपका स्वागत है',
      'title':'स्पंदन भाषा - स्थानीयकरण',
      'Track Progress' :'ट्रैक प्रगति',
      'changelang':'भाषा बदलो',
      'What you want to Explore ?': 'आप क्या एक्सप्लोर करना चाहते हैं?',
'Physical Activity': 'शारीरिक गतिविधि'
    },


  };
}