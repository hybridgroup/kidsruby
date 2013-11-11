# KidsRuby

KidsRuby (http://kidsruby.com) is a Ruby programming environment meant for kids. If what you want is just to download/install KidsRuby, please go to http://kidsruby.com/download 

KidsRuby is heavily influenced by Hackety Hack (http://hackety-hack.com). In fact, you can run many of the same code samples from Hackety Hack in KidsRuby. For example:

``` ruby
color = ask("what is your favorite color")
if color == "blue"
  alert("you picked blue")
end
```

You can also use the Turtle, just like Hackety-Hack does

``` ruby
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
```

## Design Goals
* Simple single file editor
* You can run the current contents of the editor
* The output appears next to the editor
* It runs a normal Ruby 1.9.2 on the code. With normal gems etc.

## Implementation choices
* Webkit-based editor - currently using Ace (http://ace.ajax.org/)
* QtRuby app - hosts webkit and provide http server to communicate with running Ruby environment
* Minitest/Minispec for testing. Yes, code must be tested
* Tutorial content is easy to create just drop HTML files on disk locally to the KidsRuby editor.
* Using a modified version of the JS library Turtlewax for the Turtle implementation https://github.com/davebalmer/turtlewax

## How to Run KidsRuby:

    ruby main.rb

## Getting setup for development on Ubuntu
    sudo apt-get install libqt4-dev
    sudo apt-get install cmake
    bundle install
Take note that the native compilation of qt (the line `Installing qtbindings (4.6.3.4) with native extensions`) can take several minutes without apparent progress ... You could run `top` to see `cmake` and `cc1plus` effectively in action.

## If you also want Gosu
    echo "" >> Gemfile
    echo "# needed for gosu" >> Gemfile
    echo "gem 'gosu'" >> Gemfile
    sudo apt-get install g++ libgl1-mesa-dev libpango1.0-dev libboost-dev libopenal-dev libsndfile-dev libxdamage-dev libsdl-ttf2.0-dev libfreeimage3 libfreeimage-dev libxinerama-dev
    bundle install
    
## Mac

### Mavericks Using homebrew
First things first: Macs are getting weirder. Secondly you will most likely need to install ```Command Line Tools for XCode```. That should solve [this](http://stackoverflow.com/questions/10390186/install-name-tool-reporting-malformed-object) ```install_name_tool: object: Abacate malformed object``` For instructions go [here](http://stackoverflow.com/questions/11598082/install-name-tool-on-os-x-lion)

You won't be able to use the normal Qt install from homebrew because of some changes with Mavericks. To fix that go [here](https://github.com/mxcl/homebrew/pull/23793). If you get any problems with cmake then run ``` brew install cmake```.

Clone the repo

```
bundle install
```

That should be it. Get coding. *whip cracks*

### Mountain Lion using homebrew
This was testing on homebrew commit d02e16c4415e41c7510442a1d58b98077e5e0ae4

You will most likely need to install ```Command Line Tools for XCode```. That should solve [this](http://stackoverflow.com/questions/10390186/install-name-tool-reporting-malformed-object) ```install_name_tool: object: Abacate malformed object``` For instructions go [here](http://stackoverflow.com/questions/11598082/install-name-tool-on-os-x-lion)

Then run...

```
brew install qt
```


```
for DIR in /usr/local/Cellar/qt/*/lib/*.framework; do ln -s $DIR/Headers ${DIR%%/lib/*}/include/$(basename $DIR .framework); done
```

Note: the above was done when I was trying the old instructions and I am not sure if this is needed.

Clone the repo

```
bundle install
```

```
NOTES: I had anaconda installed which was using the wrong qmake version make sure anaconda's qmake is not in the path
```

### Getting setup for development on a Mac (pre Mountain Lion) 
using Homebrew
I used the qtbindings gem: https://github.com/ryanmelt/qtbindings
Since I also run homebrew, I discovered that the homebrew install for Qt4 needed a little symlinking before I could run the gem install for qtbindings as described here: https://github.com/ryanmelt/qtbindings/issues#issue/14

However, since KidsRuby requires Qt 4.7, you need to use the following (thanks @clemcke for updated instructions):

    cd /usr/local/Library/Formula
    git checkout 83f742e /usr/local/Library/Formula/qt.rb
    brew install qt
    for DIR in /usr/local/Cellar/qt/*/lib/*.framework; do ln -s $DIR/Headers ${DIR%%/lib/*}/include/$(basename $DIR .framework); done
    brew install cmake
    bundle install

If you have already installed KidsRuby using the OSX installer, you will need to uninstall that Qt package before trying to install the qtbindings gem, or it will not build/install as described here https://github.com/ryanmelt/qtbindings/blob/master/README.txt.

The solution is to run this before attempting to install the qtbindings gem:

    sudo /Developer/Tools/uninstall-qt.py

## Getting setup on a Mac using Ports
Someone please describe this procedure here.

## Getting setup on Windows
    Install git standalone
    Install Ruby 1.9.2 standalone
    bundle install


## Credits and Attributions

Light Icon for theme inversion: Creative Commons (Attribution-Share Alike 3.0 Unported)

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
* need to display complete debug info on errors again
* make the turtle canvas keep a correct aspect ratio when resized
* switch editor colors to white background for better presentation display. we already have inverse css file, just need a way to switch to it, and back

## TODO

### ROADMAP
* 1.1 - Localization

### TURTLE
* correct pencolor so it works when switching color while drawing

### EDITOR
* paste into editor (copy already works)

### HELP/TUTORIAL
* update ruby4kids to include their latest lessons
* add more good stuff!

### POSSIBLE IDEAS:
* make it easy to run pie (see what I did there?)
* create Shoes compatible classes (slippers?) to run Shoes example code too
