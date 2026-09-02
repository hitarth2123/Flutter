import 'dart:io';

//fucntion without parameters
// void message(){
//     print("Hello World");
// }

//fucntion with parameters with addNumber
// void addnumber(int a, int b){
//     print("The sum of $a and $b is ${a+b}");
// }

//Function with return value
// int multiply(int a, int b){
//     return a*b;
// }

// find square of a number  
// int square(int a){
//     return a*a;
// }

//function with loop
String checkEvenOdd(int a){
    if(a%2==0){
        return "Even";
    }else{
        return "Odd";
    }
}




void main (){

//fucntion without parameters
// message();

//fucntion with parameters
// stdout.write("Enter first number: ");
// int? num1 = int.parse(stdin.readLineSync()!);
// stdout.write("Enter second number: ");
// int? num2 = int.parse(stdin.readLineSync()!);
// addnumber(num1, num2);

//Function with return value
// stdout.write("Enter first number: ");
// int? num1 = int.parse(stdin.readLineSync()!);
// stdout.write("Enter second number: ");
// int? num2 = int.parse(stdin.readLineSync()!);
// int result = multiply(num1, num2);
// print("The product of $num1 and $num2 is $result");


// find square of a number  
// stdout.write("Enter a number: ");
// int? num = int.parse(stdin.readLineSync()!);
// int result = square(num);
// print("The square of $num is $result");

//function with loop
stdout.write("Enter a number: ");
int? num = int.parse(stdin.readLineSync()!);
String result = checkEvenOdd(num);
print("The number $num is $result");
}