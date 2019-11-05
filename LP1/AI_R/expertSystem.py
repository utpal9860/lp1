import csv

fileReader = []

with open('expertsys.csv') as csvfile:
	reader = csv.reader(csvfile)
	count = 0
	for row in reader:
		if count==0:
			count += 1
			continue
		else:
			fileReader.append(list(row))
			count += 1

print "For all the following symptoms mention 0/1 \n\t 0:Absence \n\t 1:Presence\n"

userStatus = []

a = raw_input('Fever ')
userStatus.append(a)

a = raw_input('Sore Throat ')
userStatus.append(a)

a = raw_input('Body Rash ')
userStatus.append(a)

a = raw_input('Tiredness ')
userStatus.append(a)

a = raw_input('Joint Pain ')
userStatus.append(a)

a = raw_input('Muscle Pain ')
userStatus.append(a)

a = raw_input('weight loss ')
userStatus.append(a)

a = raw_input('Loss of Appetite ')
userStatus.append(a)

a = raw_input('recurrent infections ')
userStatus.append(a)

a = raw_input('Abdominal Pain ')
userStatus.append(a)

a = raw_input('Yellowing of Skin ')
userStatus.append(a)

a = raw_input('grey-coloured poo ')
userStatus.append(a)

a = raw_input('dark urine ')
userStatus.append(a)

a = raw_input('runny or blocked nose ')
userStatus.append(a)

a = raw_input('cough ')
userStatus.append(a)

a = raw_input('headache ')
userStatus.append(a)

a = raw_input('chills ')
userStatus.append(a)

a = raw_input('vomiting ')
userStatus.append(a)

a = raw_input('Feeling Thirsty ')
userStatus.append(a)

a = raw_input('blurred vision ')
userStatus.append(a)

a = raw_input('rapid heartbeat ')
userStatus.append(a)

a = raw_input('difficulty breathing ')
userStatus.append(a)

a = raw_input('spotty red rash ')
userStatus.append(a)

a = raw_input('persistent headaches ')
userStatus.append(a)

a = raw_input('seizures (fits) ')
userStatus.append(a)

a = raw_input('behavioural changes ')
userStatus.append(a)

a = raw_input('feeling drowsy ')
userStatus.append(a)

a = raw_input('breathless to eat or speak ')
userStatus.append(a)

a = raw_input('fatigue ')
userStatus.append(a)



ResultPercentList = []

count = 0

for row in fileReader:
	Sum = 0
	totalSum = 0
	for i in range(len(row)-2):
		totalSum += (int(row[i+2])*4 +1)
		if row[i+2]==userStatus[i]:
			Sum += (int(row[i+2])*4 +1)
	res = float(Sum)/totalSum
	ResultPercentList.append(res*100)
	if res>0.6:				# to count disease of chances more than 80 percent
		count += 1

#print ResultPercentList   

if count>0:
	print "\n\n\tYou have high risk of "
	for i in range(len(ResultPercentList)):
		if ResultPercentList[i]>60:
			print "\t\t-"
			print fileReader[i][1]  #prints disease name from dataset
else:
	print "\n\n\tYou do not have high risk of any disease."
	

