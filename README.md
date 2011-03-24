# KidsRuby
KidsRuby (http://kidsruby.com) is a Ruby programming environment meant for kids. It is heavily influenced by Hackety Hack (http://hackety-hack.com).

In fact you can run many of the same code samples from Hackety Hack in KidsRuby. For example:

    color = ask("what is your favorite color")
    if color == "blue"
      alert("you picked blue")
    end

You can also use the Turtle, just like Hackety-Hack does

    Turtle.start do
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
* It runs a normal Ruby 1.9.2 on the code. With normal gems etc.

## Implementation choices
* Webkit-based editor - currently using CodeMirror
* QtRuby app - hosts webkit and provide http server to communicate with running Ruby environment
* Minitest/Minispec for testing. Yes, code must be tested
* Tutorial content is easy to create just drop HTML files on disk locally to the KidsRuby editor.
* Using a modified version of the JS library Turtlewax for the Turtle implementation https://github.com/davebalmer/turtlewax

## How to Run KidsRuby:

    ruby main.rb

## Getting setup on Ubuntu
    sudo apt-get install libqt4-dev
    bundle install
    
## Getting setup on a Mac using Homebrew
I used the qtbindings gem: https://github.com/ryanmelt/qtbindings
Since I also run homebrew, I discovered that the homebrew install for Qt4 needed a little symlinking before I could run the gem install for qtbindings as described here: https://github.com/ryanmelt/qtbindings/issues#issue/14

To summarize:

    brew install qt
    for DIR in /usr/local/Cellar/qt/4.7.1/lib/*.framework; do ln -s $DIR/Headers ${DIR%%/lib/*}/include/$(basename $DIR .framework); done
    bundle install

## Getting setup on a Mac using Ports
Someone please describe this procedure here.

## Getting setup on Windows
    Install git standalone
    Install Ruby 1.8.7 standalone
    bundle install


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

## TODO

### CORE

### TURTLE
* make the turtle canvas keep a correct aspect ratio when resized

### EDITOR
* switch editor colors to white background for better presentation display. we already have inverse css file, just need a way to switch to it, and back
* paste into editor (copy already works)

### HELP/TUTORIAL
* update ruby4kids to include their latest lessons
* add more good stuff!

### POSSIBLE IDEAS:
* make it easy to run pie (see what I did there?)
* create Shoes compatible classes (slippers?) to run Shoes example code too
