import numpy as np
import matplotlib.pyplot as plt
import re
import os


WD = open(r'Lab4\WeatherData.txt', 'w', encoding='utf-8')
try:
    WD.write("\t\t\t\tWeather Data\n\t\tFrom Astrakhan\n")
    fileA = open(r'Lab4\AstrakhanNEW.txt', 'r', encoding='utf-8')
    try:
        # This part used to read file backwards
        with open(r"Lab4\AstrakhanNEW.txt", "rb") as file:
            try:
                # -2 specifies how many characters to move.\
                #  Use a negative value to move backward.\
                #  SEEK_END relative to the end of the file.
                file.seek(-2, os.SEEK_END)
                # read(1) - Read the character from the right
                while file.read(1) != b'\n':
                    # Jump 2 characters left from the current character. b’\n’ is the line break character in binary mode
                    file.seek(-2, os.SEEK_CUR)
            except OSError:
                file.seek(0)
            last_line = file.readline().decode()
            # print(last_line)
            WMO = re.search(r'\d{5}\s', last_line)
            WMO = WMO.group(0)
            subline = re.sub(WMO, '', last_line)
            # print(subline)
            WMO = re.search(r'\s[01239]\s[029]$', subline, re.MULTILINE)
            WMO = WMO.group(0)
            subline = re.sub(WMO, '', subline)
            # print(subline)
            subline = (subline.strip()).split()
            EYear = np.array([subline])
            EYear = int(EYear[0, 0])
            # print(EYear)

        smatrix = np.zeros((1, 7))
        i = 0
        tempZ = 0.0
        countZ = 0
        tempL = 0.0
        countL = 0
        tempG = 0.0
        countG = 0
        NoData = str(-99.9)
        ForPlotTL = np.array([0])
        ForPlotYL = np.array([0])
        ForPlotTZ = np.array([0])
        ForPlotYZ = np.array([0])
        # This part can be interpritated as using buffer
        for line in fileA:
            # This part can be interpritated as using both module re and slice
            WMO = re.search(r'\d{5}\s', line)
            WMO = WMO.group(0)
            subline = re.sub(WMO, '', line)
            Eflag = re.search(r'\s[01239]\s[029]$', subline, re.MULTILINE)
            if (Eflag) is not None:
                Eflag = Eflag.group(0)
                subline = re.sub(Eflag, '', subline)
            # print(subline)
            subline = (subline.strip()).split()
            # print(subline)
            matrix = np.array([subline])
            # print(matrix)
            # print(matrix.ndim, matrix.shape, matrix.size)
            # print(matrix[0, 0])
            if (smatrix[0, 0] != 0):
                # print("\n", smatrix)
                matrix = np.vstack((smatrix, matrix))
                smatrix = matrix

                if (((smatrix[i, 1] == '1') or (smatrix[i, 1] == '2') or (smatrix[i, 1] == '12')) and (int(smatrix[i, 0]) == year)):
                    if ((smatrix[i, 4] != NoData)):
                        tempZ += float(smatrix[i, 4])
                        countZ += 1

                if (((smatrix[i, 1] == '6') or (smatrix[i, 1] == '7') or (smatrix[i, 1] == '8')) and (int(smatrix[i, 0]) == year)):
                    # print(smatrix[i, 1], smatrix[i, 4])
                    if ((smatrix[i, 4] != NoData)):
                        tempL += float(smatrix[i, 4])
                        countL += 1

                if ((smatrix[i, 4] != NoData)):
                    tempG += float(smatrix[i, 4])
                    countG += 1

                if ((int(smatrix[i, 0]) > year) and (year < EYear)):
                    # print(year)
                    if (countL != 0):
                        WD.write(f'Here is mean temperature in {year} Summer: ' + str(tempL / countL) + '\n')
                        ForPlotTL = np.hstack([ForPlotTL, int(tempL / countL)])
                        ForPlotYL = np.hstack([ForPlotYL, year])
                        # print(TMEAN_Leto)

                    if (countZ != 0):
                        WD.write(f'Here is mean temperature in {year} Winter: ' + str(tempZ / countZ) + '\n')
                        ForPlotTZ = np.hstack([ForPlotTZ, int(tempZ / countZ)])
                        ForPlotYZ = np.hstack([ForPlotYZ, year])
                        # print(TMEAN_Zima)

                    year += 1
                    tempZ = 0.0
                    countZ = 0
                    tempL = 0.0
                    countL = 0
                i += 1

            if (smatrix[0, 0] == 0):
                smatrix = matrix.copy()
                # print(smatrix)
                year = int(smatrix[0, 0])

                if (((smatrix[i, 1] == '1') or (smatrix[i, 1] == '2') or (smatrix[i, 1] == '12')) and (int(smatrix[i, 0]) == year)):
                    if ((smatrix[i, 4] != NoData)):
                        tempZ += float(smatrix[i, 4])
                        countZ += 1

                if (((smatrix[i, 1] == '6') or (smatrix[i, 1] == '7') or (smatrix[i, 1] == '8')) and (int(smatrix[i, 0]) == year)):
                    # print(smatrix[i, 1], smatrix[i, 4])
                    if ((smatrix[i, 4] != NoData)):
                        tempL += float(smatrix[i, 4])
                        countL += 1

                if ((smatrix[i, 4] != NoData)):
                    tempG += float(smatrix[i, 4])
                    countG += 1
                i += 1

        if (countL != 0):
            WD.write(f'Here is mean temperature in {year} Summer: ' + str(tempL / countL) + '\n')
            ForPlotTL = np.hstack([ForPlotTL, int(tempL / countL)])
            ForPlotYL = np.hstack([ForPlotYL, year])
            # print(TMEAN_Leto)

        if (countZ != 0):
            WD.write(f'Here is mean temperature in {year} Winter: ' + str(tempZ / countZ) + '\n')
            ForPlotTZ = np.hstack([ForPlotTZ, int(tempZ / countZ)])
            ForPlotYZ = np.hstack([ForPlotYZ, year])
            # print(TMEAN_Zima)

        ForPlotTZ = np.delete(ForPlotTZ, [0], None)
        ForPlotYZ = np.delete(ForPlotYZ, [0], None)
        ForPlotTL = np.delete(ForPlotTL, [0], None)
        ForPlotYL = np.delete(ForPlotYL, [0], None)
        # print(ForPlotTL, '\n', ForPlotYL)

        plt.figure('Astrakhan\'s Data', figsize=(10, 6))
        plt.subplot(211)
        plt.plot(ForPlotYL, ForPlotTL, 'r-o', markersize=3)
        plt.title('Astrakhan Summer Period')
        plt.ylabel('Temperature')
        plt.xlabel('Year')
        plt.grid(True)
        plt.subplot(212)
        plt.plot(ForPlotYZ, ForPlotTZ, 'b-o', markersize=3)
        plt.title('Astrakhan Winter Period')
        plt.ylabel('Temperature')
        plt.xlabel('Year')
        plt.grid(True)
        plt.subplots_adjust(top=0.92, bottom=0.08, left=0.10, right=0.95, hspace=0.45, wspace=0.35)

        # PrimerYear = np.array([year])
        # EndYear = np.hstack([PrimerYear, year])
        # print(EndYear)
        # print(smatrix.shape[0], type(smatrix.shape[0]), NoData, type(NoData))
        TMEAN_Astrakhan = tempG / countG

        WD.write("\t\tFrom Moscow\n")
        fileM = open(r'Lab4\MoscowNEW.txt', 'r', encoding='utf-8')
        try:
            # This part used to read file backwards
            with open(r"Lab4\MoscowNEW.txt", "rb") as file:
                try:
                    # -2 specifies how many characters to move.\
                    #  Use a negative value to move backward.\
                    #  SEEK_END relative to the end of the file.
                    file.seek(-2, os.SEEK_END)
                    # read(1) - Read the character from the right
                    while file.read(1) != b'\n':
                        # Jump 2 characters left from the current character. b’\n’ is the line break character in binary mode
                        file.seek(-2, os.SEEK_CUR)
                except OSError:
                    file.seek(0)
                last_line = file.readline().decode()
                # print(last_line)
                WMO = re.search(r'\d{5}\s', last_line)
                WMO = WMO.group(0)
                subline = re.sub(WMO, '', last_line)
                # print(subline)
                WMO = re.search(r'\s[01239]\s[029]$', subline, re.MULTILINE)
                WMO = WMO.group(0)
                subline = re.sub(WMO, '', subline)
                # print(subline)
                subline = (subline.strip()).split()
                EYear = np.array([subline])
                EYear = int(EYear[0, 0])

            smatrixM = np.zeros((1, 7))
            i = 0
            tempZ = 0.0
            countZ = 0
            tempL = 0.0
            countL = 0
            tempG = 0.0
            countG = 0
            NoData = str(-99.9)
            ForPlotTL = np.array([0])
            ForPlotYL = np.array([0])
            ForPlotTZ = np.array([0])
            ForPlotYZ = np.array([0])
            mes = 1
            Amount = 0
            countA = 0
            Amount_Arr = np.array([0])
            disp = 0
            disp_arr = np.array([0])
            arith_mean_arr = np.array([0])
            # print(disp_arr, arith_mean_arr)
            for line in fileM:
                WMOM = re.search(r'\d{5}\s', line)
                WMOM = WMOM.group(0)
                sublineM = re.sub(WMOM, '', line)
                EflagM = re.search(r'\s[01239]\s[029]$', sublineM, re.MULTILINE)
                if (EflagM) is not None:
                    EflagM = EflagM.group(0)
                    # print(sublineM)
                    sublineM = re.sub(EflagM, '', sublineM)
                    # print(sublineM)
                sublineM = (sublineM.strip()).split()
                matrixM = np.array([sublineM])
                # print(matrixM)
                # print(matrixM.ndim, matrixM.shape, matrixM.size)
                # print(matrixM[0, 0])
                if (smatrixM[0, 0] != 0):
                    # print("\n", smatrixM)
                    matrixM = np.vstack((smatrixM, matrixM))
                    smatrixM = matrixM

                    if (((smatrixM[i, 1] == '1') or (smatrixM[i, 1] == '2') or (smatrixM[i, 1] == '12')) and (int(smatrixM[i, 0]) == year)):
                        if ((smatrixM[i, 4] != NoData)):
                            tempZ += float(smatrixM[i, 4])
                            countZ += 1

                    if (((smatrixM[i, 1] == '6') or (smatrixM[i, 1] == '7') or (smatrixM[i, 1] == '8')) and (int(smatrixM[i, 0]) == year)):
                        if ((smatrixM[i, 4] != NoData)):
                            tempL += float(smatrixM[i, 4])
                            countL += 1

                    if ((smatrixM[i, 4] != NoData)):
                        tempG += float(smatrixM[i, 4])
                        countG += 1

                    # Construct for making dispersion in exactly one year from 1 to 12 mounth
                    if ((smatrixM[i, 0] == '2001') and (smatrixM[i, 6] != NoData)):
                        if (int(smatrixM[i, 1]) == mes):
                            Amount += float(smatrixM[i, 6])
                            Amount_Arr = np.hstack([Amount_Arr, float(smatrixM[i, 6])])
                            # Amount_Arr.append(Amount)
                            countA += 1
                        if (int(smatrixM[i, 1]) == (mes + 1)):
                            if (countA != 0):
                                Amount_Arr = np.delete(Amount_Arr, [0], None)
                                arith_mean = (Amount / countA)
                                arith_mean_arr = np.hstack([arith_mean_arr, int(arith_mean)])
                                for m in range(Amount_Arr.shape[0]):
                                    disp += ((Amount_Arr[m] - arith_mean)**2)
                                disp = disp / countA
                                WD.write(f'Dispersion for {mes} mounth in 2001: {disp}\n')
                                disp_arr = np.hstack([disp_arr, int(disp)])
                            Amount = 0
                            countA = 0
                            Amount_Arr = np.array([0])
                            disp = 0
                            mes += 1

                    if ((int(smatrixM[i, 0]) > year) and (year < EYear)):
                        if (countL != 0):
                            WD.write(f'Here is mean temperature in {year} Summer period: ' + str(tempL / countL) + '\n')
                            ForPlotTL = np.hstack([ForPlotTL, int(tempL / countL)])
                            ForPlotYL = np.hstack([ForPlotYL, year])
                        if (countZ != 0):
                            WD.write(f'Here is mean temperature in {year} Winter period: ' + str(tempZ / countZ) + '\n')
                            ForPlotTZ = np.hstack([ForPlotTZ, int(tempZ / countZ)])
                            ForPlotYZ = np.hstack([ForPlotYZ, year])
                        year += 1
                        tempZ = 0.0
                        countZ = 0
                        tempL = 0.0
                        countL = 0
                    i += 1

                if (smatrixM[0, 0] == 0):
                    smatrixM = matrixM.copy()
                    year = int(smatrixM[0, 0])

                    if (((smatrixM[i, 1] == '1') or (smatrixM[i, 1] == '2') or (smatrixM[i, 1] == '12')) and (int(smatrixM[i, 0]) == year)):
                        if ((smatrixM[i, 4] != NoData)):
                            tempZ += float(smatrixM[i, 4])
                            countZ += 1

                    if (((smatrixM[i, 1] == '6') or (smatrixM[i, 1] == '7') or (smatrixM[i, 1] == '8')) and (int(smatrixM[i, 0]) == year)):
                        if ((smatrixM[i, 4] != NoData)):
                            tempL += float(smatrixM[i, 4])
                            countL += 1

                    if ((smatrixM[i, 4] != NoData)):
                        tempG += float(smatrixM[i, 4])
                        countG += 1
                    i += 1

            if (countA != 0):
                Amount_Arr = np.delete(Amount_Arr, [0], None)
                arith_mean = (Amount / countA)
                arith_mean_arr = np.hstack([arith_mean_arr, int(arith_mean)])
                for m in range(Amount_Arr.shape[0]):
                    disp += ((Amount_Arr[m] - arith_mean)**2)
                disp = disp / countA
                WD.write(f'Dispersion for {mes} mounth in 2001: {disp}\n')
                disp_arr = np.hstack([disp_arr, int(disp)])

            if (countL != 0):
                WD.write(f'Here is mean temperature in {year} Summer period: ' + str(tempL / countL) + '\n')
                ForPlotTL = np.hstack([ForPlotTL, int(tempL / countL)])
                ForPlotYL = np.hstack([ForPlotYL, year])

            if (countZ != 0):
                WD.write(f'Here is mean temperature in {year} Winter period: ' + str(tempZ / countZ) + '\n')
                ForPlotTZ = np.hstack([ForPlotTZ, int(tempZ / countZ)])
                ForPlotYZ = np.hstack([ForPlotYZ, year])
            # print(smatrixM)
            ForPlotTZ = np.delete(ForPlotTZ, [0], None)
            ForPlotYZ = np.delete(ForPlotYZ, [0], None)
            ForPlotTL = np.delete(ForPlotTL, [0], None)
            ForPlotYL = np.delete(ForPlotYL, [0], None)
            # print(ForPlotTL, '\n', ForPlotYL)

            plt.figure('Moscow\'s Data', figsize=(10, 6))
            plt.subplot(211)
            plt.plot(ForPlotYL, ForPlotTL, 'r-o', markersize=3)
            plt.title('Moscow Summer Period')
            plt.ylabel('Temperature')
            plt.xlabel('Year')
            plt.grid(True)
            plt.subplot(212)
            plt.plot(ForPlotYZ, ForPlotTZ, 'b-o', markersize=3)
            plt.title('Moscow Winter Period')
            plt.ylabel('Temperature')
            plt.xlabel('Year')
            plt.grid(True)
            plt.subplots_adjust(top=0.92, bottom=0.08, left=0.10, right=0.95, hspace=0.45, wspace=0.35)

            disp_arr = np.delete(disp_arr, [0], None)
            arith_mean_arr = np.delete(arith_mean_arr, [0], None)
            # disp_arr = np.sort(disp_arr)
            # arith_mean_arr = np.sort(arith_mean_arr)

            # print(arith_mean_arr, '\n', disp_arr)

            plt.figure('Moscow\'s total precipitation amount', figsize=(10, 6))
            plt.subplot(211)
            # bins - NUMBER of colums
            plt.hist(arith_mean_arr, bins=(np.amax(arith_mean_arr) * 2), facecolor='y')
            plt.title('Mean precipitation amount')
            plt.ylabel('Precipitation amount')
            plt.xlabel('Precipitation value')

            # plt.grid(True)
            plt.subplot(212)
            plt.hist(disp_arr, bins=(np.amax(disp_arr) * 2), facecolor='g')
            plt.title('Dispersion of precipitation amount')
            plt.ylabel('Dispersion')
            plt.xlabel('Dispersion value')
            # plt.grid(True)
            plt.subplots_adjust(top=0.92, bottom=0.08, left=0.10, right=0.95, hspace=0.45, wspace=0.35)

            plt.show()

            TMEAN_Moscow = tempG / countG
            WD.write('\nHere is year mean temperature between Moscow and Astrakhan: ' + str(TMEAN_Moscow - TMEAN_Astrakhan) + '\n')
        except FileNotFoundError:
            print('File is not found!')
        finally:
            fileM.close
    except FileNotFoundError:
        print('File is not found!')
    finally:
        fileA.close
except FileNotFoundError:
    print('File is not found!')
finally:
    WD.close
