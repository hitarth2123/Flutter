// Types of Contructor
// 1. Default Constructor
// 2. Parameterized Constructor
// 3. Named Constructor
// 4. Constant Constructor



// Parameterized Constructor
// class Student{
//   String name;
//   int age;

//   Student(this.name, this.age);

//   void display(){
//     print("Name : $name");
//     print("Age : $age");
//   }
// }

// void main(){
//   Student s = Student("Tillu", 20);
//   s.display();
// }



// Named Constructor
// class Employee{
//   String? name;

// Employee.manager(){
//   name = "Manager";
// }
// }
// void main(){
//   Employee e = Employee.manager();
//   print("Employee Name : ${e.name}");
// }



//constant constructor
// class Student{
//   final String name;
//   final int age;

//   const Student(this.name, this.age);

//   void display(){
//     print("Name : $name");
//     print("Age : $age");
//   }
// }

// void main(){
//   const Student s = Student("Tillu", 20);
//   s.display();
// }