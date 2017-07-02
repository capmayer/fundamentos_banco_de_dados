import openpyxl as op
import re

wb = op.load_workbook('atlas.xlsx')
ws = wb.active

names = open('names.txt', 'w+')



for d in ws.iter_cols():
    if re.match("^\d+?\.\d+?$", str(d[1].value)) is not None:
        names.writelines("`" + d[0].value + "` DOUBLE NULL ,\n")
    elif re.match("^\d+?$", str(d[1].value)) is not None:
        names.writelines("`" + d[0].value + "` INT NULL ,\n")
    else:
        names.writelines("`" + d[0].value + "` VARCHAR(50) NULL ,\n")

names.close()
