import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../layout/shop_app/cubit/cubit.dart';
import '../network/local/cache_helper.dart';
import '../styles/colors.dart';

Widget defaultButton({
   double width = double.infinity,
   Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) => Container(
     width: width ,
      height: 40.0,
    child: MaterialButton(
    onPressed: () {
      function();
    },
    height: 40.0,
     child: Text(
        isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background ,
      ),
);

Widget defaultTextButton({
  required Function function,
  required String text,
}) => TextButton(
  onPressed: () {
    function();
  },
  child: Text(text.toUpperCase(),),
);

Widget defaultFormFild({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChanged,
  Function? onTap,
  bool isPassword = false,
  Function? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isClickable =true,
}) =>  TextFormField(
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  enabled: isClickable,
  onFieldSubmitted: (s) {
    onSubmit!(s);
  },
  onChanged: (s) {
    onChanged!(s);
  },
  onTap: () {
    if(onTap != null)
    {
      onTap();
    }
  },
  validator: (s) {
    validate!(s);
  },
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix != null ?  IconButton(
      onPressed: () {
        suffixPressed!();
      },
      icon: Icon(
        suffix,
      ),
    ) : null,
    border: OutlineInputBorder(),
  ),
);

Widget buildTaskItem(Map model , context) => Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        CircleAvatar(
  
          radius: 40.0,
  
          child: Text(
  
            '${model['time']}',
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20.0,
  
        ),
  
        Expanded(
  
          child: Column(
  
            mainAxisSize: MainAxisSize.min,
  
            crossAxisAlignment: CrossAxisAlignment.start,
  
            children: [
  
              Text(
  
                '${model['title']}',
  
                style: TextStyle(
  
                  fontSize: 16.0,
  
                  fontWeight: FontWeight.bold,
  
                ),
  
              ),
  
              Text(
  
                '${model['date']}',
  
                style: TextStyle(
  
                  color: Colors.grey,
  
                ),
  
              ),
  
            ],
  
          ),
  
  
  
        ),
  
        SizedBox(
  
          width: 20.0,
  
        ),
  
        IconButton(
  
          onPressed: ()
  
          {
            //
            // AppCubit.get(context).updateData(
            //
            //   status: 'done',
            //
            //   id: model['id'],
            //
            // );
            //
          },
  
          icon: Icon(
  
            Icons.check_box,
  
            color: Colors.green,
  
          ),
  
        ),
  
        IconButton(
  
          onPressed: ()
  
          {

            // AppCubit.get(context).updateData(
            //
            //     status: 'archive',
            //
            //     id: model['id'],
            //
            // );
  
          },
  
          icon: Icon(
  
            Icons.archive,
  
            color: Colors.black45,
  
          ),
  
        )
  
      ],
  
    ),
  
  ),
  onDismissed: (direction)
  {
      // AppCubit.get(context).deleteData(id: model['id'],);
  },
);
Widget tasksBuilder ({
  required List<Map> tasks,
}) => ConditionalBuilder(
  condition: tasks.length > 0,
  builder: (context) => ListView.separated(
    itemBuilder: (context, index) => buildTaskItem(tasks[index], context),
    separatorBuilder: (context, index) => myDivider(),
    itemCount: tasks.length,),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          size: 100.0,
          color: Colors.grey,
        ),
        Text(
          'No Tasks Yet , Please Add Some Tasks',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  ),
);

Widget myDivider() => Padding(
padding: const EdgeInsetsDirectional.only(
start: 20.0,
),
child: Container(
width: double.infinity,
height: 1.0,
color: Colors.grey[300],
),
);


Widget builArticleItem (article , context) {
  bool isDark = CacheHelper.getData(key: 'isDark') ?? true;
  return InkWell(

    onTap: ()
    {
      // navigateTo(context, WebViewScreen(article['url']),);
    },
    child:   Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0,),
              image: DecorationImage(
                image: NetworkImage('${article['urlToImage']}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Container(
              height: 120.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(color: isDark ? Colors.white : Colors.black),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget articleBulider(list , context , {isSearch = false}) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) => ListView.separated(
    itemBuilder: (context , index) => builArticleItem(list[index] , context),
    physics: BouncingScrollPhysics(),
    separatorBuilder: (context , index) =>myDivider(),
    itemCount: 10,
  ),
  fallback: (context) => isSearch ? Container() :Center(child: CircularProgressIndicator()),
);

void navigateTo(context , widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder:(context) => widget,
  ),
);

void navigateAndFinish(context , widget,) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder:(context) => widget,
  ),
    (route)
  {
      return false;
    },
);

void showToast({
  required String text,
  required ToastState state,
}) =>  Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: ChooseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);

enum ToastState {SUCCESS, ERROR , WARNING}

Color ChooseToastColor(ToastState state)
{
  Color color;
  switch(state)
  {
    case ToastState.SUCCESS:
      color =  Colors.green;
      break;
    case ToastState.ERROR:
      color =  Colors.red;
      break;
    case ToastState.WARNING:
      color =  Colors.amber;
      break;
  }
  return color;

}

Widget buildListProduct(
    model ,
    context ,
    {
      isOldPrice = true,
    }) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image : NetworkImage(model.image),
              width: 120.0,
              height: 120.0,
            ),
            if(model.discount != 0 && isOldPrice)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 5.0,),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 8.0,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      model.price.toString(),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: defaultColor,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    if(model.discount != 0 && isOldPrice)
                      Text(
                        model.oldPrice.toString(),
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      onPressed: ()
                      {
                        ShopCubit.get(context).changeFavorites(model.id);
                      },
                      icon: CircleAvatar(
                        radius:15.0,
                        backgroundColor:
                        ShopCubit.get(context).favorites[model.id]!
                            ? defaultColor
                            : Colors.grey ,
                        child: Icon(
                          Icons.favorite_border,
                          size: 14.0,
                          color: Colors.white,
                        ),
                      ) ,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);