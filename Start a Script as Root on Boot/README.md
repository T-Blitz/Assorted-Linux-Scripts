# Start a Script as Root on Boot

### You can't start a linux script as root using the script it's self, but instead you need to write a very simple wrapper using C.

Create a file (myScriptWrapper.c for example, make sure the ending is .c) and copy and paste this main function in to it. Make sure to change the path to the paht of your own script.
Make sure to write the wrapper file inside your script folder and compile it there

```c
int main(void) {        
    setuid(0);
    clearenv();
    system("/absolute/path/to/your/script.sh");
}
```
Save and close the file. 
Now rund the following commands:

```
gcc <myscriptWrapper.c> -o myScriptWrapper
```

the default name of the output is "a.out", you can give it a name after the -o flag. 
Use these command to make it executable as root:
```
sudo chown root:root myScriptWrapper.out 
sudo chmod u+s myScriptWrapper.out
```

You need to use these commands again, each time you compile the wrapper.
Now you got a wrapper that starts your script as root. 
You can now finally use systemctl to autostart your script as service on boot. And that as Root.

<br><br>
### Now use this command to creat the .service file in it's needed directory:
```bash
sudo nano /etc/systemd/system/myScriptWrapper.service
```



You can use this example as base for your .service file. Adapt it to your needs.
```ini
[Unit]
Description=My Custom Script
After=network.target

[Service]
ExecStart=/absolute/path/to/your/myScriptWrapper.out
Restart=always
User=root

[Install]
WantedBy=multi-user.target
```
Save it and use the next command to enable your service.
```bash
sudo systemctl daemon-reload
sudo systemctl enable myScriptWrapper.service

sudo systemctl start myScriptWrapper.service
```
Make sure to use this command, to check if your script is running:
```bash
sudo systemctl status myScriptWrapper.service
```
