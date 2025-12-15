#pragma once
using namespace System;

namespace AirlineApp {
    public ref class Service {
    private:
        String^ serviceName;

    public:
        Service(String^ serviceName);

        property String^ ServiceName {
            String^ get();
            void set(String^ value);
        }
    };
}
