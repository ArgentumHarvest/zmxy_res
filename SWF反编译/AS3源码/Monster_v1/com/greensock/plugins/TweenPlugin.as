package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import com.greensock.core.PropTween;
   
   public class TweenPlugin
   {
      
      public static const VERSION:Number = 1.31;
      
      public static const API:Number = 1;
       
      
      public var activeDisable:Boolean;
      
      protected var _changeFactor:Number = 0;
      
      protected var _tweens:Array;
      
      public var onDisable:Function;
      
      public var propName:String;
      
      public var round:Boolean;
      
      public var onEnable:Function;
      
      public var priority:int = 0;
      
      public var overwriteProps:Array;
      
      public var onComplete:Function;
      
      public function TweenPlugin()
      {
         super();
         this._tweens = [];
      }
      
      public static function activate(param1:Array) : Boolean
      {
         var _loc2_:Object = null;
         TweenLite.onPluginEvent = TweenPlugin.onTweenEvent;
         var _loc3_:* = param1.length;
         while(_loc3_--)
         {
            if(param1[_loc3_].hasOwnProperty("API"))
            {
               _loc2_ = new (param1[_loc3_] as Class)();
               TweenLite.plugins[_loc2_.propName] = param1[_loc3_];
            }
         }
         return true;
      }
      
      private static function onTweenEvent(param1:String, param2:TweenLite) : Boolean
      {
         var _loc7_:* = undefined;
         var _loc3_:Boolean = false;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:* = param2.cachedPT1;
         if(param1 == "onInit")
         {
            _loc4_ = [];
            while(_loc6_)
            {
               _loc4_[_loc4_.length] = _loc6_;
               _loc6_ = _loc6_.nextNode;
            }
            _loc4_.sortOn("priority",Array.NUMERIC | Array.DESCENDING);
            _loc5_ = _loc4_.length;
            while(_loc5_--)
            {
               PropTween(_loc4_[_loc5_]).nextNode = _loc4_[_loc5_ + 1];
               PropTween(_loc4_[_loc5_]).prevNode = _loc4_[_loc5_ - 1];
            }
            param2.cachedPT1 = _loc4_[0];
         }
         else
         {
            while(_loc6_)
            {
               if(_loc6_.isPlugin && _loc6_.target[param1])
               {
                  if(_loc6_.target.activeDisable)
                  {
                     _loc3_ = true;
                  }
                  (_loc7_ = _loc6_.target)._loc_3.target[param1]();
               }
               _loc6_ = _loc6_.nextNode;
            }
         }
         return _loc3_;
      }
      
      protected function updateTweens(param1:Number) : void
      {
         var _loc2_:PropTween = null;
         var _loc3_:Number = NaN;
         var _loc4_:* = this._tweens.length;
         if(this.round)
         {
            while(_loc4_--)
            {
               _loc2_ = this._tweens[_loc4_];
               _loc3_ = _loc2_.start + _loc2_.change * param1;
               _loc2_.target[_loc2_.property] = _loc3_ > 0 ? int(_loc3_ + 0.5) : int(_loc3_ - 0.5);
            }
         }
         else
         {
            while(_loc4_--)
            {
               _loc2_ = this._tweens[_loc4_];
               _loc2_.target[_loc2_.property] = _loc2_.start + _loc2_.change * param1;
            }
         }
      }
      
      protected function addTween(param1:Object, param2:String, param3:Number, param4:*, param5:String = null) : void
      {
         var _loc6_:Number = NaN;
         if(param4 != null)
         {
            if((_loc6_ = typeof param4 == "number" ? Number(Number(param4) - param3) : Number(Number(param4))) != 0)
            {
               this._tweens[this._tweens.length] = new PropTween(param1,param2,param3,_loc6_,param5 || param2,false);
            }
         }
      }
      
      public function get changeFactor() : Number
      {
         return this._changeFactor;
      }
      
      public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         this.addTween(param1,this.propName,param1[this.propName],param2,this.propName);
         return true;
      }
      
      public function killProps(param1:Object) : void
      {
         var _loc2_:* = this.overwriteProps.length;
         while(_loc2_--)
         {
            if(this.overwriteProps[_loc2_] in param1)
            {
               this.overwriteProps.splice(_loc2_,1);
            }
         }
         _loc2_ = this._tweens.length;
         while(_loc2_--)
         {
            if(PropTween(this._tweens[_loc2_]).name in param1)
            {
               this._tweens.splice(_loc2_,1);
            }
         }
      }
      
      public function set changeFactor(param1:Number) : void
      {
         this.updateTweens(param1);
         this._changeFactor = param1;
      }
   }
}
