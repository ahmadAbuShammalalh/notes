



import 'package:flutter/material.dart';
import 'package:notes/sqldb.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    SqlDb sqlDb =SqlDb();

    Future<List<Map>> readData()async{
      List<Map> response = await sqlDb.readData('SELECT * FROM notes');
      return response ;
    }

    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('HomePage'),
        centerTitle: true,
      ),
      body:  Container(
        width: double.infinity,
        child: ListView(
          children:  [
            FutureBuilder(
                future: readData(),
                builder: (BuildContext context ,AsyncSnapshot<List<Map>> snapshot){
              if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context , i ){
                           return  Card(child: ListTile(
                             title: Text('${snapshot.data![i]['note']}'),
                           ));
                  });
              }
              return const Center(
                child: CircularProgressIndicator()
              );

            })

          ],
        ),
      ),
    );
  }
}
