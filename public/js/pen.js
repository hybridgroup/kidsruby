/**
	Pen
	===
	
	Canvas implementation of turtle graphics found in Logo, at least in spirit, and
	reimagined for a JavaScript world.

	Conventions
	-----------
	
	- coordinate and distance units are expressed in pixels
	- angles are expressed in degrees (mecause most humans don't grok radians)
	
	Methods
	-------

	- `begin()`
	
	  Starts a new path in canvas, and looks more Logo-ish along the way.
	
	- `go(distance)`
	
	  Moves forward in the current direction by `distance` pixels.
	
	- `back(distance)`
	
	  The opposite of `go`.
	
	- `turn(angle)`
	
	  Turns your current direction. To turn left (counter-clockwise), use negative
	  numbers. To turn right, well, do the opposite.

	- `penup()` and `pendown()`
	
	  Sets the pen down (turns on drawing) or picks it up (turns off drawing).
	
	- `up(distance)`, `down(distance)`, `left(distance)` and `right(distance)`
	
	  Makes a relative move using the coordinate system. These are convenience methods.
	
	- `goto(x, y)`
	
	  Moves the pen to the specified coordinates, respecting pen state (up or down).
	
	- `jump(x, y)`
	
	  Like `goto` except it will never draw a line to the specified point, and it
	  also quietly calls `begin`.

	- `draw()`

	  Convenience method which calls `fill()` and `stroke()`, in that order, but only
	  calls each if there is a fill style and stroke style defined, respectively.

	- `close()`

	  If you're making a closed shape and you want the corners to match up, put this
	  after you're done drawing your shape but before you call `draw()`.

	- `stroke()` and `fill()`
	
	  Canvas wrappers which let you manually specify which of these operations you want
	  to perform on your path (everything since the last `begin` or `jump` call).
	
	- `pensize(width)`
	
	  Sets the thickness of the line your pen draws with.
	
	- `penstyle(string)`
	
	  A canvas passthru to set the line style of your pen. For example: `penstyle("#00f")`
	  will turn your pen blue.
	
	- `fillstyle(string)`
	
	  A canvas wrapper, usually this is a solid color, e.g. `fillstyle("#ff0")` will
	  fill your shapes with eye-blinding yellow.
	
	- `font(string)`
	
	  Pass in a typical CSS font spec, e.g. `font("bold 15px Helvetica")`. The color
	  of your font will depend on your last `fillstyle` (defaults to black).
	
	- `text(string)`
	
	  Draws, well, text... at the current position. Currently does not support current
	  angle, but it should in the future.
	
	- `origin()`
	
	  Sets current location as the origin point for `polar()` moves.
	
	- `polar(distance, angle)`
	
	  Performs a `goto` using polar coordinates which are relative to the last origin set.
	  This is an interesting addition to typical turtle features, and can be a huge time
	  (math) saver.
	
	- `set()` and `home()`
	
	  Stores current position, angle and origin. A call to `home()` performs a move
	  to this position. Limited use convenience; it doesn't quite work yet and may go away.
	
	- `angle(direction)`
	
	  Resets the pen's current direction relative to the page (0 degrees is "up").

  - `canvas()`
	
	  Retu the entire canvas.
	
  
*/

