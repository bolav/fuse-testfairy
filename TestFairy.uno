using Uno;
using Uno.Collections;
using Fuse;
using Uno.Compiler.ExportTargetInterop;
public class TestFairy : Behavior {
	public TestFairy () {
		Uno.Platform2.Application.EnteringForeground += OnEnteringForeground;
	}

	void OnEnteringForeground(Uno.Platform2.ApplicationState newState)
	{
		Init();
	}

	void Init() {
		if (Token == null) {
			return;
		}
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
