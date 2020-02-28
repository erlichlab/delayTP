from psychopy import *
import random
import os
import csv
# Imprtant!! Parameter set up here:
# total times of test
intervals = [10]
def generate_file_name(user_id):
    file_name = "demo_" + str(user_id) + ".csv"
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
result = []
win = visual.Window([1000,1000], fullscr = True, monitor="testMonitor")
n = 60
line1 = 'This is the demo of the time perception task'.center(n) + "\n\n"
line2 = 'You will estimate how long the circle has shown up'.center(n)+ "\n"
lines2_2 = 'and type in your estimation as an integer (unit = seconds).'.center(n)+ "\n\n"
line3 = 'Please press [space] key to start the experiment'.center(n)+ "\n"
lines3_2 = 'when you are ready.'.center(n)

lines = line1 + line2 +lines2_2 + line3 + lines3_2 
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

line1 = 'This is the demo of the time production task'.center(n) + "\n\n"
line2 = 'You will press the [enter] key to start and press the [enter] key'.center(n)+ "\n"
lines2_2 = 'to end the estimation of the given time intervals.'.center(n)+ "\n\n"
line3 = 'Please press [space] key to start the experiment'.center(n)+ "\n"
lines3_2 = 'when you are ready.'.center(n)

lines = line1 + line2 +lines2_2 + line3 + lines3_2 

b = visual.TextStim(win, lines, alignHoriz='center', alignVert='center',units='norm')
b.wrapWidth = 1.8
b.draw()
win.flip()

keys = event.waitKeys(keyList=["space"])
clock = core.Clock()
for i in range(len(intervals)):
    message = visual.TextStim(win, text='Please press [space] key to continue.\n\n' + "Trial Number: " + str(i+1))
    message.wrapWidth = 1.3
    message.draw()
    win.mouseVisible = False
    win.flip()
    
    keys = event.waitKeys(keyList=["space"])
    text = "Please estimate an interval of " +  str(intervals[i]) + " seconds.\nPlease press [enter] to start\nand press [enter] to end."
    message = visual.TextStim(win, text=text,pos = (-0.3,0.15), units='norm')
    message.wrapWidth = 1.5
    message.draw()
    win.flip()
    keys = event.waitKeys(keyList=["return"])
    clock.reset()
    text = "You've pressed the key\nplease press [enter] again to end."
    message = visual.TextStim(win, text=text,pos = (-0.3,0.15), units='norm')
    message.draw()
    win.flip()
    keys = event.waitKeys(keyList=["return"])
    t = clock.getTime()
    print(t)


    result.append(float(t))
    #get_result.show()

datafile = open(file_name, "wb")
writer = csv.writer(datafile, delimiter=",")
information_row = ["user_id:", user_id]
writer.writerow(information_row)
information_row2 = ["Perception"]
writer.writerow(information_row2)
writer.writerow(["Actual Time", "User's estimation"])
writer.writerow([intervals[0],result[0]])
information_row3 = ["Production"]
writer.writerow(information_row3)
writer.writerow(["Actual Time", "User's production"])
writer.writerow([intervals[0],result[1]])
datafile.close()



thankyoumessageline1 = 'You have finished the demo.';
thankyoumessageline2 = '\n Please press any key to exit.';
thankyoumessagelines = thankyoumessageline1 + thankyoumessageline2
c = visual.TextStim(win, thankyoumessagelines, alignHoriz='center', alignVert='center',units='norm')
c.wrapWidth = 1.7
c.draw()
win.flip()
keys = event.waitKeys()
# Close the window
win.close()
 
# Close PsychoPy
core.quit()
