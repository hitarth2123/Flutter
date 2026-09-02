import "dart:io";
void main(){
    //calutar using switch case
    // stdout.write("Enter your first number: ");
    // int? a = int.parse(stdin.readLineSync()!);
    // stdout.write("Enter your second number: ");
    // int? b = int.parse(stdin.readLineSync()!);
    // stdout.write("Enter your operation (+,-,*,/): ");
    // String? operation = stdin.readLineSync();
    // switch(operation){
    //     case "+":
    //         print(a+b);
    //         break;
    //     case "-":
    //         print(a-b);
    //         break;
    //     case "*":
    //         print(a*b);
    //         break;
    //     case "/":
    //         print(a/b);
    //         break;  
    //     default:
    //         print("Invalid operation");
    // }

    //Identify day of the week using switch case
    stdout.write("Enter a number (1-7) to identify the day of the week: ");
    int? day = int.parse(stdin.readLineSync()!);
    switch(day){
        case 1:
            print("Monday");
            break;
        case 2:
            print("Tuesday");
            break;
        case 3:
            print("Wednesday");
            break;
        case 4:
            print("Thursday");
            break;
        case 5:
            print("Friday");
            break;
        case 6:
            print("Saturday");
            break;
        case 7:
            print("Sunday");
            break;
        default:
            print("Invalid day");
    }
}