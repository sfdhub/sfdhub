#pragma once
using namespace System;

namespace FoodStoreApp {
    public ref class ProductOrder {
    private:
        String^ productTitle;

    public:
        ProductOrder(String^ productTitle);

        property String^ ProductTitle {
            String^ get();
            void set(String^ value);
        }
    };
}
