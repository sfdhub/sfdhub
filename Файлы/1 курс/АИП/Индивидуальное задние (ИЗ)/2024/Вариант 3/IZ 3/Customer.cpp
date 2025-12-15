#include "Customer.h"

using namespace AirlineApp;

Customer::Customer(String^ name, int id) : name(name), id(id) {
    orders = gcnew List<Order^>();
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

int Customer::Id::get() {
    return id;
}

void Customer::Id::set(int value) {
    if (value <= 0) {
        throw gcnew ArgumentException("ID must be positive");
    }
    id = value;
}

List<Order^>^ Customer::Orders::get() {
    return orders;
}
