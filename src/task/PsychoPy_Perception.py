from psychopy import *
import random
import os
import csv
# Important!! Parameter set up here:
#intervals = [3,7,14] #testing
intervals = [3,3,3,7,7,7,14,14,14,30,30,30,64,64,64]
def generate_file_name(user_id):
    file_name = "perception_" + str(user_id) + ".csv"
    return file_name
def check_input_integer(input):
    if input == "":
        return False
    for i in input:
        if not i.isdigit():
            return False
    return True
def check_input_float(input):
    if input.count(".") >= 2:
        return False
    if input == "":
        return False
    for i in input:
        if not (i.isdigit() or i == "."):
            return False
    return True
def input_username():
    f = False
    while not f:
        info = {"Net ID":""}
        a = gui.DlgFromDict(info, title='Net ID')
        user_id = info["Net ID"]
        #f = check_input_integer(user_id)
        f = True
        print(f)
    return user_id
random.shuffle(intervals)


user_id = input_username()
file_name = generate_file_name(user_id)
data_path_exists = os.path.exists(file_name)
while data_path_exists:
    warning = gui.Dlg(title="warning")
    warning.addText('Net ID Duplicates')
    warning.show()  # show dialog and wait for OK or Cancel
    if warning.OK:  
        user_id = input_username()
        file_name = generate_file_name(user_id)
        data_path_exists = os.path.exists(file_name)
    else:
        warning2 = gui.Dlg(title="warning")
        warning2.addText('If you click ok, previous data will be overwritten')
        warning2.show()
        if warning2.OK:
            data_path_exists = False


#print type(user_name_id)
# Create a stimulus for a certain window
result = []
win = visual.Window([1000,1000], fullscr = True, monitor="testMonitor")
n = 60
line1 = 'Welcome to the experiment'.center(n) + "\n\n"
line2 = 'You will estimate how long the circle has shown up'.center(n)+ "\n"
lines2_2 = 'and type in your estimation as an integer (unit = seconds).'.center(n)+ "\n\n"
line3 = 'Please press [space] key to start the experiment'.center(n)+ "\n"
lines3_2 = 'when you are ready.'.center(n)

lines = line1 + line2 +lines2_2 + line3 + lines3_2 
#print(lines)
b = visual.TextStim(win, lines, alignHoriz='center', alignVert='center',units='norm')
b.wrapWidth = 1.8
b.draw()
win.flip()

keys = event.waitKeys(keyList=["space"])
for i in range(len(intervals)):
    message = visual.TextStim(win, text='Please press [space] key to continue.\n\n' + "Trial Number: " + str(i+1))
    message.wrapWidth = 1.3
    message.draw()
    win.mouseVisible = False
    win.flip()
    
    keys = event.waitKeys(keyList=["space"])
    circle = visual.Circle(win=win,units="pix",radius=100,fillColor=[1, 1, 0],lineColor=[1, 1, 0],edges=32)
    circle.draw()
    win.flip()
    print(intervals[i])
    core.wait(intervals[i])
    message = visual.TextStim(win, text="\n\n\nPlease type in your estimation as \nan integer (unit:second): \n\nand press [enter] key.",pos = (-0.3,0.15))
    message.draw()
    win.mouseVisible = True
    win.flip()
    flag = True
    input_text = ""
    while flag:
        key = event.waitKeys()[0]
        print(key)
        if key == 'return':
            if not check_input_float(input_text):
                input_text = ""
            else:
                break
        elif key == 'backspace':
            if input_text != "":
                input_text = input_text[:-1]
        elif key == 'period':
            input_text += '.'
        elif check_input_integer(key):
            input_text += key
        message1 = visual.TextStim(win, text="\n\n\nPlease type in your estimation as \nan integer (unit:second): \n\nand press [enter] key.",pos = (-0.3,0.15))
        message2 = visual.TextStim(win, input_text,pos = (0,0))
        message1.draw()
        message2.draw()
        win.flip()
    #time_dict = {"Estimated Time:":""}
    #get_result = gui.DlgFromDict(time_dict, title='What\'s your estimated time')
    print(input_text)
    result.append(float(input_text))
    #get_result.show()
final_list = []
for i in range(len(intervals)):
    final_list.append(
        [
            intervals[i],
            result[i]
        ]
    )
datafile = open(file_name, "wb")
writer = csv.writer(datafile, delimiter=",")
information_row = ["user_id:", user_id]
writer.writerow(information_row)
writer.writerow(["Actual Time", "User's estimation"])
for row in final_list:
    writer.writerow(row)
datafile.close()

thankyoumessageline1 = 'You have finished the experiment.'
thankyoumessageline2 = '\nPlease press any key to exit the experiment.'
thankyoumessageline3 = '\nThank you for your participation.'
thankyoumessagelines = thankyoumessageline1 + thankyoumessageline2 + thankyoumessageline3
c = visual.TextStim(win, thankyoumessagelines, pos = (-0.,0.1), units='norm')
c.wrapWidth = 1.7
c.draw()
win.flip()
keys = event.waitKeys()
# Close the window
win.close()
 
# Close PsychoPy
core.quit()
