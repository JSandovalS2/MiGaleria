import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'PhotoUpload.dart';
import 'posts.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<Posts> postList = [];

  @override
  void initState() {
    super.initState();
    //aqui hace referencia para postear la imagen
    DatabaseReference postsRef = FirebaseDatabase.instance.reference().child("Posts");
    //toma captura de datos
    postsRef.once().then((DataSnapshot snap){
      var keys = snap.value.keys;
      var data = snap.value;

      postList.clear(); //limpia la lista

      for(var individualKey in keys){  //se encarga de juntar todos los datos que se enviaran a la bd
        Posts posts = Posts (
          data[individualKey]['image'],
          data[individualKey]['description'],
          data[individualKey]['date'],
          data[individualKey]['time']
        );
        postList.add(posts);
      }
      setState(() {
        print('Lenght: $postList.lenght');
      });



    },);
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Inicio"),
      ),
      body: new Container(//posts
          child: postList.length == 0 ? Text("No hay imagenes que mostrar :c "
              "Presiona el boton inferior y sube alguna :3") : //si no hay nada en la bd muestra este mensaje
              ListView.builder(
                itemCount: postList.length,
                itemBuilder: (_,index){
                  return postsUI(
                    postList[index].image,
                    postList[index].description,
                    postList[index].date,
                    postList[index].time,
                  );

                },
              ),
      ),

      bottomNavigationBar: new BottomAppBar(
        color: Colors.blueAccent, //color de la barra de navegacion inferior
        child: new Container(
          margin: const EdgeInsets.only(
              left: 50.0, right: 50.0), //margenes del boton de barra inferior
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[

              new IconButton //primer boton
                  (
                icon: new Icon(Icons.home),
                iconSize: 35,
                color: Colors.black,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){return HomePage();}));
                }
              ),


              new IconButton //boton de subida de archivos
                  (
                  icon: new Icon(Icons.add_a_photo),
                  iconSize: 35,
                  color: Colors.black,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PhotoUpload();
                    }));
                  }),

            ],
          ),
        ),
      ),
    );
  }
  Widget postsUI(String image, String description, String date, String time){
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.all(14.0),
      child: Container(
          padding: EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:<Widget>[
                  Text(
                      date,
                      style: Theme.of(context).textTheme.subtitle,
                      textAlign: TextAlign.center,
                  ),
                  Text(
                      time,
                      style: Theme.of(context).textTheme.subtitle,
                      textAlign: TextAlign.center,
                  ),

                ],
              ),
              SizedBox(height: 10.0,),
              Image.network(
                image,
                fit: BoxFit.cover
              ),

              SizedBox(height: 10.0,),

              Text(
                description,
                style: Theme.of(context).textTheme.subhead,
                textAlign: TextAlign.center,
              ),

            ],
          ),
      )
    );
  }
}
