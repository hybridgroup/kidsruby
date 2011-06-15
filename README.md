# KidsRuby
KidsRuby (http://kidsruby.com) is a Ruby programming environment meant for kids. It is heavily influenced by Hackety Hack (http://hackety-hack.com).

In fact you can run many of the same code samples from Hackety Hack in KidsRuby. For example:

    color = ask("what is your favorite color")
    if color == "blue"
      alert("you picked blue")
    end

You can also use the Turtle, just like Hackety-Hack does

    Turtle.draw do
      background yellow
      pencolor brown
      pensize 2
      goto 30, 200
      setheading 180
      1000.times do
        forward 20
        turnleft rand(10)
        backward 10
      end
    end

## Design Goals
* Simple single file editor
* You can run the current contents of the editor
* The output appears next to the editor
* It runs a normal Ruby on the code (both 1.8.7 & 1.9.2 supported). With normal gems etc.

## Implementation choices
* Titanium Desktop app - hosts webkit and provide http server to communicate with running Ruby environment
* Webkit-based editor - currently using CodeMirror
* Minitest/Minispec for testing. Yes, code must be tested
* Tutorial content is easy to create just drop HTML files on disk locally to the KidsRuby editor.
* Using a modified version of the JS library Turtlewax for the Turtle implementation https://github.com/davebalmer/turtlewax

## How to Run KidsRuby:

    To simply run KidsRuby, you should go to the web site (http://kidsruby.com/downloads) and download the latest installer for your operating system. 

## Getting setup for development with KidsRuby:
    If you want to help development of KidsRuby, then read on...
    You will need to obtain Titanium Studio, which is a free download from appcelerator.com. Register for the free community edition and you can then download Titanium Studio for your OS.
    You will need to be using Titanium Desktop SDK version 1.2 RC2 or above. As of 6/15/2011 this is immanently going to be available to public.
    If you are using a development build of the Titanium SDK you will need to install it as described here: http://wiki.appcelerator.org/display/guides/Continuous+Builds
    Clone this repo into a working directory
    Launch Titanium Developer
    Click on "Import Project"
    Choose the working directory that you cloned the repo into
    You should now be able to choose the KidsRuby project from the list of projects in Titanium Developer
    Click on the "Tast & Package" tab
    Click on the "Launch App" button, and it should build & run KidsRuby

## Getting setup on Ubuntu
    ...
## Getting setup on a Mac using Homebrew
    ...
    
## Getting setup on a Mac using Ports
    ...
    
## Getting setup on Windows
    ...

## DONE
* create hackety-hack compatible class with UI dialogs for ask/alert
* get syntax highlighting correct for Ruby code
* create hackety-hack compatible class for Turtle graphics
* tabbed divs for output/turtle/help
* layout for local html pages with tutorials
* implement Turtle width and height methods
* correct top/bottom orientation for Turtle relative to user
* adjust proportions of editor to sidebar for more visible space for tutorial section
* home to main index for help & browser forward/back buttons for help section
* split up HH help "pages" to go forward/back like the original tutorial
* make the canvas bigger for the Turtle
* add Gosu libs/classes to KidsRuby OS to make it easy to write games right away
* How to use KidsRuby
* editor save/open
* make the Run button WAY WAY bigger
* capture keystrokes within main Qt app and pipe to stdin when executing ruby process so we can support gets
* replace DBus communications with http based protocol which allows better multi-platform support and fewer installation dependancies
* fix background color
* A couple of funny things with the formatting of gets
* make the turtle canvas keep a correct aspect ratio when resized
* switch editor colors to white background for better presentation display. we already have inverse css file, just need a way to switch to it, and back
* need to display complete debug info on errors again

## TODO

### CORE
* the gets implementation needs to be recreated using JS within Titanium environment

### TURTLE
* correct pencolor so it works

### EDITOR
* paste into editor (copy already works)

### HELP/TUTORIAL
* update ruby4kids to include their latest lessons
* add more good stuff!

### POSSIBLE IDEAS:
* make it easy to run pie (see what I did there?)
* create Shoes compatible classes (slippers?) to run Shoes example code too
