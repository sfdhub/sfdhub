#pragma once

#include <vector>
#include "ProductOrder.h"

using namespace System;
using namespace System::Collections::Generic;

namespace FoodStoreApp {
    public ref class Order {
    private:
        int orderNumber;
        List<ProductOrder^>^ productOrders;

    public:
        Order();

        property int OrderNumber {
            int get();
            void set(int value);
        }

        property List<ProductOrder^>^ ProductOrders {
            List<ProductOrder^>^ get();
        }

        void AddProductOrder(ProductOrder^ productOrder);
    };
}
