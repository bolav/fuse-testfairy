using Uno;
using Uno.Collections;
using Fuse;
using Uno.Compiler.ExportTargetInterop;
public class FuseTestFairy : Behavior {
	public FuseTestFairy () {
		Uno.Platform2.Application.EnteringForeground += OnEnteringForeground;
		if (Uno.Platform2.Application.State == Uno.Platform2.ApplicationState.Foreground) {
			_foreground = true;
		}
	}

	void OnEnteringForeground(Uno.Platform2.ApplicationState newState)
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
