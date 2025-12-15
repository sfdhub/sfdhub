#pragma once

using namespace System;
using namespace System::Collections::Generic;

namespace WarehouseApp {
    public ref class SupplyOrder {
    private:
        int orderNumber;
        List<String^>^ fruits;

    public:
        SupplyOrder(int orderNumber);

        property int OrderNumber {
            int get();
            void set(int value);
        }

        property List<String^>^ Fruits {
            List<String^>^ get();
        }

        void AddFruit(String^ fruit);
    };
}
