#include "Warehouse.h"

using namespace WarehouseApp;

Warehouse::Warehouse(String^ name) : name(name) {
    fruits = gcnew List<String^>();
}

String^ Warehouse::Name::get() {
    return name;
}

void Warehouse::Name::set(String^ value) {
    if (String::IsNullOrEmpty(value)) {
        throw gcnew ArgumentException("Name cannot be empty");
    }
    name = value;
}

List<String^>^ Warehouse::Fruits::get() {
    return fruits;
}

void Warehouse::AddFruit(String^ fruit) {
    fruits->Add(fruit);
}
