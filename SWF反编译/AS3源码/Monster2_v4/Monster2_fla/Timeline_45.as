package Monster2_fla
{
   import base.*;
   import flash.accessibility.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.media.*;
   import flash.net.*;
   import flash.net.drm.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.ime.*;
   import flash.ui.*;
   import flash.utils.*;
   
   public dynamic class Timeline_45 extends MovieClip
   {
       
      
      public function Timeline_45()
      {
         super();
         addFrameScript(2,this.frame3,4,this.frame5,6,this.frame7);
      }
      
      function frame3() : *
      {
         BaseMonster(this.parent.parent.parent).newAttackId();
      }
      
      function frame5() : *
      {
         BaseMonster(this.parent.parent.parent).newAttackId();
      }
      
      function frame7() : *
      {
         BaseMonster(this.parent.parent.parent).newAttackId();
      }
   }
}
