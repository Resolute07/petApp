import 'package:flutter/material.dart';
import 'package:petapp/screens/details_page.dart';
import 'package:petapp/static_data/data.dart';

class ReadyToAdoptPage extends StatefulWidget {
  const ReadyToAdoptPage({super.key});

  @override
  _ReadyToAdoptPageState createState() => _ReadyToAdoptPageState();
}

class _ReadyToAdoptPageState extends State<ReadyToAdoptPage> {
    int itemsPerPage = 10;
  int currentPage = 1;

 
  int get totalPages => (listOfPetsGeneral.length / itemsPerPage).ceil();
  
  int get currentPageItemCount {
    final remainingItems = listOfPetsGeneral.length - (currentPage - 1) * itemsPerPage;
    return remainingItems < itemsPerPage ? remainingItems : itemsPerPage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: 'Ready to adopt',
          child:  Text("Ready to Adopt",style:  Theme.of(context).textTheme.headlineMedium)),
      ),
      body: Column(
        children: [
          
          Expanded(
            child: ListView.builder(
              itemCount: currentPageItemCount,
              itemBuilder: (context, index) {
          
       
                
                
               

              
                return InkWell(
onTap: (){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return DetailsPage(petModel: listOfPetsGeneral[index+((currentPage-1)*10)]);
  },));
},

                  child: Card(child: Container(padding:const  EdgeInsets.all(8),child: Row(children: [
                          
                          SizedBox(height: 80, width: 80,child: Hero(
                            tag: listOfPetsGeneral[index+((currentPage-1)*10)].id,
                            child: Image.asset(listOfPetsGeneral[index+((currentPage-1)*10)].imageUrl!)),),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(listOfPetsGeneral[index+((currentPage-1)*10)].name!),
                          )
                          
                            ],),),),
                );
              },
            ),
          ),

         
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Showing ${(currentPage*10)-9} - ${(((currentPage)*10)+currentPageItemCount)-10} "),
          
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: currentPage > 1
                    ? () {
                        setState(() {
                          currentPage--;
                        });
                      }
                    : null,
              ),
              
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: currentPage < totalPages
                    ? () {
                        setState(() {
                          currentPage++;
                        });
                      }
                    : null,
              ),
            ],
          ),
         const SizedBox(height: 20,)
        ],
      ),
    );
  }
}
