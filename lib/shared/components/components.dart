import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';

Widget defaultButton({
  double width=double.infinity,
  Color background=Colors.blue ,
  bool isUppercase=true,

  required  VoidCallback  function,
  required String text,
})=> Container(
  height: 40,
  color: background,
  width: width,
  decoration: BoxDecoration(

  ),
  child: MaterialButton(
    onPressed:function,

    child: Text(
      isUppercase?text.toUpperCase():text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
);
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  onSubmit,
  onChange,
  onTap,
  bool isPassword = false,
  required  validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: suffixPressed,
          icon: Icon(
            suffix,
          ),
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );
Widget buildTaskItems(Map model)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      CircleAvatar(
        radius: 40,
        child: Text(
            '${model['time']}'
        ),
      ),
      SizedBox(
        width: 20,
      ),
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${model['title']}',
            style: TextStyle(
              fontSize: 18.0,
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
    ],
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
Widget buildArticleItem(article,context)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        height: 120.0,
        width: 120.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(
                '${article['urlToImage']}',
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
      SizedBox(
        width: 20.0,
      ),
      Expanded(
        child: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${article['title']}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
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
);
Widget articleBuilder(list,context)=>Conditional.single(
  context: context,
  conditionBuilder:(context)=> list.length>0 ,
  widgetBuilder: (context)=>ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context,index)=>buildArticleItem(list[index],context),
    separatorBuilder: (context,index)=>myDivider(),
    itemCount: list.length,
  ),
  fallbackBuilder: (context)=>Center(child: CircularProgressIndicator()),
);