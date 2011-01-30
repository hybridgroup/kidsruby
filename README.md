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
* QtRuby app - lets us communicate with the OS to create a full Ruby interactive environment
* Minitest/Minispec for testing. Yes, code must be tested
* Tutorial content is easy to create just drop HTML files on disk locally to the KidsRuby editor.
* Using a modified version of the JS library Turtlewax for the Turtle implementation https://github.com/davebalmer/turtlewax

Running it:

    ruby main.rb

Getting setup on Ubuntu:
Coming soon...

## Getting setup on a Mac using Homebrew
I used the qtbindings gem: https://github.com/ryanmelt/qtbindings
Since I also run homebrew, I discovered that the homebrew install for Qt4 needed a little symlinking before I could run the gem install for qtbindings as described here: https://github.com/ryanmelt/qtbindings/issues#issue/14

To summarize:

    brew install dbus
    brew install qt --with-qtdbus
    for DIR in /usr/local/Cellar/qt/4.7.1/lib/*.framework; do ln -s $DIR/Headers ${DIR%%/lib/*}/include/$(basename $DIR .framework); done
    gem install qtbindings


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

## TODO

### CORE
* capture keystrokes within main Qt app and pipe to stdin when executing ruby process so we can support gets

### UI
* make the Run button WAY WAY bigger

### EDITOR
* editor save/open/clear
* paste into editor (copy already works)

### HELP/TUTORIAL
* copy relevant basic ruby part from Hackety Hack tutorial

### TOYS/GOODIES
* make it easy to run pie (see what I did there?)

### POSSIBLE IDEAS:
* create Shoes compatible classes (slippers?) to run Shoes example code too
