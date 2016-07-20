#include "CppUTest/TestHarness.h"
#include "FizzBuzz.h"

TEST_GROUP(FizzBuzz)
{
  FizzBuzz sut;
  std::string resultStr;    
 
  void setup()
  {
  }
  
  void teardown()
  {
  }
  
};

TEST(FizzBuzz, 整数1を入力すると文字列1を表示する)
{
  resultStr = sut.Execute(1);
  STRCMP_EQUAL(resultStr.c_str(),"1");
}

TEST(FizzBuzz, 整数2を入力すると文字列1と2を表示する)
{
  resultStr = sut.Execute(2);
  STRCMP_EQUAL(resultStr.c_str(),"1,2");
}

TEST(FizzBuzz, 整数3を入力すると文字列1と2とFizzを表示する)
{
  resultStr = sut.Execute(3);
  STRCMP_EQUAL(resultStr.c_str(),"1,2,Fizz");
}

TEST(FizzBuzz, 整数5を入力すると文字列1と2とFizzと4とBuzzを表示する)
{
  resultStr = sut.Execute(5);
  STRCMP_EQUAL(resultStr.c_str(),"1,2,Fizz,4,Buzz");
}

TEST(FizzBuzz, 整数15を入力すると文字列1と2とFizzと4とBuzzと7と8とFizzと10と11とBuzzと13と14とFizzBuzzを表示する)
{
  resultStr = sut.Execute(15);
  STRCMP_EQUAL(resultStr.c_str(),"1,2,Fizz,4,Buzz,Fizz,7,8,Fizz,Buzz,11,Fizz,13,14,FizzBuzz");
}

TEST(FizzBuzz, マイナス1を入力すると何も表示されない)
{
  resultStr = sut.Execute(-1);
  CHECK_EQUAL(resultStr.length(), 0);
}

TEST(FizzBuzz, 数字の0を入力しても何も表示されない)
{
  resultStr = sut.Execute(0);
  CHECK_EQUAL(resultStr.length(), 0);
}
