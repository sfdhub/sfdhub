Maple 6
Windows
Read Me


This file describes the following topics:


   System Requirements
   Installation Instructions
   Network Installation
   License and Registration 
   Contents of the Maple Folder 
   Command Line Maple 
   Changing User Mode or Folder 
   Notes 


System Requirements
-------------------

Before beginning the installation of Maple 6, check that
your computer fulfills the following minimum requirements:

  * Intel Pentium 90 or fully compatible processor
  * CD-ROM drive (for installation)
  * 65 MB of free hard disk space
  * 8-bit graphics adaptor and display to support 256 simultaneous colors at
    640x480 resolution
  * Windows NT 4 (Service Pack 5), Windows 95, or Windows 98 
  * 16 MB of available RAM for Windows 95 or 98; 32 MB of available RAM for 
    Windows NT 4.


Installation Instructions
-------------------------

1. Insert the Maple 6 program CD-ROM into the appropriate drive.

2. Open My Computer. Double-click Control Panel. In the Control Panel window,
   double-click Add/Remove Programs. In the Add/Remove Programs Properties
   dialog box (Install/Uninstall tab), click the Install button. Click Next. 

3. A Welcome screen introduces you to Maple 6.  Click Next to proceed.

4. The Choose Destination dialog box suggests a location for the Maple 6 
   files. To select a different location in which to place the files, 
   click Browse. Click Next to copy the program files there.  

   Note:  If there is insufficient hard disk space, you will receive an 
   error message that requests more space or a new location in which to copy
   the files.
   
5. The User Profile Setup dialog box is displayed. If only one person will be
   using this installation of Maple, select Single User Profile. If two or
   more people will share the installation of Maple on this computer, select 
   Multiple User Profile. When done, click Next.
   
6. Use the suggested folder to install the Maple 6 files in, or select a
   different one from the Existing Folders list. Click Next.
   
7. Indicate whether you want a Maple 6 shortcut added to your Desktop; click
   Yes or No.            

The installer will also search for the CRC Standard Math Interactive 
program. If this program is on your machine, a dialog box will ask you 
if you want to upgrade the mathematical tool of Standard Math Interactive 
to Maple 6.     


Network Installation
--------------------

1. To enable user profiles, a writable location must be established prior
   to installing Maple. This location may be a writable share point on
   a Windows machine or a writable directory on a UNIX machine. It must be
   writable for the install to be successful. This writable location will be
   requested during the installation. 

2. On the network server, install Maple 6 by using the steps described in
   the previous procedure. By default, the installation location is 
   C:/Program Files/Maple 6. After you have finished this installation, 
   this install directory should be shared to allow client access.

3. When asked about user profiles (step 5 above), you must use a universal
   naming convention (UNC) directory location, such as 
   \\server1\chem\Maple6\USERS. Do not use specific drive letters.
   If the location you provide is not a writable share location, you
   will be warned that the directory does not have write permissions.

4. Maple 6 comes with a license manager that determines and restricts the
   number of users. During installation you will be asked for the location of 
   your License Manager Server. The server name you enter must be in a 
   format that is acceptable to your network. If the license will be served
   from the same machine where you are installing Maple 6, you can specify
   the special keyword THIS_HOST as the server name.
   
5. To configure Maple 6 to run on the network, share the folder in which  
   Maple 6 was installed (e.g. \\server1\chem\Maple6). Go to each client 
   computer and start the client setup program by clicking on the Setup.exe 
   icon located in the Client subfolder of the Maple 6 folder.
   
   The client setup steps are similar to those in the server installation. On
   the client side, the Program Folder you choose is where the program icons
   are placed on the client machine. The default is Maple 6.
   

License and Registration:  Non-network (single user) version
------------------------

If you have already received a license file (license.dat) from 
Waterloo Maple Inc. before you start Maple 6 for the first time, copy that 
file into the License folder in your Maple 6 directory. 

Otherwise, start Maple 6. The Maple 6 Startup dialog box will appear 
stating that Maple cannot be started. Check Details and this README file 
for more information. 

If you have Internet access, click Register to go to the Web site
http://register.maplesoft.com and register. Fill in the form at that location, 
and submit it. Return to the dialog box in Maple and click OK. Maple will exit.

A License File will be e-mailed to you shortly. Copy that file into the
License folder in your Maple 6 directory.

Restart Maple.
  
If you do not have access to e-mail or the Internet, please call 
(519) 747-2373 and ask for License File Registration. 


License and Registration:  Network version
-------------------------

These instructions are for the system administrator.


