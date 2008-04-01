//
//  test
//
//  Created by Andrew Fitzgerald on 2007-07-09.
//  Copyright (c) 2007 __MyCompanyName__. All rights reserved.
//
// A *really* crude sample to test the "Build in MTASC" command
// Run the "Install MTASC Support Files" in your project before running "Build in MTASC", and be sure to edit the data to suit your class' name
//
import com.visualcondition.twease.*;
class test {
	function test() {
		// Empty constructor
	}
	// Hook for MTASC. This method will be called to start the application
	static function main() {
		Stage.scaleMode = 'noscale';
		var t:MovieClip = _root.createEmptyMovieClip('5', 3);
		t.beginFill(0,100);
		t.lineTo(50,0);
		t.lineTo(50,50);
		t.lineTo(0,50);
		t.endFill();
		var f1:Function = function(target){trace("hey anthony")};
		var f2:Function = function(target){trace("hey bob is cool")};
		
		var k:MovieClip = _root.createEmptyMovieClip('mc3', 4);
		k.beginFill(0x555050,100);
		k.lineTo(50,0);
		k.lineTo(50,50);
		k.lineTo(0,50);
		k.endFill();
		k._y = k._x = 100;
		//k._y = 0;
		Twease.register(Easing, Colors, Extras, Filters, Texts);
		
		//Twease.collectionrate = 5000;
		
	//	Twease.tween({target:t, _xscale:500, _yscale:500, rate:3, ease:Twease.easeOut, cycles:-1, startfunc:f1, func:f2, delay:0});
		
	//	Twease.tween([{target:k, _x:'50', time:1}, {target:t, _xscale:500, _yscale:500, time:3, ease:Twease.easeOut, delay:.5}]);
		
	//	Twease.tween({delay:2, func:f1});
	
		
//	var s = Twease.tween([{delay: 1, time:2, _rotation:'365'}, {delay:2, func:f1}, {target:t, _x:100, _y:100, _alpha:50, delay:0, ease:Twease.easeOut, time:2, cycles:3, func:function(to,po,q){if(Twease.tweens[to][po][0].cycles == 1){Twease.advance(q)}}}, {time:2, _rotation:'25'}, {time:2, _rotation:'-55'}, {time:2, _rotation:0}], k);
		
		
		
		
	//	Twease.tween({delay:3, func:function(){Twease.advance(s)}});
	//	Twease.tween([{target:t, _rotation:50, time:2}, {target:k, _xscale:50, time:2}]);
	// 	Twease.stacking = false;

	//	/PennerEasing.init();
//		Twease.tween({target:k, _width:150, time:9, ease:'linear', delay:1});
//		Twease.tween({target:k, _rotation:-250, time:2});
	//	Twease.tween({target:k, _rotation:50, time:2});
	//	Twease.queue[s].splice(2,1);
	//	trace(Twease.queue[s]);
	
	//	Extend.init();
	var co:Object = {color:0x0e350f};
	//Twease.tween({target:co, color:0xffffff, time:4});
	

	var oldc = (new Color(k)).getTransform();
	var newc = Twease.getColorObject('tint', 100, 0xDf5AF1);
	
	newc.target = oldc;
	newc.time = 2;
	//newc.round = true;
//	newc.upfunc = function(to, po){
	//	trace(to[po]);
	//	(new Color(k)).setTransform(oldc);
//	};
	
//	Twease.tween(newc);
	
	
	Twease.combinecolors = true;
	
	Twease.setColor(k, 'tint', 100, 0x4f5801);
	
	
//	Twease.tween({target:k, tint:0xff0000, tintPercent:80, time:2, delay:0});
//	Twease.tween({target:k, tint:0xfaf100, tintPercent:80, time:2, delay:0});
	
	
	//Twease.tween({target:k, brightOffset:80, time:2, delay:0, ease:'easeOutBounce', cycles:2});
	
	
	
	var tttp = "BlurFilter";
	var newf = new flash.filters.BlurFilter(8, 8, 3);
	//k.filters = [newf];
		
	
	Twease.tween([{_x: 350, _y:380, bezier:[{_x:'-200', _y:'250'}, {_x:'200', _y:'100'}, {_x:0, _y:100}], tint:0xff4d8a, time:5, ease:'easeOutBounce', cycles:-1}], k);
	
	
	var tok:Object = {text:"A"};
	
	Twease.tween({target:tok, time:2, character:"Z"});
	
	var toyk:Object = {text:"BOOBOOB"};
	
	//Twease.tween({target:toyk, time:4, words:"Frank Carloton"});	


	//Twease.tween({target:k, _x:'200' , rate:2, delay:0, cycles:-1, progress: 0});
	

/*	
	
var pool = Twease.tween({target:k, _x:'100', _y:'150', time:1, delay:.2, cycles:1}, true);
	
	
	
	k.onEnterFrame = function ():Void{
		var gtt:Number = getTimer();
		for ( var i in pool ){
			trace(Twease.render(pool[i], gtt));
		};
		
	};
	*/

/*

	//make color object
	var masc:Object = {};
	masc.colorobj = new Color(targetmc);
	masc.currentcolor = masc.colorobj.getTransform();
	masc.newcolortween = Twease.getColorTransObj(prop, amount, value);

*/
var os = false;
_root.onMouseDown = function() {
	if(os != true){
		os = true;
		Twease.setActive(false, k);
	}else {
		os = false;
		Twease.setActive(true, k);
	}
}

}



};
