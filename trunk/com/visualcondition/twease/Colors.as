//
//  Twease Extended Colors
//  Color Equations From Fuse Kit - http://www.mosessupposes.com/Fuse/
// 
// 	Copyright (c) 2007-2008 Andrew Fitzgerald - MIT License
//  Creation: 02/21/08
//  Author: Andrew Fitzgerald
//  Homepage: http://play.visualcondition.com/twease/
//

import com.visualcondition.twease.*;
class com.visualcondition.twease.Colors {
	static var version:Number = 1.9;
	static var cl = com.visualcondition.twease.Colors;
	static var clname:String = 'Colors';
	static var exfuncs:Array = ['setColor', 'getColorObject', 'combinecolors'];
	static var exprops:Object = {
		Colors: ['brightness', 'brightOffset', 'contrast', 'invertColor', 'tint'],
		nullhelpers: ['tintPercent']
	};
	static var combinecolors:Boolean = false;
	
	static var nameForCO:String = 'colorObject';
	static var nameForCT:String = 'colorTrans';
	static var nameForCOC:String = 'colorObjectCombine';
	
	//standard class init
	static function init():Void {
		Extend.initExtended(exprops, exfuncs, clname, cl);
	}
	
	//sets up special tween property and inserts an applier to update the prop
	static function setup(prop:String, tweenobj:Object):Void {
		var cop:Color = tweenobj.target[nameForCO];
		var copobj:Object = tweenobj.target[nameForCT];
		var copobjf:Object = tweenobj.target[nameForCOC];
		var rn:Object = Twease.extendedapplies[tweenobj.target + "-" + clname];
		if(cop == undefined){
			cop = tweenobj.target[nameForCO] = new Color(tweenobj.target);
			copobj = tweenobj.target[nameForCT] = cop.getTransform();
		}
		if(rn == undefined){
			var masc:Object = {};
			masc.colorobj = cop;
			masc.currentcolor = copobj;
			rn = Extend.insertapplier(tweenobj, clname, Colors.colorupdater, masc);
		}
		var cch:Boolean = (colorPropCount(tweenobj) >= 2 && tweenobj.stack != true) ? true : Twease.combinecolors;
		var cccs:Boolean = (cch) ? copobjf : null;
		var amount:Number = (prop == 'tint') ? (tweenobj.tintPercent == undefined) ? 100 : tweenobj.tintPercent : tweenobj[prop];
		var temptween:Object = Twease.getColorObject(prop, amount, tweenobj[prop], cccs);
		tweenobj.target[nameForCOC] = temptween;
		for ( var i in tweenobj ) if(Twease.compareInObject(i, Twease.baseprops)) temptween[i] = tweenobj[i];
		temptween.stack = (temptween.stack == undefined && colorPropCount(tweenobj) >= 2) ? false : temptween.stack;
		temptween.target = tweenobj.target[nameForCT];
		rn.realtween = Twease.tween(temptween);
	};
	
	//this is the function that gets called on the applier update every frame
	static function colorupdater(ao:Object):Void {
		ao.tempobj.colorobj.setTransform(ao.tempobj.currentcolor);
		//trace(ao.target);
	};
	
	//returns how many color properties in a tweenobject
	static function colorPropCount(obj:Object):Number{
		var ct:Number = 0;
		for ( var i in obj ){
			if(Twease.compareInObject(i, exprops.Colors)) ct++;
		};
		return ct;
	};
	
	//sets a color and sets it up for future tweening
	static function setColor(target:Object, type:String, amt:Number, rgb:Object):Void {
		var nc = target[nameForCO] = (target[nameForCO] == undefined) ? new Color(target) : target[nameForCO];
		var ct = target[nameForCT] = (target[nameForCT] == undefined) ? nc.getTransform() : target[nameForCT];
		var coc = target[nameForCOC];
		var cccs:Boolean = (Twease.combinecolors) ? coc : null;
		var ncs = target[nameForCOC] = target[nameForCT] = getColorObject(type, amt, rgb, cccs);
		nc.setTransform(ncs);
		if(ncs == getColorObject()){
			delete target[nameForCO];
			delete target[nameForCT];
			delete target[nameForCOC];
		}
	}
	
	//returns the magical object that contains the transformation information
	static function getColorObject(type:String, amt:Number, rgb:Object, cco:Object):Object {
		var cr:Number;
		var cg:Number;
		var cb:Number;
		var cr2:Number;
		var cg2:Number;
		var cb2:Number;
		if(cco != undefined && cco != null){
			cr = cco.rb;
			cb = cco.bb;
			cg = cco.gb;
			cr2 = Math.round(cr/2);
			cb2 = Math.round(cb/2);
			cg2 = Math.round(cg/2);
		} else {
			cr = cb = cg = 255;
			cr2 = cb2 = cg2 = 128;
		}
		switch (type) {
		 case 'brightness' : //amt:-100=black, 0=normal, 100=white
			var percent:Number = (100-Math.abs(amt));
			var offset:Number = ((amt > 0) ? (255*(amt/100)) : 0);
			return {ra:percent, rb:offset, ga:percent, gb:offset, ba:percent, bb:offset};
		 case 'brightOffset' : //"burn" effect. amt:-100=black, 0=normal, 100=white
			return {ra:100, rb:(cr*(amt/100)), ga:100, gb:(cg*(amt/100)), ba:100, bb:(cb*(amt/100))};
		 case 'contrast' : //amt:0=gray, 100=normal, 200=high-contrast, higher=posterized.
			return {ra:amt, rb:(cr2-(cr2/100*amt)), ga:amt, gb:(cg2-(cg2/100*amt)), ba:amt, bb:(cb2-(cb2/100*amt))};
		 case 'invertColor' : //amt:0=normal,50=gray,100=photo-negative
			return {ra:(100-2*amt), rb:(amt*(cr/100)), ga:(100-2*amt), gb:(amt*(cg/100)), ba:(100-2*amt), bb:(amt*(cb/100))};
		 case 'tint' : //amt:0=none,100=solid color (>100=posterized to tint, <0=inverted posterize to tint)
		 	if (rgb != null) {
		 		var rgbnum:Number;
				if (typeof rgb == 'string') {
					if (rgb.charAt(0) == '#') rgb = rgb.slice(1);
					rgb = ((rgb.charAt(1)).toLowerCase()!='x') ? ('0x'+rgb) : (rgb);
				}
				rgbnum = Number(rgb);
				return {ra:(100-amt), rb:(rgbnum >> 16)*(amt/100), ga:(100-amt), gb:((rgbnum >> 8) & 0xFF)*(amt/100), ba:(100-amt), bb:(rgbnum & 0xFF)*(amt/100)};
			}
		}
		return {rb:0, ra:100, gb:0, ga:100, bb:0, ba:100}; //full reset
	};
}