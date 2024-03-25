import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:localcloudlink/boxes/boxes.dart';
import 'package:localcloudlink/models/notes_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local CLoud Link"),
      ),
      body:ValueListenableBuilder<Box<NoteModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context,box,_){
          var data = box.values.toList().cast<NoteModel>();
          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context,index){
              return Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(data[index].title.toString()),
                          Spacer(),
                          Icon(Icons.edit),
                          Icon(Icons.delete, color: Colors.red)

                        ],
                      ),

                      Text(data[index].description.toString())
                    ],
                  ),
                ),
              );
            }

          );
        }
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async{

          // var box = await Hive.openBox("sawan");
          // var box2 = await Hive.openBox('vishal');
          // box2.put('name','vishal');
          // box2.put('father name','suresh dodiya');
          // box.put('name','sawan dodiya');
          // box.put('age',23);
          // box.put('details',{
          //   'name':'sawan dodiya',
          //   'father name': 'suresh dodiya',
          //   'mother name' : 'mamata dodiya',
          // });
          //
          // print(box.get('name'));
          // print(box.get('age'));
          // print(box.get('details')['father name']);


          _showMyDilog();


        },
        child: Icon(Icons.add),
      ),


    );
  }
  Future<void> _showMyDilog() async
  {
    return showDialog(
      context:context,
      builder:(context)
        {
          return AlertDialog(
            title: Text('Add Notes'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: 'Enter title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Enter description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Cancel')),

              TextButton(onPressed: (){
                final data = NoteModel(title: titleController.text, description:descriptionController.text);
                final box = Boxes.getData();
                box.add(data);

                // data.save();
                // print(box);
                titleController.clear();
                descriptionController.clear();

                Navigator.pop(context);
              }, child: Text('Add'))
            ],
          );
        }
    );
  }
}
