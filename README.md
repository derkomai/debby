# Debby: a simple deb package installer

Debbie is a simple user interface which can install deb packages.
Just remember to be cautious with your downloads and be sure about what you are actually installing.


## Usage

### The graphical, beginner-friendly way

1. Download Debby in [this link](https://raw.githubusercontent.com/derkomai/debby/master/debby.sh): right click on the link, select *save link as* and click OK, ensuring that the file name is just *debby.sh* without any other extensions.
2. Open your downloads folder. You should see a file named *debby.sh*.
3. Right click *debby.sh* file, select *Properties* and open the tab named *Permissions* in the dialog.
4. Now, depending on your system, you should see something like *Allow executing file as a program* or a table where you can give *Execution* permissions for the file owner. Ensure this is activated and click OK.
5. If you are using Ubuntu or at least the Nautilus file browser, ensure that **Edit > Preferences > Behaviour > Executable text files > Run executable text files when they are opened** option is activated.
6. Open *debby.sh* by clicking on it.
7. You will be asked for your password. Type it and click OK.
8. Select the tasks you want to perform and click OK. Wait for them to complete. That's it.



### The easy command line way

1. Open a terminal, paste the line below and then press enter. You will have to type your password.
    ```
    sudo apt -y install git && git clone https://github.com/derkomai/debby && sudo ./debby/debby.sh

    ```


## Donation
If you find Debby useful and it has saved you some time or trouble, you can support it by making a small donation through Paypal.


[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donate_LG.gif)](https://www.paypal.me/dvilela)
