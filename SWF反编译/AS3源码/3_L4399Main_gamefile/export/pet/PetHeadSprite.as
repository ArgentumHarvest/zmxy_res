package export.pet
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class PetHeadSprite extends Sprite
   {
       
      
      private var bbdc:BaseBitmapDataClip;
      
      private var petName:String;
      
      public function PetHeadSprite(name:String)
      {
         super();
         this.petName = name;
         this.initBBC();
      }
      
      private function initBBC() : void
      {
         var body:* = null;
         var bmdName:String = "";
         if(this.petName == "monkey1")
         {
            bmdName = "PetMonkeyBmd1";
         }
         else if(this.petName == "monkey2")
         {
            bmdName = "PetMonkeyBmd2";
         }
         else if(this.petName == "monkey3")
         {
            bmdName = "PetMonkeyBmd3";
         }
         else if(this.petName == "monkey4")
         {
            bmdName = "PetMonkeyBmd4";
         }
         else if(this.petName == "horse1")
         {
            bmdName = "PetHorseBmd1";
         }
         else if(this.petName == "horse2")
         {
            bmdName = "PetHorseBmd2";
         }
         else if(this.petName == "horse3")
         {
            bmdName = "PetHorseBmd3";
         }
         else if(this.petName == "horse4")
         {
            bmdName = "PetHorseBmd4";
         }
         else if(this.petName == "ufo1")
         {
            bmdName = "PetKabuBmd1";
         }
         else if(this.petName == "ufo2")
         {
            bmdName = "PetKabuBmd2";
         }
         else if(this.petName == "ufo3")
         {
            bmdName = "PetKabuBmd3";
         }
         else if(this.petName == "tigress1")
         {
            bmdName = "PetTigerBmd1";
         }
         else if(this.petName == "tigress2")
         {
            bmdName = "PetTigerBmd2";
         }
         else if(this.petName == "tigress3")
         {
            bmdName = "PetTigerBmd3";
         }
         else if(this.petName == "tigress4")
         {
            bmdName = "PetTigerBmd4";
         }
         else if(this.petName == "turtle1")
         {
            bmdName = "PetTurtleBmd1";
         }
         else if(this.petName == "turtle2")
         {
            bmdName = "PetTurtleBmd2";
         }
         else if(this.petName == "turtle3")
         {
            bmdName = "PetTurtleBmd3";
         }
         else if(this.petName == "turtle4")
         {
            bmdName = "PetTurtleBmd4";
         }
         else if(this.petName == "phoenix1")
         {
            bmdName = "PetPhoenixBmd1";
         }
         else if(this.petName == "phoenix2")
         {
            bmdName = "PetPhoenixBmd2";
         }
         else if(this.petName == "phoenix3")
         {
            bmdName = "PetPhoenixBmd3";
         }
         else if(this.petName == "phoenix4")
         {
            bmdName = "PetPhoenixBmd4";
         }
         else if(this.petName == "dragon1")
         {
            bmdName = "PetDragonBmd1";
         }
         else if(this.petName == "dragon2")
         {
            bmdName = "PetDragonBmd2";
         }
         else if(this.petName == "dragon3")
         {
            bmdName = "PetDragonBmd3";
         }
         else if(this.petName == "dragon4")
         {
            bmdName = "PetDragonBmd4";
         }
         else if(this.petName == "rabbit1")
         {
            bmdName = "PetPetRabbitBmd1";
         }
         else if(this.petName == "rabbit2")
         {
            bmdName = "PetPetRabbitBmd2";
         }
         else if(this.petName == "rabbit3")
         {
            bmdName = "PetPetRabbitBmd3";
         }
         else if(this.petName == "rabbit4")
         {
            bmdName = "PetPetRabbitBmd4";
         }
         else if(this.petName == "nian1")
         {
            bmdName = "Monster1551";
         }
         else if(this.petName == "nian2")
         {
            bmdName = "Monster1551";
         }
         else if(this.petName == "nian3")
         {
            bmdName = "Monster1551";
         }
         else if(this.petName == "nian4")
         {
            bmdName = "Monster155";
         }
         else if(this.petName == "nian5")
         {
            bmdName = "PetNianBmd5";
         }
         else if(this.petName == "mouse1")
         {
            bmdName = "PetMouseBmd1";
         }
         else if(this.petName == "mouse2")
         {
            bmdName = "PetMouseBmd1";
         }
         else if(this.petName == "mouse3")
         {
            bmdName = "PetMouseBmd1";
         }
         else if(this.petName == "mouse4")
         {
            bmdName = "PetMouseBmd2";
         }
         else if(this.petName == "neat1")
         {
            bmdName = "PetNeatBmd1";
         }
         else if(this.petName == "neat2")
         {
            bmdName = "PetNeatBmd1";
         }
         else if(this.petName == "neat3")
         {
            bmdName = "PetNeatBmd1";
         }
         else if(this.petName == "neat4")
         {
            bmdName = "PetNeatBmd4";
         }
         else if(this.petName == "roomhorse1" || this.petName == "roomhorse2" || this.petName == "roomhorse3")
         {
            bmdName = "PetRoomHorseBmd1";
         }
         else if(this.petName == "roomhorse4")
         {
            bmdName = "PetRoomHorseBmd4";
         }
         else if(this.petName == "terribletiger1" || this.petName == "terribletiger2" || this.petName == "terribletiger3")
         {
            bmdName = "PetYinTaigerBmd1";
         }
         else if(this.petName == "terribletiger4")
         {
            bmdName = "PetYinTaigerBmd2";
         }
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName(bmdName);
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            if(this.petName == "monkey1")
            {
               bbdc = new BaseBitmapDataClip([body],70,70,new Point(0,0));
               bbdc.setOffsetXY(-8,-10);
               bbdc.setFrameStopCount([[2,2,2,2],[8],[2,2,2,2,1,1],[2,2,2,10],[1,1,1,12]]);
               bbdc.setFrameCount([4,1,6,4,4]);
            }
            else if(this.petName == "monkey2")
            {
               bbdc = new BaseBitmapDataClip([body],100,100,new Point(0,0));
               bbdc.setOffsetXY(-8,-10);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,8],[1,1],[10]]);
               bbdc.setFrameCount([6,4,1,5,3,12,1]);
            }
            else if(this.petName == "monkey3")
            {
               bbdc = new BaseBitmapDataClip([body],150,150,new Point(0,0));
               bbdc.setOffsetXY(-8,5);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,8],[2,9,15],[10],[1,1]]);
               bbdc.setFrameCount([6,4,1,5,3,3,1,20]);
            }
            else if(this.petName == "monkey4")
            {
               bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
               bbdc.setOffsetXY(-8,-5);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,8],[2,9,15],[10],[1,1],[2,2,2]]);
               bbdc.setFrameCount([6,4,1,5,3,3,1,20,3]);
            }
            else if(this.petName == "horse1")
            {
               bbdc = new BaseBitmapDataClip([body],80,80,new Point(0,0));
               bbdc.setOffsetXY(1,-10);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[8],[2,2,2,2,1,2],[2,2,1,1,8],[2,2,2,8]]);
               bbdc.setFrameCount([6,1,6,5,4]);
               this.addChild(bbdc);
            }
            else if(this.petName == "horse2")
            {
               bbdc = new BaseBitmapDataClip([body],100,100,new Point(0,0));
               bbdc.setOffsetXY(1,-10);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,4,20],[15],[2,2,1,1,8]]);
               bbdc.setFrameCount([6,4,1,4,3,1,5]);
            }
            else if(this.petName == "horse3")
            {
               bbdc = new BaseBitmapDataClip([body],150,150,new Point(0,0));
               bbdc.setOffsetXY(12,-10);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,8],[1,1],[10]]);
               bbdc.setFrameCount([6,4,1,5,3,12,1]);
            }
            else if(this.petName == "horse4")
            {
               bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
               bbdc.setOffsetXY(1,-25);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,8],[1,1],[10]]);
               bbdc.setFrameCount([6,4,1,5,3,12,1]);
            }
            else if(this.petName == "ufo1")
            {
               bbdc = new BaseBitmapDataClip([body],80,80,new Point(0,0));
               bbdc.setOffsetXY(12,-10);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[8],[2,2,2,2,2],[2,2,2,10],[2,2,2,10]]);
               bbdc.setFrameCount([6,1,5,4,4]);
            }
            else if(this.petName == "ufo2")
            {
               bbdc = new BaseBitmapDataClip([body],100,100,new Point(0,0));
               bbdc.setOffsetXY(12,-10);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[8],[2,2,2,2,2],[2,2,2,10],[2,2,2,10]]);
               bbdc.setFrameCount([6,1,5,4,4]);
            }
            else if(this.petName == "ufo3")
            {
               bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
               bbdc.setOffsetXY(12,-10);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[8],[2,2,2,2,2],[2,2,2,10],[2,2,2,10]]);
               bbdc.setFrameCount([6,1,5,4,4]);
            }
            else if(this.petName == "tigress1")
            {
               bbdc = new BaseBitmapDataClip([body],100,100,new Point(0,0));
               bbdc.setOffsetXY(12,-10);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[8],[2,2,2,2,2],[2,2,2,10],[2,2,2,10]]);
               bbdc.setFrameCount([6,1,4,4,4]);
            }
            else if(this.petName == "tigress2")
            {
               bbdc = new BaseBitmapDataClip([body],150,150,new Point(0,0));
               bbdc.setOffsetXY(12,-10);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[8],[2,2,2,2,2],[2,2,2,10],[2,2,2,10]]);
               bbdc.setFrameCount([6,1,5,4,3,3]);
            }
            else if(this.petName == "tigress3")
            {
               bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
               bbdc.setOffsetXY(20,-10);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,10],[2,2,2,10],[2,2,10]]);
               bbdc.setFrameCount([6,4,1,5,4,4,3,5]);
            }
            else if(this.petName == "tigress4")
            {
               bbdc = new BaseBitmapDataClip([body],250,250,new Point(0,0));
               bbdc.setOffsetXY(30,-15);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,10],[2,2,2,10],[2,2,10]]);
               bbdc.setFrameCount([6,4,1,5,4,4,3,5]);
            }
            else if(this.petName == "turtle1")
            {
               bbdc = new BaseBitmapDataClip([body],150,150,new Point(0,0));
               bbdc.setOffsetXY(1,-10);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[8],[2,2,2,2,2],[2,2,10],[2,2,10]]);
               bbdc.setFrameCount([6,1,5,3,3]);
            }
            else if(this.petName == "turtle2")
            {
               bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
               bbdc.setOffsetXY(1,-10);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,2],[2,2,10],[2,2,10]]);
               bbdc.setFrameCount([6,4,1,5,4,3]);
            }
            else if(this.petName == "turtle3")
            {
               bbdc = new BaseBitmapDataClip([body],250,250,new Point(0,0));
               bbdc.setOffsetXY(21,5);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,2],[2,2,10],[2,2,10]]);
               bbdc.setFrameCount([6,4,1,5,4,3]);
            }
            else if(this.petName == "turtle4")
            {
               bbdc = new BaseBitmapDataClip([body],250,250,new Point(0,0));
               bbdc.setOffsetXY(21,-17);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,2],[2,2,10],[2,2,10]]);
               bbdc.setFrameCount([6,4,1,5,4,3]);
            }
            else if(this.petName == "phoenix1")
            {
               bbdc = new BaseBitmapDataClip([body],100,100,new Point(0,0));
               bbdc.setOffsetXY(1,-10);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[8],[2,2,2,2,2],[2,2,10],[2,2,10]]);
               bbdc.setFrameCount([6,1,5,3,3]);
            }
            else if(this.petName == "phoenix2")
            {
               bbdc = new BaseBitmapDataClip([body],150,150,new Point(0,0));
               bbdc.setOffsetXY(1,-10);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,2],[2,2,10],[2,2,10]]);
               bbdc.setFrameCount([6,4,1,5,4,3]);
            }
            else if(this.petName == "phoenix3")
            {
               bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
               bbdc.setOffsetXY(1,-10);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,2],[2,2,10],[2,2,10]]);
               bbdc.setFrameCount([6,4,1,5,4,3]);
            }
            else if(this.petName == "phoenix4")
            {
               bbdc = new BaseBitmapDataClip([body],300,300,new Point(0,0));
               bbdc.setOffsetXY(1,-40);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,2],[2,2,10],[2,2,10]]);
               bbdc.setFrameCount([6,4,1,5,4,3]);
            }
            else if(this.petName == "dragon1")
            {
               bbdc = new BaseBitmapDataClip([body],150,150,new Point(0,0));
               bbdc.setOffsetXY(1,-5);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[8],[2,2,2,10],[2,2,2,10],[2,2,2,2,10]]);
               bbdc.setFrameCount([6,1,4,4,5]);
            }
            else if(this.petName == "dragon2")
            {
               bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
               bbdc.setOffsetXY(1,-5);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,10],[2,2,2,2,10],[30]]);
               bbdc.setFrameCount([6,4,1,5,4,5,1]);
            }
            else if(this.petName == "dragon3")
            {
               bbdc = new BaseBitmapDataClip([body],250,250,new Point(0,0));
               bbdc.setOffsetXY(1,-15);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,7,2,2,10],[2,2,2,2,10],[30],[2,2,30]]);
               bbdc.setFrameCount([6,4,1,5,6,5,1,3]);
            }
            else if(this.petName == "dragon4")
            {
               bbdc = new BaseBitmapDataClip([body],300,250,new Point(0,0));
               bbdc.setOffsetXY(31,-15);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,7,2,2,10],[2,2,2,2,10],[30],[2,2,30]]);
               bbdc.setFrameCount([6,4,1,5,6,5,1,3]);
            }
            else if(this.petName == "rabbit1")
            {
               bbdc = new BaseBitmapDataClip([body],100,100,new Point(0,0));
               bbdc.setOffsetXY(1,-10);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[8],[2,2,2,2,10],[2,2,2,10],[2,10]]);
               bbdc.setFrameCount([6,1,5,4,2]);
            }
            else if(this.petName == "rabbit2")
            {
               bbdc = new BaseBitmapDataClip([body],150,150,new Point(0,0));
               bbdc.setOffsetXY(1,-10);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,2,10],[2,10],[10]]);
               bbdc.setFrameCount([6,4,1,5,5,2,1]);
            }
            else if(this.petName == "rabbit3")
            {
               bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
               bbdc.setOffsetXY(1,-28);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,2,10],[2,10],[10]]);
               bbdc.setFrameCount([6,4,1,5,5,2,1]);
            }
            else if(this.petName == "rabbit4")
            {
               bbdc = new BaseBitmapDataClip([body],250,250,new Point(0,0));
               bbdc.setOffsetXY(1,-48);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,2,2],[2,10],[10],[1,1,1,7,1,40]]);
               bbdc.setFrameCount([6,4,1,5,5,2,1,6]);
            }
            else if(this.petName == "nian1" || this.petName == "nian2" || this.petName == "nian3")
            {
               bbdc = new BaseBitmapDataClip([body],150,150,new Point(0,0));
               bbdc.setOffsetXY(1,-10);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,10],[2,2,10]]);
               bbdc.setFrameCount([6,4,1,5,4,3]);
            }
            else if(this.petName == "nian4")
            {
               bbdc = new BaseBitmapDataClip([body],300,200,new Point(0,0));
               bbdc.setOffsetXY(-15,5);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,10],[2,2,10],[30]]);
               bbdc.setFrameCount([6,4,1,5,4,3,1]);
               bbdc.scaleX = 0.8;
               bbdc.scaleY = 0.8;
            }
            else if(this.petName == "nian5")
            {
               bbdc = new BaseBitmapDataClip([body],300,300,new Point(0,0));
               bbdc.setOffsetXY(-15,0);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,10],[2,10],[30],[30]]);
               bbdc.setFrameCount([6,4,1,5,4,2,1,1]);
               bbdc.scaleX = 0.8;
               bbdc.scaleY = 0.8;
            }
            else if(this.petName == "mouse1" || this.petName == "mouse2" || this.petName == "mouse3")
            {
               bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
               bbdc.setOffsetXY(-20,-25);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,10],[2,2,2,2]]);
               bbdc.setFrameCount([6,4,1,5,3,4]);
            }
            else if(this.petName == "mouse4")
            {
               bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
               bbdc.setOffsetXY(-20,-25);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,10],[2,2,1,10],[2,2,10]]);
               bbdc.setFrameCount([6,4,1,5,3,4,3]);
            }
            else if(this.petName == "neat1" || this.petName == "neat2" || this.petName == "neat3")
            {
               bbdc = new BaseBitmapDataClip([body],150,150,new Point(0,0));
               bbdc.setOffsetXY(10,-25);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,10],[30]]);
               bbdc.setFrameCount([6,4,1,5,3,1]);
            }
            else if(this.petName == "neat4")
            {
               bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
               bbdc.setOffsetXY(10,-25);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,10],[30],[2,2,10]]);
               bbdc.setFrameCount([6,4,1,5,3,1,3]);
            }
            else if(this.petName == "roomhorse1" || this.petName == "roomhorse2" || this.petName == "roomhorse3")
            {
               bbdc = new BaseBitmapDataClip([body],150,150,new Point(0,0));
               bbdc.setOffsetXY(1,-10);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,2,10],[3,3,10],[2,2,2,2]]);
               bbdc.setFrameCount([6,4,1,6,3,4]);
            }
            else if(this.petName == "roomhorse4")
            {
               bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
               bbdc.setOffsetXY(1,-18);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,2,10],[3,3,10],[2,2,2],[3,3,10]]);
               bbdc.setFrameCount([6,4,1,6,3,3,3]);
            }
            else if(this.petName == "terribletiger1" || this.petName == "terribletiger2" || this.petName == "terribletiger3")
            {
               bbdc = new BaseBitmapDataClip([body],160,160,new Point(0,0));
               bbdc.setOffsetXY(1,-25);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,2,10],[3,3,10],[2,2,2,2]]);
               bbdc.setFrameCount([6,4,1,6,3,4]);
            }
            else if(this.petName == "terribletiger4")
            {
               bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
               bbdc.setOffsetXY(1,-23);
               bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,2,10],[3,3,3,3,10],[3,3,10],[3,3,3,30]]);
               bbdc.setFrameCount([6,4,1,6,5,3,4]);
            }
            this.addChild(bbdc);
            this.addEventListener("enterFrame",__enterFrame);
            return;
         }
         throw new Error("HeadSprite---" + bmdName + "---type Error");
      }
      
      private function __enterFrame(evt:Event) : void
      {
         if(this.bbdc)
         {
            this.bbdc.step();
         }
      }
      
      public function destroy() : void
      {
         this.bbdc.destroy();
         this.bbdc = null;
         this.removeEventListener("enterFrame",__enterFrame);
      }
   }
}
