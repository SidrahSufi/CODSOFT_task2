import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:provider/provider.dart';
import 'package:todayqoutes/color.dart';
import 'favourite.dart';
import 'favourite_provider.dart';

class TodaysQuotes extends StatefulWidget {
  const TodaysQuotes({Key? key}) : super(key: key);

  @override
  State<TodaysQuotes> createState() => _TodaysQuotesState();
}

class _TodaysQuotesState extends State<TodaysQuotes> {
  final String quoteURL = "https://favqs.com/api/qotd";
  String? quote;


  Future<void> refreshQuote() async {
    var res = await http.get(Uri.parse(quoteURL));
    final result = jsonDecode(res.body);
    if (kDebugMode) {
      print(result);
    }

    setState(() {
      quote = result['quote']['body'];
    });
  }

  @override
  void initState() {
    super.initState();
    refreshQuote();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoritesProvider>(context);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: darkblue,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quote of The Day',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
              IconButton(onPressed:
                  (){

                final route = MaterialPageRoute(
                    builder: (context)=>favourite());
                Navigator.push(context, route);

              } ,

                  icon: Icon(Icons.favorite, color:Colors.white ,)

              )
            ],
          )
      ),
      body:
          Container(
            width: double.infinity,
           height: double.infinity,
           decoration: BoxDecoration(
             image: DecorationImage(image: AssetImage("images/f_background.png"),fit:BoxFit.cover),

           ),
      child: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            quote == null
                ? CircularProgressIndicator()
                : Text(
              '"' +quote! +'"',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),

            SizedBox(height: 40,),
            // ElevatedButton(
            //   onPressed: () {
            //     refreshQuote();
            //   },
            //   child: Icon(Icons.refresh),
            // ),
            IconButton(onPressed :(){
              provider.toggleFavorite(quote);
            },
                icon: provider.isExist(quote)
                    ? const Icon(Icons.favorite, color: Colors.red,)
                    : const Icon(Icons.favorite_border,color: Colors.white,)

            ),
            // const SizedBox(
            //   height: 10,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ElevatedButton(
                  onPressed: () {
                    refreshQuote();
                  },
                  child: Icon(Icons.refresh),
                ),
                SizedBox(width: 10,),
                ElevatedButton(onPressed: () async
                {
                  await Share.share(quote!);
                },
                  child:
                  Icon(Icons.share),
                ),
              ],
            ),







          ],
        ),

      ),
          )
    );
  }
}