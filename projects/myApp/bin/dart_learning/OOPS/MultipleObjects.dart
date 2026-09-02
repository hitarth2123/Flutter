class Car{
  String brand="";
  String model="";
  void showDetails(){
    print("$brand: $model");
  }
}
void main(){
  Car c1 =Car();
  c1.brand="Land Rover";
  c1.model="Defender";
  Car c2 =Car();
  c2.brand="BMW";
  c2.model="X7";
  c1.showDetails();
  c2.showDetails();
}