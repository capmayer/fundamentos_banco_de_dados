import openpyxl as op
import re

wb = op.load_workbook('atlas.xlsx')
ws = wb.active

cargas = open('cargas.sql', 'w+')


r = 0
for row in ws.iter_rows():
    line = "insert into atlas_desnormalizado values ("
    if (r != 0): #pula primeira linha do xlsx
        for col in row:
            if re.match("^\d+?\.\d+?$", str(col.value)) is not None:
                line += str(col.value) + ", "
            elif re.match("^\d+?$", str(col.value)) is not None:
                line += str(col.value) + ", "
            else:
                if(col.value is None):
                    line += "NULL, "
                else:
                    line += "'" + str(col.value) + "', "

        line = line[:-2]
        line += "); \n"
        if (r <= 500):
            cargas.writelines(line);
    r += 1



cargas.close()
