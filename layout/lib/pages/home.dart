import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:layout/pages/detail.dart';
import 'package:http/http.dart' as http; // as เป็นการตั้งชื่อเล่น เวาลาเราใช้เรียกตัวนี้ก็ใช่ชื่อ http ทีี่ตั้งไว้หลัง as ได้เลย
import 'dart:async';

class HomePage extends StatefulWidget {
  //const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แนะนำอนิเมะ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder(builder: (context , AsyncSnapshot snapshot) {  
          //var data = json.decode(snapshot.data.toString());   //snapshot เหมือนเป็นข้อมูลทั้งก้อนที่ส่งมาจาก FutureBuilder คือตัว [{},{},{}]
          return ListView.builder(                     //ListView เหมือนการ repeat ข้อมูลออกมาเป็นชุดๆ
            itemBuilder: (BuildContext context , int index) {
                return mybox(snapshot.data[index]['title'], snapshot.data[index]['subtitle'], snapshot.data[index]['URL_image'],snapshot.data[index]['detail']);
            },
            itemCount: snapshot.data.length ,
            );


        },
        future: getData(),
        //future: DefaultAssetBundle.of(context).loadString('assets/data.json'),//เป็นฟังก์ชั่นพิเศษเหมือนการดึงไฟล์data.jsonมาแล้วโยนไปให้ snapshot
                                                                              
        )  //future เหมือนเป็นการรันคำสั่งหลายอันพร้อมกัน ใครเสร็จก่อนก็ไปแสดงผลก่อน
      ),
      
    );
  }


  Widget mybox(String title,String subtitle,String URL_image,String detail) {
    var v1 , v2 , v3 , v4;
    v1 = title;
    v2 = URL_image;
    v3 = subtitle;
    v4 = detail;
    return Container(
      margin: EdgeInsets.only(top:20,left: 10,right: 10,),
      //color: Colors.pinkAccent,
      height: 150,
      decoration: BoxDecoration(
        //color: Colors.pinkAccent,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: NetworkImage(URL_image),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.615), BlendMode.darken)
        )
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
          SizedBox(height: 15,),
          Text(subtitle,style: TextStyle(fontSize: 20,color: Colors.white),
          ),
          SizedBox(height: 15,),
          TextButton(onPressed: () {
            print('Next Page');
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(v1,v2,v3,v4)));
          }, child: Text('Continue...',style: TextStyle(color: Colors.white70),))
        
        ],
      ),
    );
  }


  Future getData() async {
    //https://raw.githubusercontent.com/kusthanapat/BasicAPI/main/data.json
    var URL = Uri.https('raw.githubusercontent.com', '/kusthanapat/BasicAPI/main/data.json');
    var response = await http.get(URL);         // await เป็นฟังก์ชั่นที่ใช้คู่กับ async
    var result = json.decode(response.body);
    return result;
  }


}




