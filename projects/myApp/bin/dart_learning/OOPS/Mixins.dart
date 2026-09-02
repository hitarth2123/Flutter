
//Mixin in dart

// mixin Fly{
//   void fly(){
//     print("I can fly");
//   }
// }
// class Bird with Fly{}
// void main(){
//   Bird b = Bird();
//   b.fly();
// }

//Canonical constant Object resuse
// class Student {
//   final String name;
//   final int age;
//   const Student(this.name, this.age);
// }
// void main() {
//   const Student s1 = Student("Tillu", 20);
//   const Student s2 = Student("Tillu", 20);
//   print(identical(s1, s2)); 
// }