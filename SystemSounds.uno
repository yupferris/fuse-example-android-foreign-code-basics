using Uno;
using Uno.Collections;
using Fuse;
using Fuse.Scripting;

using Uno.Compiler.ExportTargetInterop;

public class SystemSounds : NativeModule
{
	public SystemSounds()
	{
		AddMember(new NativeFunction("playNotification",
			(NativeCallback)PlayNotification));
	}

	object PlayNotification(Context c, object[] args)
	{
		PlayNotification();

		return null;
	}

	[Foreign(Language.Java)]
	static extern(Android) void PlayNotification()
	@{
		android.net.Uri uri = android.media.RingtoneManager.getDefaultUri(android.media.RingtoneManager.TYPE_NOTIFICATION);
		android.media.Ringtone ringtone = android.media.RingtoneManager.getRingtone(com.fuse.Activity.getRootActivity(), uri);
		ringtone.play();
	@}

	static extern(!Android) void PlayNotification()
	{
		debug_log("Notification sounds not supported on this platform.");
	}
}
