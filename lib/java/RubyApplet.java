//package org.jruby.demo;
package kidsruby;

import java.applet.Applet;

import org.jruby.Ruby;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineFactory;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;
import javax.script.ScriptContext;


public class RubyApplet extends Applet {
  private ScriptEngineManager factory;
	private ScriptEngine engine;
	
  public void setRubyFactory(ScriptEngineManager theRuby) {
    this.factory = theRuby;
  }

	public void setEngine(ScriptEngine engine) {
		this.engine = engine;
	}
  
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
  
    // this.setRuby(Ruby.getDefaultInstance());
    setRubyFactory(new ScriptEngineManager());
		setEngine(factory.getEngineByName("jruby"));
	}
            
  public String evalRuby(String code) {
    try {
			
      Object o = this.engine.eval(code);
//      return o.getInstanceVariables().toString();
      return o.toString();    
    } catch (Exception e) {
      return e.toString();
    }
  }
}