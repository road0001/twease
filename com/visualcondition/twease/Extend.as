//
//  Twease Extended Beta - Extended Functions For Twease
// 
// 	Copyright (c) 2007-2008 Andrew Fitzgerald - MIT License
//  Creation: 08/21/07 | Updated: 02/21/08
//  Author: Andrew Fitzgerald
//  Homepage: http://play.visualcondition.com/twease/
//
import com.visualcondition.twease.*;
class com.visualcondition.twease.Extend {
	static var version:Number = 1.9;
	//standard class init
	static function init():Void {
		Twease.extensions.Extend = com.visualcondition.twease.Extend;
	}
	
	//initiates extended classes into the Twease engine
	static function initExtended(ep:Object, ef:Array, clname:String, cl):Void{
		Extend.init();
		Twease.extensions[clname] = cl;
		initExtendedProps(ep);
		initExtendedMethods(ef, cl);
	};
	
	//checks to see if property is an exteded property
	static function checkExtendedProp(prop):Boolean{
		for ( var i in Twease.extendedprops ){
			if(Twease.extendedprops[i][0] == prop) return true;
		};
		return false;
	};
		
	//initiate extended methods for Twease, so methods can be called via Twease.method_name()
	static function initExtendedMethods(nexfuncs:Array, cl):Void{
		for ( var i in nexfuncs ){
			Twease[nexfuncs[i]] = cl[nexfuncs[i]];
		};
	};
	
	//initiate extended props for Twease
	static function initExtendedProps(nexprops:Object):Void{
		if (Twease.extendedprops == undefined) Twease.extendedprops = {};
		if (Twease.extendedapplies == undefined) Twease.extendedapplies = {};
		for ( var i in nexprops ){
			var pr:Array = nexprops[i];
			for ( var j in pr ){
				Twease.extendedprops[pr[j]] = [pr[j], i];
			};
		};
	};
	
	//prop setup function
	static function propSetup(parr:Array, tobj:Object):Void{
		//trace('Extended Property: ' + parr[0] + ' | Classification: ' + parr[1]);
		if(parr[1] != 'nullhelpers') Twease.extensions[parr[1]].setup(parr[0], tobj);
	};
	
	//garbage collect
	static function garbageCollect():Void {
		//trace("Extended GC");
		for ( var i in Twease.extendedapplies ){
			var ap:Object = Twease.extendedapplies[i];
			if(ap.realtween[0] == undefined) delete Twease.extendedapplies[i];
		};
	};
	
	//create applier
	static function insertapplier(tweenobj:Object, prop:String, func:Function, temptween:Object):Object{
		var nname:String = tweenobj.target + "-" + prop;
		if(nname == "[object Object]" + "-" + prop){
			nname = "Object" + Math.round(Math.random()*1000);
			tweenobj.target['eaname'] = nname;
			nname += "-" + prop;
		}
		return Twease.extendedapplies[nname] = {target:tweenobj.target, tempobj:temptween, applyfunc:func, realtween:null, eaname:nname};
	};
	
	//loop to apply extened appliers
	static function applier():Void{
		for ( var i in Twease.extendedapplies ){
			var ap:Object = Twease.extendedapplies[i];
			ap.applyfunc(ap);
		};
	};
}