FLEXlm 7.0 is used as Maple's License Manager. For complete information on
how to set it up, please refer to the FLEXlm End User Manual that is located 
in the FLEXlm directory within your Maple 6 directory. Alternatively, go to 
http://www.globetrotter.com for a more searchable version of this manual. 

Details pertaining specifically to Maple are included below.  

The FLEXlm directory on the Maple 6 CD also contains a directory for each 
platform. These directories contain daemons (lmgrd.exe and maplelmg.exe) 
that you will need to run Maple, as well as utilities that will 
assist you in configuring FLEXlm for your system. We recommend that you copy 
all the files specific to your platform into a FLEXlm directory under your 
installed Maple 6 directory. If Maple 6 is running on more than one platform, 
Maple 6 needs to be installed on each of the SERVER platforms and then the 
FLEXlm utilities and daemons specific to one of the platforms should be copied 
to a FLEXlm folder in that Maple 6 directory. 

The License directory under the directory where Maple 6 is installed includes 
a file called license.dat. We will send you a network license file whose name 
is customizable. We recommend that you place the network license file in the 
same location as your license manager daemons (usually in the FLEXlm directory
under your Maple 6 directory). You will have to open both of these files and
make sure that the SERVER line in each is correct and that they match.  Both 
license files contain comments to assist you in this, and the FLEXlm 
End User Manual also provides useful information.

A dialog box, Maple 6 Startup, will appear if the license files are 
not properly configured or if there are other problems in starting Maple. 
In that dialog box, click the Details button to get more information. Refer 
to the FLEXlm End User Manual for full information.


Contents of the Maple Folder
----------------------------

The installation procedure requires 65 MB of disk space and, by
default, places the Maple 6 files in 
C:\Program Files\Maple 6.  
In this folder, you should see the following files and folders:

  Readme.txt       This file
  Cmdline.txt      A description of the Command Line interface
  Excel.txt	   Information about using Maple 6 through Excel 2000
  Intro.mws	   Introductory help page that points out new features
  Latex.txt	   Information about formatting and printing Maple worksheets
  		   as LaTeX
  Mint.txt         Description of the Mint Maple syntax checker
  Updtsrc.txt      Information on updating source code to Maple 6
  AFM              Folder that contains font information
  BIN.WNT          Folder that contains Maple executable programs 
		   for Windows 95, Windows 98, or Windows NT users
		   installed as a stand-alone; Directory containing
		   Maple executable programs for Windows NT users
		   installed on a network
  BIN.W95          Folder that contains Maple executable programs for
		   Windows 95 or Windows 98 users installed on a
		   network
  ETC              Folder that includes the readme and style files for
		   LaTeX
  EXCEL		   Folder that contains the files related to the Maple 6
  		   add-in for Excel 2000
  EXTERN	   Folder that contains files used for generic external
  		   calling		   		  
  FLEXlm	   (For network installations only) Folder that contains 
                   FLEXlm documentation  
  LIB              Folder that contains the Maple library files
  LICENSE          Folder that contains Maple licensing information
  SAMPLES	   Folder that contains sample code for use with Chapter 6
  		   of the Programming Guide, which deals with modules.

Command Line Maple 
------------------
 
Maple 6 provides a Command Line Interface.  This is a small, efficient 
interface to the full Maple mathematical engine. It is particularly 
useful when tackling large problems on slower computers or on computers 
with limited memory.

On any Windows platform, the Command Line Interface can be accessed by
going to the Start menu and selecting Programs, then Maple 6, and then
Command Line Maple. A description of this version of Maple is located 
in the file "cmdline.txt". 

If the Command Line version of Maple (cmaple) does not appear to start, 
start the GUI version to check for messages regarding startup problems.

Changing User Mode or Folder
----------------------------

The BIN folder under the MAPLE folder contains an ASCII text file called
Maplesys.ini. System administrators can use this file after installation to
change user profile information. To change Maple from Single to Multiple
User Mode, change the MultiUserProfile option from 0 to 1. To change
the location of the user directory, specify the new directory in the
UserDirectory option.


Notes
-----

When you open a Maple 6 worksheet that contains code written in 
Maple V Release 5 or Release 5.1, the built-in updtsrc feature updates the 
code for use in Maple 6. The worksheet is parsed one statement at a time. 
Each statement is syntactically checked before any updating is done, and any 
lines that are syntactically wrong are not converted. To get around the 
problem, run the the worksheet through the standalone updtsrc utility. For 
more information about that utility, see the updtsrc.txt file.


Using MATLAB and Maple
----------------------

MATLAB is an interactive system and programming language for general 
scientific and technical computation. For information on using the 
Maple-MATLAB link, see the ?Matlab,setup help page in Maple 6.
