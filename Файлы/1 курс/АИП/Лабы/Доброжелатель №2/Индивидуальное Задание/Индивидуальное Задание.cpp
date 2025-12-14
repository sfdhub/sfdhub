
#include <iostream>
#include <fstream>
#include <string>
#include <cstring>
#include <ctime>

using namespace std;

struct Clients {
    char name[100];
    char phone[20];
    string startdg;
    string enddg;
    string dolg;
    string cred;
};

struct Information {
    char phone[50];
    char number_serv[50];
    char date[50];
    char time_used[50];
};

struct Services {
    char service[200];
    char code[10];
    char cost[10];
    char type_of_time[10];
};

struct Params {
    char name[100];
    char phone[20];
    char numberserv[10];
    char date[20];
    char service[200];
};

int lenf(const string& filename) {
    int linecount = 0;
    string line;
    ifstream file(filename);

    while (getline(file, line)) {
        linecount++;
    }

    return linecount;
}


int main() {
    system("chcp 1251");
    string inf;
    int i, j, len_s;

    ifstream clients("clients.txt");
    Clients* names;
    len_s = sizeof(Clients);
    names = (Clients*)calloc(lenf("clients.txt"), len_s);

    if (!(clients.is_open())) {
        cout << "Ошибка открытия файла clients.txt!!!" << endl;
        return -1;
    }
    else {
        for (i = 0; i < lenf("clients.txt"); i++) {
            getline(clients, inf, ',');
            strcpy_s(names[i].name, inf.c_str());
            getline(clients, inf, ',');
            strcpy_s(names[i].phone, inf.c_str());
            getline(clients, inf);
        }
    }

    ifstream usedf("inf.txt");
    Information* used;
    len_s = sizeof(Information);
    used = (Information*)calloc(lenf("inf.txt"), len_s);

    if (!(usedf.is_open())) {
        cout << "Ошибка открытия файла inf.txt!!!" << endl;
        return -1;
    }
    else {
        for (i = 0; i < lenf("inf.txt"); i++) {
            getline(usedf, inf, ',');
            strcpy_s(used[i].phone, inf.c_str());
            getline(usedf, inf, ',');
            strcpy_s(used[i].number_serv, inf.c_str());
            getline(usedf, inf, ' ');
            getline(usedf, inf, ',');
            strcpy_s(used[i].date, inf.c_str());
            getline(usedf, inf);
        }
    }

    ifstream serv("serv.txt");
    Services* numserv;
    len_s = sizeof(Services);
    numserv = (Services*)calloc(lenf("serv.txt"), len_s);

    if (!(serv.is_open())) {
        cout << "Ошибка открытия файла serv.txt!!!" << endl;
        return -1;
    }
    else {
        for (i = 0; i < lenf("serv.txt"); i++) {
            getline(serv, inf, ',');
            strcpy_s(numserv[i].service, inf.c_str());
            getline(serv, inf, ',');
            strcpy_s(numserv[i].code, inf.c_str());
            getline(serv, inf);
        }
    }

    ifstream parms("parms.txt");
    ofstream result("result.txt");


    if (!(parms.is_open())) {
        cout << "Ошибка открытия файла parms.txt!!!" << endl;
        return -1;
    }
    else {
        time_t now = time(nullptr);
        tm currentTime;
        localtime_s(&currentTime, &now);
        int currentMonth = currentTime.tm_mon;

        Params* ans;
        len_s = sizeof(Params);
        ans = (Params*)calloc(lenf("parms.txt"), len_s);

        for (j = 0; j < lenf("parms.txt"); j++) {
            getline(parms, inf);

            for (i = 0; i < lenf("clients.txt"); i++) {
                if (strcmp(inf.c_str(), names[i].name) == 0) {
                    strcpy_s(ans[j].phone, names[i].phone);
                    strcpy_s(ans[j].name, names[i].name);
                }
            }

            bool found = false;
            for (i = 0; i < lenf("inf.txt"); i++) {
                if (strcmp(ans[j].phone, used[i].phone) == 0) {
                    found = true;
                    if (strcmp(used[i].date, "00:00:00") >= 0 && strcmp(used[i].date, "06:00:00") <= 0) {
                        strcpy_s(ans[j].date, used[i].date);
                        strcpy_s(ans[j].numberserv, used[i].number_serv);
                    }
                }
            }

            
                if (found) {
                    bool isWithinMonth = false;
                    if (ans[j].date[0] != '\0') {
                        int usedMonth = stoi(string(ans[j].date).substr(5, 2));
                        if (usedMonth != currentMonth) {
                            isWithinMonth = true;
                        }
                    }

                    if (isWithinMonth) {
                        for (i = 0; i < lenf("serv.txt"); i++) {
                            if (strcmp(ans[j].numberserv, numserv[i].code) == 0) {
                                strcpy_s(ans[j].service, numserv[i].service);
                            }
                        }
                        result << ans[j].service << " " << ans[j].date << " " << ans[j].name << "\n";
                    }
                }
        }
        result.close(); // Закрыть файл после использования

        if (!result.is_open()) {
            cout << "Данные успешно записаны в файл result.txt" << endl;
        }
        else {
            cout << "Ошибка записи в файл result.txt!!!" << endl;
            return -1;
        }
    }

    clients.close();
    serv.close();
    usedf.close();
    parms.close();

    return 0;
}