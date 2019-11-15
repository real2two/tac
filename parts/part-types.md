---
description: These are the stuff you need to know for part types.
---

# Part Types



## What are part types?

There are currently 3 "official" part types. You can edit the part type of a part in the file "data\game\&lt;part name&gt;\run.\(filetype\)". You simply write the part type name in there, without any caps.

### Similarities between the part types.

Currently, all official part types can send text and images to the program.  
Also, all official part types can contain the folder "actions" \("data\game\&lt;part name&gt;\actions\"\).

### Differences between the part types.

* num
  * This part type **requires** the folder "actions" in the part folder \("data\game\&lt;part name&gt;\actions\"\).
* continue
  * Instead of the program waiting for a specific keybinds or keys, it also detects if you click "any" button. If you click any button, it goes to another part.
  * It requires the file named "goto.\(filetype\)", which is what part you go to if you click any button \(besides keys that are in the "actions" folder, if there is one\).
* end
  * This is a bit similar to the part type "continue", but after you click any button \(besides keys that are in the "actions folder", if there is one\), it closes the program.

