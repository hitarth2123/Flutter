import 'dart:io';
void main(){
    // print numbers (for loop)
    // for(int i = 1; i <= 10; i++){
    //     print(i);
    // }

    // Multiplication table (for loop)
    // stdout.write("Enter a number: ");
    // int? num = int.parse(stdin.readLineSync()!);
    // for(int i = 1; i <= 10; i++){
    //     print("$num x $i = ${num*i}");
    // }

    // Sum of first n natural numbers (for loop)
    // stdout.write("Enter a number: ");
    // int? num = int.parse(stdin.readLineSync()!);
    // int sum = 0;
    // for(int i = 1; i <= num; i++){
    //     sum += i;
    // }
    // print("Sum of first $num natural numbers is: $sum");
    
    //Print the number till the number (while loop)
    // stdout.write("Enter a number: ");
    // int? num = int.parse(stdin.readLineSync()!);
    // int i = 1;
    // while(i <= num){
    //     print(i);
    //     i++;
    // }
    
    //factorial of a number (while loop)
    stdout.write("Enter a number: ");
    int? num = int.parse(stdin.readLineSync()!);
    int fact = 1;
    int i = 1;
    while(i <= num){
        fact *= i;
        i++;
    }
    print("Factorial of $num is: $fact");
}