How to write a wrapper for a script that needs sudo

You can't start a linux script as root using the script it's self, but instead you need to write a very simple wrapper using C
create a file (myScriptWrapper.c for example, make sure the ending is .c) and copy and paste this main function in to it. Make sure to change the path to the paht of your own script.
Make sure to write the wrapper file inside your script folder and compile it there


int main(void) {        
    setuid(0);
    clearenv();
    system("/absolute/path/to/your/script.sh");
}

Save and close the file. 
Now rund the following commands:


gcc <myscriptWrapper.c> -o myScriptWrapper

the default name of the output is "a.out", you can give it a name after the -o flag. 
Use these command to make it executable as root:

sudo chown root:root myScriptWrapper.out 
sudo chmod u+s myScriptWrapper.out

You need to use these commands again, each time you compile the wrapper.
Now you got a wrapper that starts your script as root. 
You can now finally use systemctl to autostart your script as service on boot. And that as Root.


Use this command to creat the .service file in it's needed directory:

sudo nano /etc/systemd/system/myScriptWrapper.service

Use this example as base for your .service file. Adapt it to your needs.
[Unit]
Description=My Custom Script
After=network.target

[Service]
ExecStart=/absolute/path/to/your/myScriptWrapper.out
Restart=always
User=root

[Install]
WantedBy=multi-user.target

sudo systemctl daemon-reload
sudo systemctl enable myScriptWrapper.service

sudo systemctl start myScriptWrapper.service

use this to check if your script is running:
sudo systemctl status myScriptWrapper.service

