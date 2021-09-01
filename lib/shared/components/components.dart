
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildArticalItem(article , context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),fit: BoxFit.cover,
            )
        ),
      ),
      SizedBox(width: 20,),
      Expanded(child: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text('${article['title']}  ' ,
                style: Theme.of(context).textTheme.bodyText1,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text('${article['publishedAt']}' , style: TextStyle(
              color: Colors.grey,
            ),)
          ],
        ),
      ),),
    ],
  ),
);


Widget myDivider() => Padding(
  padding: const EdgeInsets.all(10.0),
  child:   Divider(
    thickness: 1,
  color: Colors.grey[300],
  ),
);


Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: type,
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
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix))
            : null,
      ),
    );

void navigateTo(context , widget) => Navigator.push(context,
    MaterialPageRoute(builder: (context) => widget,
    ));


Widget articleBuilder(list , context , {isSearch=false}) => ConditionalBuilder(condition: list.lenght>0,
    builder: (context )=> ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context , index) =>buildArticalItem(list[index], context),
        separatorBuilder: (context , index) => myDivider(),
        itemCount: 10,),
  fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator(),),

);