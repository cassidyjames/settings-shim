/*
* Copyright © 2019 Cassidy James Blaede (https://cassidyjames.com)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Cassidy James Blaede <c@ssidyjam.es>
*/

public class Application : Gtk.Application {
    private static string? link  = null;

    public Application () {
        Object (
            application_id: "com.github.cassidyjames.settings-shim",
            flags: ApplicationFlags.HANDLES_OPEN
        );
    }

    construct {
        if (GLib.AppInfo.get_default_for_uri_scheme ("settings") == null) {
            var appinfo = new GLib.DesktopAppInfo (application_id + ".desktop");
            try {
                appinfo.set_as_default_for_type ("x-scheme-handler/settings");
            } catch (Error e) {
                critical ("Unable to set default for the settings scheme: %s", e.message);
            }
        }
    }

    public override void open (File[] files, string hint) {
        var file = files[0];
        if (file == null) {
            return;
        }

        if (file.get_uri_scheme () == "settings") {
            link = file.get_uri ().replace ("settings://", "");
            if (link.has_suffix ("/")) {
                link = link.substring (0, link.last_index_of_char ('/'));
            }
        }

        activate ();
    }

    protected override void activate () {
        // TODO: Stuff
        print ("Attempting to open “%s”\n", link);

        if (info != null) {
            string flag = "";

            // https://github.com/elementary/switchboard/wiki/System-Settings-Schema-Specification
            switch (link) {
                case "":
                    break;
                case "network":
                    flag = "network";
                    break;
                default:
                    critical ("Settings URI “%s” not (yet) supported", link);
                    break;
            }

            try {
                Process.spawn_command_line_async ("gnome-control-center %s");
            } catch (Error e) {
                critical ("Could not launch: %s", e.message);
            }
        }

        quit ();
    }

    public static int main (string[] args) {
        var app = new Application ();
        return app.run (args);
    }
}

