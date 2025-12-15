#include "Customer.h"

using namespace TaxiApp;

Customer::Customer(String^ name, double discount) : name(name), discount(discount) {
    order = gcnew TaxiApp::Order();
}

String^ Customer::Name::get() {
    return name;
}

void Customer::Name::set(String^ value) {
    if (String::IsNullOrEmpty(value)) {
        throw gcnew ArgumentException("Name cannot be empty");
    }
    name = value;
}

double Customer::Discount::get() {
    return discount;
}

void Customer::Discount::set(double value) {
    if (value < 0 || value > 100) {
        throw gcnew ArgumentException("Discount must be between 0 and 100");
    }
    discount = value;
}

TaxiApp::Order^ Customer::Order::get() {
    return order;
}
