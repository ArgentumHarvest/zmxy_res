package com.greensock
{
   import com.greensock.core.PropTween;
   import com.greensock.core.SimpleTimeline;
   import com.greensock.core.TweenCore;
   import com.greensock.events.TweenEvent;
   import com.greensock.plugins.AutoAlphaPlugin;
   import com.greensock.plugins.BevelFilterPlugin;
   import com.greensock.plugins.BezierPlugin;
   import com.greensock.plugins.BezierThroughPlugin;
   import com.greensock.plugins.BlurFilterPlugin;
   import com.greensock.plugins.ColorMatrixFilterPlugin;
   import com.greensock.plugins.ColorTransformPlugin;
   import com.greensock.plugins.DropShadowFilterPlugin;
   import com.greensock.plugins.EndArrayPlugin;
   import com.greensock.plugins.FrameLabelPlugin;
   import com.greensock.plugins.FramePlugin;
   import com.greensock.plugins.GlowFilterPlugin;
   import com.greensock.plugins.HexColorsPlugin;
   import com.greensock.plugins.RemoveTintPlugin;
   import com.greensock.plugins.RoundPropsPlugin;
   import com.greensock.plugins.ShortRotationPlugin;
   import com.greensock.plugins.TintPlugin;
   import com.greensock.plugins.TweenPlugin;
   import com.greensock.plugins.VisiblePlugin;
   import com.greensock.plugins.VolumePlugin;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class TweenMax extends TweenLite implements IEventDispatcher
   {
      
      public static const version:Number = 11.37;
      
      private static var _overwriteMode:int = !!OverwriteManager.enabled ? int(OverwriteManager.mode) : int(OverwriteManager.init(2));
      
      public static var killTweensOf:Function = TweenLite.killTweensOf;
      
      public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;
      
      {
         TweenPlugin.activate([AutoAlphaPlugin,EndArrayPlugin,FramePlugin,RemoveTintPlugin,TintPlugin,VisiblePlugin,VolumePlugin,BevelFilterPlugin,BezierPlugin,BezierThroughPlugin,BlurFilterPlugin,ColorMatrixFilterPlugin,ColorTransformPlugin,DropShadowFilterPlugin,FrameLabelPlugin,GlowFilterPlugin,HexColorsPlugin,RoundPropsPlugin,ShortRotationPlugin,{}]);
      }
      
      protected var _cyclesComplete:uint = 0;
      
      protected var _dispatcher:EventDispatcher;
      
      protected var _hasUpdateListener:Boolean;
      
      protected var _easeType:uint;
      
      protected var _repeatDelay:Number = 0;
      
      public var yoyo:Boolean;
      
      protected var _easePower:uint;
      
      protected var _repeat:int = 0;
      
      public function TweenMax(param1:Object, param2:Number, param3:Object)
      {
         super(param1,param2,param3);
         if(TweenLite.version < 11.2)
         {
            throw new Error("TweenMax error! Please update your TweenLite class or try deleting your ASO files. TweenMax requires a more recent version. Download updates at http://www.TweenMax.com.");
         }
         this.yoyo = Boolean(this.vars.yoyo);
         this._repeat = !!this.vars.repeat ? int(int(this.vars.repeat)) : 0;
         this._repeatDelay = !!this.vars.repeatDelay ? Number(Number(this.vars.repeatDelay)) : Number(0);
         this.cacheIsDirty = true;
         if(this.vars.onCompleteListener || this.vars.onInitListener || this.vars.onUpdateListener || this.vars.onStartListener || this.vars.onRepeatListener || this.vars.onReverseCompleteListener)
         {
            this.initDispatcher();
            if(param2 == 0 && _delay == 0)
            {
               this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
               this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.COMPLETE));
            }
         }
         if(this.vars.timeScale && !(this.target is TweenCore))
         {
            this.cachedTimeScale = this.vars.timeScale;
         }
      }
      
      public static function set globalTimeScale(param1:Number) : void
      {
         if(param1 == 0)
         {
            param1 = 0.0001;
         }
         if(TweenLite.rootTimeline == null)
         {
            TweenLite.to({},0,{});
         }
         var _loc2_:SimpleTimeline = TweenLite.rootTimeline;
         var _loc3_:Number = getTimer() * 0.001;
         _loc2_.cachedStartTime = _loc3_ - (_loc3_ - _loc2_.cachedStartTime) * _loc2_.cachedTimeScale / param1;
         _loc2_ = TweenLite.rootFramesTimeline;
         _loc3_ = TweenLite.rootFrame;
         _loc2_.cachedStartTime = _loc3_ - (_loc3_ - _loc2_.cachedStartTime) * _loc2_.cachedTimeScale / param1;
         TweenLite.rootFramesTimeline.cachedTimeScale = TweenLite.rootTimeline.cachedTimeScale = param1;
      }
      
      public static function fromTo(param1:Object, param2:Number, param3:Object, param4:Object) : TweenMax
      {
         param4.startAt = param3;
         if(param3.immediateRender)
         {
            param4.immediateRender = true;
         }
         return new TweenMax(param1,param2,param4);
      }
      
      public static function allFromTo(param1:Array, param2:Number, param3:Object, param4:Object, param5:Number = 0, param6:Function = null, param7:Array = null) : Array
      {
         param4.startAt = param3;
         if(param3.immediateRender)
         {
            param4.immediateRender = true;
         }
         return allTo(param1,param2,param4,param5,param6,param7);
      }
      
      public static function pauseAll(param1:Boolean = true, param2:Boolean = true) : void
      {
         changePause(true,param1,param2);
      }
      
      public static function getTweensOf(param1:Object) : Array
      {
         var _loc2_:int = 0;
         var _loc3_:uint = 0;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc4_:Array = masterList[param1];
         var _loc5_:Array = [];
         if(_loc4_)
         {
            _loc2_ = _loc4_.length;
            _loc3_ = 0;
            while(--_loc2_ > -1)
            {
               if(!_loc4_[_loc2_].gc)
               {
                  _loc6_ = _loc3_;
                  _loc3_ += 1;
                  _loc7_ = _loc6_;
                  _loc5_[_loc7_] = _loc4_[_loc2_];
               }
            }
         }
         return _loc5_;
      }
      
      public static function get globalTimeScale() : Number
      {
         return TweenLite.rootTimeline == null ? Number(1) : Number(TweenLite.rootTimeline.cachedTimeScale);
      }
      
      public static function killChildTweensOf(param1:DisplayObjectContainer, param2:Boolean = false) : void
      {
         var _loc3_:Object = null;
         var _loc4_:DisplayObjectContainer = null;
         var _loc5_:Array;
         var _loc6_:int = (_loc5_ = getAllTweens()).length;
         while(--_loc6_ > -1)
         {
            _loc3_ = _loc5_[_loc6_].target;
            if(_loc3_ is DisplayObject)
            {
               _loc4_ = _loc3_.parent;
               while(_loc4_)
               {
                  if(_loc4_ == param1)
                  {
                     if(param2)
                     {
                        _loc5_[_loc6_].complete(false);
                     }
                     else
                     {
                        _loc5_[_loc6_].setEnabled(false,false);
                     }
                  }
                  _loc4_ = _loc4_.parent;
               }
            }
         }
      }
      
      public static function delayedCall(param1:Number, param2:Function, param3:Array = null, param4:Boolean = false) : TweenMax
      {
         return new TweenMax(param2,0,{
            "delay":param1,
            "onComplete":param2,
            "onCompleteParams":param3,
            "immediateRender":false,
            "useFrames":param4,
            "overwrite":0
         });
      }
      
      public static function isTweening(param1:Object) : Boolean
      {
         var _loc2_:TweenLite = null;
         var _loc3_:Array = getTweensOf(param1);
         var _loc4_:int = _loc3_.length;
         while(--_loc4_ > -1)
         {
            _loc2_ = _loc3_[_loc4_];
            if(_loc2_.active || _loc2_.cachedStartTime == _loc2_.timeline.cachedTime && _loc2_.timeline.active)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function killAll(param1:Boolean = false, param2:Boolean = true, param3:Boolean = true) : void
      {
         var _loc4_:* = false;
         var _loc5_:Array;
         var _loc6_:int = (_loc5_ = getAllTweens()).length;
         while(--_loc6_ > -1)
         {
            if((_loc4_ = _loc5_[_loc6_].target == _loc5_[_loc6_].vars.onComplete) == param3 || _loc4_ != param2)
            {
               if(param1)
               {
                  _loc5_[_loc6_].complete(false);
               }
               else
               {
                  _loc5_[_loc6_].setEnabled(false,false);
               }
            }
         }
      }
      
      private static function changePause(param1:Boolean, param2:Boolean = true, param3:Boolean = false) : void
      {
         var _loc4_:* = false;
         var _loc5_:Array;
         var _loc6_:int = (_loc5_ = getAllTweens()).length;
         while(--_loc6_ > -1)
         {
            if((_loc4_ = TweenLite(_loc5_[_loc6_]).target == TweenLite(_loc5_[_loc6_]).vars.onComplete) == param3 || _loc4_ != param2)
            {
               TweenCore(_loc5_[_loc6_]).paused = param1;
            }
         }
      }
      
      public static function from(param1:Object, param2:Number, param3:Object) : TweenMax
      {
         param3.runBackwards = true;
         if(!("immediateRender" in param3))
         {
            param3.immediateRender = true;
         }
         return new TweenMax(param1,param2,param3);
      }
      
      public static function allFrom(param1:Array, param2:Number, param3:Object, param4:Number = 0, param5:Function = null, param6:Array = null) : Array
      {
         param3.runBackwards = true;
         if(!("immediateRender" in param3))
         {
            param3.immediateRender = true;
         }
         return allTo(param1,param2,param3,param4,param5,param6);
      }
      
      public static function getAllTweens() : Array
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc4_:uint = 0;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc3_:Dictionary = masterList;
         var _loc5_:Array = [];
         for each(_loc1_ in _loc3_)
         {
            _loc2_ = _loc1_.length;
            while(--_loc2_ > -1)
            {
               if(!TweenLite(_loc1_[_loc2_]).gc)
               {
                  _loc6_ = _loc4_;
                  _loc4_ += 1;
                  _loc7_ = _loc6_;
                  _loc5_[_loc7_] = _loc1_[_loc2_];
               }
            }
         }
         return _loc5_;
      }
      
      public static function resumeAll(param1:Boolean = true, param2:Boolean = true) : void
      {
         changePause(false,param1,param2);
      }
      
      public static function to(param1:Object, param2:Number, param3:Object) : TweenMax
      {
         return new TweenMax(param1,param2,param3);
      }
      
      public static function allTo(param1:Array, param2:Number, param3:Object, param4:Number = 0, param5:Function = null, param6:Array = null) : Array
      {
         var onCompleteProxy:* = undefined;
         var onCompleteParamsProxy:* = undefined;
         var onCompleteAll:* = undefined;
         var onCompleteAllParams:* = undefined;
         var _arg1:Array = param1;
         var _arg2:Number = param2;
         var _arg3:Object = param3;
         var _arg4:Number = param4;
         var _arg5:Function = param5;
         var _arg6:Array = param6;
         var i:* = 0;
         var varsDup:* = null;
         var p:* = null;
         onCompleteProxy = null;
         onCompleteParamsProxy = null;
         var targets:* = _arg1;
         var duration:* = _arg2;
         var vars:* = _arg3;
         var stagger:int = _arg4;
         onCompleteAll = _arg5;
         onCompleteAllParams = _arg6;
         var l:* = targets.length;
         var a:* = [];
         var curDelay:* = "delay" in vars ? Number(vars.delay) : 0;
         onCompleteProxy = vars.onComplete;
         onCompleteParamsProxy = vars.onCompleteParams;
         var lastIndex:* = stagger <= 0 ? 0 : l - 1;
         i = 0;
         while(i < l)
         {
            varsDup = {};
            for(p in vars)
            {
               varsDup[p] = vars[p];
            }
            varsDup.delay = curDelay;
            if(i == lastIndex && onCompleteAll != null)
            {
               varsDup.onComplete = function():void
               {
                  if(onCompleteProxy != null)
                  {
                     onCompleteProxy.apply(null,onCompleteParamsProxy);
                  }
                  onCompleteAll.apply(null,onCompleteAllParams);
               };
            }
            a[a.length] = new TweenMax(targets[i],duration,varsDup);
            curDelay += stagger;
            i += 1;
         }
         return a;
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return this._dispatcher == null ? false : Boolean(this._dispatcher.dispatchEvent(param1));
      }
      
      public function set timeScale(param1:Number) : void
      {
         if(param1 == 0)
         {
            param1 = 0.0001;
         }
         var _loc2_:Number = _pauseTime || _pauseTime == 0 ? Number(_pauseTime) : Number(this.timeline.cachedTotalTime);
         this.cachedStartTime = _loc2_ - (_loc2_ - this.cachedStartTime) * this.cachedTimeScale / param1;
         this.cachedTimeScale = param1;
         setDirtyCache(false);
      }
      
      override public function renderTime(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         var _loc11_:Number = !!this.cacheIsDirty ? Number(this.totalDuration) : Number(this.cachedTotalDuration);
         var _loc12_:Number = this.cachedTime;
         if(param1 >= _loc11_)
         {
            this.cachedTotalTime = _loc11_;
            this.cachedTime = this.cachedDuration;
            this.ratio = 1;
            _loc4_ = true;
            if(this.cachedDuration == 0)
            {
               if((param1 == 0 || _rawPrevTime < 0) && _rawPrevTime != param1)
               {
                  param3 = true;
               }
               _rawPrevTime = param1;
            }
         }
         else if(param1 <= 0)
         {
            if(param1 < 0)
            {
               this.active = false;
               if(this.cachedDuration == 0)
               {
                  if(_rawPrevTime > 0)
                  {
                     param3 = true;
                     _loc4_ = true;
                  }
                  _rawPrevTime = param1;
               }
            }
            this.cachedTotalTime = this.cachedTime = this.ratio = 0;
            if(this.cachedReversed && _loc12_ != 0)
            {
               _loc4_ = true;
            }
         }
         else
         {
            this.cachedTotalTime = this.cachedTime = param1;
            _loc6_ = true;
         }
         if(this._repeat != 0)
         {
            _loc7_ = this.cachedDuration + this._repeatDelay;
            if(_loc4_)
            {
               if(this.yoyo && this._repeat % 2)
               {
                  this.cachedTime = this.ratio = 0;
               }
            }
            else if(param1 > 0)
            {
               _loc8_ = this._cyclesComplete;
               this._cyclesComplete = int(this.cachedTotalTime / _loc7_);
               if(this._cyclesComplete == this.cachedTotalTime / _loc7_)
               {
                  --this._cyclesComplete;
               }
               if(_loc8_ != this._cyclesComplete)
               {
                  _loc5_ = true;
               }
               this.cachedTime = (this.cachedTotalTime / _loc7_ - this._cyclesComplete) * _loc7_;
               if(this.yoyo && this._cyclesComplete % 2)
               {
                  this.cachedTime = this.cachedDuration - this.cachedTime;
               }
               else if(this.cachedTime >= this.cachedDuration)
               {
                  this.cachedTime = this.cachedDuration;
                  this.ratio = 1;
                  _loc6_ = false;
               }
               if(this.cachedTime <= 0)
               {
                  this.cachedTime = this.ratio = 0;
                  _loc6_ = false;
               }
            }
         }
         if(_loc12_ == this.cachedTime && !param3)
         {
            return;
         }
         if(!this.initted)
         {
            this.init();
         }
         if(!this.active && !this.cachedPaused)
         {
            this.active = true;
         }
         if(_loc6_)
         {
            if(this._easeType)
            {
               _loc9_ = this._easePower;
               _loc10_ = this.cachedTime / this.cachedDuration;
               if(this._easeType == 2)
               {
                  _loc10_ = 1 - _loc10_;
                  this.ratio = _loc10_;
                  while(--_loc9_ > -1)
                  {
                     this.ratio = _loc10_ * this.ratio;
                  }
                  this.ratio = 1 - this.ratio;
               }
               else if(this._easeType == 1)
               {
                  this.ratio = _loc10_;
                  while(--_loc9_ > -1)
                  {
                     this.ratio = _loc10_ * this.ratio;
                  }
               }
               else if(_loc10_ < 0.5)
               {
                  _loc10_ *= 2;
                  this.ratio = _loc10_;
                  while(--_loc9_ > -1)
                  {
                     this.ratio = _loc10_ * this.ratio;
                  }
                  this.ratio *= 0.5;
               }
               else
               {
                  _loc10_ = (1 - _loc10_) * 2;
                  this.ratio = _loc10_;
                  while(--_loc9_ > -1)
                  {
                     this.ratio = _loc10_ * this.ratio;
                  }
                  this.ratio = 1 - 0.5 * this.ratio;
               }
            }
            else
            {
               this.ratio = _ease(this.cachedTime,0,1,this.cachedDuration);
            }
         }
         if(_loc12_ == 0 && this.cachedTotalTime != 0 && !param2)
         {
            if(this.vars.onStart)
            {
               this.vars.onStart.apply(null,this.vars.onStartParams);
            }
            if(this._dispatcher)
            {
               this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.START));
            }
         }
         var _loc13_:PropTween = this.cachedPT1;
         while(_loc13_)
         {
            _loc13_.target[_loc13_.property] = _loc13_.start + this.ratio * _loc13_.change;
            _loc13_ = _loc13_.nextNode;
         }
         if(_hasUpdate && !param2)
         {
            this.vars.onUpdate.apply(null,this.vars.onUpdateParams);
         }
         if(this._hasUpdateListener && !param2)
         {
            this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
         }
         if(_loc4_)
         {
            if(_hasPlugins && this.cachedPT1)
            {
               onPluginEvent("onComplete",this);
            }
            this.complete(true,param2);
         }
         else if(_loc5_ && !param2)
         {
            if(this.vars.onRepeat)
            {
               this.vars.onRepeat.apply(null,this.vars.onRepeatParams);
            }
            if(this._dispatcher)
            {
               this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.REPEAT));
            }
         }
      }
      
      override public function set totalDuration(param1:Number) : void
      {
         if(this._repeat == -1)
         {
            return;
         }
         this.duration = (param1 - this._repeat * this._repeatDelay) / (this._repeat + 1);
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         if(this._dispatcher == null)
         {
            this.initDispatcher();
         }
         if(param1 == TweenEvent.UPDATE)
         {
            this._hasUpdateListener = true;
         }
         this._dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      protected function insertPropTween(param1:Object, param2:String, param3:Number, param4:*, param5:String, param6:Boolean, param7:PropTween) : PropTween
      {
         var _loc8_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:PropTween = new PropTween(param1,param2,param3,typeof param4 == "number" ? Number(param4 - param3) : Number(Number(param4)),param5,param6,param7);
         if(param6 && param5 == "_MULTIPLE_")
         {
            _loc9_ = (_loc8_ = param1.overwriteProps).length;
            while(--_loc9_ > -1)
            {
               this.propTweenLookup[_loc8_[_loc9_]] = _loc10_;
            }
         }
         else
         {
            this.propTweenLookup[param5] = _loc10_;
         }
         return _loc10_;
      }
      
      override protected function init() : void
      {
         var _loc1_:TweenMax = null;
         var _loc2_:String = null;
         var _loc3_:* = null;
         var _loc4_:Array = null;
         var _loc5_:Object = null;
         var _loc6_:PropTween = null;
         var _loc7_:PropTween = null;
         var _loc8_:int = 0;
         if(this.vars.startAt)
         {
            this.vars.startAt.overwrite = 0;
            this.vars.startAt.immediateRender = true;
            _loc1_ = new TweenMax(this.target,0,this.vars.startAt);
         }
         if(this._dispatcher)
         {
            this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.INIT));
         }
         super.init();
         if(_ease in fastEaseLookup)
         {
            this._easeType = fastEaseLookup[_ease][0];
            this._easePower = fastEaseLookup[_ease][1];
         }
         if(this.vars.roundProps != null && "roundProps" in TweenLite.plugins)
         {
            _loc8_ = (_loc4_ = this.vars.roundProps).length;
            while(--_loc8_ > -1)
            {
               _loc2_ = _loc4_[_loc8_];
               _loc7_ = this.cachedPT1;
               while(_loc7_)
               {
                  if(_loc7_.name == _loc2_)
                  {
                     if(_loc7_.isPlugin)
                     {
                        _loc7_.target.round = true;
                     }
                     else
                     {
                        if(_loc5_ == null)
                        {
                           (_loc5_ = new TweenLite.plugins.roundProps()).add(_loc7_.target,_loc2_,_loc7_.start,_loc7_.change);
                           _hasPlugins = true;
                           _loc6_ = this.insertPropTween(_loc5_,"changeFactor",0,1,"_MULTIPLE_",true,this.cachedPT1);
                           this.cachedPT1 = _loc6_;
                        }
                        else
                        {
                           _loc5_.add(_loc7_.target,_loc2_,_loc7_.start,_loc7_.change);
                        }
                        this.removePropTween(_loc7_);
                        this.propTweenLookup[_loc2_] = _loc6_;
                     }
                  }
                  else if(_loc7_.isPlugin && _loc7_.name == "_MULTIPLE_" && !_loc7_.target.round)
                  {
                     _loc3_ = " " + _loc7_.target.overwriteProps.join(" ") + " ";
                     if(_loc3_.indexOf(" " + _loc2_ + " ") != -1)
                     {
                        _loc7_.target.round = true;
                     }
                  }
                  _loc7_ = _loc7_.nextNode;
               }
            }
         }
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         if(this._dispatcher)
         {
            this._dispatcher.removeEventListener(param1,param2,param3);
         }
      }
      
      public function setDestination(param1:String, param2:*, param3:Boolean = true) : void
      {
         var _loc4_:Object;
         (_loc4_ = {})[param1] = param2;
         this.updateTo(_loc4_,!param3);
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return this._dispatcher == null ? false : Boolean(this._dispatcher.willTrigger(param1));
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return this._dispatcher == null ? false : Boolean(this._dispatcher.hasEventListener(param1));
      }
      
      protected function initDispatcher() : void
      {
         if(this._dispatcher == null)
         {
            this._dispatcher = new EventDispatcher(this);
         }
         if(this.vars.onInitListener is Function)
         {
            this._dispatcher.addEventListener(TweenEvent.INIT,this.vars.onInitListener,false,0,true);
         }
         if(this.vars.onStartListener is Function)
         {
            this._dispatcher.addEventListener(TweenEvent.START,this.vars.onStartListener,false,0,true);
         }
         if(this.vars.onUpdateListener is Function)
         {
            this._dispatcher.addEventListener(TweenEvent.UPDATE,this.vars.onUpdateListener,false,0,true);
            this._hasUpdateListener = true;
         }
         if(this.vars.onCompleteListener is Function)
         {
            this._dispatcher.addEventListener(TweenEvent.COMPLETE,this.vars.onCompleteListener,false,0,true);
         }
         if(this.vars.onRepeatListener is Function)
         {
            this._dispatcher.addEventListener(TweenEvent.REPEAT,this.vars.onRepeatListener,false,0,true);
         }
         if(this.vars.onReverseCompleteListener is Function)
         {
            this._dispatcher.addEventListener(TweenEvent.REVERSE_COMPLETE,this.vars.onReverseCompleteListener,false,0,true);
         }
      }
      
      public function set currentProgress(param1:Number) : void
      {
         if(this._cyclesComplete == 0)
         {
            setTotalTime(this.duration * param1,false);
         }
         else
         {
            setTotalTime(this.duration * param1 + this._cyclesComplete * this.cachedDuration,false);
         }
      }
      
      public function get totalProgress() : Number
      {
         return this.cachedTotalTime / this.totalDuration;
      }
      
      public function set totalProgress(param1:Number) : void
      {
         setTotalTime(this.totalDuration * param1,false);
      }
      
      protected function removePropTween(param1:PropTween) : Boolean
      {
         if(param1.nextNode)
         {
            param1.nextNode.prevNode = param1.prevNode;
         }
         if(param1.prevNode)
         {
            param1.prevNode.nextNode = param1.nextNode;
         }
         else if(this.cachedPT1 == param1)
         {
            this.cachedPT1 = param1.nextNode;
         }
         if(param1.isPlugin && param1.target.onDisable)
         {
            param1.target.onDisable();
            if(param1.target.activeDisable)
            {
               return true;
            }
         }
         return false;
      }
      
      public function get currentProgress() : Number
      {
         return this.cachedTime / this.duration;
      }
      
      public function get repeat() : int
      {
         return this._repeat;
      }
      
      public function updateTo(param1:Object, param2:Boolean = false) : void
      {
         var _loc3_:* = null;
         var _loc4_:Number = NaN;
         var _loc5_:PropTween = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = this.ratio;
         if(param2 && this.timeline != null && this.cachedStartTime < this.timeline.cachedTime)
         {
            this.cachedStartTime = this.timeline.cachedTime;
            this.setDirtyCache(false);
            if(this.gc)
            {
               this.setEnabled(true,false);
            }
            else
            {
               this.timeline.addChild(this);
            }
         }
         for(_loc3_ in param1)
         {
            this.vars[_loc3_] = param1[_loc3_];
         }
         if(this.initted)
         {
            this.initted = false;
            if(!param2)
            {
               this.init();
               if(!param2 && this.cachedTime > 0 && this.cachedTime < this.cachedDuration)
               {
                  _loc4_ = 1 / (1 - _loc7_);
                  _loc5_ = this.cachedPT1;
                  while(_loc5_)
                  {
                     _loc6_ = _loc5_.start + _loc5_.change;
                     _loc5_.change *= _loc4_;
                     _loc5_.start = _loc6_ - _loc5_.change;
                     _loc5_ = _loc5_.nextNode;
                  }
               }
            }
         }
      }
      
      override public function set currentTime(param1:Number) : void
      {
         if(this._cyclesComplete != 0)
         {
            if(this.yoyo && this._cyclesComplete % 2 == 1)
            {
               param1 = this.duration - param1 + this._cyclesComplete * (this.cachedDuration + this._repeatDelay);
            }
            else
            {
               param1 += this._cyclesComplete * (this.duration + this._repeatDelay);
            }
         }
         setTotalTime(param1,false);
      }
      
      public function get repeatDelay() : Number
      {
         return this._repeatDelay;
      }
      
      public function killProperties(param1:Array) : void
      {
         var _loc2_:Object = {};
         var _loc3_:int = param1.length;
         while(--_loc3_ > -1)
         {
            _loc2_[param1[_loc3_]] = true;
         }
         killVars(_loc2_);
      }
      
      public function set repeatDelay(param1:Number) : void
      {
         this._repeatDelay = param1;
         setDirtyCache(true);
      }
      
      public function set repeat(param1:int) : void
      {
         this._repeat = param1;
         setDirtyCache(true);
      }
      
      override public function complete(param1:Boolean = false, param2:Boolean = false) : void
      {
         super.complete(param1,param2);
         if(!param2 && this._dispatcher)
         {
            if(this.cachedTotalTime == this.cachedTotalDuration && !this.cachedReversed)
            {
               this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.COMPLETE));
            }
            else if(this.cachedReversed && this.cachedTotalTime == 0)
            {
               this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.REVERSE_COMPLETE));
            }
         }
      }
      
      override public function invalidate() : void
      {
         this.yoyo = Boolean(this.vars.yoyo == true);
         this._repeat = !!this.vars.repeat ? int(Number(this.vars.repeat)) : 0;
         this._repeatDelay = !!this.vars.repeatDelay ? Number(Number(this.vars.repeatDelay)) : Number(0);
         this._hasUpdateListener = false;
         if(this.vars.onCompleteListener != null || this.vars.onUpdateListener != null || this.vars.onStartListener != null)
         {
            this.initDispatcher();
         }
         setDirtyCache(true);
         super.invalidate();
      }
      
      public function get timeScale() : Number
      {
         return this.cachedTimeScale;
      }
      
      override public function get totalDuration() : Number
      {
         if(this.cacheIsDirty)
         {
            this.cachedTotalDuration = this._repeat == -1 ? Number(999999999999) : Number(this.cachedDuration * (this._repeat + 1) + this._repeatDelay * this._repeat);
            this.cacheIsDirty = false;
         }
         return this.cachedTotalDuration;
      }
   }
}
