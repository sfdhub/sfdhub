#include "SupplyOrder.h"

using namespace WarehouseApp;

SupplyOrder::SupplyOrder(int orderNumber) : orderNumber(orderNumber) {
    fruits = gcnew List<String^>();
}

int SupplyOrder::OrderNumber::get() {
    return orderNumber;
}

void SupplyOrder::OrderNumber::set(int value) {
    if (value <= 0) {
        throw gcnew ArgumentException("Order number must be positive");
    }
    orderNumber = value;
}

List<String^>^ SupplyOrder::Fruits::get() {
    return fruits;
}

void SupplyOrder::AddFruit(String^ fruit) {
    fruits->Add(fruit);
}
