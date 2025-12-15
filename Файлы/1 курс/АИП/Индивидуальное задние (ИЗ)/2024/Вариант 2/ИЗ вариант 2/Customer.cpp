#include "Customer.h"

using namespace BookStoreApp;

Customer::Customer(String^ name, int id, double discount) : name(name), id(id), discount(discount) {
    order = gcnew BookStoreApp::Order();
}

String^ Customer::Name::get() {
    return name;
}

void Customer::Name::set(String^ value) {
    if (String::IsNullOrEmpty(value)) {
        throw gcnew ArgumentException("»м€ не может быть пустым");
    }
    name = value;
}

int Customer::Id::get() {
    return id;
}

void Customer::Id::set(int value) {
    if (value <= 0) {
        throw gcnew ArgumentException("ID должно быть положительным");
    }
    id = value;
}

double Customer::Discount::get() {
    return discount;
}

void Customer::Discount::set(double value) {
    if (value < 0 || value > 100) {
        throw gcnew ArgumentException("«начение скидки должно находитс€ в значении от 0 до 100");
    }
    discount = value;
}

BookStoreApp::Order^ Customer::Order::get() {
    return order;
}
