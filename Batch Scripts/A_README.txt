These Batch files are used to automate a lot of the processes we encounter frequently. These can be deployed a number of ways. 
If your remoted in to a users machine you can copy the file and then Right click > Paste on their desktop or you can send them the batch file in teams/email etc. 
You can also open the scripts up in notepad then copy the text over to another notepad and save it as a .bat file on their desktop and run it (may need to enable file extentions). 
Not all of these files require Admin in order to run but if its making any type of change it probably will.

Note: If you send a file to someone in Teams it will keep a copy in your teams "files" section and you'll want to just go back and share that one as needed. 
Instead of resending the file like you did the first time. Otherwise you'll end up with duplicates (File1 File2 File3 etc) and is annoying. 
You should still move the file(s) to desktop before running, especially if Admin creds is required.

**IMPORTANT**
- Some files may require other files along side them such as powershell scripts to work correctly. They will be listed as "REQUIRED_DO_NOT_RUN"
- You can escalate these batch files by remoting in and using credentials as normal. You can also have a user to run the batch file on their own using the local admin info and password. (Only use if you cant assist)
- Do NOT give out your own creds to users to escalate any of these files.
- If you encounter an "ERROR This script requires elevated rights" that means you need to right click the file > Run As Admin.
- ALL of these files should be ran directly from the machine itself (desktop). Do not run from a network drive or other location. Otherwise filepath errors could potentially occur.

If any of these files give you an error when launching please screenshot full CMD error log and send to me.

