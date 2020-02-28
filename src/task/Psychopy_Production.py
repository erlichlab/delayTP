from psychopy import *
import random
import os
import csv
# Important!! Parameter set up here:
# total times of test
#intervals = [3,7,14] # testing
intervals = [3,3,3,7,7,7,14,14,14,30,30,30,64,64,64]
def generate_file_name(user_id):
    file_name = "production_" + str(user_id) + ".csv"
    return file_name
def check_input_integer(input):
    if input == "":
        return False
    for i in input:
        if not i.isdigit():
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
line1 = 'Welcome to the experiment.'.center(n) + "\n\n"
line2 = 'You will press the [enter] key to start and press the [enter] key'.center(n)+ "\n"
lines2_2 = 'to end the estimation of the given time intervals.'.center(n)+ "\n\n"
line3 = 'Please press [space] key to start the experiment'.center(n)+ "\n"
lines3_2 = 'when you are ready.'.center(n)

lines = line1 + line2 +lines2_2 + line3 + lines3_2 
print(lines)
b = visual.TextStim(win, lines, alignHoriz='center', alignVert='center',units='norm')
b.wrapWidth = 1.8
b.draw()
win.flip()


keys = event.waitKeys(keyList=["space"])
clock = core.Clock()
for i in range(len(intervals)):
    message = visual.TextStim(win, text='Please press [space] key to continue.\n\n' + "Trial Number: " + str(i+1))
    message.wrapWidth = 1.5
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
writer.writerow(["Actual Time", "User's production"])
for row in final_list:
    writer.writerow(row)
datafile.close()


thankyoumessageline1 = 'You have finished the experiment.';
thankyoumessageline2 = '\n Please press any key to exit the experiment.';
thankyoumessageline3 = '\n Thank you for your participation.';
thankyoumessagelines = thankyoumessageline1 + thankyoumessageline2 + thankyoumessageline3
c = visual.TextStim(win, thankyoumessagelines, pos = (-0.1,0), units='norm')
c.wrapWidth = 1.7
c.draw()
win.flip()
keys = event.waitKeys()
# Close the window
win.close()
 
# Close PsychoPy
core.quit()
