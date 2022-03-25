
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:json_test/webview/webview_screen.dart';


Widget buildArticleItem ( article , context)=>InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        Container(

          width: 120.0,

          height: 120.0,

          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10.0),

            image: DecorationImage(

              image: NetworkImage('${article['urlToImage']}'),

              fit: BoxFit.cover ,

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

              children: [

                Expanded(

                  child: Text(

                    '${article['title']}',

                    style: Theme.of(context).textTheme.bodyText1,

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

Widget articleBuilder(list ,context)=>ConditionalBuilder(
  condition: list.length>0,
  builder:(context)=> ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildArticleItem(list[index],context),
    separatorBuilder: (context, index) => myDivider(),
    itemCount: 10,
  ),
  fallback: (context)=> Center(child: CircularProgressIndicator()),
);


Widget myDivider()=>Container(
  height: 1.0,
  color: Colors.grey,
  width: double.infinity,
);





Widget defaultFormField(
    {
      @required TextEditingController controller ,
      @required TextInputType type,
      Function onChange,
      Function onSubmitted,
      String label,
      String hint,
      bool isPassword =false,
      IconData prefix,
      IconData suffix,
      @required Function validate,
      Function suffixPressed,
      double cRadius ,

    }
    )=>TextFormField(
    obscureText: isPassword,
    decoration: InputDecoration(

    hintText: hint,
    labelText:label,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(cRadius),
    ),
    prefixIcon: Icon(prefix),
    suffixIcon: suffix != null ?IconButton(onPressed: suffixPressed, icon: Icon(suffix)):null ,
  ),
  controller: controller,
  keyboardType:type,
  validator: validate ,
);

void navigateTo (context ,widget)=>Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context)=>widget),);