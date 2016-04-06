using Uno;
using Uno.Collections;
using Fuse;
using Uno.Compiler.ExportTargetInterop;
public class FuseTestFairy : Behavior {
	public FuseTestFairy () {
		Uno.Platform2.Application.EnteringForeground += OnEnteringForeground;
	}

	void OnEnteringForeground(Uno.Platform2.ApplicationState newState)
	{
		Init();
	}

	bool _inited = false;
	void Init() {
		if (_inited)
			return;
		if (Token == null) {
			return;
		}
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

	string _token;
	public string Token {
		get { return _token; } 
		set { 
			_token = value;
			Init();
		}
	}
}
