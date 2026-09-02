import 'dart:io';

void main(){
    // Number is odd or even
    // int a=20;
    // if(a%2==0){
    //     print("$a is an Even number");
    // }
    // else{
    //     print("$a is an Odd number");
    // }

    //find the laregest of two number
    // int a = 20;
    // int b = 30;
    // if(a>b){
    //     print("$a is greater than $b");
    // }
    // else{
    //     print("$b is greater than $a");
    // }

    //Find the largest of three numbers
    // int a = 20;
    // int b = 30;
    // int c = 10;
    // if(a>b && a>c){
    //     print("$a is the largest number");
    // }
    // else if(b>a && b>c){
    //     print("$b is the largest number");
    // }
    // else{
    //     print("$c is the largest number");
    // }

    //Grade calculation
    stdout.write("Enter your marks: ");
    int? marks = int.parse(stdin.readLineSync()!);
    if(marks>=90){
        print("A Grade");
    }
    else if(marks>=80){
        print("B Grade");
    }
    else if (marks>=70){
        print("C Grade");
    }
    else if(marks>=60){
        print("D Grade");
    }
    else{
        print("Fail");
    }


}
