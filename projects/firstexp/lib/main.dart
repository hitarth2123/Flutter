// import 'package:flutter/material.dart';
















// user profile with function calling
// void main(){
//   runApp(const MyApp());
// }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       useMaterial3: true,
//       home: const ProfilePage(),
//     );
//   }
// }
// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Student Profile'),
//         centerTitle: true,
//         backgroundColor: const Color.white,
//       ),
//       body: Center(
//         child :Container(
//           wdth: 300,
//           padding: const EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(8.0),
//             boxShadow: [
//               BoxShadow(
//                 blurRadius: 4.0,
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 2.0,
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const CircleAvatar(
//                 radius: 50,
//                 backgroundImage: NetworkImage('https://imgs.search.brave.com/R4t_7cnLKV4aSUBHFpy4hQ_wuEJ9pfsMXIj6QXRP3BI/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9waWNz/YXJ0LmNvbS9sYW5k/aW5ncy1zc3IvX25l/eHQvaW1hZ2UvP3Vy/bD1odHRwczovL2Nk/bi1jbXMtdXBsb2Fk/cy5waWNzYXJ0LmNv/bS9jbXMtdXBsb2Fk/cy9iYTQ2MWM1NS1k/ZmEyLTRmODYtYWI1/Mi0yNjk1NGI2Mzdi/OTIud2VicCZ3PTM4/NDAwJnE9NzU'),
//                 child:Icon(
//                   Icons.person,
//                   size: 50,
//                   color: Colors.white,
//                 ),
//                 )
//               ),

//         )
//       ),
//     );
//   }
// }


//importing the widget and making button 
// void main() => runApp(MaterialApp(
//   home: Scaffold(
//     appBar: AppBar(
//       title: Text('Kya haal chaal'),
//       centerTitle: true,
//       backgroundColor: const Color.fromARGB(255, 0, 234, 70),
//     ),
//     body: Center(
//       child: Text(
//         'This is my First flutter app',
//         style: TextStyle(
//            color: Colors.redAccent,
//            fontSize: 44,
//            letterSpacing: 2,
//            fontWeight: FontWeight(600),
//            fontFamily: 'IndieFlower',
//         ),
//       ),
//     ),
//     floatingActionButton: FloatingActionButton(
//       onPressed: () {},
//       backgroundColor: Colors.pinkAccent,
//       child: Text('Click'),
//   ),
// )));

//using override in the main function
// void main() => runApp(const MaterialApp(home: Home()));

// class Home extends StatelessWidget {
//   const Home();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Het Fellows!!'),
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 0, 234, 70),
//       ),
//       body: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'This is my First flutter app',
//               style: TextStyle(
//                 color: Colors.redAccent,
//                 fontSize: 44,
//                 letterSpacing: 2,
//                 fontWeight: FontWeight(600),
//                 fontFamily: 'IndieFlower',
//               ),
//             ),
//              Text(' hello, how are you?'),
//                 Text(' I am fine, what about you?'),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: const Text('Elevated Button'),
//                 ),
//             const SizedBox(height: 30),
//             TextButton(
//               style: ButtonStyle(
//                 foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
//               ),
//               onPressed: () {},
//               child: const Text('TextButton'),
//             ),
//           ],

//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//                onPressed: () {},
//                backgroundColor: Colors.pinkAccent,
//                child: Text('Click'),
//              ),
//     );
//   }
// }

//user profile page
// void main() => runApp(const MaterialApp(home: Home()));
// class Home extends StatelessWidget {
//   const Home();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Profile'),
//         centerTitle: true,
//         backgroundColor: const Color.fromARGB(255, 0, 234, 70),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               CircleAvatar(
//                 radius: 50,
//                 backgroundImage: AssetImage('https://imgs.search.brave.com/R4t_7cnLKV4aSUBHFpy4hQ_wuEJ9pfsMXIj6QXRP3BI/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9waWNz/YXJ0LmNvbS9sYW5k/aW5ncy1zc3IvX25l/eHQvaW1hZ2UvP3Vy/bD1odHRwczovL2Nk/bi1jbXMtdXBsb2Fk/cy5waWNzYXJ0LmNv/bS9jbXMtdXBsb2Fk/cy9iYTQ2MWM1NS1k/ZmEyLTRmODYtYWI1/Mi0yNjk1NGI2Mzdi/OTIud2VicCZ3PTM4/NDAwJnE9NzU'),
//               ),
//               SizedBox(height: 10),
//               Text(
//                 'Username',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Column(
//                 children: [
//                   Icon(Icons.favorite, color: Colors.red),
//                   Text('Likes'),
//                 ],
//               ),
//               Column(
//                 children: [
//                   Icon(Icons.comment, color: Colors.blue),
//                   Text('Comments'),
//                 ],
//               ),
//               Column(
//                 children: [
//                   Icon(Icons.share, color: Colors.green),
//                   Text('Shares'),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('This is a sample profile page.'),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }






