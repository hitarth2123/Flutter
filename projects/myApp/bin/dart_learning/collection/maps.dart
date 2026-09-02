void main(){

    //create a map of person details
    Map<String, String> studentMarks = {
        "John": "85",
        "Alice": "90",
        "Bob": "78"
    };
    print("Student Marks:");

    //accessing values in a map
    print("John's mark: ${studentMarks["John"]}");
    print("Alice's mark: ${studentMarks["Alice"]}");
    print("Bob's mark: ${studentMarks["Bob"]}");

    //add and update values
    studentMarks["Rohan"] = "88";
    print("Rohan's mark: ${studentMarks["Rohan"]}");
    studentMarks["Alice"] = "95";
    print("Updated Alice's mark: ${studentMarks["Alice"]}");

    //iterate through a map
    print("Student Marks:");
    studentMarks.forEach((name, mark) {
        print("$name: $mark");
    });

}