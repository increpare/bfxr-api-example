/*
	Bfrx API example.

	An example showing four types of sound generation.

		1: synthesized on the fly
		2: precached
		3: mutated on the fly
		4: precached mutations
	
	For realtime applications, I *strongly* recommend precaching :)

	And yes, you'll need a different Bfxr instance for each sound.

	One other note: 
		- Synthesis is substantially slower in debug mode than final release 
		  builds, so don't get too down if it makes things a bit laggy while 
		  testing.
		- The caching API in this version is synchronous.  This means that 
		  the program can't do anything while caching sounds.  
		- Mixes take longer to generate than plain 'ol synths, so they can
		  take substantially longer to generation mutations for.

	http://www.bfxr.net

	Stephen Lavelle
	analytic@gmail.com

*/
package
{
	import com.increpare.bfxr.Bfxr;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Mouse;
	
	import ui.TinyButton;

	[SWF(width="220", height="120", backgroundColor="#C0B090")] 
	
	public class Bfxr_API_Example extends Sprite
	{		
		// This is a sound data string, directly copied from Bfxr.
		private const soundData:String = ",0.5,,0.3484,,0.2472,0.3,0.4135,,0.2198,,,,,,,,,,,0.015,,,,,0.4293,,,0.0539,,,,masterVolume";
				
		private var sound1:Bfxr;
		private var sound2:Bfxr;
		private var sound3:Bfxr;
		
		public function Bfxr_API_Example() 
		{
			//Cache sounds
			InitSounds();
			
			//Make GUI
			var b:TinyButton;
			
			b = new TinyButton(Button1Click,"Runtime Synthesize");
			b.x = 10; b.y = 10;
			this.addChild(b);
			
			b = new TinyButton(Button2Click,"Play Precached");
			b.x = 10; b.y = 40;
			this.addChild(b);
			
			b = new TinyButton(Button3Click,"Cached Mutation");
			b.x = 10; b.y = 70;
			this.addChild(b);								
		}
		
		private function InitSounds():void
		{
			//sound 1 : load , but do not cache
			sound1 = new Bfxr();
			sound1.Load(soundData);
			
			
			//sound 2: load + cache
			sound2 = new Bfxr();
			sound2.Load(soundData);
			sound2.Cache();				
			
			//sound 3: load + precache mutations
			sound3 = new Bfxr();
			sound3.Load(soundData);
			sound3.CacheMutations(0.05,10);	//cache 5 mutations
		}
		
		private function Button1Click(caller:TinyButton):void
		{
			sound1.Play();
		}
		
		private function Button2Click(caller:TinyButton):void
		{
			sound2.Play();			
		}
		
		private function Button3Click(caller:TinyButton):void
		{
			//If mutations have been cached, this will play a random one.
			sound3.Play();			
		}		
		
	}
}