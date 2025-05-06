import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_editor_pro/model/appmodels.dart';
import 'package:image_editor_pro/service/funtions.dart';
import 'package:image_editor_pro/view/edit.dart';

class HistoryPage extends StatefulWidget {
  final bool islight;
  const HistoryPage({ required this.islight,super.key,});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  
  Color bg=Colors.black;
  Color txi = Colors.white;
  bool? islight;
  void check(){
    if(islight==false){
        bg=Colors.black;
        txi = Colors.white;
    }else{
       txi=Colors.black;
       bg= Colors.white;
    }
  }
  @override
  void initState() {
    getresult();
    islight = widget.islight;
    check();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        iconTheme: IconThemeData(color: txi),
        title: Text("History",style: TextStyle(color: txi,)),
      ),
      body: ValueListenableBuilder<List<Appmodels>>(valueListenable: editList, builder: (context, value, child) {
        return ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) {
            final item=value[index];
          return ListTile(
            leading: Image.memory(item.image!,width: 100,height: 150,fit: BoxFit.cover),
            title: Text(item.date!,style: TextStyle(color: txi),),
            subtitle: Text(item.time!,style: TextStyle(color: txi)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditPage(byteImage: item.image,islight: islight,),));
                }, icon: Icon(Icons.edit,color: txi)),
                Gap(2),
                IconButton(onPressed: (){delete(index);}, icon: Icon(Icons.delete,color: txi)),
                
                
              ],
            ),
          );
        },);
      },),
    );
  }
}