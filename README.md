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
* It runs a normal Ruby 2 on the code. With normal gems etc.

## Implementation choices
* Webkit-based editor - currently using Ace (http://ace.ajax.org/)
* node-webkit app - hosts webkit and provide http server to communicate with running Ruby environment
* Minitest/Minispec for testing. Yes, code must be tested
* Tutorial content is easy to create just drop HTML files on disk locally to the KidsRuby editor.
* Using a modified version of the JS library Turtlewax for the Turtle implementation https://github.com/davebalmer/turtlewax

## How to Run KidsRuby:
    nodewebkit app

## Getting setup for development on Ubuntu

### Node dependencies
  - Install Yeoman globally: `sudo npm install yeoman -g`
  - Install the Yeoman Node WebKit Generator globally: `sudo npm install generator-node-webkit -g`
  - Install Node WebKit globally: `sudo npm install nodewebkit -g`
  - Install the Grunt CLI globally: `sudo npm install grunt-cli -g`

### Ruby dependencies
```
    bundle install
```

## If you also want Gosu
    echo "" >> Gemfile
    echo "# needed for gosu" >> Gemfile
    echo "gem 'gosu'" >> Gemfile
    sudo apt-get install g++ libgl1-mesa-dev libpango1.0-dev libboost-dev libopenal-dev libsndfile-dev libxdamage-dev libsdl-ttf2.0-dev libfreeimage3 libfreeimage-dev libxinerama-dev
    bundle install
    
## Getting setup for development on Mac

### Node dependencies
  - Install Yeoman globally: `sudo npm install yeoman -g`
  - Install the Yeoman Node WebKit Generator globally: `sudo npm install generator-node-webkit -g`
  - Install Node WebKit globally: `sudo npm install nodewebkit -g`
  - Install the Grunt CLI globally: `sudo npm install grunt-cli -g`

### Mavericks Using homebrew
First things first: Macs are getting weirder. Secondly you will most likely need to install ```Command Line Tools for XCode```. That should solve [this](http://stackoverflow.com/questions/10390186/install-name-tool-reporting-malformed-object) ```install_name_tool: object: Abacate malformed object``` For instructions go [here](http://stackoverflow.com/questions/11598082/install-name-tool-on-os-x-lion)

Clone the repo

```
bundle install
```

That should be it. Get coding. *whip cracks*

### Mountain Lion using homebrew

You will most likely need to install ```Command Line Tools for XCode```. That should solve [this](http://stackoverflow.com/questions/10390186/install-name-tool-reporting-malformed-object) ```install_name_tool: object: Abacate malformed object``` For instructions go [here](http://stackoverflow.com/questions/11598082/install-name-tool-on-os-x-lion)

Clone the repo

```
bundle install
```

### Getting setup for development on a Mac (pre Mountain Lion) using Homebrew

```
bundle install
```

## Getting setup on a Mac using Ports
Someone please describe this procedure here.

## Getting setup on Windows
    Install git standalone
    Install Ruby 2.1 standalone
    bundle install

## Credits and Attributions

Light Icon for theme inversion: Creative Commons (Attribution-Share Alike 3.0 Unported)

## TODO

### TURTLE
* correct pencolor so it works when switching color while drawing

### EDITOR
* paste into editor (copy already works)

### HELP/TUTORIAL
* update ruby4kids to include their latest lessons
* add more good stuff!

### POSSIBLE IDEAS:
* make it easy to run pie (see what I did there? And it will only run on macs :P)
* create Shoes compatible classes (slippers?) to run Shoes example code too
