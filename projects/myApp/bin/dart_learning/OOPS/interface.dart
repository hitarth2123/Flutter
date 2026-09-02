//interfaces in dart
class Printer{
  void printDocument(){}
}
class HpPrinter implements Printer{
  @override
  void printDocument(){
    print("Printing document from HP printer");
  }
}
void main(){
  HpPrinter hp = HpPrinter();
  hp.printDocument();
}