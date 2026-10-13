package com.greensock.plugins
{
   import com.greensock.TweenLite;
   
   public class BezierPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
      
      protected static const _RAD2DEG:Number = 57.2957795130823;
       
      
      protected var _future:Object;
      
      protected var _orient:Boolean;
      
      protected var _orientData:Array;
      
      protected var _target:Object;
      
      protected var _beziers:Object;
      
      public function BezierPlugin()
      {
         _future = {};
         super();
         this.propName = "bezier";
         this.overwriteProps = [];
      }
      
      public static function parseBeziers(_arg1:Object, _arg2:Boolean = false) : Object
      {
         var _local3:int = 0;
         var _local4:* = null;
         var _local5:* = null;
         var _local6:* = null;
         var _local7:Object = {};
         if(_arg2)
         {
            for(_local6 in _arg1)
            {
               _local4 = _arg1[_local6];
               _local5 = [];
               _local7[_local6] = _local5;
               if(_local4.length > 2)
               {
                  _local5[_local5.length] = [_local4[0],_local4[1] - (_local4[2] - _local4[0]) / 4,_local4[1]];
                  _local3 = 1;
                  while(_local3 < _local4.length - 1)
                  {
                     _local5[_local5.length] = [_local4[_local3],_local4[_local3] + (_local4[_local3] - _local5[_local3 - 1][1]),_local4[_local3 + 1]];
                     _local3++;
                  }
               }
               else
               {
                  _local5[_local5.length] = [_local4[0],(_local4[0] + _local4[1]) / 2,_local4[1]];
               }
            }
         }
         else
         {
            for(_local6 in _arg1)
            {
               _local4 = _arg1[_local6];
               _local5 = [];
               _local7[_local6] = _local5;
               if(_local4.length > 3)
               {
                  _local5[_local5.length] = [_local4[0],_local4[1],(_local4[1] + _local4[2]) / 2];
                  _local3 = 2;
                  while(_local3 < _local4.length - 2)
                  {
                     _local5[_local5.length] = [_local5[_local3 - 2][2],_local4[_local3],(_local4[_local3] + _local4[_local3 + 1]) / 2];
                     _local3++;
                  }
                  _local5[_local5.length] = [_local5[_local5.length - 1][2],_local4[_local4.length - 2],_local4[_local4.length - 1]];
               }
               else if(_local4.length == 3)
               {
                  _local5[_local5.length] = [_local4[0],_local4[1],_local4[2]];
               }
               else if(_local4.length == 2)
               {
                  _local5[_local5.length] = [_local4[0],(_local4[0] + _local4[1]) / 2,_local4[1]];
               }
            }
         }
         return _local7;
      }
      
      override public function killProps(_arg1:Object) : void
      {
         var _local2:* = null;
         for(_local2 in _beziers)
         {
            if(_local2 in _arg1)
            {
               delete _beziers[_local2];
            }
         }
         super.killProps(_arg1);
      }
      
      protected function init(_arg1:TweenLite, _arg2:Array, _arg3:Boolean) : void
      {
         var _local6:int = 0;
         var _local7:* = null;
         var _local8:* = null;
         _target = _arg1.target;
         var _local4:Object = _arg1.vars.isTV == true ? _arg1.vars.exposedVars : _arg1.vars;
         if(_local4.orientToBezier == true)
         {
            _orientData = [["x","y","rotation",0,0.01]];
            _orient = true;
         }
         else if(_local4.orientToBezier is Array)
         {
            _orientData = _local4.orientToBezier;
            _orient = true;
         }
         var _local5:Object = {};
         _local6 = 0;
         while(_local6 < _arg2.length)
         {
            for(_local7 in _arg2[_local6])
            {
               if(_local5[_local7] == undefined)
               {
                  _local5[_local7] = [_arg1.target[_local7]];
               }
               if(typeof _arg2[_local6][_local7] == "number")
               {
                  _local5[_local7].push(_arg2[_local6][_local7]);
               }
               else
               {
                  _local5[_local7].push(_arg1.target[_local7] + Number(_arg2[_local6][_local7]));
               }
            }
            _local6++;
         }
         for(this.overwriteProps[this.overwriteProps.length] in _local5)
         {
            if(_local4[_local7] != undefined)
            {
               if(typeof _local4[_local7] == "number")
               {
                  _local5[_local7].push(_local4[_local7]);
               }
               else
               {
                  _local5[_local7].push(_arg1.target[_local7] + Number(_local4[_local7]));
               }
               _local8 = {};
               _local8[_local7] = true;
               _arg1.killVars(_local8,false);
               delete _local4[_local7];
            }
         }
         _beziers = parseBeziers(_local5,_arg3);
      }
      
      override public function onInitTween(_arg1:Object, _arg2:*, _arg3:TweenLite) : Boolean
      {
         if(!(_arg2 is Array))
         {
            return false;
         }
         init(_arg3,_arg2 as Array,false);
         return true;
      }
      
      override public function set changeFactor(_arg1:Number) : void
      {
         var _local2:int = 0;
         var _local3:* = null;
         var _local4:* = null;
         var _local5:Number = NaN;
         var _local6:* = 0;
         var _local7:Number = NaN;
         var _local8:* = null;
         var _local9:Number = NaN;
         var _local10:Number = NaN;
         var _local11:* = null;
         var _local12:Number = NaN;
         var _local13:* = null;
         var _local14:Boolean = false;
         _changeFactor = _arg1;
         if(_arg1 == 1)
         {
            for(_local3 in _beziers)
            {
               _local2 = _beziers[_local3].length - 1;
               _target[_local3] = _beziers[_local3][_local2][2];
            }
         }
         else
         {
            for(_local3 in _beziers)
            {
               _local6 = uint(_beziers[_local3].length);
               if(_arg1 < 0)
               {
                  _local2 = 0;
               }
               else if(_arg1 >= 1)
               {
                  _local2 = _local6 - 1;
               }
               else
               {
                  _local2 = int(_local6 * _arg1);
               }
               _local5 = (_arg1 - _local2 * (1 / _local6)) * _local6;
               _local4 = _beziers[_local3][_local2];
               if(this.round)
               {
                  _local7 = _local4[0] + _local5 * (2 * (1 - _local5) * (_local4[1] - _local4[0]) + _local5 * (_local4[2] - _local4[0]));
                  _target[_local3] = _local7 > 0 ? int(_local7 + 0.5) : int(_local7 - 0.5);
               }
               else
               {
                  _target[_local3] = _local4[0] + _local5 * (2 * (1 - _local5) * (_local4[1] - _local4[0]) + _local5 * (_local4[2] - _local4[0]));
               }
            }
         }
         if(_orient)
         {
            _local2 = _orientData.length;
            _local8 = {};
            while(_local2--)
            {
               _local11 = _orientData[_local2];
               _local8[_local11[0]] = _target[_local11[0]];
               _local8[_local11[1]] = _target[_local11[1]];
            }
            _local13 = _target;
            _local14 = this.round;
            _target = _future;
            this.round = false;
            _orient = false;
            _local2 = _orientData.length;
            while(_local2--)
            {
               _local11 = _orientData[_local2];
               this.changeFactor = _arg1 + (_local11[4] || 0.01);
               _local12 = _local11[3] || 0;
               _local9 = _future[_local11[0]] - _local8[_local11[0]];
               _local10 = _future[_local11[1]] - _local8[_local11[1]];
               _local13[_local11[2]] = Math.atan2(_local10,_local9) * 57.2957795130823 + _local12;
            }
            _target = _local13;
            this.round = _local14;
            _orient = true;
         }
      }
   }
}
