# PLister

A very simple tool for displaying Apple property lists at the command-line.

I wrote this as part of a uni project when I got tired of having to SCP binary property lists off my iPhone when I wanted to inspect them while logged in by SSH.

## Usage

    $ plister /Library/MobileSubstrate/DynamicLibraries/RocketBootstrap.plist
    {
      Filter =     {
          CoreFoundationVersion =         (
             800
         );
         Executables =         (
             ReportCrash
         );
      };
    }

