package com.greensock
{
   import com.greensock.core.*;
   
   public class OverwriteManager
   {
      
      public static const ALL_ONSTART:int = 4;
      
      public static const CONCURRENT:int = 3;
      
      public static const ALL_IMMEDIATE:int = 1;
      
      public static const PREEXISTING:int = 5;
      
      public static const AUTO:int = 2;
      
      public static const version:Number = 6.02;
      
      public static const NONE:int = 0;
      
      public static var enabled:Boolean;
      
      public static var mode:int;
       
      
      public function OverwriteManager()
      {
         super();
      }
      
      public static function getGlobalPaused(param1:TweenCore) : Boolean
      {
         while(param1)
         {
            if(param1.cachedPaused)
            {
               return true;
            }
            param1 = param1.timeline;
         }
         return false;
      }
      
      public static function init(param1:int = 2) : int
      {
         if(TweenLite.version < 11.1)
         {
            throw new Error("Warning: Your TweenLite class needs to be updated to work with OverwriteManager (or you may need to clear your ASO files). Please download and install the latest version from http://www.tweenlite.com.");
         }
         TweenLite.overwriteManager = OverwriteManager;
         mode = param1;
         enabled = true;
         return mode;
      }
      
      public static function manageOverwrites(param1:TweenLite, param2:Object, param3:Array, param4:uint) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:Boolean = false;
         var _loc7_:TweenLite = null;
         var _loc8_:uint = 0;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:TweenCore = null;
         var _loc12_:Number = NaN;
         var _loc13_:SimpleTimeline = null;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc19_:* = undefined;
         var _loc20_:* = undefined;
         var _loc21_:* = undefined;
         var _loc22_:* = undefined;
         if(param4 >= 4)
         {
            _loc8_ = param3.length;
            _loc5_ = 0;
            while(_loc5_ < _loc8_)
            {
               if((_loc7_ = param3[_loc5_]) != param1)
               {
                  if(_loc7_.setEnabled(false,false))
                  {
                     _loc6_ = true;
                  }
               }
               else if(param4 == 5)
               {
                  break;
               }
               _loc5_++;
            }
            return _loc6_;
         }
         var _loc14_:Number = param1.cachedStartTime + 1e-10;
         var _loc15_:Array = [];
         var _loc16_:Array = [];
         _loc5_ = param3.length;
         while(--_loc5_ > -1)
         {
            if(!((_loc7_ = param3[_loc5_]) == param1 || _loc7_.gc))
            {
               if(_loc7_.timeline != param1.timeline)
               {
                  if(!getGlobalPaused(_loc7_))
                  {
                     _loc19_ = _loc17_;
                     _loc17_ += 1;
                     _loc20_ = _loc19_;
                     _loc16_[_loc20_] = _loc7_;
                  }
               }
               else if(_loc7_.cachedStartTime <= _loc14_ && _loc7_.cachedStartTime + _loc7_.totalDuration + 1e-10 > _loc14_ && !getGlobalPaused(_loc7_))
               {
                  _loc21_ = _loc18_;
                  _loc18_ += 1;
                  _loc20_ = _loc21_;
                  _loc15_[_loc20_] = _loc7_;
               }
            }
         }
         if(_loc17_ != 0)
         {
            _loc9_ = param1.cachedTimeScale;
            _loc10_ = _loc14_;
            _loc13_ = param1.timeline;
            while(_loc13_)
            {
               _loc9_ *= _loc13_.cachedTimeScale;
               _loc10_ += _loc13_.cachedStartTime;
               _loc13_ = _loc13_.timeline;
            }
            _loc14_ = _loc9_ * _loc10_;
            _loc5_ = _loc17_;
            while(--_loc5_ > -1)
            {
               _loc9_ = (_loc11_ = _loc16_[_loc5_]).cachedTimeScale;
               _loc10_ = _loc11_.cachedStartTime;
               _loc13_ = _loc11_.timeline;
               while(_loc13_)
               {
                  _loc9_ *= _loc13_.cachedTimeScale;
                  _loc10_ += _loc13_.cachedStartTime;
                  _loc13_ = _loc13_.timeline;
               }
               if((_loc12_ = _loc9_ * _loc10_) <= _loc14_ && (_loc12_ + _loc11_.totalDuration * _loc9_ + 1e-10 > _loc14_ || _loc11_.cachedDuration == 0))
               {
                  _loc22_ = _loc18_;
                  _loc18_ += 1;
                  _loc20_ = _loc22_;
                  _loc15_[_loc20_] = _loc11_;
               }
            }
         }
         if(_loc18_ == 0)
         {
            return _loc6_;
         }
         _loc5_ = _loc18_;
         if(param4 == 2)
         {
            while(--_loc5_ > -1)
            {
               if((_loc7_ = _loc15_[_loc5_]).killVars(param2))
               {
                  _loc6_ = true;
               }
               if(_loc7_.cachedPT1 == null && _loc7_.initted)
               {
                  _loc7_.setEnabled(false,false);
               }
            }
         }
         else
         {
            while(--_loc5_ > -1)
            {
               if(TweenLite(_loc15_[_loc5_]).setEnabled(false,false))
               {
                  _loc6_ = true;
               }
            }
         }
         return _loc6_;
      }
   }
}
