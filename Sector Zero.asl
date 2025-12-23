//Aethermancer Demo Autosplitter V1.0 15/02/2025
//Timed via Load Remover - Please compare to Game Time
//Credit to:
//TheDementedSalad - Created the splitter
//Joey - Testing

state("SECTOR ZERO")
{}

startup
{
	timer.CurrentTimingMethod = TimingMethod.GameTime;
	Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Aethermancer";
	vars.Helper.Settings.CreateFromXml("Components/SectorZero.Settings.xml");
	vars.Helper.LoadSceneManager = true;
	//Aethermancer Demo Autosplitter V1.0 15/02/2025
//Timed via Load Remover - Please compare to Game Time
//Credit to:
//TheDementedSalad - Created the splitter
//Joey - Testing

state("SECTOR ZERO")
{}

startup
{
	timer.CurrentTimingMethod = TimingMethod.GameTime;
	Assembly.Load(File.ReadAllBytes("Components/asl-help")).CreateInstance("Unity");
    vars.Helper.GameName = "Aethermancer";
	vars.Helper.Settings.CreateFromXml("Components/SectorZero.Settings.xml");
	vars.Helper.LoadSceneManager = true;
	
	vars.completedSplits = new HashSet<string>();
}

init
{
	vars.Helper.TryLoad = (Func<dynamic, bool>)(mono => {
		vars.Helper["Timer"] = mono.Make<double>("SpeedrunTimer", "Instance", "runTime");
		vars.Helper["State"] = mono.Make<byte>("SpeedrunTimer", "Instance", "speedrunTimerState");
		vars.Helper["CheckID"] = mono.Make<byte>("StoredDataContainer", "SaveData", "checkpointID");
		vars.Helper["Lvl"] = mono.Make<byte>("AutoSplitterData", "levelID");
		vars.Helper["Running"] = mono.Make<byte>("AutoSplitterData", "isRunning");
		
        return true;
    });
}

onStart
{
	vars.completedSplits.Clear();
}
start
{
	return current.Timer != 0 && old.Timer == 0;
}

update
{
}

split
{
	string setting = "";
	
	if(current.CheckID != old.CheckID || current.Lvl != old.Lvl){
		setting = "Lvl_" + current.Lvl + "_" + current.CheckID;
	}
	
	// Debug. Comment out before release.
	if (!string.IsNullOrEmpty(setting))
	vars.Log(setting);
		
	if (settings.ContainsKey(setting) && settings[setting] && vars.completedSplits.Add(setting)){
		return true;
	}
	
	return current.isRunning == 2 && old.isRunning != 2;
}

gameTime
{
	return TimeSpan.FromSeconds(current.Timer);
}

isLoading
{
	return true;
}

reset
{

}

	vars.completedSplits = new HashSet<string>();
}

init
{
	vars.Helper.TryLoad = (Func<dynamic, bool>)(mono => {
		vars.Helper["Timer"] = mono.Make<double>("SpeedrunTimer", "Instance", "runTime");
		vars.Helper["State"] = mono.Make<byte>("SpeedrunTimer", "Instance", "speedrunTimerState");
		vars.Helper["CheckID"] = mono.Make<byte>("StoredDataContainer", "SaveData", "checkpointID");
		vars.Helper["Ded"] = mono.Make<byte>("StoredDataContainer", "SaveData", "deathLaser");
		vars.Helper["Lvl"] = mono.Make<byte>("StoredDataContainer", "SaveData", "currentLevel");
		
        return true;
    });
}

onStart
{
	vars.completedSplits.Clear();
}
start
{
	return current.Timer != 0 && old.Timer == 0;
}

update
{
	current.activeScene = vars.Helper.Scenes.Active.Name == null ? current.activeScene : vars.Helper.Scenes.Active.Name;			//creates a function that tracks the games active Scene name

    //if(current.activeScene != old.activeScene) vars.Log("active: Old: \"" + old.activeScene + "\", Current: \"" + current.activeScene + "\"");			//Prints when a new scene becomes active
}

split
{
	string setting = "";
	
	if(current.activeScene != old.activeScene){
		setting = "Lvl_" + current.activeScene;
	}
	
	// Debug. Comment out before release.
	if (!string.IsNullOrEmpty(setting))
	vars.Log(setting);
		
	if (settings.ContainsKey(setting) && settings[setting] && vars.completedSplits.Add(setting)){
		return true;
	}
	
	return current.State == 4 && old.State != 4;
}

gameTime
{
	return TimeSpan.FromSeconds(current.Timer);
}

isLoading
{
	return true;
}

reset
{

}

