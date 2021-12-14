# Gnome Terminal Profiles Tweaker

View and edit the following [Gnome Terminal](https://en.wikipedia.org/wiki/GNOME_Terminal) profile settings using the [gsettings](https://wiki.gnome.org/HowDoI/GSettings) command and a [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) script:
- Font name/size (using default Pango `'filename fontsize'` format)
- Row size (terminal height)
- Column size (terminal width)

![image](https://user-images.githubusercontent.com/10182110/145905455-5f94f57d-992d-4dab-a4e4-006a012ddbbc.png)

### Rationale

**Why this application?** Because I like terminal themes, and I have accumulated many (many) themes over the years. It's difficult to manage so many theme properties, and I needed a programmatic way to make my property changes in bulk.

### Roadmap

The gsettings profile getter/setter functions in this program can be used for the custom configuration of all Gnome Terminal properties. But this is really what I'm interested in (for now).
