#include "Order.h"

using namespace FoodStoreApp;

Order::Order() {
    productOrders = gcnew List<ProductOrder^>();
}

int Order::OrderNumber::get() {
    return orderNumber;
}

void Order::OrderNumber::set(int value) {
    if (value <= 0) {
        throw gcnew ArgumentException("Поле товар не может быть пустым");
    }
    orderNumber = value;
}

List<ProductOrder^>^ Order::ProductOrders::get() {
    return productOrders;
}

void Order::AddProductOrder(ProductOrder^ productOrder) {
    productOrders->Add(productOrder);
}