Pen = function(tag) {
	this.dir = -90;
	this.x = 0;
	this.y = 0;
	
	this.tag = document.getElementById(tag) || tag;
	
	this.canvas = this.tag.getContext("2d");
	this.strokeStyle = this.canvas.strokeStyle = "#000";
	this.lineWidth = this.canvas.lineWidth = 1;
	this.fillStyle = this.canvas.fillStyle = "";

	this.ox = 0;
	this.oy = 0;
	
	this.pen = true;
	
	this.canvas.clearRect(0, 0, this.tag.width, this.tag.height);
  var w = this.tag.width;
  this.tag.width = 1;
  this.tag.width = w;
	
	this.canvas.beginPath();
};
Pen.prototype = {
	turn: function(deg) {
		this.dir += deg;
		this.dir = this.dir % 360;
		
		return this;
	},
	
	fillstyle: function(style) {
		this.fillStyle = this.canvas.fillStyle = style;

		return this;
	},
	
	set: function() {
		this.homes.push({ x: this.x, y: this.y, angle: this.dir });
		return this;
	},
	
	angle: function(a) {
		this.dir = a - 90;
		return this;
	},
	
	home: function() {
		var last = this.homes.pop();
		this.dir = last.angle;

		return this.goto(this.x, this.y);
	},
		
	go: function(r) {
		var a = this.toRad(this.dir);

		this.x += r * Math.cos(a);
		this.y += r * Math.sin(a);
		
		if (this.pen)
			this.canvas.lineTo(this.x, this.y);
		else
			this.canvas.moveTo(this.x, this.y);
		
		return this;
	},
	
	back: function(r) {
		this.turn(-180);
		this.go(r);
		this.turn(180);
		
		return this;
	},
	
	stroke: function() {
		this.canvas.stroke();

		return this;
	},
	
	fill: function() {
		this.canvas.fill();

		return this;
	},
	
	begin: function() {
		this.canvas.beginPath();

		return this;
	},
	
	close: function() {
		this.canvas.closePath();
	
		return this;
	},
	
	draw: function() {
		if (this.fillStyle)
			this.fill();
		if (this.lineWidth)
			this.stroke();

		return this.begin();
	},
	
	penup: function() {
		this.pen = false;
		
		return this;
	},
	
	pendown: function() {
		this.pen = true;
		
		return this;
	},
	
	goto: function(x, y) {
		this.x = x;
		this.y = y;

		if (!this.pen)
			this.canvas.moveTo(x, y);
		else
			this.canvas.lineTo(x, y);
		
		return this;
	},
	
	jump: function(x, y) {
		this.canvas.beginPath();
		
		var p = this.pen;
		this.pen = true;
		this.goto(x, y);
		this.pen = p;

		return this;
	},

	up: function(r) {
		return this.goto(this.x, this.y - r);
	},
	
	down: function(r) {
		return this.goto(this.x, this.y + r);
	},
	
	left: function(r) {
		return this.goto(this.x - r, this.y);
	},
	
	right: function(r) {
		return this.goto(this.x + r, this.y);
	},
	
	polar: function(r, angle) {
		var a = this.toRad(angle + this.dir);
		
		this.x = this.ox + r * Math.cos(a);
		this.y = this.oy + r * Math.sin(a);

		if (this.pen)
			this.canvas.lineTo(this.x, this.y);
		else
			this.canvas.moveTo(this.x, this.y);

		return this;
	},
	
	origin: function() {
		this.ox = this.x;
		this.oy = this.y;
		
		return this;
	},
	
	rad: Math.PI / 180.0,
	
	toRad: function(d) {
		return d * this.rad;
	},
	
	pensize: function(size) {
		this.lineWidth = this.canvas.lineWidth = size;

		return this;
	},
	
	penstyle: function(str) {
		this.canvas.strokeStyle = this.strokeStyle = str;
		
		return this;
	},
	
	text: function(str) {
		this.canvas.fillText(str, this.x, this.y);
		
		return this;
	},
	
	font: function(str) {
		this.canvas.font = str;

		return this;
	},

  // background: function(color) {
  //     // var oldStyle = this.canvas.fillStyle;
  //     // this.canvas.fillStyle = color ;
  //     // this.canvas.fillRect(0, 0, this.tag.width, this.tag.height);
  //     // this.canvas.fillStyle = oldStyle ;
  //     this.tag.backgroundColor = color ;
  // },

	width: function() {
	  return this.tag.width;
	},

	height: function() {
	  return this.tag.height;
	},

  center: function() {
    return this.goto(this.width() / 2, this.height() / 2);
  }
};