import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class MylogicController extends GetxController {
  TextEditingController textEditingController = TextEditingController();
  RxString valueToPass = "".obs;
  RxString output = "".obs;
  RxList series = [].obs;
  RxString pattern = "".obs;
  RxList<Map<String, String>> logicList = [
    {
      'Prime number': """String generatePattern(int rows) {
    String pattern = '';
    for (int i = 1; i <= rows; i++) {
      for (int j = 1; j <= i; j++) {
        pattern += '* ';
      }
      pattern += "\\n";
    }
    return pattern;
  }
""",
      'Fibonacci Series': """List<int> generateFibonacciSeries(int n) {
  List<int> fibonacciSeries = [0, 1]; // Initial values

  for (int i = 2; i < n; i++) {
    int nextFibonacci = fibonacciSeries[i - 1] + fibonacciSeries[i - 2];
    fibonacciSeries.add(nextFibonacci);
  }

  return fibonacciSeries;
}

void main() {
  int n = 10; // Number of Fibonacci numbers to generate
  List<int> fibonacciSeries = generateFibonacciSeries(n);

  print('Fibonacci Series of the first n numbers:');
  for (int number in fibonacciSeries) {
    print(number);
  }
}
""",
      'Armstrong Number': """class ArmstrongNumber{    
  public static void main(String[] args)  {    
    int sumOfCube=0,a,temp;    
    int number=153;    
    temp=number;    
    while(number>0)    
    {    
        a=number%10; //Getting last digit  
        number=number/10;  //Removing last digit from number  
        sumOfCube=sumOfCube+(a*a*a); //Calculating sum of cubes of digits    
    }    
    if(temp==sumOfCube)    
        System.out.println(temp+" is an armstrong number");     
    else    
        System.out.println(temp+ "is not an armstrong number");     
   }    
}  
"""
    }
  ].obs;

  List<int> generateFibonacciSeries(int n) {
    List<int> fibonacciSeries = [0, 1]; // Initial values

    for (int i = 2; i < n; i++) {
      int nextFibonacci = fibonacciSeries[i - 1] + fibonacciSeries[i - 2];
      fibonacciSeries.add(nextFibonacci);
    }

    return fibonacciSeries;
  }

  String generatePattern(int rows) {
    String pattern = '';
    for (int i = 1; i <= rows; i++) {
      for (int j = 1; j <= i; j++) {
        pattern += '* ';
      }
      pattern += '\n';
    }
    return pattern;
  }
}
