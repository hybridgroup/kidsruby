//package org.jruby.demo;
package kidsruby;

import java.applet.Applet;
import java.io.*;

import org.jruby.Ruby;
import org.jruby.RubyObject;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineFactory;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;
import javax.script.ScriptContext;

public class RubyApplet extends Applet {
	Ruby instance = null;
	
  private boolean started = false;
  public boolean hasStarted() {
    return this.started;
  }
  public void started() {
    this.started = true;
  }

  public void start() {
    super.start();
    this.started();
  }
  
  public void init() {
    super.init();
		System.out.println("the init method has been called");
	}
	
	public void resetRuby() {
    instance = Ruby.newInstance();
  }

  private Ruby instance() {
    if (instance == null) {
      resetRuby();
    }
    return instance;
  }
  
  public Object evalRubyToObject(String input) {
    return instance().evalScriptlet(input);
  }

	public String evalRuby(String input) {
		  try {
        RubyObject result = (RubyObject) evalRubyToObject(input);
				return result.toString();
      } catch (Exception e) {
				System.out.println("uh oh");
				return e.toString();
      }
	}
}