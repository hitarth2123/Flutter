import 'dart:io';

// optional positional parameters
// void displayStudent(String name,[String? course]){
//     print("Student name: $name");
//     print("Student course: ${course ?? "Not Available"}");
// }

//required named parameters
// void employeeDetails({required String name, required int age}){
//     print("Employee name: $name");
//     print("Employee age: $age");
// }


//for greetins
// void greet(String name, {String city ="Mumbai"}){
//    print("Hello $name from $city");
// }


//Largrest Number Arrow fucntion
void largestNumber(int a, int b) => print("Largest number is: ${a>b ? a : b}");

void main(){
// optional positional parameters
// stdout.write("Enter your name: ");
// String? name = stdin.readLineSync();
// stdout.write("Enter your course: ");
// String? course = stdin.readLineSync();
// displayStudent(name!);
// print("-------------");
// displayStudent(name,course);

//required named parameters
    // stdout.write("Enter your name: ");
    // String? name = stdin.readLineSync();
    // stdout.write("Enter your age: ");
    // int? age = int.parse(stdin.readLineSync()!);
    // employeeDetails(name: name!, age: age);


//For greeting 
    // stdout.write("Enter your name: ");
    // String? name = stdin.readLineSync();
    // greet(name!,city);
    // stdout.write("Enter your city: ");
    // String? city = stdin.readLineSync();
    // greet(name!, city);

//Largest Number Arrow function
    stdout.write("Enter first number: ");
    int? a = int.parse(stdin.readLineSync()!);
    stdout.write("Enter second number: ");
    int? b = int.parse(stdin.readLineSync()!);
    largestNumber(a, b);

}