#include "Fruit.h"

using namespace WarehouseApp;

Fruit::Fruit(String^ name) : name(name) {}

String^ Fruit::Name::get() {
    return name;
}

void Fruit::Name::set(String^ value) {
    if (String::IsNullOrEmpty(value)) {
        throw gcnew ArgumentException("Name cannot be empty");
    }
    name = value;
}
