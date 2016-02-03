package com.fegla.texture
{
	import com.fegla.FeglaItem;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.textures.Texture;
	
	/**
	 * tile platforms using textures
	 */
	public class TextureBlock implements ITextureFiller
	{
		private var tileBR:Image;
		private var tileBC:Image;
		private var tileBL:Image;
		private var tileR:Image;
		private var tileC:Image;
		private var tileL:Image;
		private var tileTR:Image;
		private var tileTC:Image;
		private var tileTL:Image;
		
		/**
		 * the texture
		 */
		public var texture:Texture;
		
		/**
		 * Constructor
		 */
		public function TextureBlock(texture:Texture)
		{
			this.texture = texture;
			
			if (!texture)
				throw new Error("Invalid texture provided.");
		}
		
		/**
		 * Skin a texture to a FeglaItem
		 */
		public function run(target:FeglaItem, fillMode = TextureFillMode.NONE):void
		{
			if (target)
				target.parent.removeChild(target);
			
			var tile:Image = new Image(texture);
			var tileW:Number = tile.width;
			var tileH:Number = tile.height;
			var qb:QuadBatch;
			var i:int;
			var j:int;
			
			if (fillMode == TextureFillMode.NONE)
			{
				target.view = tile;
			}
			else if (fillMode == TextureFillMode.STRETCH)
			{
				tile.width = w;
				tile.height = h;
				target.view = tile;
			}
			else if (fillMode == TextureFillMode.STRETCH_X)
			{
				tile.width = w;
				target.view = tile;
			}
			else if (fillMode == TextureFillMode.STRETCH_Y)
			{
				tile.height = h;
				target.view = tile;
			}
			else if (fillMode == TextureFillMode.REPEAT)
			{
				qb = new QuadBatch();
				
				for (i = 0; i < 500; i++)
				{
					if (qb.width <= w - tileW)
					{
						tile.x = i * tileW;
						qb.addImage(tile);
						
						for (j = 0; j < 500; j++)
						{
							if (qb.height <= h - tileH)
							{
								tile.y = j * tileH;
								qb.addImage(tile);
							}
							else break;
						}
					}
					else break;
				}
				
				target.view = qb;
			}
			else if (fillMode == TextureFillMode.REPEAT_X)
			{
				qb = new QuadBatch();
				
				for (i = 0; i < 500; i++)
				{
					if (qb.width <= w - tileW)
					{
						tile.x = i * tileW;
						qb.addImage(tile);
					}
					else break;
				}
				
				target.view = qb;
			}
			else if (fillMode == TextureFillMode.REPEAT_Y)
			{
				qb = new QuadBatch();
				
				for (j = 0; j < 500; j++)
				{
					if (qb.height <= h - tileH)
					{
						tile.y = j * tileH;
						qb.addImage(tile);
					}
					else break;
				}
				
				target.view = qb;
			}
			
			target.addChild(target.view);
		}
	}
}