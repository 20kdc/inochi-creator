module crashdump;
import std.file : write;
import i18n;
import std.stdio;
import std.path;

version(Windows) {
    pragma(lib, "user32.lib");
    pragma(lib, "shell32.lib");
    import core.sys.windows.winuser : MessageBoxExW;
    import std.utf : toUTF16, toUTF8;

    private string getDesktopDir() {
        import core.sys.windows.windows;
        import core.sys.windows.shlobj;
        dstring desktopDir = new dstring(MAX_PATH);
        SHGetSpecialFolderPath(HWND_DESKTOP, desktopDir.ptr, CSIDL_DESKTOP, FALSE);
        return desktopDir.toUTF8;
    }

    private void ShowMessageBox(string message, string title) {
        MessageBoxExW(null, toUTF16(message).ptr, toUTF16(title).ptr);
    }

    void crashdump(Throwable throwable) {
        write(buildPath(getDesktopDir(), "inochi-creator-crashdump.txt"), throwable.toString);

        ShowMessageBox(
            _("The application has unexpectedly crashed\nPlease send the developers the inochi-creator-crashdump.txt which has been put on your desktop\nVia https://github.com/Inochi2D/inochi-creator/issues"),
            _("Inochi Creator Crashdump")
        );
    }
}

version(Posix) {
    void crashdump(Throwable throwable) {
        write(expandTilde("~/inochi-creator-crashdump.txt"), throwable.toString);
        writeln(_("\n\n\n===   Inochi Creator has crashed   ===\nPlease send us the inochi-creator-crashdump.txt file in your home folder\nAttach the file as a git issue @ https://github.com/Inochi2D/inochi-creator/issues"));
    }
}