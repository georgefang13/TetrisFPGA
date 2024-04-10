import csv
path = "C:/Users/lja26/Desktop/tetris/"

with open(path + "colors.csv", "r") as csvFile:
       with open(path + "colors.mem", "w") as memFile:
            for row in csv.reader(csvFile):
                memFile.write(" ".join(row) + "\n")

# with open(path + "image.csv", "r") as csvFile:
#    with open(path + "image.mem", "w") as memFile:
#        for row in csv.reader(csvFile):
#            memFile.write(" ".join(row) + "\n")
