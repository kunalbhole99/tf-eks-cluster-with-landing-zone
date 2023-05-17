import csv
 
# opening the CSV file
with open('Data.csv', mode ='r') as file:
   
    # reading the CSV file
    csvFile = csv.reader(file)

    f = open("vpc.auto.tfvars", "w")
    # displaying the contents of the CSV file
    for lines in csvFile:
        if(lines[1] == "null" or lines[1] == "true" or lines[1] == "false"):
            print(f'{lines[0]} = {lines[1]}')
            temp = f'{lines[0]} = {lines[1]}'
        else:
            print(f'{lines[0]} = "{lines[1]}"')
            temp = f'{lines[0]} = "{lines[1]}"'
        
        f.write(f"{temp}\n")
    f.close()