#!/bin/sh

# just build the applet for now
javac -classpath public/jruby/classes/jruby.jar:public/jruby/classes/asm.jar \
      -d public/jruby/classes lib/java/RubyApplet.java 
