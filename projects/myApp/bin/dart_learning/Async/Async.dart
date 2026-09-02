//Future with then() and string
// Future<String> getData(){
//   return Future.delayed(Duration(seconds: 2),()=>"Data received");
// }
// void main(){
//   print("start");
//   getData().then((data){print(data);});
//   print("End");
// }

//Future with multiple then()
// Future<int> getNumber(){
//   return Future.value(10);
// }
// void main(){
//   print("start");
//   getNumber().then((value){return value *2;}).then((value){print(value);});
//   print("end");
// }


//Future with async 
// Future<String> getData() async{
//   return "Hello Dart";
// }
// void main(){
//   getData().then((data){print(data);});
// }

//Future with async and await
//  Future<String> getData(){
//   return Future.delayed(Duration(seconds: 2),()=>"Data received");
// }
// void main() async{
//   print("start");
//   String data = await getData();
//   print(data);
//   print("End");
// }

//Sequential Asynchronous Operations
// Future<String> login() async{
//   return "Logged in";
// }
// Future<String> getProfile() async{
//   return "Profile loaded";
// }
// Future<String>getPosts() async{
//   return "Posts loaded";
// }
// void main() async{
// String loginResult = await login();
// print(loginResult);
// String ProfileResult = await getProfile();
// print(ProfileResult);
// String PostResult = await getPosts();
// print(PostResult);
// }

//Parallel Asynchronous Operations
// Future<String> getUser() async{
//   await Future.delayed(Duration(seconds: 2));
//   return "User Data";
// }
// Future<String> getPosts() async{
//   await Future.delayed(Duration(seconds: 2));
//   return "Post Data";
// }


// void main() async{
//   var userFuture =getUser();
//   var postFture =getPosts();
//   var user =await userFuture;
//   var posts =await postFture;
//   print(user);
//   print(posts);
// }

//Future.wait()
Future<String> getUser() async{
  return "User Data";
}
Future<String> getPosts() async{
  return "Post Data";
}
void main() async{
 List<String> results = await Future.wait([getUser(),getPosts()]);
 print(results);
}
