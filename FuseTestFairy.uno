using Uno;
using Uno.Collections;
using Fuse;
using Uno.Compiler.ExportTargetInterop;
public class FuseTestFairy : Behavior {
	public FuseTestFairy () {
		Fuse.Platform.Lifecycle.EnteringForeground += OnEnteringForeground;
		if (Fuse.Platform.Lifecycle.State == Fuse.Platform.ApplicationState.Foreground) {
			_foreground = true;
		}
	}

	void OnEnteringForeground(Fuse.Platform.ApplicationState  newState)
	{
		_foreground = true;
		Init();
	}

	static bool _foreground = false;
	static bool _inited = false;
	void Init() {
		if (_inited)
			return;
		if (Token == null) {
			return;
		}
		if (!_foreground)
			return;
		_inited = true;
		if defined(iOS) 
			InitImpl(Token);
	}

    [Require("Source.Declaration", "#import \"TestFairy.h\"")]
    [Foreign(Language.ObjC)]
    extern(iOS) void InitImpl(string token) 
    @{
    	[TestFairy begin:token];
    @}

	static string _token;
	public string Token {
		get { return _token; } 
		set { 
			_token = value;
			Init();
		}
	}
}
