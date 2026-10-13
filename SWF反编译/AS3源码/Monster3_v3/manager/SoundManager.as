package manager
{
   import flash.media.*;
   
   public class SoundManager
   {
      
      private static var xz:Sound = AUtils.getNewObj("SD_xz");
      
      private static var Role1_hit1AndHit2:Sound = AUtils.getNewObj("Role1_hit1AndHit2");
      
      private static var Role1_hit3AndHit4:Sound = AUtils.getNewObj("Role1_hit3AndHit4");
      
      private static var Role1_hit5:Sound = AUtils.getNewObj("Role1_hit5");
      
      private static var Role1_hit6:Sound = AUtils.getNewObj("Role1_hit6");
      
      private static var Role1_hit7:Sound = AUtils.getNewObj("Role1_hit7");
      
      private static var Role1_hit8:Sound = AUtils.getNewObj("Role1_hit8");
      
      private static var Role1_hit9:Sound = AUtils.getNewObj("Role1_hit9");
      
      private static var Role1_hit10_1:Sound = AUtils.getNewObj("Role1_hit10_1");
      
      private static var Role1_hit10_2:Sound = AUtils.getNewObj("Role1_hit10_2");
      
      private static var Role1_hit10_3:Sound = AUtils.getNewObj("Role1_hit10_3");
      
      private static var Role2_hit1:Sound = AUtils.getNewObj("Role2_hit1");
      
      private static var Role2_hit2:Sound = AUtils.getNewObj("Role2_hit2");
      
      private static var Role2_hit3:Sound = AUtils.getNewObj("Role2_hit3");
      
      private static var Role2_hit4:Sound = AUtils.getNewObj("Role2_hit4");
      
      private static var Role2_hit5:Sound = AUtils.getNewObj("Role2_hit5");
      
      private static var Role2_hit6:Sound = AUtils.getNewObj("Role2_hit6");
      
      private static var Role1_beAttack:Sound = AUtils.getNewObj("Role1_beAttack");
      
      private static var Role2_beAttack:Sound = AUtils.getNewObj("Role2_beAttack");
      
      private static var begin:Sound = AUtils.getNewObj("begin");
      
      private static var over:Sound = AUtils.getNewObj("over");
      
      private static var stage1:Sound = AUtils.getNewObj("bg1");
      
      private static var stage2:Sound = AUtils.getNewObj("bg2");
      
      private static var stage3:Sound = AUtils.getNewObj("bg3");
      
      private static var stage4:Sound = AUtils.getNewObj("bg4");
      
      private static var BeattackByRole1:Sound = AUtils.getNewObj("BeattackByRole1");
      
      private static var BeattackByRole2:Sound = AUtils.getNewObj("BeattackByRole2");
      
      private static var loopChannel:SoundChannel;
      
      private static var playing:String = "";
      
      public static var soundStay:Boolean = true;
       
      
      public function SoundManager()
      {
         super();
      }
      
      public static function play(param1:String) : void
      {
         switch(param1)
         {
            case "xz":
               xz.play();
               break;
            case "Role1_hit1AndHit2":
               Role1_hit1AndHit2.play();
               break;
            case "Role1_hit3AndHit4":
               Role1_hit3AndHit4.play();
               break;
            case "Role1_hit5":
               Role1_hit5.play();
               break;
            case "Role1_hit6":
               Role1_hit6.play();
               break;
            case "Role1_hit7":
               Role1_hit7.play();
               break;
            case "Role1_hit8":
               Role1_hit8.play();
               break;
            case "Role1_hit9":
               Role1_hit9.play();
               break;
            case "Role1_hit10_1":
               Role1_hit10_1.play();
               break;
            case "Role1_hit10_2":
               Role1_hit10_2.play();
               break;
            case "Role1_hit10_3":
               Role1_hit10_3.play();
               break;
            case "Role1_beAttack":
               Role1_beAttack.play();
               break;
            case "Role2_beAttack":
               Role2_beAttack.play();
               break;
            case "BeattackByRole1":
               BeattackByRole1.play();
               break;
            case "BeattackByRole2":
               BeattackByRole2.play();
               break;
            case "Role2_hit1":
               Role2_hit1.play();
               break;
            case "Role2_hit2":
               Role2_hit2.play();
               break;
            case "Role2_hit3":
               Role2_hit3.play();
               break;
            case "Role2_hit4":
               Role2_hit4.play();
               break;
            case "Role2_hit5":
               Role2_hit5.play();
               break;
            case "Role2_hit6":
               Role2_hit6.play();
               break;
            case "begin":
               if(playing != "begin")
               {
                  playing = "begin";
                  if(loopChannel)
                  {
                     loopChannel.stop();
                  }
                  loopChannel = begin.play(0,9999);
                  setVom(loopChannel);
               }
               break;
            case "over":
               if(playing != "over")
               {
                  playing = "over";
                  if(loopChannel)
                  {
                     loopChannel.stop();
                  }
                  loopChannel = over.play(0,9999);
                  setVom(loopChannel);
               }
               break;
            case "stage1":
               if(playing != "stage1")
               {
                  playing = "stage1";
                  if(loopChannel)
                  {
                     loopChannel.stop();
                  }
                  loopChannel = stage1.play(0,9999);
                  setVom(loopChannel);
               }
               break;
            case "stage2":
               if(playing != "stage2")
               {
                  playing = "stage2";
                  if(loopChannel)
                  {
                     loopChannel.stop();
                  }
                  loopChannel = stage2.play(0,9999);
                  setVom(loopChannel);
               }
               break;
            case "stage3":
               if(playing != "stage3")
               {
                  playing = "stage3";
                  if(loopChannel)
                  {
                     loopChannel.stop();
                  }
                  loopChannel = stage3.play(0,9999);
                  setVom(loopChannel);
               }
               break;
            case "stage4":
               if(playing != "stage4")
               {
                  playing = "stage4";
                  if(loopChannel)
                  {
                     loopChannel.stop();
                  }
                  loopChannel = stage4.play(0,9999);
                  setVom(loopChannel);
               }
         }
      }
      
      public static function setVom(param1:SoundChannel) : void
      {
         var _loc2_:SoundTransform = param1.soundTransform;
         _loc2_.volume = 0.5;
         param1.soundTransform = _loc2_;
      }
      
      public static function controlSound() : *
      {
         if(soundStay)
         {
            soundStay = false;
            SoundMixer.soundTransform = new SoundTransform(0);
         }
         else
         {
            soundStay = true;
            SoundMixer.soundTransform = new SoundTransform(1);
         }
      }
   }
}
