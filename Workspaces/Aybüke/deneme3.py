rows = []
rows2=[]
f = open("50K.txt")

header = f.readline()
for line in f:
    row = line.replace("\n", "").split("\t")
    rows.append(row)

f.close()

for i in range (1,len(rows)):
    if rows[i][6] != 'NA':
        if float(rows[i][6]) <= 0.05:
            rows2.append(rows[i][:])

f = open("output.txt", "w")

for row in rows2:
    f.write("\t".join((row)))
    f.write("\n")

f.close()