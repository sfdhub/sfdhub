#include "ProductOrder.h"

using namespace FoodStoreApp;

ProductOrder::ProductOrder(String^ productTitle) : productTitle(productTitle) {}

String^ ProductOrder::ProductTitle::get() {
    return productTitle;
}

void ProductOrder::ProductTitle::set(String^ value) {
    if (String::IsNullOrEmpty(value)) {
        throw gcnew ArgumentException("Product title cannot be empty");
    }
    productTitle = value;
}
