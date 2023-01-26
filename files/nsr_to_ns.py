def firstLetter(string):
    if string != "":
        return string[0].upper()
    else:
        return ""


file_raw = open("nasdaq_screener_raw.csv", "r")
file = open("nasdaq_screener.csv", "w")

isData = False
for line in file_raw:
    if isData:
        isWordExist = False
        wordIndex = 0
        symbol = line.split(',')[0]
        nameList = line.split(',')[1].split(' ')

        for word in ["Inc.", "inc.", "Incorporated", "Corporation"]:
            if word in nameList:
                isWordExist = True
                wordIndex = nameList.index(word)

        if isWordExist:
            if wordIndex < 3:
                name = " ".join(nameList[0:wordIndex])
            else:
                name = "".join(list(map(firstLetter, nameList[0:wordIndex])))
        else:
            name = nameList[0]

        file.write(symbol+','+name+'\n')

    else:
        isData = True
