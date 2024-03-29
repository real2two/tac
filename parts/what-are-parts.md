---
description: Parts are the parts of the game.
---

# What are "parts" and how do you make them?

## What are parts?

Parts are the things that make up the game.  
You can make parts with text, images, custom fonts, keybinds and many more!

## How does the part work through the code?

In the source code, "part$" is the variable that controls which part you are in, which is useful for custom coding a part, as in maybe make a game with both text adventure and moving graphics.

Of course, there is multiple more processes that read the code/files \(input\) and sends the output to the program.

{% hint style="info" %}
If you want to know exactly how the program works, read the code and learn QB64.
{% endhint %}

## What are the required files?

* "run.\(filetype\)"
  * This is required to set the part type of the part.
* "text.\(filetype\)" and/or "images.\(filetype\)
  * You can have both of these, but at least one of these files are required.
  * They are used to set the text or image of the files. You can set a custom font to the text.
* "actions\" \(folder\) if the part type is "num".
  * This folder is only required if the part type is "num".
  * Nothing needs to be in the folder "actions" though, but the folder is required.

## How do I edit a part?

All parts \(besides custom coded parts\) are edited in the folder, "data\game\".

Making a folder in "data\game\" means you make a unstable part. 🎉Yay!🎉

After you make the part, there are many things you can add to the part. The main thing you need to know is the part types.

You also need to know how to output text and images to the program.

These are the current required files \(for the official build\):

* "text.\(filetype\)" and/or "images.\(filetype\)"
  * Sets the text/images of the program.
* "run.\(filetype\)"
  * Sets the part type.
* \(if the file type is "num"\) Folder "actions"
  * Manage the key actions \(as in click on a specific key to go to a part\).
* \(if the file type is "continue"\) "goto.\(filetype\)"
  * The part you go to when you click any button/key \(except the key actions from the folder "actions", if exists\).

## 

