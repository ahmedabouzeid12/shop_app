// https://newsapi.org/
// v2/top-headlines?
// country=eg&category=business&apiKey=API_KEY




//https://newsapi.org/v2/everything?q=tesla&apiKey=b4a9c8b128934dd8a0a19fb2ac5be1ab

import '../../modules/shop_app/login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';
import 'components.dart';


void signOut(context)
{
  CacheHelper.removeData(key: 'token',).then((value)
  {
    if(value)
    {
      navigateAndFinish(context, ShopLoginScreen(),);
    }
  });
}

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';

String uId = '';
//CacheHelper.getData(key: 'token');