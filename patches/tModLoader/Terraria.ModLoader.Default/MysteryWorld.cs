using System;
using System.Collections.Generic;
using System.IO;
using Terraria.ModLoader;

namespace Terraria.ModLoader.Default
{
	public class MysteryWorld : ModWorld
	{
		private IList<UnloadedData> data;

		internal void AddData(string mod, string name, byte[] newData)
		{
			data.Add(new UnloadedData(mod, name, newData));
		}

		internal void RestoreData()
		{
			int k = 0;
			while (k < data.Count)
			{
				Mod mod = ModLoader.GetMod(data[k].modName);
				ModWorld modWorld = mod == null ? null : mod.GetModWorld(data[k].name);
				if (modWorld == null)
				{
					k++;
				}
				else
				{
					using (MemoryStream memoryStream = new MemoryStream(data[k].data))
					{
						using (BinaryReader reader = new BinaryReader(memoryStream))
						{
							modWorld.LoadCustomData(reader);
						}
					}
					data.RemoveAt(k);
				}
			}
		}

		public override void Initialize()
		{
			data = new List<UnloadedData>();
		}

		public override void SaveCustomData(BinaryWriter writer)
		{
			if (data.Count > 0)
			{
				writer.Write((ushort)data.Count);
				foreach (UnloadedData unloadedData in data)
				{
					writer.Write(unloadedData.modName);
					writer.Write(unloadedData.name);
					writer.Write((ushort)unloadedData.data.Length);
					writer.Write(unloadedData.data);
				}
			}
		}

		public override void LoadCustomData(BinaryReader reader)
		{
			int count = reader.ReadUInt16();
			for (int k = 0; k < count; k++)
			{
				string modName = reader.ReadString();
				string name = reader.ReadString();
				byte[] unloadedData = reader.ReadBytes(reader.ReadUInt16());
				AddData(modName, name, unloadedData);
			}
		}

		private struct UnloadedData
		{
			internal string modName;
			internal string name;
			internal byte[] data;

			internal UnloadedData(string mod, string name, byte[] data)
			{
				this.modName = mod;
				this.name = name;
				this.data = data;
			}
		}
	}
}
