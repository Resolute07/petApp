import 'package:flutter/material.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key, this.ownername, this.contactnumber});
  final String? ownername;
  final int? contactnumber;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
                
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset("assets/images/profilePicture.jpg"),
              ),
            ),
            const SizedBox(width: 10),
           
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ownername ?? 'Unknown Owner', style: const TextStyle(fontWeight: FontWeight.bold)),
                const Text("Pet Owner"),
              ],
            ),
            const Spacer(),
         
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.phone),
            ),
           
            CircleAvatar(
              backgroundColor: Colors.blue,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.message),
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
