//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/	 	/*Update Interval*/	/*Update Signal*/
    {" 🐧 ", "~/-/dotfiles/dwmblocks/scripts/kernel",		    360,		        2},

	/*{" 🔺 ","~/-/dotfiles/dwmblocks/scripts/upt",		        60,		            2},*/

	/*{" 📦 ", "/opt/dwmblocks/scripts/pacupdate",		360,		        9},*/

	{" 💻 ","~/-/dotfiles/dwmblocks/scripts/memory",	        6,		            1},

	{" 🔋", "~/-/dotfiles/dwmblocks/scripts/battery",                    60,                             0},
	
	{" 🔊 ","~/-/dotfiles/dwmblocks/scripts/volume",			2,		            10},

	{" 🕑 ", "~/-/dotfiles/dwmblocks/scripts/clock",			5,		            0},

};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
