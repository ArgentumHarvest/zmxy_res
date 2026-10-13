package com.superkaka.game.Manager.Keyboard
{
   import com.superkaka.game.Base.BaseVO;
   
   public class KeyVo extends BaseVO
   {
       
      
      public var keyCode:uint = 0;
      
      public var time:uint = 0;
      
      public var lastKeyDownTime:uint = 0;
      
      public var curKeyDownTime:uint = 0;
      
      public var isJustKeyDown:Boolean = false;
      
      public var isKeyDown:Boolean = false;
      
      public var isDoubleClick:Boolean = false;
      
      public var isJustKeyUp:Boolean = false;
      
      public var isKeyUp:Boolean = false;
      
      public function KeyVo()
      {
         super();
      }
   }
}
