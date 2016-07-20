#include "FizzBuzz.h"

FizzBuzz::FizzBuzz()
{
}

FizzBuzz::~FizzBuzz()
{
}

std::string FizzBuzz::Execute(int number)
{
    std::string convertedMessage;
    
    if (number <= 0) {
        return convertedMessage;
    }
    
    for (int i=1 ; i<=number ; i++) {
        if (i%15 == 0) {
            convertedMessage += "FizzBuzz";
            
        } else if (i%3 == 0) {
            convertedMessage += "Fizz";
            
        } else if (i%5 == 0) {
            convertedMessage += "Buzz";
            
        } else {
            convertedMessage += std::to_string(i);
        }
        
        convertedMessage += ",";
    }
    
    convertedMessage.erase(convertedMessage.end()-1, convertedMessage.end());
    
    return convertedMessage;
}


