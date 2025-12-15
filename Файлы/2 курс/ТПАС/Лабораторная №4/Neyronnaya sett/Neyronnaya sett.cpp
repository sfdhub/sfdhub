
#include <iostream>
#include <time.h> 
#include <math.h>
using namespace std;

// Summary value in neuron
float NeuronSum(float input[2], float weights[2], float bweight) {
    float result = 0;
    for (int i = 0; i < 2; i++) {
        result += input[i] * weights[i];
    }
    result += 1.0 * bweight;
    return result;
}
float ActivateFunction(float x) {
    return 1 / (1 + pow(2.72, -x));
}
float ActivateFunctionDerivative(float x) {
    return ActivateFunction(x) * (1 - ActivateFunction(x));
}
// ai result
float aiRes(float input[2], float weights[2], float bweight) {
    return ActivateFunction(NeuronSum(input, weights, bweight));
}

int main() {
    /*-----------Neural network--------------------------------
    -------------STRUCTURE:------------------------------------
    * - input neuron, # - hidden neuron, @ - output neuron
    -----------------------------------------------------------
        *
        *   @
    -----------------------------------------------------------
    */


    srand(time(0));

    float imput[4][2] = { {1,0}, {0,0}, {0,1}, {1,1} };
    float output[4] = { 1,0,0,1 };
    float weights[2];
    float speed = 0.3;
    float error;
    float result;
    float rawResult;
    // bias weight
    float bweight = (float)rand() / (float)(RAND_MAX) * 2 - 1;
    for (int weight = 0; weight < 2; weight++) {
        weights[weight] = (float)rand() / (float)(RAND_MAX) * 2 - 1;
    }

    for (int epoch = 1; epoch <= 2000; epoch++) {
        float gl_error = 0;
        for (int i = 0; i < 4; i++) {
            rawResult = NeuronSum(imput[i], weights, bweight);  
            result = aiRes(imput[i], weights, bweight);
            error = output[i] - result;
            for (int mask = 0; mask < 2; mask++) {
                weights[mask] = weights[mask] + error * ActivateFunctionDerivative(rawResult) * imput[i][mask] * speed;
            }
            bweight = bweight + error * ActivateFunctionDerivative(rawResult) * 1 * speed;
            gl_error += (error * error) / 2;
            printf("error: %f\n", gl_error);

            if (gl_error < 0.001)
            break;
        }
    }
    float test[2] = { 1,0 };
    cout << aiRes(test, weights, bweight) << endl;
    if (aiRes(test, weights, bweight) > 0.5) {
        cout << "I think answer is 1!";
    }
    else {
        cout << "I think answer is 0!";
    }
}