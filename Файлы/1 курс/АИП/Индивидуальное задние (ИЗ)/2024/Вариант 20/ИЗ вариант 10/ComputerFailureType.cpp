#include "ComputerFailureType.h"

using namespace SecurityApp;

ComputerFailureType::ComputerFailureType(String^ failureType) : failureType(failureType) {}

String^ ComputerFailureType::FailureType::get() {
    return failureType;
}

void ComputerFailureType::FailureType::set(String^ value) {
    if (String::IsNullOrEmpty(value)) {
        throw gcnew ArgumentException("Failure type cannot be empty");
    }
    failureType = value;
}