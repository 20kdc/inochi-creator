/*
    Copyright © 2020, Inochi2D Project
    Distributed under the 2-Clause BSD License, see LICENSE file.
    
    Authors: Luna Nielsen
*/
module creator.utils.link;
import std.process;

/**
    Opens a link with the user's preferred webbrowser
*/
void incOpenLink(string link) {
    version(Windows) {
        spawnShell("start " ~ link);
    } else version(OSX) {
        spawnShell("open " ~ link);
    } else version(Posix) {
        spawnShell("xdg-open " ~ link);
    }
}