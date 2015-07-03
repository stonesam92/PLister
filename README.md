# PLister

A very simple tool for displaying Apple property lists at the command-line.

I wrote this as part of a uni project when I got tired of having to SCP binary property lists off my iPhone when I wanted to inspect them while logged in by SSH.

## Usage

    $ plcat /Library/MobileSubstrate/DynamicLibraries/MobileSafety.plist
    <?xml version="1.0" encoding="UTF-8"?>
    <plist version="1.0">
    <dict>
        <key>Filter</key>
        <dict>
            <key>Flags</key>
            <integer>3</integer>
            <key>Mode</key>
            <string>Any</string>
            <key>Bundles</key>
            <array>
                <string>com.apple.springboard</string>
            </array>
        </dict>
    </dict>
    </plist>

You can print multiple files with one command and plcat will print the filename of each file before its contents.

You can also use this to quickly convert binary property lists to XML versions if you want to be able to easily modify the file:

    $ plcat /Library/MobileSubstrate/DynamicLibraries/MobileSafety.plist > MobileSafetyxml.plist
    
